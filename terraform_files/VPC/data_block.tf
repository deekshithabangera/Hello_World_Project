data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnet = {for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbit, k)}
  private_subnet = {for k, az in local.azs : cidrsubnet(var.vpc_cidr, var.subnet_newbit, k+10)}
}