#!/usr/bin/env bash
set -euo pipefail

echo "🟢 start.sh: starting..."

# choose python binary
if command -v python3 >/dev/null 2>&1; then
  PY=python3
elif command -v python >/dev/null 2>&1; then
  PY=python
else
  echo "❌ Python is not installed. Install Python 3 and retry."
  exit 1
fi

VENV_DIR=".venv"
if [ ! -d "$VENV_DIR" ]; then
  echo "⚙️  Creating virtual environment in $VENV_DIR..."
  $PY -m venv "$VENV_DIR"
fi

# shellcheck source=/dev/null
source "$VENV_DIR/bin/activate"

echo "⬆️  Upgrading pip..."
pip install --upgrade pip setuptools wheel

if [ -f "requirements.txt" ]; then
  echo "📦 Installing from requirements.txt..."
  pip install -r requirements.txt
else
  if [ -f "Install-requirements.bat" ]; then
    echo "🔎 Parsing Install-requirements.bat for pip install lines..."
    PKG_LINE=$(grep -Eio "pip(3)? install .*" Install-requirements.bat || true)
    if [ -n "$PKG_LINE" ]; then
      PKGS=$(echo "$PKG_LINE" | sed -E "s/pip(3)? install //Ig" | tr -s ' ' '\n' | sed '/^$/d' | tr '\n' ' ')
      if [ -n "$PKGS" ]; then
        echo "📥 Installing packages found in .bat: $PKGS"
        pip install $PKGS
      else
        echo "⚠️  Could not parse packages from Install-requirements.bat."
      fi
    else
      echo "⚠️  No 'pip install' lines found inside Install-requirements.bat."
    fi
  else
    echo "ℹ️  No requirements.txt or Install-requirements.bat found. Skipping dependency install."
  fi
fi

if [ -f "raider.py" ]; then
  echo "🚀 Running: python raider.py $*"
  python raider.py "$@"
else
  echo "❌ raider.py not found in current directory."
  exit 1
fi
