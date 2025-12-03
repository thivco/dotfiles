#!/usr/bin/env bash
set -eu

SRC="${1:?source required}"
DST="${2:?destination required}"

SRC="$(realpath "$SRC")"
DST="$(realpath "$DST")"

echo "Indexing destination..."
declare -A dstmap

while IFS= read -r f; do
  [ -f "$f" ] || continue
  h=$(sha256sum "$f" | awk '{print $1}')
  dstmap["$h"]=1
done < <(find "$DST" -type f)

echo "Copying unique files..."
export DST SRC

while IFS= read -r f; do
  rel="${f#$SRC/}"
  dstdir="$DST/$(dirname "$rel")"

  [ -f "$f" ] || continue
  h=$(sha256sum "$f" | awk '{print $1}')

  if [[ -n "${dstmap[$h]:-}" ]]; then
    continue
  fi

  mkdir -p "$dstdir"
  cp -p "$f" "$dstdir/"
  dstmap["$h"]=1
done < <(find "$SRC" -type f)

