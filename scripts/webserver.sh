#!/bin/bash

# Atualiza pacotes
echo "==> Atualizando lista de pacotes..."
sudo apt update -y

# Pergunta sobre servidor web
echo "Deseja instalar um servidor web?"
echo "1) Apache"
echo "2) Nginx"
echo "3) Nenhum"
read -p "Digite sua escolha [1/2/3]: " web_choice

case $web_choice in
    1)
        echo "==> Instalando Apache..."
        sudo apt install -y apache2
        sudo systemctl enable apache2
        sudo systemctl start apache2
        WEB_SERVER="apache"
        ;;
    2)
        echo "==> Instalando Nginx..."
        sudo apt install -y nginx
        sudo systemctl enable nginx
        sudo systemctl start nginx
        WEB_SERVER="nginx"
        ;;
    *)
        echo "==> Pulando instalação do servidor web."
        WEB_SERVER="none"
        ;;
esac

# Pergunta sobre PHP
echo ""
echo "Deseja instalar PHP?"
echo "1) Sim"
echo "2) Não"
read -p "Digite sua escolha [1/2]: " php_choice

if [ "$php_choice" = "1" ]; then
    echo "==> Instalando PHP + módulos..."
    sudo apt install -y php libapache2-mod-php php-fpm php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip
    
    # Configuração específica para Apache
    if [ "$WEB_SERVER" = "apache" ]; then
        echo "==> Configurando Apache para priorizar PHP..."
        sudo sed -i 's/index.html/index.php index.html/' /etc/apache2/mods-enabled/dir.conf
        sudo systemctl restart apache2
    fi
    
    # Configuração específica para Nginx
    if [ "$WEB_SERVER" = "nginx" ]; then
        echo "==> Configurando PHP-FPM para Nginx..."
        sudo systemctl enable php-fpm
        sudo systemctl start php-fpm
    fi
    
    echo "==> Criando arquivo de teste PHP..."
    if [ "$WEB_SERVER" = "apache" ]; then
        echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php > /dev/null
    elif [ "$WEB_SERVER" = "nginx" ]; then
        echo "<?php phpinfo(); ?>" | sudo tee /usr/share/nginx/html/info.php > /dev/null
    fi
else
    echo "==> Pulando instalação do PHP."
fi

# Pergunta sobre MySQL
echo ""
echo "Deseja instalar MySQL?"
echo "1) Sim"
echo "2) Não"
read -p "Digite sua escolha [1/2]: " mysql_choice

if [ "$mysql_choice" = "1" ]; then
    echo "==> Instalando MySQL Server..."
    sudo apt install -y mysql-server
    sudo systemctl enable mysql
    sudo systemctl start mysql
    
    # Pergunta sobre configuração segura
    echo ""
    echo "Deseja executar a configuração segura do MySQL?"
    echo "1) Sim"
    echo "2) Não"
    read -p "Digite sua escolha [1/2]: " mysql_secure_choice
    
    if [ "$mysql_secure_choice" = "1" ]; then
        sudo mysql_secure_installation
    fi
else
    echo "==> Pulando instalação do MySQL."
fi

# Pergunta sobre phpMyAdmin (só se MySQL e PHP estiverem instalados)
if [ "$mysql_choice" = "1" ] && [ "$php_choice" = "1" ]; then
    echo ""
    echo "Deseja instalar phpMyAdmin?"
    echo "1) Sim"
    echo "2) Não"
    read -p "Digite sua escolha [1/2]: " phpmyadmin_choice
    
    if [ "$phpmyadmin_choice" = "1" ]; then
        echo "==> Instalando phpMyAdmin..."
        sudo DEBIAN_FRONTEND=noninteractive apt install -y phpmyadmin
        
        # Configuração para Apache
        if [ "$WEB_SERVER" = "apache" ]; then
            # Criar link simbólico para acessar via navegador
            if [ ! -L /var/www/html/phpmyadmin ]; then
                sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
            fi
        fi
        
        # Configuração para Nginx
        if [ "$WEB_SERVER" = "nginx" ]; then
            # Configurar Nginx para phpMyAdmin
            if [ ! -f /etc/nginx/conf.d/phpmyadmin.conf ]; then
                sudo tee /etc/nginx/conf.d/phpmyadmin.conf > /dev/null << EOF
server {
    listen 80;
    server_name _;
    root /usr/share/phpmyadmin;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$is_args\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php-fpm.sock;
    }
}
EOF
                sudo systemctl reload nginx
            fi
        fi
        
        # Habilita extensões necessárias
        sudo phpenmod mbstring
        if [ "$WEB_SERVER" = "apache" ]; then
            sudo systemctl restart apache2
        elif [ "$WEB_SERVER" = "nginx" ]; then
            sudo systemctl restart php-fpm
        fi
    fi
else
    echo "==> phpMyAdmin não foi instalado porque MySQL ou PHP não estão presentes."
fi

# Mostrar informações finais
IP=$(hostname -I | awk '{print $1}')
echo ""
echo "===================================================="
echo "Instalação concluída!"
[ "$WEB_SERVER" = "apache" ] && echo "Apache rodando em: http://$IP/"
[ "$WEB_SERVER" = "nginx" ] && echo "Nginx rodando em: http://$IP/"
[ "$php_choice" = "1" ] && [ "$WEB_SERVER" = "apache" ] && echo "Teste PHP em:       http://$IP/info.php"
[ "$php_choice" = "1" ] && [ "$WEB_SERVER" = "nginx" ] && echo "Teste PHP em:       http://$IP/info.php"
[ "$phpmyadmin_choice" = "1" ] && echo "phpMyAdmin em:      http://$IP/phpmyadmin"
echo "===================================================="