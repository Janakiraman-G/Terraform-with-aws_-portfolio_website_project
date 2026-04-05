terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "6.39.0"
    }
  }
}

provider "aws" {
    #configure the AWS provider with your credentials and region
    region = "us-east-1"
  
}