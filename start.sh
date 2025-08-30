#!/bin/bash

clear
echo "=========================="
echo "       MENU SIMPLES       "
echo "=========================="
echo "1) Atualizar sistema"
echo "2) Mostrar data"
echo "3) Sair"
echo "=========================="

read -p "Escolha uma opção: " opcao

case $opcao in
    1)
        echo "Atualizando sistema..."
        sudo apt update && sudo apt upgrade -y
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
