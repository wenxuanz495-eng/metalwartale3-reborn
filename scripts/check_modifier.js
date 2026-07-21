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

console.log(`[OK] modifier JavaScript: ${file}`);
