package ctrl4399.proxy.rankListApi
{
   import org.apache.thrift.TApplicationError;
   import org.apache.thrift.TError;
   import org.apache.thrift.protocol.TMessage;
   import org.apache.thrift.protocol.TMessageType;
   import org.apache.thrift.protocol.TProtocol;
   
   public class FlashScoreApiImpl implements FlashScoreApi
   {
      
      protected var iprot_:TProtocol;
      
      protected var oprot_:TProtocol;
      
      protected var seqid_:int;
      
      public function FlashScoreApiImpl(param1:TProtocol, param2:TProtocol = null)
      {
         super();
         this.iprot_ = param1;
         if(param2 == null)
         {
            this.oprot_ = param1;
         }
         else
         {
            this.oprot_ = param2;
         }
      }
      
      public function getInputProtocol() : TProtocol
      {
         return this.iprot_;
      }
      
      public function getOutputProtocol() : TProtocol
      {
         return this.oprot_;
      }
      
      public function submit(param1:ApiHeader, param2:int, param3:Array, param4:Function, param5:Function) : void
      {
         var args:submit_args;
         var header:ApiHeader = param1;
         var index:int = param2;
         var data:Array = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("submit",TMessageType.CALL,this.seqid_));
         args = new submit_args();
         args.header = header;
         args.index = index;
         args.data = data;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:submit_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new submit_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"submit failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function getRankingByArounds(param1:ApiHeader, param2:int, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var args:getRankingByArounds_args;
         var header:ApiHeader = param1;
         var index:int = param2;
         var rId:int = param3;
         var arounds:int = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("getRankingByArounds",TMessageType.CALL,this.seqid_));
         args = new getRankingByArounds_args();
         args.header = header;
         args.index = index;
         args.rId = rId;
         args.arounds = arounds;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getRankingByArounds_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new getRankingByArounds_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getRankingByArounds failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function getRankingByPage(param1:ApiHeader, param2:int, param3:int, param4:int, param5:Function, param6:Function) : void
      {
         var args:getRankingByPage_args;
         var header:ApiHeader = param1;
         var rId:int = param2;
         var pageSize:int = param3;
         var page:int = param4;
         var onError:Function = param5;
         var onSuccess:Function = param6;
         this.oprot_.writeMessageBegin(new TMessage("getRankingByPage",TMessageType.CALL,this.seqid_));
         args = new getRankingByPage_args();
         args.header = header;
         args.rId = rId;
         args.pageSize = pageSize;
         args.page = page;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getRankingByPage_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new getRankingByPage_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getRankingByPage failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function getRank(param1:ApiHeader, param2:int, param3:String, param4:Function, param5:Function) : void
      {
         var args:getRank_args;
         var header:ApiHeader = param1;
         var rId:int = param2;
         var userName:String = param3;
         var onError:Function = param4;
         var onSuccess:Function = param5;
         this.oprot_.writeMessageBegin(new TMessage("getRank",TMessageType.CALL,this.seqid_));
         args = new getRank_args();
         args.header = header;
         args.rId = rId;
         args.userName = userName;
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:getRank_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new getRank_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"getRank failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
      
      public function test(param1:Function, param2:Function) : void
      {
         var args:test_args;
         var onError:Function = param1;
         var onSuccess:Function = param2;
         this.oprot_.writeMessageBegin(new TMessage("test",TMessageType.CALL,this.seqid_));
         args = new test_args();
         args.write(this.oprot_);
         this.oprot_.writeMessageEnd();
         this.oprot_.getTransport().flush(function(param1:Error):void
         {
            var msg:TMessage = null;
            var result:test_result = null;
            var x:TApplicationError = null;
            var error:Error = param1;
            try
            {
               if(error != null)
               {
                  if(onError != null)
                  {
                     onError(error);
                  }
                  return;
               }
               msg = iprot_.readMessageBegin();
               if(msg.type == TMessageType.EXCEPTION)
               {
                  x = TApplicationError.read(iprot_);
                  iprot_.readMessageEnd();
                  if(onError != null)
                  {
                     onError(x);
                  }
                  return;
               }
               result = new test_result();
               result.read(iprot_);
               iprot_.readMessageEnd();
               if(result.isSetSuccess())
               {
                  if(onSuccess != null)
                  {
                     onSuccess(result.success);
                  }
                  return;
               }
               if(onError != null)
               {
                  onError(new TApplicationError(TApplicationError.MISSING_RESULT,"test failed: unknown result"));
               }
            }
            catch(e:TError)
            {
               if(onError != null)
               {
                  onError(e);
               }
            }
         });
      }
   }
}

import flash.utils.Dictionary;
import org.apache.thrift.*;
import org.apache.thrift.meta_data.*;
import org.apache.thrift.protocol.*;

class submit_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("submit_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const INDEX_FIELD_DESC:TField = new TField("index",TType.I32,2);
   
   private static const DATA_FIELD_DESC:TField = new TField("data",TType.LIST,3);
   
   public static const HEADER:int = 1;
   
   public static const INDEX:int = 2;
   
   public static const DATA:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[DATA] = new FieldMetaData("data",TFieldRequirementType.DEFAULT,new ListMetaData(TType.LIST,new StructMetaData(TType.STRUCT,FSQE_Submit)));
   FieldMetaData.addStructMetaDataMap(submit_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _index:int;
   
   private var _data:Array;
   
   private var __isset_index:Boolean = false;
   
   public function submit_args()
   {
      super();
   }
   
   public function get header() : ApiHeader
   {
      return this._header;
   }
   
   public function set header(param1:ApiHeader) : void
   {
      this._header = param1;
   }
   
   public function unsetHeader() : void
   {
      this.header = null;
   }
   
   public function isSetHeader() : Boolean
   {
      return this.header != null;
   }
   
   public function get index() : int
   {
      return this._index;
   }
   
   public function set index(param1:int) : void
   {
      this._index = param1;
      this.__isset_index = true;
   }
   
   public function unsetIndex() : void
   {
      this.__isset_index = false;
   }
   
   public function isSetIndex() : Boolean
   {
      return this.__isset_index;
   }
   
   public function get data() : Array
   {
      return this._data;
   }
   
   public function set data(param1:Array) : void
   {
      this._data = param1;
   }
   
   public function unsetData() : void
   {
      this.data = null;
   }
   
   public function isSetData() : Boolean
   {
      return this.data != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEADER:
            if(param2 == null)
            {
               this.unsetHeader();
            }
            else
            {
               this.header = param2;
            }
            break;
         case INDEX:
            if(param2 == null)
            {
               this.unsetIndex();
            }
            else
            {
               this.index = param2;
            }
            break;
         case DATA:
            if(param2 == null)
            {
               this.unsetData();
            }
            else
            {
               this.data = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case HEADER:
            return this.header;
         case INDEX:
            return this.index;
         case DATA:
            return this.data;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEADER:
            return this.isSetHeader();
         case INDEX:
            return this.isSetIndex();
         case DATA:
            return this.isSetData();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      var _loc3_:TList = null;
      var _loc4_:int = 0;
      var _loc5_:FSQE_Submit = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case HEADER:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.header = new ApiHeader();
                  this.header.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case INDEX:
               if(_loc2_.type == TType.I32)
               {
                  this.index = param1.readI32();
                  this.__isset_index = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case DATA:
               if(_loc2_.type == TType.LIST)
               {
                  _loc3_ = param1.readListBegin();
                  this.data = new Array();
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.size)
                  {
                     _loc5_ = new FSQE_Submit();
                     _loc5_.read(param1);
                     this.data.push(_loc5_);
                     _loc4_++;
                  }
                  param1.readListEnd();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      var _loc2_:* = undefined;
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.header != null)
      {
         param1.writeFieldBegin(HEADER_FIELD_DESC);
         this.header.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(INDEX_FIELD_DESC);
      param1.writeI32(this.index);
      param1.writeFieldEnd();
      if(this.data != null)
      {
         param1.writeFieldBegin(DATA_FIELD_DESC);
         param1.writeListBegin(new TList(TType.STRUCT,this.data.length));
         for each(_loc2_ in this.data)
         {
            _loc2_.write(param1);
         }
         param1.writeListEnd();
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("submit_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "header:";
      if(this.header == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.header;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "index:";
      _loc1_ += this.index;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "data:";
      if(this.data == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.data;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class submit_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("submit_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.MAP,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new MapMetaData(TType.MAP,new FieldValueMetaData(TType.I32),new StructMetaData(TType.STRUCT,FSR_Submit)));
   FieldMetaData.addStructMetaDataMap(submit_result,metaDataMap);
   
   private var _success:Dictionary;
   
   public function submit_result()
   {
      super();
   }
   
   public function get success() : Dictionary
   {
      return this._success;
   }
   
   public function set success(param1:Dictionary) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      var _loc3_:TMap = null;
      var _loc4_:int = 0;
      var _loc5_:int = 0;
      var _loc6_:FSR_Submit = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.MAP)
               {
                  _loc3_ = param1.readMapBegin();
                  this.success = new Dictionary();
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.size)
                  {
                     _loc5_ = param1.readI32();
                     _loc6_ = new FSR_Submit();
                     _loc6_.read(param1);
                     this.success[_loc5_] = _loc6_;
                     _loc4_++;
                  }
                  param1.readMapEnd();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      var _loc2_:int = 0;
      var _loc3_:* = undefined;
      var _loc4_:* = undefined;
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         _loc2_ = 0;
         for(_loc3_ in this.success)
         {
            _loc2_++;
         }
         param1.writeMapBegin(new TMap(TType.I32,TType.STRUCT,_loc2_));
         for(_loc4_ in this.success)
         {
            param1.writeI32(_loc4_);
            this.success[_loc4_].write(param1);
         }
         param1.writeMapEnd();
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("submit_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRankingByArounds_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRankingByArounds_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const INDEX_FIELD_DESC:TField = new TField("index",TType.I32,2);
   
   private static const R_ID_FIELD_DESC:TField = new TField("rId",TType.I32,3);
   
   private static const AROUNDS_FIELD_DESC:TField = new TField("arounds",TType.I32,4);
   
   public static const HEADER:int = 1;
   
   public static const INDEX:int = 2;
   
   public static const RID:int = 3;
   
   public static const AROUNDS:int = 4;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[INDEX] = new FieldMetaData("index",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[RID] = new FieldMetaData("rId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[AROUNDS] = new FieldMetaData("arounds",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(getRankingByArounds_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _index:int;
   
   private var _rId:int;
   
   private var _arounds:int;
   
   private var __isset_index:Boolean = false;
   
   private var __isset_rId:Boolean = false;
   
   private var __isset_arounds:Boolean = false;
   
   public function getRankingByArounds_args()
   {
      super();
   }
   
   public function get header() : ApiHeader
   {
      return this._header;
   }
   
   public function set header(param1:ApiHeader) : void
   {
      this._header = param1;
   }
   
   public function unsetHeader() : void
   {
      this.header = null;
   }
   
   public function isSetHeader() : Boolean
   {
      return this.header != null;
   }
   
   public function get index() : int
   {
      return this._index;
   }
   
   public function set index(param1:int) : void
   {
      this._index = param1;
      this.__isset_index = true;
   }
   
   public function unsetIndex() : void
   {
      this.__isset_index = false;
   }
   
   public function isSetIndex() : Boolean
   {
      return this.__isset_index;
   }
   
   public function get rId() : int
   {
      return this._rId;
   }
   
   public function set rId(param1:int) : void
   {
      this._rId = param1;
      this.__isset_rId = true;
   }
   
   public function unsetRId() : void
   {
      this.__isset_rId = false;
   }
   
   public function isSetRId() : Boolean
   {
      return this.__isset_rId;
   }
   
   public function get arounds() : int
   {
      return this._arounds;
   }
   
   public function set arounds(param1:int) : void
   {
      this._arounds = param1;
      this.__isset_arounds = true;
   }
   
   public function unsetArounds() : void
   {
      this.__isset_arounds = false;
   }
   
   public function isSetArounds() : Boolean
   {
      return this.__isset_arounds;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEADER:
            if(param2 == null)
            {
               this.unsetHeader();
            }
            else
            {
               this.header = param2;
            }
            break;
         case INDEX:
            if(param2 == null)
            {
               this.unsetIndex();
            }
            else
            {
               this.index = param2;
            }
            break;
         case RID:
            if(param2 == null)
            {
               this.unsetRId();
            }
            else
            {
               this.rId = param2;
            }
            break;
         case AROUNDS:
            if(param2 == null)
            {
               this.unsetArounds();
            }
            else
            {
               this.arounds = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case HEADER:
            return this.header;
         case INDEX:
            return this.index;
         case RID:
            return this.rId;
         case AROUNDS:
            return this.arounds;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEADER:
            return this.isSetHeader();
         case INDEX:
            return this.isSetIndex();
         case RID:
            return this.isSetRId();
         case AROUNDS:
            return this.isSetArounds();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case HEADER:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.header = new ApiHeader();
                  this.header.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case INDEX:
               if(_loc2_.type == TType.I32)
               {
                  this.index = param1.readI32();
                  this.__isset_index = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case RID:
               if(_loc2_.type == TType.I32)
               {
                  this.rId = param1.readI32();
                  this.__isset_rId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case AROUNDS:
               if(_loc2_.type == TType.I32)
               {
                  this.arounds = param1.readI32();
                  this.__isset_arounds = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.header != null)
      {
         param1.writeFieldBegin(HEADER_FIELD_DESC);
         this.header.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(INDEX_FIELD_DESC);
      param1.writeI32(this.index);
      param1.writeFieldEnd();
      param1.writeFieldBegin(R_ID_FIELD_DESC);
      param1.writeI32(this.rId);
      param1.writeFieldEnd();
      param1.writeFieldBegin(AROUNDS_FIELD_DESC);
      param1.writeI32(this.arounds);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRankingByArounds_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "header:";
      if(this.header == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.header;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "index:";
      _loc1_ += this.index;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "rId:";
      _loc1_ += this.rId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "arounds:";
      _loc1_ += this.arounds;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRankingByArounds_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRankingByArounds_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,FSR_GetRanking));
   FieldMetaData.addStructMetaDataMap(getRankingByArounds_result,metaDataMap);
   
   private var _success:FSR_GetRanking;
   
   public function getRankingByArounds_result()
   {
      super();
   }
   
   public function get success() : FSR_GetRanking
   {
      return this._success;
   }
   
   public function set success(param1:FSR_GetRanking) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.success = new FSR_GetRanking();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         this.success.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRankingByArounds_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRankingByPage_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRankingByPage_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const R_ID_FIELD_DESC:TField = new TField("rId",TType.I32,2);
   
   private static const PAGE_SIZE_FIELD_DESC:TField = new TField("pageSize",TType.I32,3);
   
   private static const PAGE_FIELD_DESC:TField = new TField("page",TType.I32,4);
   
   public static const HEADER:int = 1;
   
   public static const RID:int = 2;
   
   public static const PAGESIZE:int = 3;
   
   public static const PAGE:int = 4;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[RID] = new FieldMetaData("rId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[PAGESIZE] = new FieldMetaData("pageSize",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[PAGE] = new FieldMetaData("page",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   FieldMetaData.addStructMetaDataMap(getRankingByPage_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _rId:int;
   
   private var _pageSize:int;
   
   private var _page:int;
   
   private var __isset_rId:Boolean = false;
   
   private var __isset_pageSize:Boolean = false;
   
   private var __isset_page:Boolean = false;
   
   public function getRankingByPage_args()
   {
      super();
   }
   
   public function get header() : ApiHeader
   {
      return this._header;
   }
   
   public function set header(param1:ApiHeader) : void
   {
      this._header = param1;
   }
   
   public function unsetHeader() : void
   {
      this.header = null;
   }
   
   public function isSetHeader() : Boolean
   {
      return this.header != null;
   }
   
   public function get rId() : int
   {
      return this._rId;
   }
   
   public function set rId(param1:int) : void
   {
      this._rId = param1;
      this.__isset_rId = true;
   }
   
   public function unsetRId() : void
   {
      this.__isset_rId = false;
   }
   
   public function isSetRId() : Boolean
   {
      return this.__isset_rId;
   }
   
   public function get pageSize() : int
   {
      return this._pageSize;
   }
   
   public function set pageSize(param1:int) : void
   {
      this._pageSize = param1;
      this.__isset_pageSize = true;
   }
   
   public function unsetPageSize() : void
   {
      this.__isset_pageSize = false;
   }
   
   public function isSetPageSize() : Boolean
   {
      return this.__isset_pageSize;
   }
   
   public function get page() : int
   {
      return this._page;
   }
   
   public function set page(param1:int) : void
   {
      this._page = param1;
      this.__isset_page = true;
   }
   
   public function unsetPage() : void
   {
      this.__isset_page = false;
   }
   
   public function isSetPage() : Boolean
   {
      return this.__isset_page;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEADER:
            if(param2 == null)
            {
               this.unsetHeader();
            }
            else
            {
               this.header = param2;
            }
            break;
         case RID:
            if(param2 == null)
            {
               this.unsetRId();
            }
            else
            {
               this.rId = param2;
            }
            break;
         case PAGESIZE:
            if(param2 == null)
            {
               this.unsetPageSize();
            }
            else
            {
               this.pageSize = param2;
            }
            break;
         case PAGE:
            if(param2 == null)
            {
               this.unsetPage();
            }
            else
            {
               this.page = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case HEADER:
            return this.header;
         case RID:
            return this.rId;
         case PAGESIZE:
            return this.pageSize;
         case PAGE:
            return this.page;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEADER:
            return this.isSetHeader();
         case RID:
            return this.isSetRId();
         case PAGESIZE:
            return this.isSetPageSize();
         case PAGE:
            return this.isSetPage();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case HEADER:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.header = new ApiHeader();
                  this.header.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case RID:
               if(_loc2_.type == TType.I32)
               {
                  this.rId = param1.readI32();
                  this.__isset_rId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case PAGESIZE:
               if(_loc2_.type == TType.I32)
               {
                  this.pageSize = param1.readI32();
                  this.__isset_pageSize = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case PAGE:
               if(_loc2_.type == TType.I32)
               {
                  this.page = param1.readI32();
                  this.__isset_page = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.header != null)
      {
         param1.writeFieldBegin(HEADER_FIELD_DESC);
         this.header.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(R_ID_FIELD_DESC);
      param1.writeI32(this.rId);
      param1.writeFieldEnd();
      param1.writeFieldBegin(PAGE_SIZE_FIELD_DESC);
      param1.writeI32(this.pageSize);
      param1.writeFieldEnd();
      param1.writeFieldBegin(PAGE_FIELD_DESC);
      param1.writeI32(this.page);
      param1.writeFieldEnd();
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRankingByPage_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "header:";
      if(this.header == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.header;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "rId:";
      _loc1_ += this.rId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "pageSize:";
      _loc1_ += this.pageSize;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "page:";
      _loc1_ += this.page;
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRankingByPage_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRankingByPage_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,FSR_GetRanking));
   FieldMetaData.addStructMetaDataMap(getRankingByPage_result,metaDataMap);
   
   private var _success:FSR_GetRanking;
   
   public function getRankingByPage_result()
   {
      super();
   }
   
   public function get success() : FSR_GetRanking
   {
      return this._success;
   }
   
   public function set success(param1:FSR_GetRanking) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.success = new FSR_GetRanking();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         this.success.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRankingByPage_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRank_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRank_args");
   
   private static const HEADER_FIELD_DESC:TField = new TField("header",TType.STRUCT,1);
   
   private static const R_ID_FIELD_DESC:TField = new TField("rId",TType.I32,2);
   
   private static const USER_NAME_FIELD_DESC:TField = new TField("userName",TType.STRING,3);
   
   public static const HEADER:int = 1;
   
   public static const RID:int = 2;
   
   public static const USERNAME:int = 3;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[HEADER] = new FieldMetaData("header",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,ApiHeader));
   metaDataMap[RID] = new FieldMetaData("rId",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.I32));
   metaDataMap[USERNAME] = new FieldMetaData("userName",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   FieldMetaData.addStructMetaDataMap(getRank_args,metaDataMap);
   
   private var _header:ApiHeader;
   
   private var _rId:int;
   
   private var _userName:String;
   
   private var __isset_rId:Boolean = false;
   
   public function getRank_args()
   {
      super();
   }
   
   public function get header() : ApiHeader
   {
      return this._header;
   }
   
   public function set header(param1:ApiHeader) : void
   {
      this._header = param1;
   }
   
   public function unsetHeader() : void
   {
      this.header = null;
   }
   
   public function isSetHeader() : Boolean
   {
      return this.header != null;
   }
   
   public function get rId() : int
   {
      return this._rId;
   }
   
   public function set rId(param1:int) : void
   {
      this._rId = param1;
      this.__isset_rId = true;
   }
   
   public function unsetRId() : void
   {
      this.__isset_rId = false;
   }
   
   public function isSetRId() : Boolean
   {
      return this.__isset_rId;
   }
   
   public function get userName() : String
   {
      return this._userName;
   }
   
   public function set userName(param1:String) : void
   {
      this._userName = param1;
   }
   
   public function unsetUserName() : void
   {
      this.userName = null;
   }
   
   public function isSetUserName() : Boolean
   {
      return this.userName != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case HEADER:
            if(param2 == null)
            {
               this.unsetHeader();
            }
            else
            {
               this.header = param2;
            }
            break;
         case RID:
            if(param2 == null)
            {
               this.unsetRId();
            }
            else
            {
               this.rId = param2;
            }
            break;
         case USERNAME:
            if(param2 == null)
            {
               this.unsetUserName();
            }
            else
            {
               this.userName = param2;
            }
            break;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case HEADER:
            return this.header;
         case RID:
            return this.rId;
         case USERNAME:
            return this.userName;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case HEADER:
            return this.isSetHeader();
         case RID:
            return this.isSetRId();
         case USERNAME:
            return this.isSetUserName();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case HEADER:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.header = new ApiHeader();
                  this.header.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case RID:
               if(_loc2_.type == TType.I32)
               {
                  this.rId = param1.readI32();
                  this.__isset_rId = true;
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            case USERNAME:
               if(_loc2_.type == TType.STRING)
               {
                  this.userName = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      if(this.header != null)
      {
         param1.writeFieldBegin(HEADER_FIELD_DESC);
         this.header.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldBegin(R_ID_FIELD_DESC);
      param1.writeI32(this.rId);
      param1.writeFieldEnd();
      if(this.userName != null)
      {
         param1.writeFieldBegin(USER_NAME_FIELD_DESC);
         param1.writeString(this.userName);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRank_args(");
      var _loc2_:Boolean = true;
      _loc1_ += "header:";
      if(this.header == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.header;
      }
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "rId:";
      _loc1_ += this.rId;
      _loc2_ = false;
      if(!_loc2_)
      {
         _loc1_ += ", ";
      }
      _loc1_ += "userName:";
      if(this.userName == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.userName;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class getRank_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("getRank_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRUCT,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new StructMetaData(TType.STRUCT,FSR_GetRank));
   FieldMetaData.addStructMetaDataMap(getRank_result,metaDataMap);
   
   private var _success:FSR_GetRank;
   
   public function getRank_result()
   {
      super();
   }
   
   public function get success() : FSR_GetRank
   {
      return this._success;
   }
   
   public function set success(param1:FSR_GetRank) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRUCT)
               {
                  this.success = new FSR_GetRank();
                  this.success.read(param1);
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         this.success.write(param1);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("getRank_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class test_args implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("test_args");
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   FieldMetaData.addStructMetaDataMap(test_args,metaDataMap);
   
   public function test_args()
   {
      super();
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      var _loc3_:int = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function getFieldValue(param1:int) : *
   {
      var _loc2_:int = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function isSet(param1:int) : Boolean
   {
      var _loc2_:int = param1;
      switch(0)
      {
      }
      throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         var _loc3_:int = _loc2_.id;
         switch(0)
         {
         }
         TProtocolUtil.skip(param1,_loc2_.type);
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      this.validate();
      param1.writeStructBegin(STRUCT_DESC);
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("test_args(");
      var _loc2_:Boolean = true;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}

class test_result implements TBase
{
   
   private static const STRUCT_DESC:TStruct = new TStruct("test_result");
   
   private static const SUCCESS_FIELD_DESC:TField = new TField("success",TType.STRING,0);
   
   public static const SUCCESS:int = 0;
   
   public static const metaDataMap:Dictionary = new Dictionary();
   
   metaDataMap[SUCCESS] = new FieldMetaData("success",TFieldRequirementType.DEFAULT,new FieldValueMetaData(TType.STRING));
   FieldMetaData.addStructMetaDataMap(test_result,metaDataMap);
   
   private var _success:String;
   
   public function test_result()
   {
      super();
   }
   
   public function get success() : String
   {
      return this._success;
   }
   
   public function set success(param1:String) : void
   {
      this._success = param1;
   }
   
   public function unsetSuccess() : void
   {
      this.success = null;
   }
   
   public function isSetSuccess() : Boolean
   {
      return this.success != null;
   }
   
   public function setFieldValue(param1:int, param2:*) : void
   {
      switch(param1)
      {
         case SUCCESS:
            if(param2 == null)
            {
               this.unsetSuccess();
            }
            else
            {
               this.success = param2;
            }
            return;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function getFieldValue(param1:int) : *
   {
      switch(param1)
      {
         case SUCCESS:
            return this.success;
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function isSet(param1:int) : Boolean
   {
      switch(param1)
      {
         case SUCCESS:
            return this.isSetSuccess();
         default:
            throw new ArgumentError("Field " + param1 + " doesn\'t exist!");
      }
   }
   
   public function read(param1:TProtocol) : void
   {
      var _loc2_:TField = null;
      param1.readStructBegin();
      while(true)
      {
         _loc2_ = param1.readFieldBegin();
         if(_loc2_.type == TType.STOP)
         {
            break;
         }
         switch(_loc2_.id)
         {
            case SUCCESS:
               if(_loc2_.type == TType.STRING)
               {
                  this.success = param1.readString();
               }
               else
               {
                  TProtocolUtil.skip(param1,_loc2_.type);
               }
               break;
            default:
               TProtocolUtil.skip(param1,_loc2_.type);
         }
         param1.readFieldEnd();
      }
      param1.readStructEnd();
      this.validate();
   }
   
   public function write(param1:TProtocol) : void
   {
      param1.writeStructBegin(STRUCT_DESC);
      if(this.isSetSuccess())
      {
         param1.writeFieldBegin(SUCCESS_FIELD_DESC);
         param1.writeString(this.success);
         param1.writeFieldEnd();
      }
      param1.writeFieldStop();
      param1.writeStructEnd();
   }
   
   public function toString() : String
   {
      var _loc1_:String = new String("test_result(");
      var _loc2_:Boolean = true;
      _loc1_ += "success:";
      if(this.success == null)
      {
         _loc1_ += "null";
      }
      else
      {
         _loc1_ += this.success;
      }
      _loc2_ = false;
      return _loc1_ + ")";
   }
   
   public function validate() : void
   {
   }
}
