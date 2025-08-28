export AWS_HOST_NAME=localstack
export AWS_HOST_URL=http://${AWS_HOST_NAME}:4566
export AWS_ACCESS_KEY_ID=localstack
export AWS_DEFAULT_REGION=us-east-1
export AWS_SECRET_ACCESS_KEY=localstack

#S3
aws --endpoint-url=${AWS_HOST_URL} --region ${AWS_DEFAULT_REGION} s3 mb s3://develop
aws --endpoint-url=${AWS_HOST_URL} --region ${AWS_DEFAULT_REGION} s3 mb s3://develop-component-name-1
aws --endpoint-url=${AWS_HOST_URL} --region ${AWS_DEFAULT_REGION} s3 ls s3://develop/ 
aws --endpoint-url=${AWS_HOST_URL} --region ${AWS_DEFAULT_REGION} s3 ls s3://develop/ --recursive

#bucket list
aws s3 ls --endpoint-url=${AWS_HOST_URL} --region ${AWS_DEFAULT_REGION}

#SQS
aws sqs create-queue --endpoint-url=${AWS_HOST_URL} --queue-name develop-component-name-1 --region ${AWS_DEFAULT_REGION}
aws sqs create-queue --endpoint-url=${AWS_HOST_URL} --queue-name develop-component-name-2 --region ${AWS_DEFAULT_REGION}
aws sqs create-queue --endpoint-url=${AWS_HOST_URL} --queue-name develop-component-name-3 --region ${AWS_DEFAULT_REGION}
aws sqs create-queue --endpoint-url=${AWS_HOST_URL} --queue-name develop-component-name-4 --region ${AWS_DEFAULT_REGION}
