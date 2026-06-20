# VPC ID
variable "vpc_id" {
    type = string
}

# 2 Public Subnets (CIDR & AZ)
variable "public_subnet" {
    type = map(object({
        cidr = string
        az = string
    }))
}

# 2 Private Subnets (CIDR & AZ)
variable "private_subnet" {
    type = map(object({
        cidr = string
        az = string
    }))
}
