const fs = require("fs");

const file = process.argv[2];
if (!file) {
  throw new Error("usage: node check_modifier.js <modifier.html>");
}

const html = fs.readFileSync(file, "utf8");
const scripts = [...html.matchAll(/<script(?:\s[^>]*)?>([\s\S]*?)<\/script>/gi)];
if (!scripts.length) {
  throw new Error(`no inline scripts found: ${file}`);
}

for (const [index, match] of scripts.entries()) {
  try {
    new Function(match[1]);
  } catch (error) {
    throw new Error(`invalid JavaScript in ${file}, script ${index + 1}: ${error.message}`);
  }
}

if (html.includes('id="editorFrame"')) {
  const required = [
    /const\s+freeHeartLevels\s*=/,
    /function\s+indexedValue\s*\(/,
    /function\s+saveSlotEntries\s*\(/,
    /function\s+saveSlotAt\s*\(/,
    /function\s+normalizeLocalSlots\s*\(/,
    /function\s+waitEditorFrameReady\s*\(/,
    /function\s+ensureNewLevelData\s*\(/,
    /const\s+slotMarker\s*=\s*['"]const EDITOR_SLOT_INDEX=-1;/,
  ];
  for (const pattern of required) {
    if (!pattern.test(html)) {
      throw new Error(`missing modifier runtime dependency ${pattern}: ${file}`);
    }
  }
  if (!/featureData\.autoCollectLifePer===false/.test(html) ||
      !/d\.autoCollectLifePer=!Boolean\(doc\.getElementById\("disableAutoCollectLifePer"\)\.checked\)/.test(html)) {
    throw new Error(`medical-kit auto-collect toggle is not mapped as checked=disabled: ${file}`);
  }
}

if (/gameData\.localSlots\s*\[/.test(html)) {
    throw new Error('fragile localSlots indexing found in ' + file);
  }
  console.log(`[OK] modifier JavaScript: ${file}`);
