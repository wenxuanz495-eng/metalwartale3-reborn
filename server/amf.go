package main

import (
	"bytes"
	"compress/flate"
	"compress/gzip"
	"compress/zlib"
	"encoding/base64"
	"encoding/binary"
	"errors"
	"fmt"
	"io"
	"math"
	"sort"
)

type amfReader struct {
	data    []byte
	pos     int
	objects []any
	traits  []amfTraits
	strings []string
}

type amfTraits struct {
	externalizable bool
	dynamic        bool
	className      string
	keys           []string
}

const (
	maxAMFCollectionEntries = 1 << 20
	maxInflatedPayloadSize  = 32 * 1024 * 1024
)

func newAMFReader(data []byte) *amfReader {
	return &amfReader{data: data}
}

func (r *amfReader) remaining() int {
	return len(r.data) - r.pos
}

func (r *amfReader) take(n int) ([]byte, error) {
	if n < 0 || r.pos+n > len(r.data) {
		return nil, io.ErrUnexpectedEOF
	}
	v := r.data[r.pos : r.pos+n]
	r.pos += n
	return v, nil
}

func (r *amfReader) u8() (byte, error) {
	v, err := r.take(1)
	if err != nil {
		return 0, err
	}
	return v[0], nil
}

func (r *amfReader) u16() (uint16, error) {
	v, err := r.take(2)
	if err != nil {
		return 0, err
	}
	return binary.BigEndian.Uint16(v), nil
}

func (r *amfReader) u32() (uint32, error) {
	v, err := r.take(4)
	if err != nil {
		return 0, err
	}
	return binary.BigEndian.Uint32(v), nil
}

func (r *amfReader) double() (float64, error) {
	v, err := r.take(8)
	if err != nil {
		return 0, err
	}
	return math.Float64frombits(binary.BigEndian.Uint64(v)), nil
}

func (r *amfReader) utf() (string, error) {
	n, err := r.u16()
	if err != nil {
		return "", err
	}
	v, err := r.take(int(n))
	if err != nil {
		return "", err
	}
	return string(bytes.ToValidUTF8(v, []byte("\uFFFD"))), nil
}

func (r *amfReader) readValue() (any, error) {
	t, err := r.u8()
	if err != nil {
		return nil, err
	}
	return r.readType(t)
}

func (r *amfReader) readType(t byte) (any, error) {
	switch t {
	case 0x00:
		return r.double()
	case 0x01:
		v, err := r.u8()
		return v != 0, err
	case 0x02:
		return r.utf()
	case 0x03:
		return r.readObject()
	case 0x05, 0x06, 0x09:
		return nil, nil
	case 0x07:
		idx, err := r.u16()
		if err != nil {
			return nil, err
		}
		if int(idx) < len(r.objects) {
			return r.objects[idx], nil
		}
		return map[string]any{"$ref": idx}, nil
	case 0x08:
		if _, err := r.u32(); err != nil {
			return nil, err
		}
		return r.readObject()
	case 0x0A:
		n, err := r.u32()
		if err != nil {
			return nil, err
		}
		if uint64(n) > uint64(maxAMFCollectionEntries) || uint64(n) > uint64(r.remaining()) {
			return nil, fmt.Errorf("invalid AMF0 strict-array length %d with %d bytes remaining", n, r.remaining())
		}
		arr := make([]any, 0, n)
		r.objects = append(r.objects, arr)
		for range n {
			v, err := r.readValue()
			if err != nil {
				return nil, err
			}
			arr = append(arr, v)
		}
		r.objects[len(r.objects)-1] = arr
		return arr, nil
	case 0x0B:
		ms, err := r.double()
		if err != nil {
			return nil, err
		}
		if _, err := r.u16(); err != nil {
			return nil, err
		}
		return map[string]any{"$date": ms}, nil
	case 0x0C, 0x0F:
		n, err := r.u32()
		if err != nil {
			return nil, err
		}
		v, err := r.take(int(n))
		if err != nil {
			return nil, err
		}
		return string(bytes.ToValidUTF8(v, []byte("\uFFFD"))), nil
	case 0x10:
		className, err := r.utf()
		if err != nil {
			return nil, err
		}
		v, err := r.readObject()
		if err != nil {
			return nil, err
		}
		v["$type"] = className
		return v, nil
	case 0x11:
		return r.readAMF3()
	default:
		return nil, fmt.Errorf("unsupported AMF0 type 0x%02x at %d", t, r.pos-1)
	}
}

func (r *amfReader) readObject() (map[string]any, error) {
	obj := map[string]any{}
	r.objects = append(r.objects, obj)
	for {
		key, err := r.utf()
		if err != nil {
			return nil, err
		}
		if key == "" {
			end, err := r.u8()
			if err != nil {
				return nil, err
			}
			if end != 0x09 {
				r.pos--
			}
			return obj, nil
		}
		value, err := r.readValue()
		if err != nil {
			return nil, err
		}
		obj[key] = value
	}
}

func (r *amfReader) readU29() (int, error) {
	b, err := r.u8()
	if err != nil {
		return 0, err
	}
	if b < 0x80 {
		return int(b), nil
	}
	v := int(b&0x7f) << 7
	b, err = r.u8()
	if err != nil {
		return 0, err
	}
	if b < 0x80 {
		return v | int(b), nil
	}
	v = (v | int(b&0x7f)) << 7
	b, err = r.u8()
	if err != nil {
		return 0, err
	}
	if b < 0x80 {
		return v | int(b), nil
	}
	v = (v | int(b&0x7f)) << 8
	b, err = r.u8()
	if err != nil {
		return 0, err
	}
	return v | int(b), nil
}

func (r *amfReader) readAMF3String() (string, error) {
	ref, err := r.readU29()
	if err != nil {
		return "", err
	}
	if ref&1 == 0 {
		idx := ref >> 1
		if idx < len(r.strings) {
			return r.strings[idx], nil
		}
		return "", nil
	}
	n := ref >> 1
	if n == 0 {
		return "", nil
	}
	v, err := r.take(n)
	if err != nil {
		return "", err
	}
	s := string(bytes.ToValidUTF8(v, []byte("\uFFFD")))
	r.strings = append(r.strings, s)
	return s, nil
}

func (r *amfReader) readObjectReference(ref int) (any, error) {
	idx := ref >> 1
	if idx < 0 || idx >= len(r.objects) {
		return nil, fmt.Errorf("invalid AMF3 object reference %d", idx)
	}
	return r.objects[idx], nil
}

func (r *amfReader) readAMF3() (any, error) {
	t, err := r.u8()
	if err != nil {
		return nil, err
	}
	switch t {
	case 0x00, 0x01:
		return nil, nil
	case 0x02:
		return false, nil
	case 0x03:
		return true, nil
	case 0x04:
		v, err := r.readU29()
		if v&0x10000000 != 0 {
			v -= 0x20000000
		}
		return v, err
	case 0x05:
		return r.double()
	case 0x06, 0x07, 0x0B:
		return r.readAMF3String()
	case 0x08:
		ref, err := r.readU29()
		if err != nil {
			return nil, err
		}
		if ref&1 == 0 {
			return r.readObjectReference(ref)
		}
		ms, err := r.double()
		if err != nil {
			return nil, err
		}
		obj := map[string]any{"$date": ms}
		r.objects = append(r.objects, obj)
		return obj, nil
	case 0x09:
		return r.readAMF3Array()
	case 0x0A:
		return r.readAMF3Object()
	case 0x0C:
		ref, err := r.readU29()
		if err != nil {
			return nil, err
		}
		if ref&1 == 0 {
			return r.readObjectReference(ref)
		}
		v, err := r.take(ref >> 1)
		if err != nil {
			return nil, err
		}
		out := append([]byte(nil), v...)
		r.objects = append(r.objects, out)
		return out, nil
	default:
		return nil, fmt.Errorf("unsupported AMF3 type 0x%02x at %d", t, r.pos-1)
	}
}

func (r *amfReader) readAMF3Array() (any, error) {
	ref, err := r.readU29()
	if err != nil {
		return nil, err
	}
	if ref&1 == 0 {
		return r.readObjectReference(ref)
	}
	denseLen := ref >> 1
	if denseLen > maxAMFCollectionEntries {
		return nil, fmt.Errorf("invalid AMF3 array length %d", denseLen)
	}
	// AMF3 registers an inline array before reading its associative and dense
	// values. Register a placeholder now so every following object reference
	// keeps the same index as Flash Player, including references created inside
	// an associative array such as localSlots.
	objectIndex := len(r.objects)
	assoc := map[string]any{}
	r.objects = append(r.objects, assoc)
	for {
		key, err := r.readAMF3String()
		if err != nil {
			return nil, err
		}
		if key == "" {
			break
		}
		value, err := r.readAMF3()
		if err != nil {
			return nil, err
		}
		assoc[key] = value
	}
	if denseLen > r.remaining() {
		return nil, fmt.Errorf("invalid AMF3 dense-array length %d with %d bytes remaining", denseLen, r.remaining())
	}
	arr := make([]any, 0, denseLen)
	for range denseLen {
		value, err := r.readAMF3()
		if err != nil {
			return nil, err
		}
		arr = append(arr, value)
	}
	if len(assoc) == 0 {
		r.objects[objectIndex] = arr
		return arr, nil
	}
	assoc["$dense"] = arr
	r.objects[objectIndex] = assoc
	return assoc, nil
}

func (r *amfReader) readAMF3Object() (any, error) {
	ref, err := r.readU29()
	if err != nil {
		return nil, err
	}
	if ref&1 == 0 {
		return r.readObjectReference(ref)
	}
	var traits amfTraits
	if ref&3 == 1 {
		idx := ref >> 2
		if idx >= len(r.traits) {
			return nil, errors.New("invalid AMF3 traits reference")
		}
		traits = r.traits[idx]
	} else {
		traits.externalizable = ref&4 != 0
		traits.dynamic = ref&8 != 0
		n := ref >> 4
		traits.className, err = r.readAMF3String()
		if err != nil {
			return nil, err
		}
		for range n {
			key, err := r.readAMF3String()
			if err != nil {
				return nil, err
			}
			traits.keys = append(traits.keys, key)
		}
		r.traits = append(r.traits, traits)
	}
	if traits.externalizable {
		return nil, errors.New("unsupported AMF3 externalizable object")
	}
	obj := map[string]any{}
	if traits.className != "" {
		obj["$type"] = traits.className
	}
	r.objects = append(r.objects, obj)
	for _, key := range traits.keys {
		obj[key], err = r.readAMF3()
		if err != nil {
			return nil, err
		}
	}
	if traits.dynamic {
		for {
			key, err := r.readAMF3String()
			if err != nil {
				return nil, err
			}
			if key == "" {
				break
			}
			obj[key], err = r.readAMF3()
			if err != nil {
				return nil, err
			}
		}
	}
	return obj, nil
}

func readInflated(r io.Reader) ([]byte, error) {
	data, err := io.ReadAll(io.LimitReader(r, maxInflatedPayloadSize+1))
	if err != nil {
		return nil, err
	}
	if len(data) > maxInflatedPayloadSize {
		return nil, errors.New("inflated save payload is too large")
	}
	return data, nil
}

func inflateCandidates(raw []byte) [][]byte {
	candidates := make([][]byte, 0, 4)
	if zr, err := zlib.NewReader(bytes.NewReader(raw)); err == nil {
		if data, err := readInflated(zr); err == nil {
			candidates = append(candidates, data)
		}
		_ = zr.Close()
	}
	fr := flate.NewReader(bytes.NewReader(raw))
	if data, err := readInflated(fr); err == nil {
		candidates = append(candidates, data)
	}
	_ = fr.Close()
	if gr, err := gzip.NewReader(bytes.NewReader(raw)); err == nil {
		if data, err := readInflated(gr); err == nil {
			candidates = append(candidates, data)
		}
		_ = gr.Close()
	}
	candidates = append(candidates, raw)
	return candidates
}

func parseGamePayload(raw []byte) (any, int, error) {
	for _, blob := range inflateCandidates(raw) {
		r := newAMFReader(blob)
		if value, err := r.readValue(); err == nil {
			return value, len(blob), nil
		}
		r = newAMFReader(blob)
		if value, err := r.readAMF3(); err == nil {
			return value, len(blob), nil
		}
	}
	return nil, 0, errors.New("invalid deflated AMF game payload")
}

type amf3Writer struct {
	buf bytes.Buffer
}

func encodeGamePayload(value any) ([]byte, error) {
	writer := &amf3Writer{}
	if err := writer.writeValue(value); err != nil {
		return nil, err
	}
	var compressed bytes.Buffer
	deflater, err := flate.NewWriter(&compressed, flate.DefaultCompression)
	if err != nil {
		return nil, err
	}
	if _, err := deflater.Write(writer.buf.Bytes()); err != nil {
		_ = deflater.Close()
		return nil, err
	}
	if err := deflater.Close(); err != nil {
		return nil, err
	}
	return compressed.Bytes(), nil
}

func (w *amf3Writer) writeU29(value int) {
	value &= 0x1fffffff
	switch {
	case value < 0x80:
		w.buf.WriteByte(byte(value))
	case value < 0x4000:
		w.buf.WriteByte(byte((value>>7)&0x7f | 0x80))
		w.buf.WriteByte(byte(value & 0x7f))
	case value < 0x200000:
		w.buf.WriteByte(byte((value>>14)&0x7f | 0x80))
		w.buf.WriteByte(byte((value>>7)&0x7f | 0x80))
		w.buf.WriteByte(byte(value & 0x7f))
	default:
		w.buf.WriteByte(byte((value>>22)&0x7f | 0x80))
		w.buf.WriteByte(byte((value>>15)&0x7f | 0x80))
		w.buf.WriteByte(byte((value>>8)&0x7f | 0x80))
		w.buf.WriteByte(byte(value))
	}
}

func (w *amf3Writer) writeString(value string) {
	if value == "" {
		w.writeU29(1)
		return
	}
	w.writeU29(len([]byte(value))<<1 | 1)
	w.buf.WriteString(value)
}

func (w *amf3Writer) writeValue(value any) error {
	switch v := value.(type) {
	case nil:
		w.buf.WriteByte(0x01)
	case bool:
		if v {
			w.buf.WriteByte(0x03)
		} else {
			w.buf.WriteByte(0x02)
		}
	case string:
		w.buf.WriteByte(0x06)
		w.writeString(v)
	case int:
		return w.writeNumber(int64(v), float64(v), true)
	case int8:
		return w.writeNumber(int64(v), float64(v), true)
	case int16:
		return w.writeNumber(int64(v), float64(v), true)
	case int32:
		return w.writeNumber(int64(v), float64(v), true)
	case int64:
		return w.writeNumber(v, float64(v), true)
	case uint:
		return w.writeUnsigned(uint64(v))
	case uint8:
		return w.writeUnsigned(uint64(v))
	case uint16:
		return w.writeUnsigned(uint64(v))
	case uint32:
		return w.writeUnsigned(uint64(v))
	case uint64:
		return w.writeUnsigned(v)
	case float32:
		return w.writeDouble(float64(v))
	case float64:
		return w.writeDouble(v)
	case []any:
		w.buf.WriteByte(0x09)
		w.writeU29(len(v)<<1 | 1)
		w.writeString("")
		for _, item := range v {
			if err := w.writeValue(item); err != nil {
				return err
			}
		}
	case map[string]any:
		w.buf.WriteByte(0x0A)
		w.writeU29(0x0B) // inline, dynamic, anonymous object
		w.writeString("")
		keys := make([]string, 0, len(v))
		for key := range v {
			if key != "$type" {
				keys = append(keys, key)
			}
		}
		sort.Strings(keys)
		for _, key := range keys {
			w.writeString(key)
			if err := w.writeValue(v[key]); err != nil {
				return fmt.Errorf("%s: %w", key, err)
			}
		}
		w.writeString("")
	default:
		return fmt.Errorf("unsupported AMF3 value type %T", value)
	}
	return nil
}

func (w *amf3Writer) writeUnsigned(value uint64) error {
	if value <= math.MaxInt64 {
		return w.writeNumber(int64(value), float64(value), true)
	}
	return w.writeDouble(float64(value))
}

func (w *amf3Writer) writeNumber(integer int64, number float64, preferInteger bool) error {
	if preferInteger && integer >= -268435456 && integer <= 268435455 {
		w.buf.WriteByte(0x04)
		w.writeU29(int(integer))
		return nil
	}
	return w.writeDouble(number)
}

func (w *amf3Writer) writeDouble(value float64) error {
	if math.IsNaN(value) || math.IsInf(value, 0) {
		return errors.New("NaN and Infinity are not valid save values")
	}
	w.buf.WriteByte(0x05)
	var data [8]byte
	binary.BigEndian.PutUint64(data[:], math.Float64bits(value))
	_, err := w.buf.Write(data[:])
	return err
}

type solFile struct {
	Name string
	AMF  byte
	Data map[string]any
}

func parseSOL(data []byte) (*solFile, error) {
	if len(data) < 18 || data[0] != 0 || data[1] != 0xbf || string(data[6:10]) != "TCSO" {
		return nil, errors.New("invalid SOL header")
	}
	pos := 14
	if pos+2 > len(data) {
		return nil, io.ErrUnexpectedEOF
	}
	n := int(binary.BigEndian.Uint16(data[pos : pos+2]))
	pos += 2
	if pos+n+4 > len(data) {
		return nil, io.ErrUnexpectedEOF
	}
	name := string(data[pos : pos+n])
	pos += n
	var amfVersion byte
	if pos+4 <= len(data) && data[pos] == 0 && data[pos+1] == 0 && data[pos+2] == 0 {
		amfVersion = data[pos+3]
		pos += 4
	} else {
		amfVersion = data[pos]
		pos++
	}
	r := newAMFReader(data[pos:])
	out := map[string]any{}
	for r.remaining() > 2 {
		key, err := r.utf()
		if err != nil {
			break
		}
		var value any
		if amfVersion == 3 {
			value, err = r.readAMF3()
		} else {
			value, err = r.readValue()
		}
		if err != nil {
			break
		}
		if r.remaining() > 0 && r.data[r.pos] == 0 {
			r.pos++
		}
		out[key] = value
	}
	return &solFile{Name: name, AMF: amfVersion, Data: out}, nil
}

func jsonSafe(value any, depth int) any {
	if depth > 40 {
		return "<maxdepth>"
	}
	switch v := value.(type) {
	case nil, bool, string:
		return v
	case int:
		return v
	case float64:
		if math.IsNaN(v) {
			return nil
		}
		if math.IsInf(v, 0) {
			return fmt.Sprint(v)
		}
		return v
	case []byte:
		return map[string]any{
			"$bytes": base64.StdEncoding.EncodeToString(v),
			"$len":   len(v),
		}
	case []any:
		out := make([]any, len(v))
		for i, item := range v {
			out[i] = jsonSafe(item, depth+1)
		}
		return out
	case map[string]any:
		out := make(map[string]any, len(v))
		for key, item := range v {
			out[key] = jsonSafe(item, depth+1)
		}
		return out
	default:
		return fmt.Sprint(v)
	}
}
