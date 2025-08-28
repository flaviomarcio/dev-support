#!/bin/bash

. lib-envs.sh
. lib.sh

export ROOT_DIR=${PWD}
export TMP_DIR=/tmp/dev-suporte
export MAVEN_SOURCE_DIR=${TMP_DIR}/src
export MAVEN_SOURCE_TARGET_DIR=${MAVEN_SOURCE_DIR}/target
export MAVEN_BINARY_DIR=${ROOT_DIR}/target


export DOCKER_COMPONENTS=./components.txt
export DOCKER_COMPOSE_MAVEN=./docker-compose-maven.yml
export DOCKER_COMPOSE_MAVEN_PARSED=./docker-compose-maven-parsed.yml

function createDirs()
{
  cd ${ROOT_DIR}
  mkdir -p ${TMP_DIR}
  mkdir -p ${MAVEN_BINARY_DIR}
}

function mavenBuild()
{
  cd ${ROOT_DIR}
  local __component=${1}
  local __git_repository="${GIT_URI_PREFIX}/${__component}.git"
  rm -rf ${MAVEN_SOURCE_DIR}
  echo -e " ${COLOR_BLUE}Cloning${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- repository..: ${COLOR_YELLOW}${__git_repository}${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- local.......: ${COLOR_YELLOW}${MAVEN_SOURCE_DIR}${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- binary......: ${COLOR_YELLOW}${MAVEN_BINARY_DIR}${COLOR_OFF}"
  echo -e "     ${COLOR_YELLOW}Running ...${COLOR_OFF}"
  echo -e "       - ${COLOR_BLUE}git ${COLOR_CIANO}clone ${COLOR_YELLOW}${__git_repository}${COLOR_OFF}"
  git clone ${GIT_URI_PREFIX}/${__component}.git ${MAVEN_SOURCE_DIR} -q
  if ! [[ -d ${MAVEN_SOURCE_DIR} ]]; then
    echo -e "         ${COLOR_RED}Fail ${COLOR_OFF}"
    return 0;
  fi
  echo -e "         ${COLOR_GREEN}Successful ${COLOR_OFF}"
  echo -e " ${COLOR_BLUE}Buiding${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- local.......: ${COLOR_YELLOW}${MAVEN_SOURCE_DIR}${COLOR_OFF}"
  echo -e "     ${COLOR_YELLOW}Running ...${COLOR_OFF}"
  echo -e "       - ${COLOR_BLUE}mvn install ${COLOR_CIANO}-DskipTests${COLOR_OFF}"
  cd ${MAVEN_SOURCE_DIR}
  local __output=$(mvn install -DskipTests)
  local __check=$(echo ${__output} | grep ERROR)
  if [[ ${__check} != "" ]]; then
    echo -e "         ${COLOR_RED}Fail ${COLOR_OFF}"
    return 0
  fi
  echo -e "         ${COLOR_GREEN}Successful ${COLOR_OFF}"

  local __binary_origin="${MAVEN_SOURCE_TARGET_DIR}/${__component}*.jar"
  local __binary_destine=${MAVEN_BINARY_DIR}/${__component}.jar

  rm -rf ${__binary_destine}

  local __check_filter="${__component}*.jar"

  echo -e " ${COLOR_MAGENTA}Coping binary${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- origin....: ${COLOR_YELLOW}${__binary_origin}${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- destine...: ${COLOR_YELLOW}${__binary_destine}${COLOR_OFF}"
  echo -e "     ${COLOR_YELLOW}Running ...${COLOR_OFF}"
  echo -e "       - ${COLOR_BLUE}find ${COLOR_MAGENTA} ${MAVEN_SOURCE_TARGET_DIR} ${COLOR_CIANO}-maxdepth ${COLOR_YELLOW}1 ${COLOR_CIANO}-type ${COLOR_YELLOW}f ${COLOR_CIANO}-name ${COLOR_YELLOW}${__check_filter}${COLOR_OFF}"

  local __check_binary=$(find ${MAVEN_SOURCE_TARGET_DIR} -maxdepth 1 -type f -name ${__check_filter}) 
  if ! [[ -f ${__check_binary} ]]; then
    echo -e "         ${COLOR_RED}File not found, ${COLOR_YELLOW}${__binary_origin} ${COLOR_OFF}"
    return 0
  fi
  echo -e "       - ${COLOR_BLUE}cp ${COLOR_CIANO}-rf ${COLOR_YELLOW}${__check_binary} ${COLOR_GREEN}${__binary_destine}${COLOR_OFF}"
  cp -rf ${__check_binary} ${__binary_destine}
  if ! [[ -f ${__binary_destine} ]]; then
    echo -e "         ${COLOR_RED}Error on copy${COLOR_OFF}"
    return 0
  fi
  echo -e "         ${COLOR_GREEN}Successful ${COLOR_OFF}"
  return 1
}

function dockerComposeCopy(){
  cd ${ROOT_DIR}
  local __component=${1}
  export DOCKER_COMPONENT=${__component}
  echo -e " ${COLOR_BLUE}Parsing ${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- from..: ${COLOR_YELLOW}${DOCKER_COMPOSE_MAVEN}${COLOR_OFF}"
  echo -e "   ${COLOR_CIANO}- to....: ${COLOR_YELLOW}${DOCKER_COMPOSE_MAVEN_PARSED}${COLOR_OFF}"
  echo -e "     ${COLOR_YELLOW}Running ..."
  echo -e "       ${COLOR_BLUE}envsubst ${COLOR_RED}< ${COLOR_GREEN}${DOCKER_COMPOSE_MAVEN} ${COLOR_RED}> ${COLOR_YELLOW}${DOCKER_COMPOSE_MAVEN_PARSED} ${COLOR_OFF}"
  envsubst < ${DOCKER_COMPOSE_MAVEN} > ${DOCKER_COMPOSE_MAVEN_PARSED}
  echo -e "         ${COLOR_GREEN}Successful ${COLOR_OFF}"
  unset DOCKER_COMPONENT
}

function dockerDown()
{
  cd ${ROOT_DIR}
  echo -e " ${COLOR_BLUE}Docker stopping ${COLOR_OFF}"
  echo -e "   ${COLOR_YELLOW} Running ..."
  echo -e "     ${COLOR_BLUE}docker compose ${COLOR_CIANO}-f ${COLOR_YELLOW}${DOCKER_COMPOSE_MAVEN_PARSED} ${COLOR_CIANO}down ${COLOR_OFF}"
  docker compose -f ${DOCKER_COMPOSE_MAVEN_PARSED} down 
}

function dockerStart()
{
  cd ${ROOT_DIR}
  local __component=${1}
  local __binary_file=${MAVEN_BINARY_DIR}/${__component}.jar

  export DOCKER_COMPONENT=${__component}
  dockerDown
  echo -e " ${COLOR_BLUE}Docker stopping ${COLOR_OFF}"
  echo -e "   ${COLOR_YELLOW} Running ..."
  echo -e "     ${COLOR_BLUE}docker compose ${COLOR_CIANO}-f ${COLOR_YELLOW}${DOCKER_COMPOSE_MAVEN_PARSED} ${COLOR_CIANO}up -d --no-recreate${COLOR_OFF}"
  docker compose -f ${DOCKER_COMPOSE_MAVEN_PARSED} up -d --no-recreate 2>/dev/null
}

function dockerDeploy()
{
  cd ${ROOT_DIR}
  local __components=($(cat ${DOCKER_COMPONENTS}))

  for __component in "${__components[@]}"; do
    cd ${ROOT_DIR}

    dockerComposeCopy ${__component}
    echo -e "${COLOR_MAGENTA}Preparing component [${__component}]${COLOR_OFF}"

    mavenBuild ${__component}
    if ! [ "$?" -eq 1 ]; then
      echo -e "${COLOR_RED}Fail on building component: [${__component}]${COLOR_OFF}"
      continue;
    fi
    dockerStart ${__component}

  done
}


function main()
{
  createDirs
  dockerDeploy
}

main "$@"