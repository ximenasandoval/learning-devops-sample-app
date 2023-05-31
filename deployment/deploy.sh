#!/bin/bash

# We need to build the image for the server
date=$(date '+%Y-%m-%d-%H-%M-%S')
tag=deploy-$date
docker build -f app/Dockerfile -t $tag app/

# If we don't have env variables, we need to set them
if  [[ -z ${AWS_ACCOUNT_ID+x} ||  -z ${AWS_SECRET_ACCESS_KEY+x} || -z ${AWS_ACCESS_KEY_ID+x} ]]; then 
    echo "No env variables, loading from file"
    export $(cat deployment/.env | xargs)
    # Unset default AWs profile (will delete later)
    unset AWS_PROFILE
fi

# Push image to ECR repository
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS \
    --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

docker tag $tag $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME:latest

docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME:latest
