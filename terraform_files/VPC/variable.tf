variable "aws_region" {
    description = "AWS region values"
    type = string
    default = "ap-south-1"
}

variable "environment_name" {
    description = "environment name"
    type = string
    default = "dev"
}

variable "vpc_cidr" {
  description = "cidr block for vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "tags" {
  description = "global tags for all the resource"
  type = map(string)
  default = {
    "terraform" = "true"
  }
}

variable "subnet_newbit" {
  description = "number of new bits to add"
  type = number
  default = 8
}