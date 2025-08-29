#!/bin/bash

# Cores para o terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para exibir cabeçalho
show_header() {
    clear
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}    MENU DE 50 OPÇÕES                ${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

# Função para exibir menu
show_menu() {
    echo -e "${YELLOW}Escolha uma opção (1-50):${NC}"
    echo ""
    echo -e "${GREEN}1)${NC}  Script web server"
    echo -e "${RED}2)${NC}  Opção comentada"
    echo -e "${RED}3)${NC}  Opção comentada"
    echo -e "${RED}4)${NC}  Opção comentada"
    echo -e "${RED}5)${NC}  Opção comentada"
    echo -e "${RED}6)${NC}  Opção comentada"
    echo -e "${RED}7)${NC}  Opção comentada"
    echo -e "${RED}8)${NC}  Opção comentada"
    echo -e "${RED}9)${NC}  Opção comentada"
    echo -e "${RED}10)${NC} Opção comentada"
    echo -e "${RED}11)${NC} Opção comentada"
    echo -e "${RED}12)${NC} Opção comentada"
    echo -e "${RED}13)${NC} Opção comentada"
    echo -e "${RED}14)${NC} Opção comentada"
    echo -e "${RED}15)${NC} Opção comentada"
    echo -e "${RED}16)${NC} Opção comentada"
    echo -e "${RED}17)${NC} Opção comentada"
    echo -e "${RED}18)${NC} Opção comentada"
    echo -e "${RED}19)${NC} Opção comentada"
    echo -e "${RED}20)${NC} Opção comentada"
    echo -e "${RED}21)${NC} Opção comentada"
    echo -e "${RED}22)${NC} Opção comentada"
    echo -e "${RED}23)${NC} Opção comentada"
    echo -e "${RED}24)${NC} Opção comentada"
    echo -e "${RED}25)${NC} Opção comentada"
    echo -e "${RED}26)${NC} Opção comentada"
    echo -e "${RED}27)${NC} Opção comentada"
    echo -e "${RED}28)${NC} Opção comentada"
    echo -e "${RED}29)${NC} Opção comentada"
    echo -e "${RED}30)${NC} Opção comentada"
    echo -e "${RED}31)${NC} Opção comentada"
    echo -e "${RED}32)${NC} Opção comentada"
    echo -e "${RED}33)${NC} Opção comentada"
    echo -e "${RED}34)${NC} Opção comentada"
    echo -e "${RED}35)${NC} Opção comentada"
    echo -e "${RED}36)${NC} Opção comentada"
    echo -e "${RED}37)${NC} Opção comentada"
    echo -e "${RED}38)${NC} Opção comentada"
    echo -e "${RED}39)${NC} Opção comentada"
    echo -e "${RED}40)${NC} Opção comentada"
    echo -e "${RED}41)${NC} Opção comentada"
    echo -e "${RED}42)${NC} Opção comentada"
    echo -e "${RED}43)${NC} Opção comentada"
    echo -e "${RED}44)${NC} Opção comentada"
    echo -e "${RED}45)${NC} Opção comentada"
    echo -e "${RED}46)${NC} Opção comentada"
    echo -e "${RED}47)${NC} Opção comentada"
    echo -e "${RED}48)${NC} Opção comentada"
    echo -e "${RED}49)${NC} Opção comentada"
    echo -e "${RED}50)${NC} Opção comentada"
    echo -e "${GREEN}51)${NC} Sair"
    echo ""
}

# Loop principal do menu
while true; do
    show_header
    show_menu
    read -p "Digite sua escolha (1-51): " choice
    
    case $choice in
        1)
            echo -e "${BLUE}==> Executando: sudo apt update${NC}"
            sudo apt update
            echo ""
            read -p "Pressione Enter para continuar..."
            ;;
        2)
            # echo "sudo apt upgrade -y"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        3)
            # echo "sudo apt install apache2"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        4)
            # echo "sudo apt install nginx"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        5)
            # echo "sudo apt install mysql-server"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        6)
            # echo "sudo apt install php"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        7)
            # echo "sudo systemctl start apache2"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        8)
            # echo "sudo systemctl enable nginx"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        9)
            # echo "sudo apt install git"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        10)
            # echo "sudo apt install curl"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        11)
            # echo "sudo apt install wget"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        12)
            # echo "sudo apt install vim"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        13)
            # echo "sudo apt install nano"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        14)
            # echo "sudo apt install htop"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        15)
            # echo "sudo apt install tree"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        16)
            # echo "sudo apt install unzip"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        17)
            # echo "sudo apt install zip"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        18)
            # echo "sudo apt install tar"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        19)
            # echo "sudo apt install gzip"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        20)
            # echo "sudo apt install bzip2"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        21)
            # echo "sudo apt install python3"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        22)
            # echo "sudo apt install python3-pip"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        23)
            # echo "sudo apt install nodejs"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        24)
            # echo "sudo apt install npm"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        25)
            # echo "sudo apt install docker.io"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        26)
            # echo "sudo apt install docker-compose"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        27)
            # echo "sudo apt install snapd"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        28)
            # echo "sudo apt install flatpak"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        29)
            # echo "sudo apt install ufw"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        30)
            # echo "sudo apt install fail2ban"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        31)
            # echo "sudo apt install clamav"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        32)
            # echo "sudo apt install rkhunter"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        33)
            # echo "sudo apt install lynis"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        34)
            # echo "sudo apt install net-tools"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        35)
            # echo "sudo apt install iftop"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        36)
            # echo "sudo apt install iotop"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        37)
            # echo "sudo apt install nethogs"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        38)
            # echo "sudo apt install slurm"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        39)
            # echo "sudo apt install bmon"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        40)
            # echo "sudo apt install speedtest-cli"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        41)
            # echo "sudo apt install traceroute"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        42)
            # echo "sudo apt install nmap"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        43)
            # echo "sudo apt install wireshark"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        44)
            # echo "sudo apt install tcpdump"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        45)
            # echo "sudo apt install iptables"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        46)
            # echo "sudo apt install iproute2"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        47)
            # echo "sudo apt install bridge-utils"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        48)
            # echo "sudo apt install vlan"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        49)
            # echo "sudo apt install bonding"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        50)
            # echo "sudo apt install teamd"
            echo -e "${RED}Opção comentada - não executa nada${NC}"
            read -p "Pressione Enter para continuar..."
            ;;
        51)
            echo -e "${GREEN}Saindo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opção inválida! Digite um número de 1 a 51.${NC}"
            echo ""
            read -p "Pressione Enter para continuar..."
            ;;
    esac
done 