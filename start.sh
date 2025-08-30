#!/bin/bash

clear
Menu() {
    clear
    echo -e '\n'
    echo "=========================="
    echo "     TÍTULO DO SEU MENU   "
    echo "=========================="
    echo "       ============       "
    echo "          ======          "
    echo "            ==            "
    echo "__________________________"
    echo "[ 1 ] | Opção 1"
    echo "[ 2 ] | Opção 2"
    echo "[ 3 ] | Opção 3"
    echo "[ 4 ] | Opção 4"
    echo "[ 5 ] | Opção 5"
    echo "[ 6 ] | Opção 6"
    echo "[ 7 ] | Opção 7"
    echo "[ 0 ] | SAIR"
    echo -e '\n'
    echo "RESPOSTA: "
    read opcao
    case $opcao in
    1) Opcao1 ;;
    2) Opcao2 ;;
    3) Opcao3 ;;
    4) Opcao4 ;;
    5) Opcao5 ;;
    6) Opcao6 ;;
    7) Opcao7 ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Menu;;
    esac
    }

Opcao1 () {
    clear
    echo "Título da Opção 1"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao1 ;;
    esac
}

Opcao2 () {
    clear
    echo "Título da Opção 2"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao2  ;;
    esac
}

Opcao3 () {
    clear
    echo "Título da Opção 4"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao3  ;;
    esac
}

Opcao4 () {
    clear
    echo "Título da Opção 4"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao4  ;;
    esac
}

Opcao5 () {
    clear
    echo "Título da Opção 6"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao5  ;;
    esac
}

Opcao6 () {
    clear
    echo "Título da Opção 6"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao6  ;;
    esac
}

Opcao7 () {
    clear
    echo "Título da Opção 7"
    echo "O que deseja fazer?"
    echo "[ 1 ] Voltar"
    echo "[ 0 ] Sair"
    read opcao
    case $opcao in
    1) Voltar ;;
    0) Sair ;;
    *) "Comando desconhecido" ; echo ; Opcao7  ;;
    esac
}

Voltar() {
    clear
        Menu
}

Sair() {
    clear
    exit
}
clear
Menu