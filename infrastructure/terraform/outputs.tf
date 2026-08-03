output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the provisioned VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Private subnet IDs"
}

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "The EKS cluster name"
}

output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS Control Plane Endpoint"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "The ECR repository URL"
}
