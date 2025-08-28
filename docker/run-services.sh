#!/bin/bash

. lib-envs.sh
. lib.sh
. lib-postgres.sh

function readArgs(){
  unset arg_copy
  unset arg_no_update
  unset arg_info
  unset arg_docker_down
  unset arg_docker_start
  for arg in "$@"; do
    if [[ ${arg} == "--copy" ]]; then
      export arg_copy=1
    elif [[ ${arg} == "--no-update" ]]; then
      export arg_no_update=1
    elif [[ ${arg} == "--info" ]]; then
      export arg_info=1
    elif [[ ${arg} == "--docker" ]]; then
      export arg_docker_start=1
    elif [[ ${arg} == "--docker-down" ]]; then
      export arg_docker_down=1
    fi
  done
}

function copyFiles()
{
  echo -e "${COLOR_BLUE}git ${COLOR_CIANO}clone ${COLOR_YELLOW}${GIT_URI_PREFIX}/dev-support.git${COLOR_OFF}"

  local __src_path=${HOME}/temp/src
  local __docker_path=${__src_path}/docker
  mkdir -p ${__src_path}

  #clona repositorio dev-suporte para copia dos dados
  rm -rf ${__src_path}
  git clone ${GIT_URI_PREFIX}/dev-support.git ${__src_path} -q

  local __files=(resources initdb-db2inst1.sql initdb-postgres.sql initdb-sqlserver.sql init-localstack.sh docker-compose.yml script-update.sh)
  for __file in "${__files[@]}"; do
    #atualizar script de auto-update
    local __target_file=${__docker_path}/${__file}
    echo -e "${COLOR_MAGENTA}Copiando ${COLOR_YELLOW}${__file} ${COLOR_OFF}"
    if ! [[ -f ${__target_file} ]]; then
      echo -e "${COLOR_RED}  Resource not found: ${COLOR_YELLOW}${__target_file}${COLOR_OFF}"
    else
      rm -rf ./${__file}
      cp -rf ${__target_file} .
      echo -e "${COLOR_GREEN}  Successful${COLOR_OFF}"
    fi
    chmod +x *
  done
}

function createDirs()
{
  mkdir -p ./volumes/db2/database
  mkdir -p ./volumes/postgres
  mkdir -p ./volumes/sqlserver
}

function dockerDown()
{
  docker compose down
}

function dockerStart()
{
  dockerDown
  postgresDDLMaker
  docker compose up -d --no-recreate
}


function main()
{

  readArgs "$@"
  #createDirs

  # if [[ "${arg_copy}" != "" ]]; then
  #   copyFiles
  #   exit 0
  # fi

  if [[ "${arg_info}" != "" ]]; then
    clear
    printMSG
    exit 0
  fi

  if [[ "${arg_docker_down}" != "" ]]; then
    dockerDown
    exit 0
  fi

  if [[ "${arg_docker_start}" != "" ]]; then
    dockerStart
    exit 0
  fi

  # if [[ "${arg_no_update}" == "" ]]; then
  #   copyFiles
  # fi

  dockerStart
  clear
  printMSG
}

main "$@"