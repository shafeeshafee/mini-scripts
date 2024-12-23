#!/bin/bash
#
# package_checker.sh
# ------------------
# Purpose:
#   Given a list of packages, checks if they're installed on Debian/Ubuntu.
#   Offers to install missing packages. Great for ensuring system dependencies.
#
# Usage:
#   ./package_checker.sh
#
# Notes:
#   - Adjust the 'PACKAGES' array as desired.

PACKAGES=("systemd" "htop" "python3" "git" "curl" "nmap" "apt")

function get_version() {
  dpkg-query -W -f='${Version}' "$1" 2>/dev/null
}

for pkg in "${PACKAGES[@]}"; do
  echo "Checking $pkg..."
  if dpkg -l "$pkg" &>/dev/null; then
    ver=$(get_version "$pkg")
    echo "$pkg is installed (version: $ver)."
  else
    echo "$pkg is not installed."
    read -p "Install $pkg now? (yes/no): " answer
    if [[ "$answer" == "yes" ]]; then
      sudo apt update && sudo apt install -y "$pkg"
      if [ $? -eq 0 ]; then
        ver=$(get_version "$pkg")
        echo "$pkg installed successfully (version: $ver)."
      else
        echo "Installation failed for $pkg."
      fi
    fi
  fi
  echo "---------------------"
done
