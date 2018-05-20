# MIGRAÇÃO AUTOMATICA DE ROLES ENTRE INSTANCIAS DO JIRA USANDO METODOS HTTP

# REQUISITOS

Instale os programas abaixo

DEBIAN : sudo apt-get install jq postman curl which figlet

REDHAT : sudo yum install jq postman curl which figlet

# VERSÃO 1.0.0

Função GET_ROLES

Recebe a "key" de um parâmetro do jira dinâmicamente e a partir dela faz uma busca das roles que o projeto pertence.

Função GET_ROLES_FROM_CSV

Recebe via parametro a localização do arquivo xlsx e o converte para .csv .

Função GET_PACKAGES

Verifica seu sistema operacional e instala os pacotes necessários, adicionando também o postman (não obrigatório) mas util para teste de coletas caso queira alterar o programa e adaptar a sua necessidade.