#!/usr/bin/env node

// Converts a single asciimath expression to tex expression. 
// Some examples of running this standalone by entering a asciimath valid string:
//   asciimath2tex-node.sh 'a != b'
//   asciimath2tex-node.sh 'a sube b'
//
// Uses asciimath2text node library from: https://www.npmjs.com/package/asciimath2tex
// 

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
