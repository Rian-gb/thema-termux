#!/bin/bash

# RianMods Termux Theme v2.0
# Created by: RianMods
# Telegram: @Rian_Xhiters

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Animation functions
animate_text() {
    text=$1
    delay=0.05
    for (( i=0; i<${#text}; i++ )); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo
}

progress_bar() {
    duration=$1
    desc=$2
    echo -e "${CYAN}$desc...${NC}"
    steps=50
    for ((i=0; i<=steps; i++)); do
        sleep $(bc <<< "scale=2; $duration/$steps" 2>/dev/null || echo "0.1")
        bar=""
        for ((j=0; j<i; j++)); do
            bar+="█"
        done
        for ((j=i; j<steps; j++)); do
            bar+=" "
        done
        percentage=$((i * 100 / steps))
        echo -ne "\r${GREEN}[$bar] $percentage%${NC}"
    done
    echo
}

# Banner
show_banner() {
    clear
    echo -e "${PURPLE}"
    echo '▓█████▄  ██▀███   ▄▄▄       ███▄ ▄███▓ ███▄ ▄███▓ ▄▄▄       ██▀███  '
    echo '▒██▀ ██▌▓██ ▒ ██▒▒████▄    ▓██▒▀█▀ ██▒▓██▒▀█▀ ██▒▒████▄    ▓██ ▒ ██▒'
    echo '░██   █▌▓██ ░▄█ ▒▒██  ▀█▄  ▓██    ▓██░▓██    ▓██░▒██  ▀█▄  ▓██ ░▄█ ▒'
    echo '░▓█▄   ▌▒██▀▀█▄  ░██▄▄▄▄██ ▒██    ▒██ ▒██    ▒██ ░██▄▄▄▄██ ▒██▀▀█▄  '
    echo '░▒████▓ ░██▓ ▒██▒ ▓█   ▓██▒▒██▒   ░██▒▒██▒   ░██▒ ▓█   ▓██▒░██▓ ▒██▒'
    echo ' ▒▒▓  ▒ ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░ ▒░   ░  ░░ ▒░   ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░'
    echo ' ░ ▒  ▒   ░▒ ░ ▒░  ▒   ▒▒ ░░  ░      ░░  ░      ░  ▒   ▒▒ ░  ░▒ ░ ▒░'
    echo ' ░ ░  ░   ░░   ░   ░   ▒   ░      ░   ░      ░     ░   ▒     ░░   ░ '
    echo '   ░       ░           ░  ░       ░          ░         ░  ░   ░     '
    echo ' ░                                                                  '
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                   TERMUX PREMIUM THEME v2.0                 ║"
    echo "║                     Created by: RianMods                    ║"
    echo "║              Telegram: @Rian_Xhiters                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Header and Footer
show_header() {
    title=$1
    length=${#title}
    padding=$(( (50 - length) / 2 ))
    echo -e "${YELLOW}══════════════════════════════════════════════════"
    printf "║%*s%s%*s║\n" $padding "" "$title" $padding ""
    echo "══════════════════════════════════════════════════${NC}"
}

show_footer() {
    echo -e "${YELLOW}══════════════════════════════════════════════════${NC}"
}

# System Information
system_info() {
    show_banner
    progress_bar 2 "Checking System Information"
    
    show_header "SYSTEM INFORMATION"
    echo -e "${WHITE}Username.......: ${GREEN}$(whoami)${NC}"
    echo -e "${WHITE}Hostname.......: ${GREEN}$(hostname)${NC}"
    echo -e "${WHITE}OS.............: ${GREEN}$(uname -o)${NC}"
    echo -e "${WHITE}Kernel.........: ${GREEN}$(uname -r)${NC}"
    echo -e "${WHITE}Architecture...: ${GREEN}$(uname -m)${NC}"
    echo -e "${WHITE}Terminal.......: ${GREEN}${TERM:-Unknown}${NC}"
    echo -e "${WHITE}Shell..........: ${GREEN}${SHELL:-Unknown}${NC}"
    
    # CPU Info (handle different systems)
    if [ -f /proc/cpuinfo ]; then
        cpu_info=$(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | sed 's/^ *//')
        echo -e "${WHITE}CPU Info.......: ${GREEN}${cpu_info:-Unknown}${NC}"
    fi
    
    # Memory Info
    if command -v free >/dev/null 2>&1; then
        memory=$(free -h 2>/dev/null | grep Mem: | awk '{print $2}' || echo "Unknown")
        echo -e "${WHITE}Memory.........: ${GREEN}${memory} Total${NC}"
    fi
    
    echo -e "${WHITE}Current Dir....: ${GREEN}$(pwd)${NC}"
    echo -e "${WHITE}Theme Version..: ${GREEN}v2.0${NC}"
    show_footer
    
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

# Network Tools
ping_test() {
    show_header "PING TEST"
    read -p "$(echo -e ${CYAN}Enter target (e.g., google.com): ${NC})" target
    if [ -z "$target" ]; then
        target="google.com"
    fi
    progress_bar 2 "Pinging $target"
    echo -e "${GREEN}Ping results for $target:${NC}"
    if ping -c 4 $target >/dev/null 2>&1; then
        ping -c 4 $target | grep -E "statistics|packets|min/avg/max"
        echo -e "${GREEN}✓ Target is reachable${NC}"
    else
        echo -e "${RED}✗ Ping failed or target not reachable${NC}"
    fi
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

website_status() {
    show_header "WEBSITE STATUS CHECK"
    read -p "$(echo -e ${CYAN}Enter website URL: ${NC})" url
    if [ -z "$url" ]; then
        url="https://google.com"
    fi
    
    # Add http:// if missing
    if [[ ! $url =~ ^https?:// ]]; then
        url="https://$url"
    fi
    
    progress_bar 2 "Checking $url"
    
    if command -v curl >/dev/null 2>&1; then
        if curl --head --silent --fail --max-time 10 "$url" >/dev/null 2>&1; then
            echo -e "${GREEN}✓ Website $url is ONLINE${NC}"
            
            # Get additional info
            response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
            echo -e "${WHITE}HTTP Status...: ${GREEN}$response_code${NC}"
        else
            echo -e "${RED}✗ Website $url is OFFLINE or unreachable${NC}"
        fi
    else
        echo -e "${RED}✗ curl not available${NC}"
    fi
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

ip_info() {
    show_header "IP INFORMATION"
    progress_bar 2 "Fetching IP information"
    
    # Public IP
    if command -v curl >/dev/null 2>&1; then
        public_ip=$(curl -s --max-time 5 ifconfig.me || curl -s --max-time 5 ipinfo.io/ip || echo "Unknown")
        echo -e "${WHITE}Public IP.....: ${GREEN}$public_ip${NC}"
    else
        echo -e "${WHITE}Public IP.....: ${RED}curl not available${NC}"
    fi
    
    # Local IP
    if command -v ip >/dev/null 2>&1; then
        local_ip=$(ip route get 1 2>/dev/null | awk '{print $7}' | head -1 || echo "Unknown")
        echo -e "${WHITE}Local IP......: ${GREEN}$local_ip${NC}"
    elif command -v ifconfig >/dev/null 2>&1; then
        local_ip=$(ifconfig 2>/dev/null | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1 || echo "Unknown")
        echo -e "${WHITE}Local IP......: ${GREEN}$local_ip${NC}"
    else
        echo -e "${WHITE}Local IP......: ${RED}Network tools not available${NC}"
    fi
    
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

port_scanner() {
    show_header "LOCAL PORT SCANNER"
    progress_bar 2 "Scanning local ports"
    echo -e "${CYAN}Scanning common ports on localhost...${NC}"
    
    ports=(80 443 22 21 3000 8080 53 25 3306 5432)
    
    for port in "${ports[@]}"; do
        if command -v nc >/dev/null 2>&1; then
            if nc -z -w 1 localhost $port 2>/dev/null; then
                echo -e "${WHITE}Port $port: ${GREEN}OPEN${NC}"
            else
                echo -e "${WHITE}Port $port: ${RED}CLOSED${NC}"
            fi
        else
            echo -e "${WHITE}Port $port: ${YELLOW}NETCAT NOT AVAILABLE${NC}"
            break
        fi
    done
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

network_tools() {
    while true; do
        show_banner
        show_header "NETWORK TOOLS"
        echo -e "${WHITE}1. ${GREEN}Ping Test${NC}"
        echo -e "${WHITE}2. ${GREEN}Website Status${NC}"
        echo -e "${WHITE}3. ${GREEN}IP Information${NC}"
        echo -e "${WHITE}4. ${GREEN}Port Scanner (Local)${NC}"
        echo -e "${WHITE}5. ${GREEN}Back to Main Menu${NC}"
        show_footer
        
        read -p "$(echo -e ${YELLOW}Select option [1-5]: ${NC})" choice
        
        case $choice in
            1) ping_test ;;
            2) website_status ;;
            3) ip_info ;;
            4) port_scanner ;;
            5) break ;;
            *) echo -e "${RED}Invalid choice!${NC}"; sleep 1 ;;
        esac
    done
}

# File Manager
file_manager() {
    show_banner
    show_header "FILE MANAGER"
    echo -e "${GREEN}Current directory: $(pwd)${NC}"
    echo ""
    echo -e "${CYAN}Files and directories:${NC}"
    ls -la --color=always 2>/dev/null || ls -la
    echo ""
    echo -e "${YELLOW}Quick commands:${NC}"
    echo -e "${WHITE}ls -l           ${GREEN}List files${NC}"
    echo -e "${WHITE}cd <dir>        ${GREEN}Change directory${NC}"
    echo -e "${WHITE}cp <src> <dst>  ${GREEN}Copy file${NC}"
    echo -e "${WHITE}rm <file>       ${GREEN}Remove file${NC}"
    echo -e "${WHITE}pwd             ${GREEN}Show current directory${NC}"
    show_footer
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

# Text Tools
text_colorizer() {
    show_header "TEXT COLORIZER"
    read -p "$(echo -e ${CYAN}Enter text to colorize: ${NC})" text
    if [ -n "$text" ]; then
        echo ""
        echo -e "${RED}Red: $text${NC}"
        echo -e "${GREEN}Green: $text${NC}"
        echo -e "${YELLOW}Yellow: $text${NC}"
        echo -e "${BLUE}Blue: $text${NC}"
        echo -e "${PURPLE}Purple: $text${NC}"
        echo -e "${CYAN}Cyan: $text${NC}"
        echo -e "${WHITE}White: $text${NC}"
    else
        echo -e "${RED}No text entered!${NC}"
    fi
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

ascii_art() {
    show_header "ASCII ART GENERATOR"
    read -p "$(echo -e ${CYAN}Enter text for ASCII art: ${NC})" text
    if [ -n "$text" ]; then
        if command -v figlet >/dev/null 2>&1; then
            echo ""
            figlet "$text"
        else
            echo -e "${YELLOW}Installing figlet...${NC}"
            if pkg install figlet -y >/dev/null 2>&1; then
                echo ""
                figlet "$text"
            else
                echo -e "${RED}Failed to install figlet${NC}"
                # Fallback to simple echo
                echo ""
                echo "=== $text ==="
            fi
        fi
    else
        echo -e "${RED}No text entered!${NC}"
    fi
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

text_encrypt() {
    show_header "TEXT ENCRYPTION"
    read -p "$(echo -e ${CYAN}Enter text to encrypt: ${NC})" text
    if [ -n "$text" ]; then
        encrypted=$(echo "$text" | base64 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Encrypted text: $encrypted${NC}"
            
            # Decrypt example
            decrypted=$(echo "$encrypted" | base64 -d 2>/dev/null)
            echo -e "${BLUE}Decrypted text: $decrypted${NC}"
        else
            echo -e "${RED}Encryption failed!${NC}"
        fi
    else
        echo -e "${RED}No text entered!${NC}"
    fi
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

text_tools() {
    while true; do
        show_banner
        show_header "TEXT TOOLS"
        echo -e "${WHITE}1. ${GREEN}Text Colorizer${NC}"
        echo -e "${WHITE}2. ${GREEN}ASCII Art Generator${NC}"
        echo -e "${WHITE}3. ${GREEN}Text Encryption${NC}"
        echo -e "${WHITE}4. ${GREEN}Back to Main Menu${NC}"
        show_footer
        
        read -p "$(echo -e ${YELLOW}Select option [1-4]: ${NC})" choice
        
        case $choice in
            1) text_colorizer ;;
            2) ascii_art ;;
            3) text_encrypt ;;
            4) break ;;
            *) echo -e "${RED}Invalid choice!${NC}"; sleep 1 ;;
        esac
    done
}

# About
show_about() {
    show_banner
    show_header "ABOUT RIANTHEME"
    echo -e "${WHITE}Theme Name....: ${GREEN}RianMods Termux Theme${NC}"
    echo -e "${WHITE}Version.......: ${GREEN}v2.0${NC}"
    echo -e "${WHITE}Author........: ${GREEN}RianMods${NC}"
    echo -e "${WHITE}Telegram......: ${GREEN}@Rian_Xhiters${NC}"
    echo -e "${WHITE}Description...: ${GREEN}Premium Termux theme with useful tools${NC}"
    echo ""
    echo -e "${CYAN}Features included:${NC}"
    echo -e "${WHITE}• System information${NC}"
    echo -e "${WHITE}• Network utilities${NC}"
    echo -e "${WHITE}• File management${NC}"
    echo -e "${WHITE}• Text tools${NC}"
    echo -e "${WHITE}• Beautiful UI${NC}"
    echo ""
    echo -e "${YELLOW}Note: This is for educational purposes only${NC}"
    show_footer
    read -p "$(echo -e ${YELLOW}Press Enter to continue...${NC})" dummy
}

# Check dependencies
check_deps() {
    echo -e "${CYAN}Checking dependencies...${NC}"
    
    # Check if we can install packages
    if ! command -v pkg >/dev/null 2>&1; then
        echo -e "${YELLOW}Note: pkg manager not found (not in Termux?)${NC}"
        return
    fi
    
    deps=("curl" "nc" "figlet")
    for dep in "${deps[@]}"; do
        if ! command -v $dep >/dev/null 2>&1; then
            echo -e "${YELLOW}Installing $dep...${NC}"
            pkg install $dep -y >/dev/null 2>&1 && \
            echo -e "${GREEN}✓ $dep installed${NC}" || \
            echo -e "${RED}✗ Failed to install $dep${NC}"
        fi
    done
    echo -e "${GREEN}Dependencies check completed${NC}"
    sleep 1
}

# Main Menu
main_menu() {
    while true; do
        show_banner
        show_header "MAIN MENU"
        echo -e "${WHITE}1. ${GREEN}System Information${NC}"
        echo -e "${WHITE}2. ${GREEN}Network Tools${NC}"
        echo -e "${WHITE}3. ${GREEN}File Manager${NC}"
        echo -e "${WHITE}4. ${GREEN}Text Tools${NC}"
        echo -e "${WHITE}5. ${GREEN}About${NC}"
        echo -e "${WHITE}6. ${GREEN}Exit${NC}"
        show_footer
        
        read -p "$(echo -e ${YELLOW}Select option [1-6]: ${NC})" choice
        
        case $choice in
            1) system_info ;;
            2) network_tools ;;
            3) file_manager ;;
            4) text_tools ;;
            5) show_about ;;
            6) break ;;
            *) echo -e "${RED}Invalid choice! Please try again.${NC}"; sleep 1 ;;
        esac
    done
}

# Clean exit
cleanup() {
    echo -e "\n${RED}Program interrupted. Goodbye! 👋${NC}"
    exit 0
}

# Set trap for Ctrl+C
trap cleanup INT

# Main execution
echo -e "${CYAN}Starting RianMods Termux Theme...${NC}"
sleep 1

# Check if running in Termux (but don't exit if not)
if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${YELLOW}Warning: This script is designed for Termux but can run elsewhere${NC}"
    sleep 2
fi

check_deps
main_menu

echo -e "${GREEN}Thank you for using RianMods Termux Theme! 👋${NC}"
echo -e "${CYAN}Follow @Rian_Xhiters for more projects${NC}"
