#!/bin/bash

echo "=== Instalador de Servidor Web ==="
echo ""

# Pergunta sobre o servidor web
echo "Qual servidor web você deseja instalar?"
echo "1) Apache"
echo "2) Nginx"
echo "3) Ambos"
read -p "Escolha uma opção (1-3): " web_server

# Pergunta sobre PHP
echo ""
echo "Deseja instalar PHP?"
read -p "Digite 's' para sim ou 'n' para não: " install_php

if [[ $install_php == "s" || $install_php == "S" ]]; then
    echo ""
    echo "Quais módulos PHP você deseja instalar?"
    echo "Exemplos: mysql, pdo, gd, mbstring, xml, curl"
    read -p "Digite os módulos separados por espaço (ou Enter para padrão): " php_modules
fi

# Pergunta sobre MySQL
echo ""
echo "Deseja instalar MySQL?"
read -p "Digite 's' para sim ou 'n' para não: " install_mysql

# Pergunta sobre phpMyAdmin
if [[ $install_mysql == "s" || $install_mysql == "S" ]]; then
    echo ""
    echo "Deseja instalar phpMyAdmin?"
    read -p "Digite 's' para sim ou 'n' para não: " install_phpmyadmin
fi

# Resumo das escolhas
echo ""
echo "=== Resumo das Instalações ==="
echo "Servidor Web: $web_server"
echo "PHP: $install_php"
if [[ $install_php == "s" || $install_php == "S" ]]; then
    echo "Módulos PHP: ${php_modules:-padrão}"
fi
echo "MySQL: $install_mysql"
if [[ $install_mysql == "s" || $install_mysql == "S" ]]; then
    echo "phpMyAdmin: $install_phpmyadmin"
fi

echo ""
echo "Script de instalação configurado com sucesso!"
echo "Execute as instalações conforme suas escolhas."