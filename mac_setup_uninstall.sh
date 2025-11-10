#!/bin/bash

echo "=============================="
echo "   UNINSTALL DEV TOOLS (M4)"
echo "   Keep Homebrew installed"
echo "=============================="

echo "=== REMOVE JAVA 17 (Temurin) ==="
brew uninstall --cask temurin17

echo "=== REMOVE GIT ==="
brew uninstall git

echo "=== REMOVE DOCKER DESKTOP ==="
brew uninstall --cask docker

echo "=== REMOVE SUBLIME TEXT ==="
brew uninstall --cask sublime-text

echo "=== REMOVE LOCALSEND ==="
brew uninstall --cask localsend

echo "=== REMOVE POSTMAN ==="
brew uninstall --cask postman

echo "=== REMOVE VISUAL STUDIO CODE ==="
brew uninstall --cask visual-studio-code

echo "=== REMOVE NODEJS ==="
brew uninstall node

echo "=== BREW CLEANUP ==="
brew cleanup

echo "✅ All apps have been uninstalled (Homebrew still installed)."
