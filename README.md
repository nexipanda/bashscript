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

## como usar

```bash
wget https://raw.githubusercontent.com/nexigonprime/bashscript/refs/heads/main/scripts/webserver.sh
```
```bash
chmod u+x webserver.sh
```
```bash
./webserver.sh
```