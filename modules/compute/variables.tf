variable "project" {
  description = "Project name used as prefix on all resources"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "region" {
  description = "Region to deploy the VPC"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet to deploy the instance"
  type        = string
}

variable "ec2_security_group_id" {
  description = "The ID of the security group to deploy the instance"
  type        = string
}

variable "secret_arn" {
  description = "The ARN of the secret to deploy the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of the instance to deploy the instance"
  type        = string
  default     = "t4g.micro"
}

variable "instance_profile_name" {
  description = "The name of the instance profile to deploy the instance"
  type        = string
}
