variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Target AWS Region"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Target environment (e.g. dev, staging, prod)"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for VPC"
}

variable "cluster_name" {
  type        = string
  default     = "mini-idp-cluster"
  description = "EKS cluster name"
}

variable "repository_name" {
  type        = string
  default     = "mini-idp-backend"
  description = "Name of the ECR repository"
}
