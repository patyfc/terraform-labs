terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile = "paty"
  region = "us-east-1"
}
