#!/usr/bin/env bash
# Publish a file to rubica-assets and print its public URLs.
# Usage: scripts/publish.sh <source-file> <target-folder/> [new-name]
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
RAW_BASE="https://raw.githubusercontent.com/rubica-au/rubica-assets/main"
PAGES_BASE="https://rubica-au.github.io/rubica-assets"

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <source-file> <target-folder/> [new-name]" >&2
  exit 1
fi

SRC="$1"
TARGET_DIR="${2%/}"
NAME="${3:-$(basename "$SRC")}"

# Normalise the name: lower-case, spaces and odd characters to hyphens.
EXT="${NAME##*.}"
STEM="${NAME%.*}"
STEM="$(echo "$STEM" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
EXT="$(echo "$EXT" | tr '[:upper:]' '[:lower:]')"
NAME="${STEM}.${EXT}"

if [[ ! -f "$SRC" ]]; then
  echo "Source file not found: $SRC" >&2
  exit 1
fi

SIZE=$(stat -f%z "$SRC" 2>/dev/null || stat -c%s "$SRC")
if (( SIZE > 10485760 )); then
  echo "File is $((SIZE / 1048576)) MB. Keep assets under 10 MB." >&2
  exit 1
fi

mkdir -p "$REPO_ROOT/$TARGET_DIR"
DEST="$TARGET_DIR/$NAME"
cp "$SRC" "$REPO_ROOT/$DEST"

cd "$REPO_ROOT"
git pull --quiet --rebase
git add "$DEST"
if git diff --cached --quiet; then
  echo "No change: $DEST already up to date."
else
  git commit --quiet -m "Add $DEST"
  git push --quiet
  echo "Published $DEST"
fi

echo
echo "Raw:   $RAW_BASE/$DEST"
echo "Pages: $PAGES_BASE/$DEST"
