#!/usr/bin/env bash
set -euo pipefail

# prepare_data.sh
# Verifica que los archivos .nc estén en data/, genera MD5SUMS y crea symlinks

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="$REPO_ROOT/data"

FILES=(
  "cru_ts4.08.1901.2023.tmn.dat.nc"
  "cru_ts4.08.1901.2023.tmx.dat.nc"
)

echo "Repo root: $REPO_ROOT"
echo "Data dir: $DATA_DIR"

missing=0
for f in "${FILES[@]}"; do
  if [ ! -f "$DATA_DIR/$f" ]; then
    echo "[MISSING] $DATA_DIR/$f"
    missing=1
  else
    echo "[OK]     $DATA_DIR/$f"
  fi
done

if [ "$missing" -eq 1 ]; then
  echo "One or more data files are missing. Place them in $DATA_DIR and rerun this script." >&2
  exit 1
fi

echo "Generating MD5SUMS and DATA_INFO in $DATA_DIR"
cd "$DATA_DIR"
rm -f MD5SUMS DATA_INFO
if command -v md5sum >/dev/null 2>&1; then
  md5sum "${FILES[@]}" > MD5SUMS
elif command -v md5 >/dev/null 2>&1; then
  for f in "${FILES[@]}"; do
    md5 -r "$f" >> MD5SUMS
  done
else
  echo "No md5sum or md5 available; skipping checksum generation" >&2
fi

# DATA_INFO: filename, size (human), bytes, mtime
echo "# filename | size_human | bytes | mtime" > DATA_INFO
for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    size_human=$(ls -lh "$f" | awk '{print $5}')
    bytes=$(stat -c%s "$f" 2>/dev/null || echo "N/A")
    mtime=$(stat -c%y "$f" 2>/dev/null || ls -l --time-style=full-iso "$f" | awk '{print $6" " $7}')
    echo "$f | $size_human | $bytes | $mtime" >> DATA_INFO
  else
    echo "$f | MISSING" >> DATA_INFO
  fi
done

echo "Creating symlinks in repo root"
cd "$REPO_ROOT"
for f in "${FILES[@]}"; do
  ln -sf "data/$f" "$REPO_ROOT/$f"
  echo "-> $REPO_ROOT/$f -> data/$f"
done

echo "Done. You can now run the script from the repo root, e.g.:"
echo "  Rscript scripts/gVoCC_Carnivora_Maps.R"
