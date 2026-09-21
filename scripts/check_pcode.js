"use strict";

const fs = require("node:fs");
const path = require("node:path");

function parseCodeSections(text) {
  const lines = text.split(/\r?\n/);
  const sections = [];
  let current = null;

  for (const raw of lines) {
    const line = raw.trim();
    if (line === "code") {
      current = [];
      continue;
    }
    if (line === "end ; code") {
      if (current) sections.push(current);
      current = null;
      continue;
    }
    if (!current || !line || line.startsWith(";")) continue;
    current.push(line);
  }
  return sections;
}

function analyzeSection(lines, sectionNumber) {
  const instructions = [];
  const labels = new Map();
  for (const line of lines) {
    const label = line.match(/^(ofs[0-9a-f]+):$/i);
    if (label) {
      labels.set(label[1].toLowerCase(), instructions.length);
    } else {
      instructions.push(line);
    }
  }
  if (instructions.length === 0) return [];

  const leaders = new Set([0, ...labels.values()]);
  const branchPattern = /^(?:if\w+|jump)\s+(ofs[0-9a-f]+)/i;
  for (let i = 0; i < instructions.length; i++) {
    if (branchPattern.test(instructions[i]) && i + 1 < instructions.length) {
      leaders.add(i + 1);
    }
  }

  const starts = [...leaders].sort((a, b) => a - b);
  const blockByInstruction = new Map();
  const blocks = starts.map((start, index) => {
    const end = (starts[index + 1] ?? instructions.length) - 1;
    const block = { index, start, end, edges: new Set() };
    for (let i = start; i <= end; i++) blockByInstruction.set(i, block);
    return block;
  });

  const errors = [];
  for (const block of blocks) {
    const last = instructions[block.end];
    const branch = last.match(branchPattern);
    const isJump = /^jump\b/i.test(last);
    const isReturn = /^(?:returnvoid|returnvalue|throw)\b/i.test(last);
    if (branch) {
      const target = branch[1].toLowerCase();
      if (!labels.has(target)) {
        errors.push(`section ${sectionNumber}: missing label ${target}`);
      } else {
        block.edges.add(blockByInstruction.get(labels.get(target)).index);
      }
    }
    if (!isJump && !isReturn && block.index + 1 < blocks.length) {
      block.edges.add(block.index + 1);
    }
  }

  const reachable = new Set();
  const visit = (index) => {
    if (reachable.has(index)) return;
    reachable.add(index);
    for (const next of blocks[index].edges) visit(next);
  };
  visit(0);

  const reachableReturn = blocks.some(
    (block) =>
      reachable.has(block.index) &&
      /^(?:returnvoid|returnvalue|throw)\b/i.test(instructions[block.end]),
  );
  const hasReturn = instructions.some((line) =>
    /^(?:returnvoid|returnvalue|throw)\b/i.test(line),
  );
  if (hasReturn && !reachableReturn) {
    errors.push(`section ${sectionNumber}: return/throw is unreachable`);
  }

  let nextIndex = 0;
  const stack = [];
  const onStack = new Set();
  const indices = new Map();
  const low = new Map();

  function strongConnect(blockIndex) {
    indices.set(blockIndex, nextIndex);
    low.set(blockIndex, nextIndex++);
    stack.push(blockIndex);
    onStack.add(blockIndex);

    for (const target of blocks[blockIndex].edges) {
      if (!reachable.has(target)) continue;
      if (!indices.has(target)) {
        strongConnect(target);
        low.set(blockIndex, Math.min(low.get(blockIndex), low.get(target)));
      } else if (onStack.has(target)) {
        low.set(blockIndex, Math.min(low.get(blockIndex), indices.get(target)));
      }
    }

    if (low.get(blockIndex) !== indices.get(blockIndex)) return;
    const component = [];
    let item;
    do {
      item = stack.pop();
      onStack.delete(item);
      component.push(item);
    } while (item !== blockIndex);

    const members = new Set(component);
    const cyclic =
      component.length > 1 ||
      blocks[component[0]].edges.has(component[0]);
    const hasExit = component.some((member) =>
      [...blocks[member].edges].some((target) => !members.has(target)),
    );
    const hasTerminal = component.some((member) =>
      /^(?:returnvoid|returnvalue|throw)\b/i.test(
        instructions[blocks[member].end],
      ),
    );
    if (cyclic && !hasExit && !hasTerminal) {
      errors.push(`section ${sectionNumber}: closed control-flow cycle`);
    }
  }

  for (const block of blocks) {
    if (reachable.has(block.index) && !indices.has(block.index)) {
      strongConnect(block.index);
    }
  }
  return errors;
}

function checkFile(file) {
  const text = fs.readFileSync(file, "utf8");
  const sections = parseCodeSections(text);
  if (sections.length === 0) return ["no P-code sections found"];
  return sections.flatMap((section, index) => analyzeSection(section, index + 1));
}

const input = process.argv[2];
if (!input) {
  console.error("Usage: node scripts/check_pcode.js <file-or-directory>");
  process.exit(2);
}

const stat = fs.statSync(input);
const files = stat.isDirectory()
  ? fs
      .readdirSync(input, { recursive: true })
      .filter((name) => name.toLowerCase().endsWith(".pcode"))
      .map((name) => path.join(input, name))
  : [input];

if (files.length === 0) {
  console.error("[ERROR] No .pcode files found.");
  process.exit(2);
}

let failed = false;
for (const file of files) {
  const errors = checkFile(file);
  if (errors.length) {
    failed = true;
    for (const error of errors) console.error(`[ERROR] ${file}: ${error}`);
  }
}

if (failed) process.exit(1);
console.log(`[OK] P-code control flow passed: ${files.length} file(s).`);
