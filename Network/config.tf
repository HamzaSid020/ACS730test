provider "aws" {
  region = "us-east-1"
}
variable "bucket_name" {
  default = "aws-bucket-dhana"
}

variable "state_key" {
  default = "network/terraform.tfstate"
}

terraform {
  backend "s3" {
    bucket = var.bucket_name
    key    = var.state_key
    region = "us-east-1"
  }
}
