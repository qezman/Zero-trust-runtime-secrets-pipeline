variable "region" {
  description = "AWS region for all resources"
  default     = "us-east-1"
  type        = string
}

variable "project" {
  description = "Project name used as a prefix on all resources"
  default     = "ztsp"
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

variable "instance_class" {
  type    = string
  default = "db.t4g.micro"
}

variable "db_name" {
  description = "Postgres database name"
  type        = string
}

variable "engine_version" {
  description = "The version of the engine"
  default     = "16.4"
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "storage_type" {
  type    = string
  default = "gp3"
}

variable "username" {
  type = string
}
