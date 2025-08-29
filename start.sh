#!/bin/bash
# menu.sh - Menu simples

opcao=0
until [ "$opcao" -eq 5 ]; do
    echo "=============================="
    echo "         MENU PRINCIPAL       "
    echo "=============================="
    echo "1) Mostrar data e hora"
    echo "2) Mostrar diretório atual"
    echo "3) Listar arquivos"
    echo "4) Mostrar usuários logados"
    echo "5) Sair"
    echo "------------------------------"
    read -p "Escolha uma opção [1-5]: " opcao

    case $opcao in
        1) date ;;
        2) pwd ;;
        3) ls -lah ;;
        4) who ;;
        5) echo "Saindo..." ;;
        *) echo "Opção inválida, tente novamente." ;;
    esac

    echo ""
done
