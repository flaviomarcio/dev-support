#!/usr/bin/env sh

if [ -d /docker ]; then
  export DOCKER_DIR=/docker
else
  export DOCKER_DIR=${PWD}
fi
export RESOURCE_DIR=${DOCKER_DIR}/resources
export PATH=${PATH}:${RESOURCE_DIR}/localstack
export SCRIPT_PATH=${PATH}:${RESOURCE_DIR}/localstack

. zconfigure.sh

runInstall(){
  yum update -y
  yum install -y curl jq gettext
  yum clean all
}

#run aws
runAWS(){
  cd ${DOCKER_DIR}
  pwd
  ls
  chmod +x ./init-localstack.sh
  ./init-localstack.sh
  return 1
}


main()
{
  echo "AWS CLI - Commands"
  cd ${RESOURCE_DIR}
  runInstall
  runAWS
  runPG
  echo ""
  echo "AWS CLI - Commands"
  echo ""
  local __host_url=http://localhost:4566
  local __aws_default_region=us-east-1
  echo "  aws --endpoint-url=${__host_url} --region ${__aws_default_region} secretsmanager list-secrets"
  echo "  aws --endpoint-url=${__host_url} --region ${__aws_default_region} s3 ls"
  echo "  aws --endpoint-url=${__host_url} --region ${__aws_default_region} sqs list-queues"
  echo "  aws --endpoint-url=${__host_url} --region ${__aws_default_region} dynamodb list-tables"
  echo "  aws --endpoint-url=${__host_url} --region ${__aws_default_region} events list-api-destinations"  

  echo ""
  echo "sleep infinity"
  sleep infinity
}

main