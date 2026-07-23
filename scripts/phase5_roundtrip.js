const fs = require("fs");

const args = process.argv.slice(2);
if (args[0] === "--verify") {
  const response = JSON.parse(fs.readFileSync(args[1], "utf8"));
  if (!response.ok) {
    throw new Error(`save response failed: ${JSON.stringify(response)}`);
  }
  console.log(`[OK] editor save response: ${response.size} bytes`);
  process.exit(0);
}

const [input, output] = args;
if (!input || !output) {
  throw new Error("usage: node phase5_roundtrip.js <editor-data.json> <save-request.json>");
}

const response = JSON.parse(fs.readFileSync(input, "utf8"));
if (!response.ok || !response.game_data || typeof response.game_data !== "object") {
  throw new Error(`editor data is invalid: ${JSON.stringify(response)}`);
}

fs.writeFileSync(output, JSON.stringify({ game_data: response.game_data }));
console.log(`[OK] editor data parsed: ${response.size} bytes`);
