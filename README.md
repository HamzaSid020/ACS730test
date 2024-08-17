Terraform Apply on Commit
This GitHub Actions workflow is designed to automatically trigger a Terraform deployment whenever a commit is made to the main branch. It performs the following steps:

Check out the code: The workflow pulls the latest version of your repository.
Configure AWS credentials: The AWS credentials are set up to allow Terraform to interact with AWS resources.
Set up Terraform: Terraform is initialized in two directories: Network and Webserver.
Terraform execution: The workflow runs terraform init, terraform plan, and terraform apply in both the Network and Webserver directories to deploy the infrastructure.
Prerequisites
The workflow assumes that your Terraform code is located in two directories: Network and Webserver.
AWS credentials are directly specified in the workflow file as environment variables.
How to Manually Run the Workflow
If you need to manually run this Terraform setup instead of triggering it with a git commit, follow these steps:

Set up your environment: Ensure you have Terraform and AWS CLI installed locally.

Export AWS credentials: Set up your AWS credentials as environment variables by exporting them in your terminal:

bash
Copy code
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_SESSION_TOKEN="your-session-token"
export AWS_REGION="us-east-1"
Initialize Terraform in the Network directory:

bash
Copy code
cd Network
terraform init
Generate and review a Terraform plan in the Network directory:

bash
Copy code
terraform plan
Apply the Terraform configuration in the Network directory:

bash
Copy code
terraform apply -auto-approve
Initialize Terraform in the Webserver directory:

bash
Copy code
cd ../Webserver
terraform init
Generate and review a Terraform plan in the Webserver directory:

bash
Copy code
terraform plan
Apply the Terraform configuration in the Webserver directory:

bash
Copy code
terraform apply -auto-approve
Notes
AWS Credentials: Make sure your AWS credentials have sufficient permissions to manage the resources defined in your Terraform configuration.
Environment Variables: In the workflow file, AWS credentials are hard-coded, but it's recommended to store them securely using environment variables or GitHub Secrets.
By following these steps, you can manually run the Terraform deployment without triggering the GitHub Actions workflow.
