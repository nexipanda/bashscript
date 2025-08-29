#!/bin/bash
# menu.sh - Menu interativo no shell

while true; do
    clear
    echo "=================================="
    echo "         MENU PRINCIPAL"
    echo "=================================="
    echo "1) Verificar data e hora"
    echo "2) Mostrar diretório atual"
    echo "3) Listar arquivos"
    echo "4) Reiniciar serviço (exemplo)"
    echo "5) Sair"
    echo "----------------------------------"
    read -p "Escolha uma opção [1-5]: " opcao

    case $opcao in
        1)
            echo "Data e hora atuais:"
            date
            ;;
        2)
            echo "Diretório atual:"
            pwd
            ;;
        3)
            echo "Arquivos no diretório:"
            ls -lah
            ;;
        4)
            read -p "Digite o nome do serviço: " servico
            sudo systemctl restart "$servico"
            echo "Serviço $servico reiniciado."
            ;;
        5)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida!"
            ;;
    esac

    echo ""
    read -p "Pressione [Enter] para continuar..."
done
