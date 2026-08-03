provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = "${var.environment}-${var.cluster_name}"
  subnet_ids   = module.vpc.private_subnet_ids
  desired_size = 2
  max_size     = 3
  min_size     = 1
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = "${var.environment}-${var.repository_name}"

  tags = {
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
