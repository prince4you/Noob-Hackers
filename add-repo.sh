#!/bin/bash

# Colors and Emojis
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"
CHECK="✅"
CROSS="❌"
INFO=">> "
WARN="❗"

# Function to handle errors
handle_error() {
  echo -e "${RED}${CROSS} Error: $1${RESET}"
  exit 1
}

# Header
echo -e "${BLUE}========================================${RESET}"
echo -e "${GREEN}📦 Noob-backers Repo Installer 📦${RESET}"
echo -e "${BLUE}========================================${RESET}"
echo -e "${INFO} This script will install dependencies, add the Noob-backers repository, and update your package list.${RESET}"
echo ""

# Install dependencies
echo -e "${YELLOW}${INFO} Installing dependencies...${RESET}"
if apt install gnupg curl x11-repo -y > /dev/null 2>&1; then
  echo -e "${GREEN}${CHECK} Dependencies installed successfully!${RESET}"
else
  handle_error "Failed to install dependencies."
fi
echo ""

# Add Noob-backers repository
echo -e "${YELLOW}${INFO} Adding Noob-backers repository...${RESET}"
sleep 2
if [[ ! -d $PREFIX/etc/apt/sources.list.d ]]; then
  mkdir -p $PREFIX/etc/apt/sources.list.d > /dev/null 2>&1 || handle_error "Failed to create sources.list.d directory."
fi

echo "deb [trusted=yes arch=all] https://raw.githubusercontent.com/prince4you/Noob-Hackers/refs/heads/main exploit main" > $PREFIX/etc/apt/sources.list.d/noob-backers.list || handle_error "Failed to add Noob-backers repository."
echo -e "${GREEN}${CHECK} Noob-backers repository added successfully!${RESET}"
echo ""

# Add repository key
echo -e "${YELLOW}${INFO} Adding GPG key for Noob-backers repository...${RESET}"
if curl -sL https://raw.githubusercontent.com/prince4you/Noob-Hackers/refs/heads/main/noob-hacker.key | apt-key add - > /dev/null 2>&1; then
  echo -e "${GREEN}${CHECK} GPG key added successfully!${RESET}"
else
  handle_error "Failed to add GPG key."
fi
sleep 2
echo ""

# Move trusted.gpg file
echo -e "${YELLOW}${INFO} Organizing GPG keys...${RESET}"
if mv $PREFIX/etc/apt/trusted.gpg $PREFIX/etc/apt/trusted.gpg.d > /dev/null 2>&1; then
  echo -e "${GREEN}${CHECK} GPG keys organized successfully!${RESET}"
else
  echo -e "${RED}${WARN} Failed to move trusted.gpg file. Continuing anyway...${RESET}"
fi
echo ""

# Update repositories
echo -e "${YELLOW}${INFO} Updating package repositories...${RESET}"
if apt update -y > /dev/null 2>&1; then
  echo -e "${GREEN}${CHECK} Repositories updated successfully!${RESET}"
else
  handle_error "Failed to update repositories."
fi
echo ""

# Success message
echo -e "${BLUE}========================================${RESET}"
echo -e "${GREEN}🎉 Noob-backers Repo Setup Complete! 🎉${RESET}"
echo -e "${BLUE}========================================${RESET}"
echo -e "${INFO} You can now install packages from the Noob-backers repository.${RESET}"
