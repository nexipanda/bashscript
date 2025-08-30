#!/bin/bash

while true; do
    echo "=========================="
    echo "         MENU SIMPLES      "
    echo "=========================="
    echo "[ 1 ] | Atualizar sistema (apt update && upgrade)"
    echo "[ 2 ] | Mostrar data e hora"
    echo "[ 3 ] | Sair"
    echo "=========================="
    read -p "Escolha uma opção: " opcao

    case $opcao in
        1)
            echo "Atualizando sistema..."
            sudo apt update && sudo apt upgrade -y
            ;;
        2)
            echo "Data e hora atuais:"
            date
            ;;
        3)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida!"
            ;;
    esac

    echo ""
    read -p "Pressione ENTER para continuar..."
done
