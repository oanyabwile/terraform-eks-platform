terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "omari-terraform-state"
    key            = "eks-platform/dev/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
    profile        = "eks-dev"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "eks-dev"
}

module "vpc" {
  source = "../../modules/vpc"

  name = "eks-platform"

  cidr_block = "10.0.0.0/16"

  azs = [
    "us-east-2a",
    "us-east-2b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]
}

module "eks" {
  source = "../../modules/eks"

  cluster_name = "eks-platform"
  vpc_id       = module.vpc.vpc_id

  private_subnet_ids = module.vpc.private_subnet_ids
}
