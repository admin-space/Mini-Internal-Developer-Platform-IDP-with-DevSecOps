variable "repository_name" {
  type        = string
  description = "The name of the ECR repository"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to the repository"
}
