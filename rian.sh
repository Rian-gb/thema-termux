#!/bin/bash

clear
echo -e "\e[31m ________    _____   ______       __    __     __    __   __     __  " 
echo -e "\e[31m(___  ___)  / ___/  (   __ \      \ \  / /     ) )  ( (  (_ \   / _) " 
echo -e "\e[96m    ) )    ( (__     ) (__) )     () \/ ()    ( (    ) )   \ \_/ /   " 
echo -e "\e[96m   ( (      ) __)   (    __/      / _  _ \     ) )  ( (     \   /   "  
echo -e "\e[94m    ) )    ( (       ) \ \  _    / / \/ \ \   ( (    ) )    / _ \    " 
echo -e "\e[94m   ( (      \ \___  ( ( \ \_))  /_/      \_\   ) \__/ (   _/ / \ \_  " 
echo -e "\e[92m   /__\      \____\  )_) \__/  (/          \)  \______/  (__/   \__)" 
                    
 
echo -e " \e[91m                                                   ____      _____  " 
echo -e " \e[91m                                                  / __ \    / ____\ " 
echo -e " \e[96m                                                 / /  \ \  ( (___   " 
echo -e " \e[96m                                                ( ()  () )  \___ \  " 
echo -e " \e[1;91m Youtube\e[96m / \e[100;97mRianMods\e[0;31m                      ( ()  () )      ) )" 
echo -e " \e[1;91m Github\e[96m /\e[1;93m RianMods                                \ \__/ /   ___/ /"  
echo -e " \e[1;91m Telegram\e[1;96m /\e[1;92m @Rian_Xhiters                        \____/   /____/"    
echo ""

banner() {
    printf ""
    echo -e "\e[1;31m  [\e[32m√\e[31m] \e[1;91m by \e[1;36mRianMods \e[93m/ \e[100;92m@Rian_Xhiters\e[0m"
}

wr() {
    printf "\033[1;91m Invalid input!!!\n"
    selection
}

1line() {
    echo -e "\e[1;92m[*] Updating packages...\e[0m"
    apt update && apt upgrade -y
    
    echo -e "\e[1;92m[*] Installing necessary packages...\e[0m"
    pkg install zsh git figlet toilet ruby wget curl exa -y
    gem install lolcat
    
    echo -e "\e[1;92m[*] Setting up custom configuration...\e[0m"
    clear
    if [ -d "~/Termux-os/.object" ]; then
        cd ~/Termux-os/.object && cp -r 'ANSI Shadow.flf' $PREFIX/share/figlet/ASCII-Shadow.flf 2>/dev/null
    fi
    
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null || echo -e "\e[1;93m[!] oh-my-zsh already exists\e[0m"
    
    if [ -d "~/Termux-os/.object" ]; then
        rm -rf ~/.termux/colors.properties 2>/dev/null
        rm -rf /data/data/com.termux/files/usr/etc/motd 2>/dev/null
        cp -r .colors.properties ~/.termux/colors.properties 2>/dev/null
        cp -r .termux.properties ~/.termux/termux.properties 2>/dev/null
    fi
    
    clear
    echo -e "\e[1;92m[*] Setup completed successfully!\e[0m"
    sleep 2
    cd ~/Termux-os ; bash os.sh
}

2line() {
    echo -e "\e[1;92m[*] Setting up Zsh configuration...\e[0m"
    rm -rf ~/.zshrc 2>/dev/null
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh 2>/dev/null || echo -e "\e[1;93m[!] oh-my-zsh already exists\e[0m"
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc 2>/dev/null
    echo -e "\e[1;92m[*] Zsh setup completed!\e[0m"
    sleep 2
    cd ~/Termux-os ; bash os.sh
}

3line() {
    echo -e "\e[1;92m[*] Switching to Zsh shell...\e[0m"
    pkg install zsh -y
    chsh -s zsh
    echo -e "\e[1;92m[*] Zsh shell activated! Restart Termux to see changes.\e[0m"
    sleep 2
    cd ~/Termux-os ; bash os.sh
}

4line() {
    echo -e "\e[1;92m[*] Switching to Bash shell...\e[0m"
    chsh -s bash
    echo -e "\e[1;92m[*] Bash shell activated! Restart Termux to see changes.\e[0m"
    sleep 2
    cd ~/Termux-os ; bash os.sh
}

5line() {
    echo -e "\e[1;92m[*] Installing custom Zsh banner...\e[0m"
    rm -rf ~/.zshrc 2>/dev/null
    if [ -d "~/Termux-os/.object" ]; then
        cd ~/Termux-os/.object
        bash .2.sh 2>/dev/null || echo -e "\e[1;91m[!] Banner script not found\e[0m"
    else
        echo -e "\e[1;91m[!] Termux-os directory not found\e[0m"
    fi
    sleep 2
    clear
    cd ~/Termux-os ; bash os.sh
}

6line() {
    echo -e "\e[1;92m[*] Applying Zsh theme...\e[0m"
    if [ -d "~/Termux-os/.object" ]; then
        cd ~/Termux-os/.object
        bash .1.sh 2>/dev/null || echo -e "\e[1;91m[!] Theme script not found\e[0m"
    else
        echo -e "\e[1;91m[!] Termux-os directory not found\e[0m"
    fi
    sleep 2
    clear
    cd ~/Termux-os ; bash os.sh
}

7line() {
    echo -e "\e[1;92m[*] Installing syntax highlighting and auto-suggestions...\e[0m"
    if [ -d "~/Termux-os/.object" ]; then
        cd ~/Termux-os/.object
        rm -rf ~/.zshrc 2>/dev/null
        chsh -s zsh
        bash .3.sh 2>/dev/null || echo -e "\e[1;91m[!] Highlight script not found\e[0m"
    else
        echo -e "\e[1;91m[!] Termux-os directory not found\e[0m"
    fi
    sleep 2
    clear
    cd ~/Termux-os ; bash os.sh
}

8line() {
    echo -e "\e[1;92m[*] Updating RianMods Termux OS...\e[0m"
    rm -rf ~/Termux-os 2>/dev/null
    cd ~
    git clone https://github.com/RianMods/Termux-os 2>/dev/null || {
        echo -e "\e[1;91m[!] Failed to update. Using local version.\e[0m"
        mkdir -p ~/Termux-os
    }
    cd ~/Termux-os ; bash os.sh
}

9line() {
    echo -e "\e[1;92m[*] Installing custom tools and utilities...\e[0m"
    pkg install python nodejs rust -y
    pip install requests bs4 rich
    echo -e "\e[1;92m[*] Additional tools installed!\e[0m"
    sleep 2
    cd ~/Termux-os ; bash os.sh
}

10line() {
    echo -e "\e[1;92m[*] Setting up RianMods development environment...\e[0m"
    pkg install git python nodejs -y
    pip install flask django rich
    echo -e "\e[1;92m[*] Dev environment ready!\e[0m"
    sleep 2
    cd ~/Termux-os ; bash os.sh
}

selection() {
    cd ~/Termux-os 2>/dev/null || mkdir -p ~/Termux-os && cd ~/Termux-os
    echo -e -n "\e[1;96m Choose Option : \e[0m"
    read a
    case $a in
    1) 1line ;;
    2) 2line ;;
    3) 3line ;;
    4) 4line ;;
    5) 5line ;;
    6) 6line ;;
    7) 7line ;;
    8) 8line ;;
    9) 9line ;;
    10) 10line ;;
    0) exit ;;
    *) wr ;;
    esac
}

menu() {
    banner
    printf "\n\033[1;91m[\033[0m1\033[1;91m]\033[1;92m Necessary Setup \n"
    printf "\033[1;91m[\033[0m2\033[1;91m]\033[1;92m Zsh Setup\n"
    printf "\033[1;91m[\033[0m3\033[1;91m]\033[1;92m Zsh Shell\n"
    printf "\033[1;91m[\033[0m4\033[1;91m]\033[1;92m Bash Shell\n"
    printf "\033[1;91m[\033[0m5\033[1;91m]\033[1;92m Zsh Banner\n"
    printf "\033[1;91m[\033[0m6\033[1;91m]\033[1;92m Zsh Theme\n"
    printf "\033[1;91m[\033[0m7\033[1;91m]\033[1;92m Highlight / AutoSuggest\n"
    printf "\033[1;91m[\033[0m8\033[1;91m]\033[1;92m Update\n"
    printf "\033[1;91m[\033[0m9\033[1;91m]\033[1;92m Additional Tools\n"
    printf "\033[1;91m[\033[0m10\033[1;91m]\033[1;92m Dev Environment\n"
    printf "\033[1;91m[\033[0m0\033[1;91m]\033[1;92m Exit\n\n\n"
    
    selection
}

# Main execution
clear
menu
