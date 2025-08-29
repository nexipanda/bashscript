## Script Principal

### start.sh
Menu interativo para execução de scripts. Permite executar scripts locais e baixar/executar scripts diretamente do GitHub.

**Como executar:**
```bash
curl -fsSL "https://raw.githubusercontent.com/nexipanda/bashscript/refs/heads/main/start.sh" | sudo bash
```

**Funcionalidades:**
- Menu colorido e interativo
- Execução de scripts locais
- Download e execução de scripts do GitHub via curl
- Verificação de status dos serviços instalados
- Interface amigável para gerenciamento de scripts

## Scripts Disponíveis

### webserver.sh
Script interativo para instalação automática de servidor web (Apache/Nginx), PHP, MySQL e phpMyAdmin com configurações otimizadas.

**Funcionalidades:**
- Instala Apache ou Nginx (escolha do usuário)
- Instala PHP com módulos essenciais (mysql, pdo, gd, mbstring, xml, curl, zip)
- Instala MySQL Server com configuração segura
- Instala phpMyAdmin com configuração automática
- Corrige problemas de acesso root no phpMyAdmin
- Configura autenticação por cookie e acesso sem senha
- Cria arquivo de teste PHP para verificação
- Configura serviços para inicialização automática
- Exibe URLs de acesso após instalação
