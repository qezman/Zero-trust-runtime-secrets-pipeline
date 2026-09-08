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

variable "vpc_name" {
  description = "Name tag for the VPC"
  default     = "ztsp-vpc"
  type        = string
}

variable "availability_zones" {
  description = "List of AZs to deploy subnets into"
  type        = list(string)
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}