variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The IDs of the subnets to place the cluster and nodes in"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t3.medium"]
  description = "EC2 instance types for the node group"
}

variable "desired_size" {
  type        = number
  default     = 2
  description = "Desired number of worker nodes"
}

variable "max_size" {
  type        = number
  default     = 3
  description = "Maximum number of worker nodes"
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum number of worker nodes"
}
