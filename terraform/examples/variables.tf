variable "aws_region" {

  type        = string
  description = "AWS region"
}

variable "aws_subnet_ids" {

  type        = list(any)
  description = "List of subnet ids within a vpc"
}
variable "aws_vpc_id" {

  type        = string
  description = "Id of the VPC where cloud-gateway will be deployed"

}
variable "instance_type" {

  type        = string
  description = "Type of hardware, combination of cpu and memory"
}

variable "image_id" {


  type        = string
  description = "AWS AMI used to launch the instance"
}

variable "global_vars" {


  type        = map(string)
  default     = {}
  description = "Common vars like stack and env names"
}

variable "default_tags" {


  type        = map(string)
  default     = {}
  description = "Default tags"
}

variable "certificate_arn" {

  type        = string
  description = "ARN of the SSL/TLS Certificate"
}

variable "bucket_access_role" {

  type        = string
  description = "ARN of the cross-account role"
}

variable "zone_id" {

  type        = string
  description = "Rote53 ZONE ID"
}

variable "domain_name" {

  type        = string
  description = "Rote53 FQDN for cloud-gateway"
}

variable "key_name" {
  
  type        = string
  description = "Name of the public key"
}

variable "public_key" {
  
  type        = string
  description = "Public Key"
}

variable "ssh_cidr" {

  type        = list(string)
  description = "CIDR Range to establish SSH connection"
}


variable "deployer_role" {

  type        = string
  description = "AWS IAM Role used to deploy the infrastructure"
}

variable "enable_ssh" {

  type = bool
  default = false
}
