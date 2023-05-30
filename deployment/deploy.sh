# We need to build the image for the server
date=$(date '+%Y-%m-%d-%H-%M-%S')
tag=deploy-$date
docker build -f ../app/Dockerfile -t $tag ../app/

# Load env variables
export $(cat .env | xargs)
# Unset default AWs profile (will delete later)
unset AWS_PROFILE

# Push image to ECR repository
aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
docker tag $tag $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME:$date
docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/$ECR_REPO_NAME:$date