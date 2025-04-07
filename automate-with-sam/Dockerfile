# Final image: AWS Lambda Python 3.12 base image
FROM public.ecr.aws/lambda/python:3.12

# Copy the pre-downloaded secrets extension layer into /opt (expected by Lambda)
COPY layer /opt

# Copy app code and dependencies
COPY app.py requirements.txt ./

# Install Python dependencies into current directory
RUN python3.12 -m pip install -r requirements.txt -t .

# Set Lambda handler
CMD ["app.lambda_handler"]