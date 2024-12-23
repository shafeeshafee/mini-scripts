#!/bin/bash
#
# detect_and_push.sh
# ------------------
# Purpose:
#   Detect untracked files in a Git repo, optionally install GitHub CLI,
#   and push changes to remote.
#
# Usage:
#   ./detect_and_push.sh <path_to_repo>
#
# Notes:
#   - Very basic; recommended for personal/dev testing. Not robust for production.

REPO_PATH="$1"

if [ -z "$REPO_PATH" ] || [ ! -d "$REPO_PATH" ]; then
  echo "Invalid or missing path. Usage: $0 <path_to_repo>"
  exit 1
fi

cd "$REPO_PATH" || exit 1

# Check if gh is installed
if ! command -v gh &>/dev/null; then
  read -p "GitHub CLI not found. Install now? (yes/no): " REPLY_CLI
  if [[ "$REPLY_CLI" == "yes" ]]; then
    echo "Installing GitHub CLI (for Ubuntu/Debian)..."
    sudo apt update && sudo apt install -y gh
    gh auth login
  else
    echo "Skipping GitHub CLI install. Certain features will not work."
  fi
fi

# Check if we're in a Git repo with a remote
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo "Not in a Git repository. Exiting."
  exit 1
fi

REMOTE_URL=$(git config --get remote.origin.url)
if [ -z "$REMOTE_URL" ]; then
  echo "No Git remote found. You can create one with 'gh repo create' or manually."
fi

# List untracked files
UNTRACKED=$(git ls-files --others --exclude-standard)

if [ -z "$UNTRACKED" ]; then
  echo "No untracked files found."
  exit 0
fi

echo "Untracked files:"
echo "$UNTRACKED"
read -p "Commit and push these new files? (yes/no): " REPLY_PUSH
if [[ "$REPLY_PUSH" == "yes" ]]; then
  git add .
  git commit -m "Add untracked file(s)"
  git push origin main
  echo "Changes pushed to remote."
else
  echo "Aborted push."
fi
