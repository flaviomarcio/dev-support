#!/bin/bash

. lib-envs.sh
. lib.sh

export POSTGRES_DDL_FILE=${PWD}/initdb-postgres.sql
export POSTGRES_DDL_DIR=${PWD}/resources/db/postgres

function __private___db_scan_files()
{
  unset __func_return
  local __db_scan_dir=${1}
  local __db_scan_filters=(${2})

  if ! [[ -d ${__db_scan_dir} ]]; then
    return 0;
  fi
 
  local __step_dirs=($(ls ${__db_scan_dir}))
  local __step_dir=
  for __step_dir in ${__step_dirs[*]}; 
  do
    local __step_files=
    for __db_scan_filter in ${__db_scan_filters[*]}; 
    do 
      local __db_scan_filter="${__db_scan_filter}*.sql"
      local __db_scan_dir_STEP="${__db_scan_dir}/${__step_dir}"
      local __db_scan_files=($(echo $(find ${__db_scan_dir}/${__step_dir} -iname ${__db_scan_filter} | sort)))
      local __db_scan_file=
      for __db_scan_file in ${__db_scan_files[*]};
      do
        local __step_files="${__step_files} ${__db_scan_file}"
      done
    done
    if [[ ${__step_files} != "" ]]; then
      local __func_return="${__func_return} [${__step_dir}] ${__step_files}"
    fi
  done

  echo ${__func_return}
  return 1  
}

function __private___db_scan_files_for_local()
{
  __private___db_scan_files "${1}" "drops schemas tables constraints-pk constraints-fk constraints-check indexes initdata view fakedata"
  if ! [ "$?" -eq 1 ]; then
    return 0;       
  fi
  return 1
}

function postgresPGPASS()
{
  #postgres
  export POSTGRES_PGPASS=${HOME}/.pgpass
  local AUTH="${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_DATABASE}:${POSTGRES_USER}:${POSTGRES_PASSWORD}">${POSTGRES_PGPASS}
  touch ${POSTGRES_PGPASS}
  rm -rf ${POSTGRES_PGPASS}
  echo ${AUTH} >> ${POSTGRES_PGPASS}
  chmod 0600 ${POSTGRES_PGPASS};
  return 1
}

function postgresDDLFiles(){
  local __scan_files=($(__private___db_scan_files_for_local "${POSTGRES_DDL_DIR}"))
  local __scan_file=
  for __scan_file in ${__scan_files[*]};
  do 
    local __scan_dir_files="${__scan_dir_files} ${__scan_file}"
  done
  echo ${__scan_dir_files}
  return 1;
}


function postgresDDLMaker(){
  local ddl_file=${POSTGRES_DDL_FILE}
  rm -rf ${ddl_file}
  touch ${ddl_file}
  local __scan_files=$(postgresDDLFiles)
  local __scan_file=
  for __scan_file in ${__scan_files[*]};
  do 
    if ! [[ -f ${__scan_file} ]]; then
      echo "--${__scan_file}">>${ddl_file}
    else
      cat ${__scan_file}>>${ddl_file}
    fi
    echo "">>${ddl_file}
  done
  return 1;
}

function postgresDDLApply()
{
  export POSTGRES_HOST="127.0.0.1"
  export POSTGRES_USER=services
  export POSTGRES_PASSWORD=services
  export POSTGRES_DATABASE=services
  export POSTGRES_PORT=5432

  echo -e "${COLOR_CIANO}- target: ${COLOR_CIANO}${DATABASE_DIR}"
  echo -e "${COLOR_MAGENTA}  Executing"
  echo -e "${COLOR_BLUE}  - Environments"
  echo -e "${COLOR_BLUE}    - export ${COLOR_CIANO}POSTGRES_HOST      ${COLOR_RED}=${COLOR_YELLOW}${POSTGRES_HOST}${COLOR_OFF}"
  echo -e "${COLOR_BLUE}    - export ${COLOR_CIANO}POSTGRES_DATABASE  ${COLOR_RED}=${COLOR_YELLOW}${POSTGRES_DATABASE}${COLOR_OFF}"
  echo -e "${COLOR_BLUE}    - export ${COLOR_CIANO}POSTGRES_USER      ${COLOR_RED}=${COLOR_YELLOW}${POSTGRES_USER}${COLOR_OFF}"
  echo -e "${COLOR_BLUE}    - export ${COLOR_CIANO}POSTGRES_PASSWORD  ${COLOR_RED}=${COLOR_YELLOW}${POSTGRES_PASSWORD}${COLOR_OFF}"
  echo -e "${COLOR_BLUE}    - export ${COLOR_CIANO}POSTGRES_PORT      ${COLOR_RED}=${COLOR_YELLOW}${POSTGRES_PORT}${COLOR_OFF}"
  echo -e "${COLOR_BLUE}    - export ${COLOR_CIANO}POSTGRES_DDL_FILE  ${COLOR_RED}=${COLOR_YELLOW}${POSTGRES_DDL_FILE}${COLOR_OFF}"
  echo -e "${COLOR_BLUE}  - command: ${COLOR_CIANO}psql ${COLOR_CIANO}-q -h ${COLOR_YELLOW}\${POSTGRES_HOST} ${COLOR_CIANO}-U ${COLOR_YELLOW}\${POSTGRES_USER} ${COLOR_CIANO}-p ${COLOR_YELLOW}\${POSTGRES_PORT} ${COLOR_CIANO}-d ${COLOR_YELLOW}\${POSTGRES_DATABASE} ${COLOR_CIANO}-a -f ${COLOR_YELLOW}\${POSTGRES_DDL_FILE}${COLOR_OFF}"
  
  postgresDDLMaker
  postgresPGPASS
  local __scan_files=$(postgresDDLFiles)
  local __scan_file=
  local __ddl_tmp_file=/tmp/$RANDOM.sql
  for __scan_file in ${__scan_files[*]};
  do 
    if ! [[ -f ${__scan_file} ]]; then
      echo -e "${COLOR_GREEN}    - ${__scan_file}${COLOR_OFF}"
    else
      echo -e "${COLOR_YELLOW}      - $(basename ${__scan_file})${COLOR_OFF}"
      echo "set client_min_messages to WARNING; ">${__ddl_tmp_file};
      cat ${__scan_file}>>${__ddl_tmp_file}
      echo $(psql -q -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -p ${POSTGRES_PORT} -d ${POSTGRES_DATABASE} -a -f ${__ddl_tmp_file})&>/dev/null
    fi
  done
  
  exit 0
}

