#!/usr/bin/env sh

echo "📦 Homebrew Updates Available:"
echo
brew outdated
echo
echo "Run 'brew upgrade' to update all packages"
echo "Press any key to continue..."
read -n 1
