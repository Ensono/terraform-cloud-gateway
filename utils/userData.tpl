#!/bin/bash

yum update -y
yum install java-11-amazon-corretto -y
yum install unzip jq -y

creds=$(aws sts assume-role --role-arn arn:aws:iam::462418267981:${BucketAccessRole} --role-session-name ${RoleSessionName})
unset AWS_PROFILE

export AWS_ACCESS_KEY_ID=$(echo $creds | jq -r '.Credentials.AccessKeyId') 
export AWS_SECRET_ACCESS_KEY=$(echo $creds | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $creds | jq -r '.Credentials.SessionToken')
export AWS_DEFAULT_REGION=eu-west-1

aws s3 cp s3://iag-idam-sharedservices-ssvc-root-satellite-components/identityiq-CloudGateway-8.1-modified.zip identityiq-CloudGateway-8.1-modified.zip

unzip identityiq-CloudGateway-8.1-modified.zip

chmod +x bootstrap.sh

./bootstrap.sh
