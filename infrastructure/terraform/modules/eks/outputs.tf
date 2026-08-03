output "cluster_name" {
  value       = aws_eks_cluster.main.name
  description = "The EKS cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "The EKS cluster control plane endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority[0].data
  description = "The EKS cluster certificate authority data"
}
