#!/usr/bin/env sh

envInit(){
  if [ "${AWS_HOST_NAME}" = "" ]; then
    export AWS_HOST_NAME=localstack
  fi

  export AWS_DEFAULT_REGION=us-east-1
  export AWS_HOST_URL="http://${AWS_HOST_NAME}:4566"
  export AWS_SQS_URL="http://sqs.${AWS_DEFAULT_REGION}.localhost.localstack.cloud:4566"
  export AWS_ACCESS_KEY_ID=localstack
  export AWS_SECRET_ACCESS_KEY=localstack
}

envConfigure()
{
  envInit

  aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
  aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
  aws configure set default.region ${AWS_DEFAULT_REGION}

  export AWS_COMPONENT_LIST=$(cat ${STACK_REPOSITORY_FILE})
  export AWS_SECRET_LIST=$(cat ${STACK_REPOSITORY_FILE})
  export AWS_BUCKET_S3_LIST=$(cat ${STACK_BUCKETS3_FILE})
  export AWS_SQS_LIST="$(cat ${STACK_REPOSITORY_FILE}) $(cat ${STACK_SQS_FILE})"
  # echo "AWS_COMPONENT_LIST: ${AWS_COMPONENT_LIST}"
  # echo "AWS_SECRET_LIST: ${AWS_SECRET_LIST}"
  # echo "AWS_BUCKET_S3_LIST: ${AWS_BUCKET_S3_LIST}"
  # echo "AWS_SQS_LIST: ${AWS_SQS_LIST}"
}

hostIsAvailable()
{
  __host=${1}
  __port=${2}
  __check=$(curl -s http://${__host}:${__port}/_localstack/health | jq '.version')
  if [ "${__check}" = "" ]; then
    return 0;
  fi
  return 1;
}

isOnline()
{
  __counter=0
  __host=${1}
  __port=${2}
  __url=${3}
  while :
  do
    let "__counter=${__counter}+1"
    if [ "${__counter}" -gt 60 ]; then
      echo "checking LocalStack: Timeout, host: ${__url}"
      echo "checking LocalStack: Timeout, host: ${__url}"
      echo "checking LocalStack: Timeout, host: ${__url}"
      exit 1
    fi
    hostIsAvailable "${__host}" "${__port}"
    if [ "$?" -ne 1 ]; then
      echo "Wait for online LocalStack, host: ${__url}"
      echo ""
      echo "sleeping 1s"
      echo ""
      sleep 1
      continue
    fi
    echo "LocalStack server is online, host: ${__url}"
    echo ""
    break
  done
}

isOnlineCheck(){
  if ! [ "${ONLINE_CHECKED}" = "1" ]; then
    isOnline "${AWS_HOST_NAME}" 4566 "${AWS_HOST_URL}"
    export ONLINE_CHECKED=1
  fi
}

envConfigure