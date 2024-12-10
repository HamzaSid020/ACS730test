terraform {
  backend "s3" {
    bucket = "aws-bucket-dhana"         
    key    = "webserver/terraform.tfstate"  
    region = "us-east-1"              
  }
}