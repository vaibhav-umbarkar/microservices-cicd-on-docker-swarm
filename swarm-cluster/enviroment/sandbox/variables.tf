variable "region" {}
variable "vpc_cidr_block" {}
variable "vpc_name" {}
variable "env" {}
variable "author" {}

variable "public_subnet" {
    type = map(object({
        cidr = string
        az = string
    }))
}
variable "private_subnet" {
    type = map(object({
        cidr = string
        az = string
    }))
}

variable bastion_ami {}
variable bastion_instance_type {}
variable bastion_key_name {}
variable bucket_name {}
variable manager_ami {}
variable manager_instance_type {}
variable manager_key_name {}

variable worker_ami {}
variable worker_instance_type {}
variable worker_key_name {}
