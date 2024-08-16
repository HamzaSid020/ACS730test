provider "aws" {
  region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "final-dhana-s3"             // Bucket from where to GET Terraform State
    key    = "network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                     // Region where bucket created
  }
}
