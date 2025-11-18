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

echo "Generating MD5SUMS in $DATA_DIR"
cd "$DATA_DIR"
if command -v md5sum >/dev/null 2>&1; then
  md5sum "${FILES[@]}" > MD5SUMS
else
  # macOS fallback
  for f in "${FILES[@]}"; do
    if command -v md5 >/dev/null 2>&1; then
      md5 -r "$f" >> MD5SUMS
    else
      echo "No md5sum or md5 available; skipping checksum generation" >&2
      break
    fi
  done
fi

echo "Creating symlinks in repo root"
cd "$REPO_ROOT"
for f in "${FILES[@]}"; do
  ln -sf "data/$f" "$REPO_ROOT/$f"
  echo "-> $REPO_ROOT/$f -> data/$f"
done

echo "Done. You can now run the script from the repo root, e.g.:"
echo "  Rscript scripts/gVoCC_Carnivora_Maps.R"
