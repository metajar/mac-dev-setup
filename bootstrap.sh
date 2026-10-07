#!/usr/bin/env bash
# Bootstrap a fresh Mac: Homebrew -> Ansible -> run the playbook.
# Usage: ./bootstrap.sh            (full run)
#        ./bootstrap.sh --tags go  (any extra args go to ansible-playbook)
set -euo pipefail
cd "$(dirname "$0")"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script is for macOS only." >&2
  exit 1
fi

# Homebrew (its installer also installs the Xcode Command Line Tools)
if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew && ! -x /usr/local/bin/brew ]]; then
  echo "==> Installing Homebrew (you'll be asked for your password)..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "==> Installing Ansible..."
brew list ansible >/dev/null 2>&1 || brew install ansible

echo "==> Installing Ansible collections..."
ansible-galaxy collection install -r requirements.yml

echo "==> Running playbook..."
ansible-playbook main.yml "$@"

echo
echo "Done. Open iTerm2 (or run 'exec zsh') to load your new shell config."
