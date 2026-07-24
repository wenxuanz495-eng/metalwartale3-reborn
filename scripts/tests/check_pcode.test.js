const assert = require("node:assert/strict");
const { spawnSync } = require("node:child_process");
const path = require("node:path");
const test = require("node:test");

const checker = path.resolve(__dirname, "..", "check_pcode.js");
const fixture = (name) => path.join(__dirname, "fixtures", name);

function run(name) {
  return spawnSync(process.execPath, [checker, fixture(name)], {
    encoding: "utf8",
  });
}

test("accepts a bounded loop with a reachable return", () => {
  const result = run("pcode-bounded.pcode");
  assert.equal(result.status, 0, result.stderr);
});

test("rejects a closed loop whose return is unreachable", () => {
  const result = run("pcode-closed-loop.pcode");
  assert.notEqual(result.status, 0);
  assert.match(result.stderr, /closed control-flow cycle/i);
});

test("rejects a branch to a missing label", () => {
  const result = run("pcode-bad-target.pcode");
  assert.notEqual(result.status, 0);
  assert.match(result.stderr, /missing label/i);
});
