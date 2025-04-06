# Use the Alpine base image for the first stage
FROM alpine:latest as layer-copy

# Set the AWS region, access key, secret access key and session token
ARG AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-"ap-southeast-1"}
ARG AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:-""}
ARG AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:-""}
ARG AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN:-""}
ENV AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

# Install dependencies
RUN apk add --no-cache aws-cli curl unzip

# Create the /opt directory
RUN mkdir -p /opt

# Download and extract the AWS Secrets Manager Lambda extension
RUN curl $(aws lambda get-layer-version-by-arn --arn arn:aws:lambda:ap-southeast-1:044395824272:layer:AWS-Parameters-and-Secrets-Lambda-Extension:12 --query 'Content.Location' --output text) --output layer.zip
RUN unzip layer.zip -d /opt
RUN rm layer.zip

# Use the public ECR Python base image
FROM public.ecr.aws/lambda/python:3.12 as final

# Copy the downloaded Lambda layer to the final stage
COPY --from=layer-copy /opt /opt

COPY app.py requirements.txt ./

RUN python3.12 -m pip install -r requirements.txt -t .

# Set the entry point
CMD ["app.lambda_handler"]