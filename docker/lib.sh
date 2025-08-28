#!/bin/bash

. lib-envs.sh

function printAccess()
{
  echo -e  "${COLOR_BLUE}Serviços${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}Shell Script application ${COLOR_OFF}"
  echo -e  "    - ${COLOR_MAGENTA}Usando AWS ${COLOR_OFF}"
  echo -e  "      - ${COLOR_GREEN}Linux ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}apt ${COLOR_CIANO}install -y ${COLOR_YELLOW}jq awscli${COLOR_OFF}"
  echo -e  "      - ${COLOR_GREEN}Windows ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}winget install ${COLOR_CIANO}-e --id ${COLOR_YELLOW}Amazon.AWSCLI${COLOR_OFF}"
  echo -e  "    - ${COLOR_MAGENTA}Usando Azure ${COLOR_OFF}"
  echo -e  "      - ${COLOR_GREEN}Linux ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}apt ${COLOR_CIANO}install -y ${COLOR_YELLOW}jq awscli${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}curl ${COLOR_CIANO}-sL ${COLOR_YELLOW}https://aka.ms/InstallAzureCLIDeb ${COLOR_RED}| ${COLOR_BLUE}sudo ${COLOR_YELLOW}bash${COLOR_OFF}"
  echo -e  "      - ${COLOR_GREEN}Windows ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}winget ${COLOR_CIANO}install -e --id ${COLOR_YELLOW}Microsoft.AzureCLI${COLOR_OFF}"  
  echo -e  "${COLOR_BLUE}Credenciais${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}SQL Server${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_JDBC_URL${COLOR_GREEN}=${COLOR_YELLOW}${SQLSERVER_URL}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_USERNAME${COLOR_GREEN}=${COLOR_YELLOW}${SQLSERVER_USERNAME}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_PASSWORD${COLOR_GREEN}=${COLOR_YELLOW}${SQLSERVER_PASSWORD}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_PORT${COLOR_GREEN}=${COLOR_YELLOW}${SQLSERVER_PORT}${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}Postgres${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_JDBC_URL${COLOR_GREEN}=${COLOR_YELLOW}${POSTGRES_URL}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_USERNAME${COLOR_GREEN}=${COLOR_YELLOW}${POSTGRES_USERNAME}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_PASSWORD${COLOR_GREEN}=${COLOR_YELLOW}${POSTGRES_PASSWORD}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_PORT${COLOR_GREEN}=${COLOR_YELLOW}${POSTGRES_PORT}${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}DB2${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_JDBC_URL${COLOR_GREEN}=${COLOR_YELLOW}${DB2_URL}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_USERNAME${COLOR_GREEN}=${COLOR_YELLOW}${DB2_USERNAME}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_PASSWORD${COLOR_GREEN}=${COLOR_YELLOW}${DB2_PASSWORD}${COLOR_OFF}"
  echo -e  "    ${COLOR_CIANO}DB_PORT${COLOR_GREEN}=${COLOR_YELLOW} ${DB2_PORT}${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}localstack${COLOR_OFF}"
  echo -e  "    - ${COLOR_CIANO}AWS_HOST_URL${COLOR_GREEN}..........:${COLOR_YELLOW} ${AWS_HOST_URL}           ${COLOR_OFF}"
  echo -e  "    - ${COLOR_CIANO}AWS_DEFAULT_REGION${COLOR_GREEN}....:${COLOR_YELLOW} ${AWS_DEFAULT_REGION}     ${COLOR_OFF}"
  echo -e  "    - ${COLOR_CIANO}AWS_ACCESS_KEY_ID${COLOR_GREEN}.....:${COLOR_YELLOW} ${AWS_ACCESS_KEY_ID}      ${COLOR_OFF}"
  echo -e  "    - ${COLOR_CIANO}AWS_SECRET_ACCESS_KEY${COLOR_GREEN}.:${COLOR_YELLOW} ${AWS_SECRET_ACCESS_KEY}  ${COLOR_OFF}"
  echo -e  "      - ${COLOR_MAGENTA}Shell Script environments${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}export ${COLOR_CIANO}AWS_HOST_URL          ${COLOR_RED}=${COLOR_YELLOW} ${AWS_HOST_URL}           ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}export ${COLOR_CIANO}AWS_DEFAULT_REGION    ${COLOR_RED}=${COLOR_YELLOW} ${AWS_DEFAULT_REGION}     ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}export ${COLOR_CIANO}AWS_ACCESS_KEY_ID     ${COLOR_RED}=${COLOR_YELLOW} ${AWS_ACCESS_KEY_ID}      ${COLOR_OFF}"
  echo -e  "        ${COLOR_BLUE}export ${COLOR_CIANO}AWS_SECRET_ACCESS_KEY ${COLOR_RED}=${COLOR_YELLOW} ${AWS_SECRET_ACCESS_KEY}  ${COLOR_OFF}"
  echo -e  "- ${COLOR_MAGENTA}Using AWS CLI${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}Configuring${COLOR_OFF}"
  echo -e  "    ${COLOR_BLUE}aws ${COLOR_CIANO}configure set ${COLOR_GREEN}aws_access_key_id     ${COLOR_YELLOW}${AWS_ACCESS_KEY_ID}      ${COLOR_OFF}"
  echo -e  "    ${COLOR_BLUE}aws ${COLOR_CIANO}configure set ${COLOR_GREEN}aws_secret_access_key ${COLOR_YELLOW}${AWS_SECRET_ACCESS_KEY}  ${COLOR_OFF}"
  echo -e  "    ${COLOR_BLUE}aws ${COLOR_CIANO}configure set ${COLOR_GREEN}default.region        ${COLOR_YELLOW}${AWS_DEFAULT_REGION}     ${COLOR_OFF}"
  echo -e  "  - ${COLOR_MAGENTA}Using Endpoints${COLOR_OFF}"
  local __arg_default="${COLOR_RED}--${COLOR_GREEN}endpoint-url${COLOR_RED}=${COLOR_YELLOW}${AWS_HOST_URL} ${COLOR_RED}${COLOR_GREEN}--region ${COLOR_YELLOW}${AWS_DEFAULT_REGION}"
  local __arg_queue_url="${COLOR_YELLOW}${AWS_HOST_URL}/000000000000/queueName"
  echo -e  "    - ${COLOR_MAGENTA}Commands${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}s3 mb ${COLOR_YELLOW}s3://develop ${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}s3 ls ${COLOR_YELLOW}s3://develop/ ${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}s3 ls ${COLOR_YELLOW}s3://develop/ ${COLOR_BLUE}--recursive${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}s3 ls ${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}sqs list-queues ${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}sqs list-queues ${COLOR_RED}| ${COLOR_BLUE}jq ${COLOR_YELLOW}'.QueueUrls[]'${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}sqs purge-queue           ${COLOR_RED}--${COLOR_GREEN}queue-url ${__arg_queue_url} ${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}sqs send-message          ${COLOR_RED}--${COLOR_GREEN}queue-url ${__arg_queue_url} ${COLOR_RED}--${COLOR_GREEN}message-body ${COLOR_YELLOW}'{\\\"id\\\": 1}'  ${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}sqs receive-message       ${COLOR_RED}--${COLOR_GREEN}queue-url ${__arg_queue_url} ${COLOR_RED}--${COLOR_GREEN}max-number-of-messages ${COLOR_YELLOW}10${COLOR_OFF}"
  echo -e  "      ${COLOR_BLUE}aws ${__arg_default} ${COLOR_CIANO}sqs get-queue-attributes  ${COLOR_RED}--${COLOR_GREEN}queue-url ${__arg_queue_url} ${COLOR_RED}--${COLOR_GREEN}attribute-names All${COLOR_OFF}"

}

function printMappingPorts()
{
  export HOST_IP="127.0.0.1"
  if [[ -d /mnt ]]; then
      export PUBLIC_HOST_IPv4=$(ip -4 route get 8.8.8.8 | awk {'print $7'} | tr -d '\n')
  else
      export PUBLIC_HOST_IPv4=$(ipconfig.exe | grep -a IPv4 | grep -a 192 | sed 's/ //g' | sed 's/Endere?oIPv4//g' | awk -F ':' '{print $2}')
  fi
  local __ports=(80 5432 4566 1433 50000)
  echo -e  "${COLOR_MAGENTA}Windows Powershell mapping ports ${COLOR_OFF}"
  echo -e "  ${COLOR_GREEN}- Mapping${COLOR_OFF}"
  for __port in ${__ports[*]};
  do
    echo -e "      ${COLOR_BLUE}netsh ${COLOR_CIANO}interface ${COLOR_YELLOW}portproxy ${COLOR_CIANO}add ${COLOR_YELLOW}v4tov4 ${COLOR_CIANO}connectaddress=${COLOR_YELLOW}${PUBLIC_HOST_IPv4} ${COLOR_CIANO}listenaddress=${COLOR_YELLOW}0.0.0.0 ${COLOR_CIANO}connectport=${COLOR_YELLOW}${__port} ${COLOR_CIANO}listenport=${COLOR_YELLOW}${__port}${COLOR_OFF}"
  done

  echo -e "  ${COLOR_GREEN}- Unmapping${COLOR_OFF}"
  for __port in ${__ports[*]};
  do
    echo -e "      ${COLOR_BLUE}netsh ${COLOR_CIANO}interface ${COLOR_YELLOW}portproxy ${COLOR_CIANO}delete ${COLOR_YELLOW}v4tov4 ${COLOR_CIANO}connectaddress=${COLOR_YELLOW}${PUBLIC_HOST_IPv4} ${COLOR_CIANO}listenaddress=${COLOR_YELLOW}0.0.0.0 ${COLOR_CIANO}listenport=${COLOR_YELLOW}${__port} ${COLOR_OFF}"
  done
  echo -e "  ${COLOR_GREEN}- Show all${COLOR_OFF}"
  echo -e "      ${COLOR_BLUE}netsh ${COLOR_CIANO}interface ${COLOR_YELLOW}portproxy ${COLOR_CIANO}show ${COLOR_YELLOW}all${COLOR_OFF}"



}

function printMSG()
{
  printMappingPorts
  printAccess
}
