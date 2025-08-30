#!/bin/bash

clear
echo "=========================="
echo "       MENU SIMPLES       "
echo "=========================="
echo "1) web server"
echo "2) Mostrar data"
echo "3) Sair"
echo "=========================="

# Lê a entrada diretamente do terminal
read -p "Escolha uma opção: " opcao </dev/tty

case $opcao in
    1)
        echo "web server instaler"
        sleep 2
        wget https://raw.githubusercontent.com/nexipanda/bashscript/refs/heads/main/scripts/webserver.sh
        chmod u+x webserver.sh
        ./webserver.sh
        ;;
    2)
        echo "Data atual:"
        date
        ;;
    3)
        echo "Saindo..."
        exit
        ;;
    *)
        echo "Opção inválida!"
        exit 1
        ;;
esac