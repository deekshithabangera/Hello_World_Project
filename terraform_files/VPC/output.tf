output "vpc_id" {
  value = aws_vpc.main.id
  description = "the Id of created VPC"
}

output "public_subnet_id" {
  value = [for s in aws_aws_subnet.public_subnet : s.id]
  description = "list of public subnet"
}

output "private_subnet_id" {
  value = [for s in aws_aws_subnet.private_subnet : s.id]
  description = "list of private subnet"
}

output "public_subnet_map" {
 value = {for az, subnet in aws_subnet.public_subnet: az => subnet.id}
 description = "map of AZ to public subnet" 
}