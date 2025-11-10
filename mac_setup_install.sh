#!/bin/bash

echo "=============================="
echo "   MAC DEV SETUP FOR M4 CHIP"
echo "=============================="

# -------------------------
# Homebrew
# -------------------------
echo "=== CHECK & INSTALL HOMEBREW ==="
if ! command -v brew &> /dev/null; then
    echo "➡️ Homebrew chưa có — bắt đầu cài..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Thêm brew vào PATH cho Apple Silicon
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew đã có sẵn."
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "=== UPDATE BREW ==="
brew update

# -------------------------
# Java 17
# -------------------------
echo "=== INSTALL JAVA 17 ==="
brew install openjdk@17

# Set JAVA_HOME và PATH
echo 'export JAVA_HOME=/opt/homebrew/opt/openjdk@17' >> ~/.zshrc
echo 'export PATH="$JAVA_HOME/bin:$PATH"' >> ~/.zshrc

# Áp dụng ngay
source ~/.zshrc

# -------------------------
# Git
# -------------------------
echo "=== INSTALL GIT ==="
brew install git

# -------------------------
# Docker Desktop
# -------------------------
echo "=== INSTALL DOCKER DESKTOP (GUI) ==="
brew install --cask docker

# -------------------------
# Sublime Text
# -------------------------
echo "=== INSTALL SUBLIME TEXT ==="
brew install --cask sublime-text

# -------------------------
# LocalSend
# -------------------------
echo "=== INSTALL LOCALSEND ==="
brew install --cask localsend

# -------------------------
# Postman
# -------------------------
echo "=== INSTALL POSTMAN ==="
brew install --cask postman

# -------------------------
# Visual Studio Code
# -------------------------
echo "=== INSTALL VISUAL STUDIO CODE ==="
brew install --cask visual-studio-code

# -------------------------
# Node.js LTS
# -------------------------
echo "=== INSTALL NODEJS (LTS) ==="
brew install node

# -------------------------
# Cleanup
# -------------------------
echo "=== CLEANUP BREW ==="
brew cleanup

echo ""
echo "✅ SETUP COMPLETED!"