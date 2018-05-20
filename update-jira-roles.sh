#!/bin/bash


function CHECK_PACKAGES {

	if [[ "$SYSTEM" == "DEBIAN" ]]; then
		sudo apt-get install -y jq postman curl which figlet
	else 
		sudo yum install -y jq postman curl which figlet 
	fi

}

CURL=$(which curl)
JQ=$(which jq)

echo "Checando pacotes ... "
echo "$CURL" | grep "/"
	if [[ "$?" -ne 0 ]]; then
		CHECK_PACKAGES
	else echo "Pacote curl já instalado ... "
	
	fi

echo "$JQ" | grep "/"
	if [[ "$?" -ne 0 ]]; then
		CHECK_PACKAGES
	else echo "Pacote jq já instalado"
	
	fi

if [ -f "/etc/redhat-release" ]; then 
	SYSTEM="REDHAT"
	echo "Distribuição ${SYSTEM}"
else SYSTEM="DEBIAN" 
	echo "Distribuição ${SYSTEM}"
fi

X="#############################################################################################"

HELP=$(echo "$X" && echo -e "INSTRUÇÕES\n\nPELO TERMINAL EXECUTE: \"bash update-jira-roles.sh NOME_DO_PROJETO\"" \
	&& echo "$X")

PROJECT="$1"

[[ ! -z "$PROJECT" ]]  && echo "Projeto selecionado: ${1}" || { echo -e "ERRO: INFORME O NOME DO PROJETO\n\n$HELP" ; exit 1 ; }

echo "$X"
echo "Inicinado ... "
echo "$X"

GET_ROLES () {
	local SERVER='http://192.168.0.6'
	local PORT='8080'
	local ADDRESS=${SERVER}:${PORT}
	local USERNAME='alvkennedy'
	local PROJECT=$1
	local PASSWORD='12345678'
	local CURL=$(which curl)
	local JQ=$(which jq)	
	local ROLES=$("$CURL" -H "Accept: application/json" -u "$USERNAME":"$PASSWORD" -XGET \
				"$ADDRESS"/rest/api/2/project/"$PROJECT"/role | "$JQ" '.' | grep -v "{" | grep -v "}" )
	local NUM=$(echo "$ROLES" | wc -l)
    #echo "Rules projeto $PROJECT" > $PWD/lista.csv && \
    #echo "$ROLES" | tail -n "$NUM" | cut -d ':' -f'1,4' | sed  's/\ //g;s/\"//g;s/\:/,/;s/[,]$//' > $PWD/lista.csv
    for (( i = 1; i < "$NUM"; i++ )); do
    	echo "$ROLES" | tail -n "$NUM" | awk -F ":" '{printf $1}' | sed 's/\ //g;s/\"//;s/\"/,/g;s/\,//;s/[\,]$//'  > $PWD/lista.csv
    	
    done
    
}

GET_ROLES "$1"