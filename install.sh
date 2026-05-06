#!/usr/bin/env bash
# NeonBash Installer – Green Hacker Termux Environment
# Author: Alienkrishn [Anon4You]
# Installs dependencies, clones the repo, copies configs, then self‑destructs.

clear
cat << 'EOF'
 ______                   ______             _     
|  ___ \                 (____  \           | |    
| |   | | ____ ___  ____  ____)  ) ____  ___| | _  
| |   | |/ _  ) _ \|  _ \|  __  ( / _  |/___) || \ 
| |   | ( (/ / |_| | | | | |__)  | ( | |___ | | | |
|_|   |_|\____)___/|_| |_|______/ \_||_(___/|_| |_|
                                                   
EOF

echo -e "\033[38;2;0;255;0m► Turns Termux into a hacker terminal:\033[0m"
echo -e "\033[38;2;0;255;0m  auto-suggestions, syntax highlighting, \n  green theme, and more.\033[0m"
echo

read -p "Install NeonBash? [Y/n]: " answer
case "$answer" in n|N) echo "Exiting."; exit 0;; *) echo "Starting installation...";; esac

if [ ! -f "$PREFIX/etc/apt/sources.list.d/termuxvoid.list" ]; then
    bash <(curl -sL is.gd/termuxvoid) -s
fi

if ! command -v apt &>/dev/null; then
    echo -e "\033[38;2;255;0;0mError: apt not found. Are you in Termux?\033[0m"
    exit 1
fi

REQUIRED_aptS="git bat lsd blesh man"
MISSING_aptS=""
for apt in $REQUIRED_aptS; do
    if ! command -v "$apt" &>/dev/null && ! apt list-installed 2>/dev/null | grep -q "^$apt"; then
        MISSING_aptS="$MISSING_aptS $apt"
    fi
done

if [ -n "$MISSING_aptS" ]; then
    apt install -y $MISSING_aptS
fi

REPO_URL="https://github.com/Anon4You/NeonBash.git"
CLONE_DIR="$TMPDIR/neonbash-install-$$"
git clone --depth 1 "$REPO_URL" "$CLONE_DIR"

cp -r "$CLONE_DIR/files/termux/"* ~/.termux/
cp "$CLONE_DIR/files/bashrc" ~/.bashrc
mkdir -p ~/.config
cp -r "$CLONE_DIR/files/config/"* ~/.config/

rm -rf "$CLONE_DIR"
rm -- "$0"

echo -e "\033[38;2;0;255;0m✔ NeonBash installed! Restart Termux to see the magic.\033[0m"

