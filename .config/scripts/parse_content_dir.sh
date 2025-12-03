#!/usr/bin/env bash
set -eu

DIR="${1:?need directory}"

# File list
files=$(find "$DIR" -type f)

# Total size
echo "Total size:"
du -sh "$DIR"

# Count by type (basic extension grouping)
echo
echo "By type:"
printf "%s\n" "$files" | awk -F. '
BEGIN { IGNORECASE=1 }
{
  ext = $NF
  if (ext ~ /jpe?g|png|gif|webp|bmp|tiff/) img++
  else if (ext ~ /mp4|mkv|mov|avi|webm|wmv/) vid++
}
END {
  print "images:", img
  print "videos:", vid
}
'

# Size by type
echo
echo "Size by type:"
printf "%s\n" "$files" | while read -r f; do
  ext="${f##*.}"
  case "$ext" in
    jpg|jpeg|png|gif|webp|bmp|tiff) echo "IMG $f";;
    mp4|mkv|mov|avi|webm|wmv) echo "VID $f";;
  esac
done | awk '
{
  if ($1=="IMG") img+=$(NF)
  if ($1=="VID") vid+=$(NF)
}
END {
  print "images (bytes):", img
  print "videos (bytes):", vid
}
' NF=0 RS="" FS=" "

# Files per month (mtime)
echo
echo "Files per month:"
printf "%s\n" "$files" | while read -r f; do
  stat -c "%y %n" "$f"
done | awk '{split($1, d, "-"); month=d[1]"-"d[2]; count[month]++} END {for (m in count) print m, count[m]}' | sort

# Top 10 days with most files (mtime)
echo
echo "Top 10 days by file count:"
printf "%s\n" "$files" | while read -r f; do
  stat -c "%y" "$f"
done | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -10

# Dates from filenames like IMG_20251202_222941578
echo
echo "Top 10 days inferred from filename metadata:"
printf "%s\n" "$files" | grep -E 'IMG_[0-9]{8}' | \
  sed -E 's/.*IMG_([0-9]{8}).*/\1/' | \
  sort | uniq -c | sort -nr | head -10

