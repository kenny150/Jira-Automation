#!/bin/bash

echo "$X"
echo "Inicinado ... "
echo "$X"

function CHECK_PACKAGES {

	if [[ "$SYSTEM" == "DEBIAN" ]]; then
		sudo apt-get install -y jq postman curl which figlet
	else 
		sudo yum install -y jq postman curl which figlet 
	fi

}

CURL=$(which curl)
JQ=$(which jq)

echo -e "CHECANDO PACOTES ... \n"
sleep 2
echo "$CURL" | grep "/"

if [[ "$?" -ne 0 ]]; then
  CHECK_PACKAGES
else echo -e "PACOTE CURL JÁ INSTALADO ... \n"
	
fi

echo "$JQ" | grep "/"
  if [[ "$?" -ne 0 ]]; then
    CHECK_PACKAGES
  else echo -e "PACOTE JQ JÁ INSTALADO\n"
  fi

  if [ -f "/etc/redhat-release" ]; then 
    SYSTEM="REDHAT"
  else SYSTEM="DEBIAN"
  fi

X="#############################################################################################"

HELP=$(echo "$X" && echo -e "INSTRUÇÕES\n\nPELO TERMINAL EXECUTE: \"bash update-jira-roles.sh NOME_DO_PROJETO\"" \
	&& echo "$X")

PROJECT="$1"

[[ ! -z "$PROJECT" ]]  && echo "PROJETO SELECIONADO: ${1}" || { echo -e "ERRO: INFORME O NOME DO PROJETO\n\n$HELP" ; exit 1 ; }

GET_ROLES () {
  local SERVER='http://192.168.0.6'
  local PORT='8080'
  local ADDRESS=${SERVER}:${PORT}
  local USERNAME='alvkennedy'
  declare -g PROJECT=$1 
  local PASSWORD='12345678'
  local CURL=$(which curl)
  local JQ=$(which jq)	
  local ROLES=$("$CURL" -H "Accept: application/json" -u "$USERNAME":"$PASSWORD" -XGET \
  "$ADDRESS"/rest/api/2/project/"$PROJECT"/role | "$JQ" '.' | grep -v "{" | grep -v "}" )
  local NUM=$(echo "$ROLES" | wc -l)
    
    for (( i = 1; i < "$NUM"; i++ )); do
      echo "$ROLES" | tail -n "$NUM" | awk -F ':' '{printf $1}' | sed 's/\ //g;s/\"//;s/\"/,/g;s/\,//;s/[\,]$/\n&/;s/[,]$//' > $PWD/lista.csv
      echo -e "\n$ROLES" | tail -n "$NUM" | awk -F '/' '{printf $NF}' | sed 's/\"//g' >> $PWD/lista.csv
    done

    if [[ "$(which figlet)" ]]; then
      figlet "TERMINADO :)"
    else 
      echo "TERMINADO :) "
    fi
}

CONVERT_XLS_TO_CSV (){	
  declare -g FILE="$1"

     ssconvert "$FILE" ${FILE}.csv

     [[ -f ${FILE}.csv ]] && echo "Arquivo ${CSV} convertido com sucesso" || echo "Algo deu errado" ;
	
     while read l
     do
      echo "$l"
     done < "$FILE".csv
}

REPLACE_CSV () {
	
  local EXPORTED_CSV="$1"

  while read n
    do
      s=,$(echo $n | awk -F ',' '{print $1}') 
      source=$(echo ${s} | sed 's/"//g')
      r=,$(echo "$n" | awk -F ',' '{print $5}')
      set -x
      sed -i "s|${source}|${r}|g" ${EXPORTED_CSV}
      set +x
      [[ $? -eq 0 ]] && echo "Alteração realizada" || echo "Não substituido" ;
    done < Relatorios-Jira_NOVOMODELO_Sprints.xlsx.csv

}

#GET_ROLES "$1"
#CONVERT_XLS_TO_CSV "$1"
REPLACE_CSV "$1"
#REPLACE_CSV "$1"