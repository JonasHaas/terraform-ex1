terraform {
    required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
    }
}
    backend "s3" {
        bucket = "nf-tfstate-bucket"
        key    = "main.tfstate"
        region = "eu-central-1"
    }
}

# Configure the AWS Provider
provider "aws" {
    region = "eu-central-1"
    profile= "default"
}
