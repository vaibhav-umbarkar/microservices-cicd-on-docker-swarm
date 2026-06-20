variable "vpc_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "private_subnet_ids" {
    type = list(string)
}

variable "ig_id" {
    type = string
}

variable "nat_id" {
    type = string
}
