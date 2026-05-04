#!/bin/bash

usage='
# $0 file.org [pdf]

# Accepts filename, and exports the file content to TEX (default),
# or further to PDF (given 2nd arg pdf).

# The file is intended to (but does not have to):
#   - have .org extension and contain org formatted text
#   - also contain AsciiMath text inside `...`
# The script does:
#   1. Open/find-file the .org file, search for each AsciiMath snippet inside the `...`,
#      then convert the AsciiMath snippet to Latex, then override the AsciiMath
#      snippet with the Latex version.
#   2. Save the file as ".tex.org"
#   3. Export the ".tex.org" file to PDF, and save/write-file the PDF buffer to ".pdf" file.
#
'  

if [[ $# -lt 1 ]]; then
    echo Missing file name argument - unknown file to convert.
    echo $usage
    echo exiting
    exit 1
fi

if [[ $# -eq 2 ]]; then
    if [[ $2 != pdf ]]; then
        echo Second argument, if given, must be pdf
        echo $usage
        echo exiting
        exit 1
    fi
    do_export_tex_org_to_pdf=yes
fi


# input_ascm_org will likely be .org file.
# It can be in another directory.
# The rest of files are in THIS directory.
input_ascm_org="$1"

input_ascm_dirname="$(dirname $input_ascm_org)/"   ; echo input_ascm_dirname=$input_ascm_dirname
input_ascm_filename="$(basename  $input_ascm_org)" ; echo input_ascm_filename=$input_ascm_filename
input_ascm_basename="${input_ascm_filename%.*}"    ; echo input_ascm_basename=$input_ascm_basename
output_dirname=$(pwd)
output_tex_org="${output_dirname}/${input_ascm_basename}.tex.org"    ; echo output_tex_org=$output_tex_org

# Check if the input file exists
if [ ! -f "$input_ascm_org" ]; then
    echo "Error: File '$input_ascm_org' not found. Exiting."
    exit 1
fi


echo "=== Running convert of .org (with asciimath) to .tex.org (org with tex) ==="

# run .el file which call shell script named ~asciimath2tex-node.sh~
# that converts asciimath to tex in the file ~$input_ascm_org~
emacs \
    --batch \
    --load ~/bin/convert-file-with-asciimath-to-file-with-tex.el \
    --eval "(my/convert-file-with-asciimath-to-file-with-tex \"$input_ascm_org\" \"$output_tex_org\")"


if [[ $do_export_tex_org_to_pdf == yes ]]; then
    echo
    echo "=== Running export .tex.org to .pdf ==="

    emacs \
        --batch \
        --eval "(progn (find-file \"${output_tex_org}\") (org-latex-export-to-pdf))" 
fi
