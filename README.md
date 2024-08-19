## Terraform Apply on Commit<br />

This GitHub Actions workflow is designed to automatically trigger a Terraform deployment whenever a commit is made to the `main` branch. It performs the following steps:<br />

1. **Check out the code**: The workflow pulls the latest version of your repository.<br />
2. **Configure AWS credentials**: The AWS credentials are set up to allow Terraform to interact with AWS resources.<br />
3. **Set up Terraform**: Terraform is initialized in two directories: `Network` and `Webserver`.<br />
4. **Terraform execution**: The workflow runs `terraform init`, `terraform plan`, and `terraform apply` in both the `Network` and `Webserver` directories to deploy the infrastructure.<br />

### Prerequisites<br />

- The workflow assumes that your Terraform code is located in two directories: `Network` and `Webserver`.<br />
- AWS credentials are directly specified in the workflow file as environment variables.<br />
- **Create an S3 bucket**: You need to create an S3 bucket in AWS. This bucket will be used for storing Terraform state files.<br />
- **Update config.tf files**: After creating the S3 bucket, update the bucket name in the config.tf files located in both the Network and Webserver directories to point to your newly created S3 bucket.<br />

### How to Manually Run the Workflow<br />

If you need to manually run this Terraform setup instead of triggering it with a `git commit`, follow these steps:<br />

1. **Set up your environment**: Ensure you have Terraform and AWS CLI installed locally.<br />

2. **Export AWS credentials**: Set up your AWS credentials as environment variables by exporting them in your terminal:<br />
   ```bash
   export AWS_ACCESS_KEY_ID="your-access-key-id"
   export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
   export AWS_SESSION_TOKEN="your-session-token"
   export AWS_REGION="us-east-1"

3. **Initialize Terraform in the `Network` directory**:<br />
   ```bash
   cd Network
   terraform init

4. **Generate and review a Terraform plan in the `Network` directory**:<br />
   ```bash
   terraform plan

5. **Apply the Terraform configuration in the `Network` directory**:<br />
   ```bash
   terraform apply -auto-approve

6. **Initialize Terraform in the `Webserver` directory**:<br />
   ```bash
   cd ../Webserver
   terraform init

7. **Generate and review a Terraform plan in the `Webserver` directory**:<br />
   ```bash
   terraform plan

8. **Apply the Terraform configuration in the `Webserver` directory**:<br />
   ```bash
   terraform apply -auto-approve

### Notes<br />

- **AWS Credentials**: Make sure your AWS credentials have sufficient permissions to manage the resources defined in your Terraform configuration.<br />
- **Environment Variables**: In the workflow file, AWS credentials are hard-coded, but it's recommended to store them securely using environment variables or GitHub Secrets.<br />
- **SSH Key**: A dummy SSH key named assgn1 has been placed in the Webserver folder. This key can be used to SSH into all of the EC2 instances being created.<br />
- **Ansible Integration**: The Ansible scripts will also use the same SSH key. You can run an Ansible playbook using the following command:<br />
```bash
ansible-playbook playbook_deploy.yaml -i aws_ec2.yaml --private-key ../Webserver/assgn1
```  
By following these steps, you can manually run the Terraform deployment without triggering the GitHub Actions workflow.<br />

#review
