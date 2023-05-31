# learning-devops-sample-app
Sample app used for [`learning-devops`](https://github.com/ximenasandoval/learning-devops) assignments.

# Development
You may need to add a `env` file to `app/` with AWS credentials

```
docker-compose up -d
```

# Deployment
```
chmod +x deployment/deploy.sh
```
You will need a `deployment/.env` file that contains the following:
```
AWS_ACCESS_KEY_ID=
AWS_ACCOUNT_ID=
AWS_DEFAULT_REGION=
AWS_SECRET_ACCESS_KEY=
ECR_REPO_NAME=
```
