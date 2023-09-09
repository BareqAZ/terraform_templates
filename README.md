# aws_template

This is a basic Terraform AWS template that provisions a simple VPC and a single instance. Before deploying, it is advisable to review the network settings, as the default configuration permits any connection to any port, which is not suitable for production environments.

## Getting Started

Follow these steps to get started:

1. Generate an SSH key pair. The public key will be uploaded to AWS and installed in the instances you create.

   ```
   ssh-keygen -t rsa -b 4096 -f ~/.ssh/aws_key
   ```

2. Ensure you have valid AWS credentials set up either in ~/.aws or as environment variables.


3. Initialize Terraform.
   ```
   terraform init
   ```
   
4. Review the variables in "variables.tf"

4. Review the plan and then deploy:
   ```
   terraform apply
   ```
