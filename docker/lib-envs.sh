#!/bin/bash
export COLOR_OFF='\e[0m'
export COLOR_BACK='\e[0;30m'
export COLOR_BACK_B='\e[1;30m'
export COLOR_RED='\e[0;31m'
export COLOR_RED_B='\e[0;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_GREEN_B='\e[1;32m'
export COLOR_YELLOW='\e[0;33m'
export COLOR_YELLOW_B='\e[2;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_BLUE_B='\e[1;34m'
export COLOR_MAGENTA='\e[0;35m'
export COLOR_MAGENTA_B='\e[1;35m'
export COLOR_CIANO='\e[0;36m'
export COLOR_CIANO_B='\e[1;36m'
export COLOR_WHITE='\e[0;37m'
export COLOR_WHITE_B='\e[1;37m'

function __envs_unload()
{
  unset LOCAL_STACK_HOST_NAME
  unset LOCAL_STACK_DEFAULT_REGION
  unset LOCAL_STACK_HOST_URL
  unset LOCAL_STACK_ACCESS_KEY_ID
  unset LOCAL_STACK_SECRET_ACCESS_KEY

  unset AWS_HOST_NAME
  unset AWS_DEFAULT_REGION
  unset AWS_HOST_URL
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY

  unset SQLSERVER_URL
  unset SQLSERVER_USERNAME
  unset SQLSERVER_PASSWORD
  unset SQLSERVER_PORT

  unset POSTGRES_URL
  unset POSTGRES_USERNAME
  unset POSTGRES_PASSWORD
  unset POSTGRES_PORT

  unset DB2_URL
  unset DB2_USERNAME
  unset DB2_PASSWORD
  unset DB2_PORT

  unset STACK_COMPANY
  unset GIT_URI_PREFIX
}

function __envs_load()
{
  export LOCAL_STACK_HOST_NAME=localstack
  export LOCAL_STACK_DEFAULT_REGION=us-east-1
  export LOCAL_STACK_HOST_URL="http://localhost:4566"
  export LOCAL_STACK_ACCESS_KEY_ID=localstack
  export LOCAL_STACK_SECRET_ACCESS_KEY=localstack

  export AWS_HOST_NAME=${LOCAL_STACK_HOST_NAME}
  export AWS_DEFAULT_REGION=${LOCAL_STACK_DEFAULT_REGION}
  export AWS_HOST_URL=${LOCAL_STACK_HOST_URL}
  export AWS_ACCESS_KEY_ID=${LOCAL_STACK_ACCESS_KEY_ID}
  export AWS_SECRET_ACCESS_KEY=${LOCAL_STACK_SECRET_ACCESS_KEY}

  export SQLSERVER_URL="jdbc:sqlserver://;serverName=localhost;databaseName=master;trustServerCertificate=true;encrypt=true"
  export SQLSERVER_USERNAME=sa
  export SQLSERVER_PASSWORD=Services123!
  export SQLSERVER_PORT=1433

  export POSTGRES_URL=jdbc:postgresql://localhost:5432/services
  export POSTGRES_USERNAME=services
  export POSTGRES_PASSWORD=Services123!
  export POSTGRES_PORT=5432

  export DB2_URL=jdbc:db2://localhost:50000/services
  export DB2_USERNAME=db2inst1
  export DB2_PASSWORD=Services123!
  export DB2_PORT=50000

  if [[ ${STACK_COMPANY} == "" ]]; then
    export STACK_COMPANY="COMPANY_NAME"
  fi

  if [[ ${GIT_URI_PREFIX} == "" ]]; then
    export GIT_URI_PREFIX="git@github.com:${STACK_COMPANY}"
  fi
}


function main(){
  __envs_unload
  __envs_load
}

main


