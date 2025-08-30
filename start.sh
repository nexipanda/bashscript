#!/bin/bash

while true; do
    echo "===== MENU ====="
    echo "1) Mostrar data"
    echo "2) Mostrar diretório atual"
    echo "3) Listar arquivos"
    echo "4) Mostrar usuários logados"
    echo "5) Sair"
    echo "================"
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1) date ;;
        2) pwd ;;
        3) ls ;;
        4) who ;;
        5) echo "Saindo..."; exit ;;
        *) echo "Opção inválida!" ;;
    esac

    echo ""  # só para dar espaço
done
