terraform {
  backend "s3" {
    bucket = "fac.terraform.remote.state"
    key = "finops-as-code-cleanup-block-storage/terraform.tfstate"
    region = "us-east-1"
  }
  
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

