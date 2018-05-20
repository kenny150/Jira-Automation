# MIGRAÇÃO AUTOMATICA DE ROLES ENTRE INSTANCIAS DO JIRA USANDO METODOS HTTP

# REQUISITOS

Instale os programas abaixo

DEBIAN : sudo apt-get install jq postman curl which figlet

REDHAT : sudo yum install jq postman curl which figlet

# CHANGELOG

# VERSÃO 1.0.1
# Alterado método de entrada e saída do xlsx


# VERSÃO 1.0.0

# Adicionado função GET_ROLES

Descrição : Recebe a "key" de um parâmetro do jira dinâmicamente e a partir dela faz uma busca das roles que o projeto pertence.

# Adicionado função GET_ROLES_FROM_CSV

Descrição : Recebe via parametro a localização do arquivo xlsx e o converte para .csv .

# Adicionado função GET_PACKAGES

Descrição : Verifica seu sistema operacional e instala os pacotes necessários, adicionando também o postman (não obrigatório) mas util para teste de coletas caso queira alterar o programa e adaptar a sua necessidade.