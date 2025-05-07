
variable "AWS_REGION" {
  description = "AWS Region"
  type    = string
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

