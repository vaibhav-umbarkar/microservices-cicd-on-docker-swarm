# Public Subnets
resource "aws_subnet" "public_subnets" {
    for_each = var.public_subnet

    vpc_id = var.vpc_id
    cidr_block = each.value.cidr
    availability_zone = each.value.az

    map_public_ip_on_launch = true

    tags = {
        Name = "${each.key}-swarm-cluster"
    }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
    for_each = var.private_subnet

    vpc_id = var.vpc_id
    cidr_block = each.value.cidr
    availability_zone = each.value.az

    map_public_ip_on_launch = false

    tags = {
        Name = "${each.key}-swarm-cluster"
    }
}
