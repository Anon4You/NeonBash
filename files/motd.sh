#!/data/data/com.termux/files/usr/bin/bash

NEON_GREEN='\033[38;2;0;255;0m'
BRIGHT_GREEN='\033[38;2;80;255;80m'
DARK_GREEN='\033[38;2;0;100;0m'
DIM_GREEN='\033[38;2;0;150;0m'
RESET='\033[0m'
BOLD='\033[1m'

LOGO='    ⢠⠀⠀⠀
⠀⠀⠀⠀⠀⢸⣧
⠀⠀⠀⠀  ⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡔
⠀⠀⠀⠀⠀⠀⠭⣿⣿⣿⣶⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⡿
⠀⠀⠀⠀⠀⠀⠀⠘⡿⣿⡿⣿⣿⣿⣿⣦⣴⣶⣶⣶⣶⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⢀⣀⣤⣲⣿⣿⣿⠟
⠀⠀⠀⠀⠀⠀⠀⠀⠐⡝⢿⣌⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣾⣿⣿⣿⣿⣿⡿⠃
⠀⠀⠀⠀⠀⠀⠀⠀ ⠈⠲⡝⡷⣮⣝⣻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣛⣿⣿⠿⠃⠀
⠀⠀⠀⠀⠀ ⠀⠀⣴⣿⣦⣝⠓⠭⣿⡿⢿⣿⣿⣛⠻⣿⠿⠿⣿⣿⣿⣿⣿⣿⡿⣇⣇
⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣤⡀⠈⠉⠚⠺⣿⠯⢽⣿⣷⣄⣶⣷⢾⣿⣯⣾⣿⠿⠃
⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⡟⠀⠀⣴⣿⣿⣼⠈⠉⠃⠋⢹⠁⢀⡇
  ⢠⢿⣿⡟⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⣀⣀⣀⣀⣴⣿⣿⡿⣿⠀⠀⠀⠀⠇⠀⣼⡇⠀
⠀⠈  ⠑⢿⢿⣾⣿⣿⡿⠿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠿⢿⡄⢦⣤⣤⣶⣿⣿⣷⡀
⠀⠀⠀  ⠙⠘⠛⠋⠁⠁⣀⢉⡉⢻⡻⣯⣻⣿⢻⣿⣀⠀⠀⠀⢠⣾⣿⣿⣿⣹⠉⣍⢁⠀
⠀ ⠀ ⣀⠠⠔⠒⠋⠀⡈⠀⠠⠤⠀⠓⠯⣟⣻⣻⠿⠛⠁⠀⠀⠣⢽⣿⡻⠿⠋⠰⠤⣀⡈⠒⢄
⠀⠀⠀⠀⠀⡀⠔⠊⠁⠀⣀⠔⠈⠁⠀⠀⠀⠀⠀⣶⠂⠀⠀⠀⢰⠆⠀⠀⠀⠈⠒⢦⡀⠉⠢⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠎⠁⠀⠀⠀⠀⠀⠀⠀⠀⠋⠀⠀⠀⠰⠃⠀⠀⠀⠀⠀⠀⠀⠈⠂
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀ ⠀⣸⣄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ⢸⣿⣿⣿⣿⣿⣿
'

print_logo() {
    local lines=()
    while IFS= read -r line; do
        lines+=("$line")
    done <<< "$LOGO"

    local total=${#lines[@]}
    for i in "${!lines[@]}"; do
        local intensity=$(echo "scale=2; 0.3 + ($i / $total) * 0.7" | bc)
        local green_val=$(printf "%.0f" $(echo "$intensity * 255" | bc))
        printf "\033[38;2;0;%d;0m%s\033[0m\n" "$green_val" "${lines[$i]}"
    done
}
clear
print_logo
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //')
USERS=$(id -un)
CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}' | cut -d, -f1)
MEM=$(free -h | awk '/^Mem:/ {print $3"/"$2}')
HOSTNAME=$(hostname)
USER=$(whoami)

echo -e "\n${NEON_GREEN}[>]${RESET} ${BOLD}KERNEL${RESET}   : ${DIM_GREEN}$KERNEL${RESET}"
echo -e "${NEON_GREEN}[>]${RESET} ${BOLD}UPTIME${RESET}   : ${DIM_GREEN}$UPTIME${RESET}"
echo -e "${NEON_GREEN}[>]${RESET} ${BOLD}USER${RESET}     : ${DIM_GREEN}$USERS logged in${RESET}"
echo -e "${NEON_GREEN}[>]${RESET} ${BOLD}CPU LOAD${RESET} : ${DIM_GREEN}$CPU_LOAD${RESET}"
echo -e "${NEON_GREEN}[>]${RESET} ${BOLD}MEMORY${RESET}   : ${DIM_GREEN}$MEM${RESET}"

echo -e "${DARK_GREEN}┌──────────────────────────────────────────┐${RESET}"
echo -e "${DARK_GREEN}│  ${NEON_GREEN}ACCESS GRANTED${RESET}                          ${DARK_GREEN}│${RESET}"
echo -e "${DARK_GREEN}│  ${BRIGHT_GREEN}$(date +"%H:%M:%S")${RESET} on ${BRIGHT_GREEN}$(date +"%a %b %d")${RESET}                  ${DARK_GREEN}│${RESET}"
echo -e "${DARK_GREEN}│  ${BRIGHT_GREEN}${USER}@${HOSTNAME}${RESET}  |  ${BRIGHT_GREEN}$(tty | cut -d/ -f3-)${RESET}           ${DARK_GREEN}│${RESET}"
echo -e "${DARK_GREEN}└──────────────────────────────────────────┘${RESET}"
