variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "secret_arn" {
  description = "ARN of the exact Secrets Manager secret"
  type        = string
}
