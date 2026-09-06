variable "region" {
  description = "AWS region for all resources"
  default     = "us-east-1"
  type        = string
}

variable "project" {
  description = "Project name used as a prefix on all resources"
  default     = "ztsp-deployer"
  type        = string
}

variable "environment" {
  description = "Environment name"
  default     = "dev"
  type        = string
}