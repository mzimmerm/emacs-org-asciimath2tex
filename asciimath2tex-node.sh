#!/usr/bin/env node
// Converts a single asciimath expression to tex expression. 

const AsciiMathParser = require('asciimath2tex');
const parser = new AsciiMathParser();

const asciimath = process.argv[2];
if (!asciimath) {
    console.error("Usage: asciimath2tex-node.sh '<asciimath expression>'");
    process.exit(1);
}

const tex = parser.parse(asciimath);
// console.log(tex);
process.stdout.write(tex);
