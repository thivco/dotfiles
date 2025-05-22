#!/usr/bin/env bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <input-file> <output-file>"
  exit 1
fi

INPUT=$(printf "%b" "$1")
OUTPUT=$(printf "%b" "$2")

if [ ! -f "$INPUT" ]; then
  echo "Error: Input file not found: $INPUT"
  exit 1
fi

touch "$OUTPUT" || {
  echo "Error: Cannot write to output file: $OUTPUT"
  exit 1
}

content=$(cat "$INPUT")

# Could be simplified using something else than regex, not really human readable
printf '%s\n' "$content" | awk '
BEGIN { RS="</annotation>"; FS="\n" }
{
  ann_block = $0 "</annotation>"
  if (match(ann_block, /<target>.*<text>([^<]+)<\/text>.*<\/target>/, a)) {
    primary = a[1]
  } else {
    primary = ""
  }

  if (match(ann_block, /<content>.*<text>([^<]+)<\/text>.*<\/content>/, b)) {
    secondary = b[1]
  } else {
    secondary = ""
  }

  if (length(primary) > 0 || length(secondary) > 0) {
    printf "> %s\n\n%s\n\n", primary, secondary >> "'"$OUTPUT"'"
  }
}
'

