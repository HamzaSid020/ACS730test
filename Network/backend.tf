terraform {
  backend "s3" {
    bucket = "aws-bucket-dhana"         
    key    = "network/terraform.tfstate"  
    region = "us-east-1"              
  }
}