# lambda-secrets-extension-with-containers

This is an example of how to use the lambda secrets extension when deploying with container images

References: 
blogpost: https://aws.amazon.com/blogs/compute/working-with-lambda-layers-and-extensions-in-container-images/  
app.py: https://github.com/aws-samples/serverless-patterns/blob/main/lambda-secrets-manager-extension-python/hello_world/app.py

Instructions (Manual way):
- Done on cloudshell
- Refer to "commands to run.txt" to run the commands to extract credentials required to build the docker image
- Create Private ECR repository
- Push to ECR (https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)
- Create the actual secret in AWS Secrets Manager 
- Deploy lambda with the pushed image  
(ensure environment variables are set PARAMETERS_SECRETS_EXTENSION_HTTP_PORT=2773, SECRET_NAME) 
- Test invoke -> success!

With SAM:
- Work in progress