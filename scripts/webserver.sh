#!/bin/bash

# Função para perguntar sim/não
ask_yes_no() {
    while true; do
        read -p "$1 [s/N]: " yn
        case ${yn:-$2} in
            [Ss]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Por favor, responda sim (s) ou não (n).";;
        esac
    done
}

# Atualiza pacotes
echo "==> Atualizando lista de pacotes..."
sudo apt update -y

# Perguntar se quer instalar servidor web
if ask_yes_no "Deseja instalar um servidor web?" "N"; then
    echo "Escolha o servidor web:"
    echo "1) Apache"
    echo "2) Nginx"
    read -p "Digite sua escolha [1/2]: " web_choice
    
    case $web_choice in
        2)
            echo "==> Instalando Nginx..."
            sudo apt install -y nginx
            sudo systemctl enable nginx
            sudo systemctl start nginx
            WEB_SERVER="nginx"
            ;;
        *)
            echo "==> Instalando Apache..."
            sudo apt install -y apache2
            sudo systemctl enable apache2
            sudo systemctl start apache2
            WEB_SERVER="apache"
            ;;
    esac
fi

# Perguntar se quer instalar PHP
if ask_yes_no "Deseja instalar PHP?" "N"; then
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
        echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php > /dev/null
    fi
fi

# Perguntar se quer instalar MySQL
if ask_yes_no "Deseja instalar MySQL?" "N"; then
    echo "==> Instalando MySQL Server..."
    sudo apt install -y mysql-server
    sudo systemctl enable mysql
    sudo systemctl start mysql
    
    # Configuração segura do MySQL
    if ask_yes_no "Deseja executar a configuração segura do MySQL?" "N"; then
        sudo mysql_secure_installation
    fi
fi

# Perguntar se quer instalar phpMyAdmin (só se MySQL e PHP estiverem instalados)
if [ "$(systemctl is-active mysql)" = "active" ] && [ -x "$(command -v php)" ]; then
    if ask_yes_no "Deseja instalar phpMyAdmin?" "N"; then
        echo "==> Instalando phpMyAdmin..."
        sudo DEBIAN_FRONTEND=noninteractive apt install -y phpmyadmin
        
        # Configuração para Apache
        if [ "$WEB_SERVER" = "apache" ]; then
            # Ativar configuração do phpMyAdmin no Apache
            sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
            sudo a2enconf phpmyadmin
            sudo systemctl reload apache2
        fi
        
        # Configuração para Nginx
        if [ "$WEB_SERVER" = "nginx" ]; then
            # Configurar Nginx para phpMyAdmin
            if [ ! -f /etc/nginx/conf.d/phpmyadmin.conf ]; then
                echo "server {
    listen 80;
    server_name _;
    root /usr/share/phpmyadmin;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php\$is_args\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php-fpm.sock;
    }
}" | sudo tee /etc/nginx/conf.d/phpmyadmin.conf > /dev/null
                sudo systemctl reload nginx
            fi
        fi
        
        # Habilita extensões necessárias
        sudo phpenmod mbstring
        if [ "$WEB_SERVER" = "apache" ]; then
            sudo systemctl restart apache2
        else
            sudo systemctl restart php-fpm
        fi
        
        # Perguntar se quer corrigir erro de acesso root no phpMyAdmin
        if ask_yes_no "Deseja corrigir o erro de acesso do usuário root no phpMyAdmin?" "N"; then
            echo "==> Corrigindo configuração do phpMyAdmin..."
            
            # Editar arquivo de configuração do phpMyAdmin
            if [ -f /etc/phpmyadmin/config.inc.php ]; then
                # Fazer backup do arquivo original
                sudo cp /etc/phpmyadmin/config.inc.php /etc/phpmyadmin/config.inc.php.backup
                
                echo "==> Verificando e corrigindo configurações do phpMyAdmin..."
                
                # Função para verificar e corrigir configurações específicas
                fix_phpmyadmin_config() {
                    local config_file="/etc/phpmyadmin/config.inc.php"
                    local temp_file="/tmp/phpmyadmin_config_temp.php"
                    
                    # Criar arquivo temporário com as configurações corretas
                    cat > "$temp_file" << 'EOF'
<?php
/**
 * Debian local configuration file
 *
 * This file overrides the settings made by phpMyAdmin interactive setup
 * utility.
 *
 * For example configuration see
 *   /usr/share/doc/phpmyadmin/examples/config.sample.inc.php
 * or
 *   /usr/share/doc/phpmyadmin/examples/config.manyhosts.inc.php
 *
 * NOTE: do not add security sensitive data to this file (like passwords)
 * unless you really know what you're doing. If you do, any user that can
 * run PHP or CGI on your webserver will be able to read them. If you still
 * want to do this, make sure to properly secure the access to this file
 * (also on the filesystem level).
 */

if (!function_exists('check_file_access')) {
    function check_file_access(string $path): bool
    {
        if (is_readable($path)) {
            return true;
        }

        if (! file_exists($path)) {
            return false;
        }

        error_log(
            'phpmyadmin: Failed to load ' . $path
            . ' Check group www-data has read access and open_basedir restrictions.'
        );
        return false;
    }
}

// Load secret generated on postinst
if (check_file_access('/var/lib/phpmyadmin/blowfish_secret.inc.php')) {
    require('/var/lib/phpmyadmin/blowfish_secret.inc.php');
}

/**
 * Server(s) configuration
 */
$i = 0;
// The $cfg['Servers'] array starts with $cfg['Servers'][1].  Do not use $cfg['Servers'][0].
// You can disable a server config entry by setting host to ''.
$i++;

/**
 * Read configuration from dbconfig-common
 * You can regenerate it using: dpkg-reconfigure -plow phpmyadmin
 */
if (check_file_access('/etc/phpmyadmin/config-db.php')) {
    require('/etc/phpmyadmin/config-db.php');
}

/* Configure according to dbconfig-common if enabled */
if (!empty($dbname)) {
    /* Authentication type */
    $cfg['Servers'][$i]['auth_type'] = 'cookie';
    /*mysql sem senha*/
    $cfg['Servers'][$i]['AllowNoPassword'] = true;
    /* Server parameters */
    if (empty($dbserver)) $dbserver = 'localhost';
    $cfg['Servers'][$i]['host'] = $dbserver;

    if (!empty($dbport) || $dbserver != 'localhost') {
        $cfg['Servers'][$i]['connect_type'] = 'tcp';
        $cfg['Servers'][$i]['port'] = $dbport;
    }
    //$cfg['Servers'][$i]['compress'] = false;
    /* Optional: User for advanced features */
    $cfg['Servers'][$i]['controluser'] = $dbuser;
    $cfg['Servers'][$i]['controlpass'] = $dbpass;
    /* Optional: Advanced phpMyAdmin features */
    $cfg['Servers'][$i]['pmadb'] = $dbname;
    $cfg['Servers'][$i]['bookmarktable'] = 'pma__bookmark';
    $cfg['Servers'][$i]['relation'] = 'pma__relation';
    $cfg['Servers'][$i]['table_info'] = 'pma__table_info';
    $cfg['Servers'][$i]['table_coords'] = 'pma__table_coords';
    $cfg['Servers'][$i]['pdf_pages'] = 'pma__pdf_pages';
    $cfg['Servers'][$i]['column_info'] = 'pma__column_info';
    $cfg['Servers'][$i]['history'] = 'pma__history';
    $cfg['Servers'][$i]['table_uiprefs'] = 'pma__table_uiprefs';
    $cfg['Servers'][$i]['tracking'] = 'pma__tracking';
    $cfg['Servers'][$i]['userconfig'] = 'pma__userconfig';
    $cfg['Servers'][$i]['recent'] = 'pma__recent';
    $cfg['Servers'][$i]['favorite'] = 'pma__favorite';
    $cfg['Servers'][$i]['users'] = 'pma__users';
    $cfg['Servers'][$i]['usergroups'] = 'pma__usergroups';
    $cfg['Servers'][$i]['navigationhiding'] = 'pma__navigationhiding';
    $cfg['Servers'][$i]['savedsearches'] = 'pma__savedsearches';
    $cfg['Servers'][$i]['central_columns'] = 'pma__central_columns';
    $cfg['Servers'][$i]['designer_settings'] = 'pma__designer_settings';
    $cfg['Servers'][$i]['export_templates'] = 'pma__export_templates';

    /* Uncomment the following to enable logging in to passwordless accounts,
     * after taking note of the associated security risks. */
    // $cfg['Servers'][$i]['AllowNoPassword'] = TRUE;

    /* Advance to next server for rest of config */
    $i++;
}

/* Authentication type */
//$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
//$cfg['Servers'][$i]['host'] = 'localhost';
//$cfg['Servers'][$i]['connect_type'] = 'tcp';
//$cfg['Servers'][$i]['compress'] = false;
/* Uncomment the following to enable logging in to passwordless accounts,
 * after taking note of the associated security risks. */
// $cfg['Servers'][$i]['AllowNoPassword'] = TRUE;

/**
 * phpMyAdmin configuration storage settings.
 */

/* User used to manipulate with storage */
// $cfg['Servers'][$i]['controlhost'] = '';
// $cfg['Servers'][$i]['controlport'] = '';
// $cfg['Servers'][$i]['controluser'] = 'pma';
// $cfg['Servers'][$i]['controlpass'] = 'pmapass';

/* Storage database and tables */
// $cfg['Servers'][$i]['pmadb'] = 'phpmyadmin';
// $cfg['Servers'][$i]['bookmarktable'] = 'pma__bookmark';
// $cfg['Servers'][$i]['relation'] = 'pma__relation';
// $cfg['Servers'][$i]['table_info'] = 'pma__table_info';
// $cfg['Servers'][$i]['table_coords'] = 'pma__table_coords';
// $cfg['Servers'][$i]['pdf_pages'] = 'pma__pdf_pages';
// $cfg['Servers'][$i]['column_info'] = 'pma__column_info';
// $cfg['Servers'][$i]['history'] = 'pma__history';
// $cfg['Servers'][$i]['table_uiprefs'] = 'pma__table_uiprefs';
// $cfg['Servers'][$i]['tracking'] = 'pma__tracking';
// $cfg['Servers'][$i]['userconfig'] = 'pma__table_uiprefs';
// $cfg['Servers'][$i]['recent'] = 'pma__recent';
// $cfg['Servers'][$i]['favorite'] = 'pma__favorite';
// $cfg['Servers'][$i]['users'] = 'pma__users';
// $cfg['Servers'][$i]['usergroups'] = 'pma__usergroups';
// $cfg['Servers'][$i]['navigationhiding'] = 'pma__navigationhiding';
// $cfg['Servers'][$i]['savedsearches'] = 'pma__savedsearches';
// $cfg['Servers'][$i]['central_columns'] = 'pma__central_columns';
// $cfg['Servers'][$i]['designer_settings'] = 'pma__designer_settings';
// $cfg['Servers'][$i]['export_templates'] = 'pma__export_templates';

/*
 * End of servers configuration
 */

/*
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

/* Support additional configurations */
foreach (glob('/etc/phpmyadmin/conf.d/*.php') as $filename)
{
    include($filename);
}
EOF
                    
                    # Substituir o arquivo original
                    sudo cp "$temp_file" "$config_file"
                    sudo chown root:www-data "$config_file"
                    sudo chmod 644 "$config_file"
                    
                    # Limpar arquivo temporário
                    rm -f "$temp_file"
                    
                    echo "==> Arquivo de configuração do phpMyAdmin atualizado com sucesso!"
                    echo "==> Configurações auth_type='cookie' e AllowNoPassword=true aplicadas"
                }
                
                # Executar a correção
                fix_phpmyadmin_config
            fi
            
            # Configurar MySQL para permitir acesso root sem senha
            echo "==> Configurando MySQL para acesso root sem senha..."
            sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '';"
            sudo mysql -e "FLUSH PRIVILEGES;"
            
            echo "==> Configuração do MySQL atualizada com sucesso!"
            echo "==> Agora você pode acessar o phpMyAdmin com usuário 'root' sem senha"
        fi
    fi
else
    echo "==> phpMyAdmin não foi instalado porque MySQL ou PHP não estão presentes."
fi

# Mostrar informações finais
IP=$(hostname -I | awk '{print $1}')
echo "===================================================="
echo "Instalação concluída!"
[ "$WEB_SERVER" = "apache" ] && echo "Apache rodando em: http://$IP/"
[ "$WEB_SERVER" = "nginx" ] && echo "Nginx rodando em: http://$IP/"
[ -x "$(command -v php)" ] && echo "Teste PHP em:       http://$IP/info.php"
[ -f /usr/share/phpmyadmin/index.php ] && echo "phpMyAdmin em:      http://$IP/phpmyadmin"
echo "====================================================" 