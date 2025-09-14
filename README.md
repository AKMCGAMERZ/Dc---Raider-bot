# Raider Bot - Start Package

Files included:
- `raider.py` - Your bot script.
- `requirements.txt` - Python dependencies.
- `start.sh` - Bash startup script (creates .venv, installs requirements, runs raider.py).

Usage:
1. Make the script executable (optional):
   ```bash
   chmod +x start.sh
   ./start.sh
   ```
   or
   ```bash
   bash start.sh
   ```

2. The script will create a `.venv`, install packages from `requirements.txt` and run `raider.py`.

Notes:
- Place your Discord token via the interactive menu when the bot starts, or create `token.json` with `{"TOKEN": "your_token_here"}`.
- This package is intended for Linux/Termux/WSL/Codespaces.
