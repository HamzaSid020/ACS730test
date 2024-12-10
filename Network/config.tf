provider "aws" {
  region = "us-east-1"
}
variable "bucket_name" {
  default = "aws-bucket-dhana"
}

variable "state_key" {
  default = "network/terraform.tfstate"
}

