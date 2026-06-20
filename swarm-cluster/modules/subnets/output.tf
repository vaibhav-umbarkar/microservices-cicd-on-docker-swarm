# Public Subnets ID's
output "public_subnet_ids" {
    value = values(aws_subnet.public_subnets)[*].id
}

# Private Subnets ID's
output "private_subnet_ids" {
    value = values(aws_subnet.private_subnets)[*].id
}
