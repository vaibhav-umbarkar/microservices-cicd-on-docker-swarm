variable "manager_ami" {
    type = string
}

variable "manager_instance_type" {
    type = string
}

variable "manager_key_name" {
    type = string
}

variable "manager_sg_id" {
    type = string
}

variable "instance_profile_name" {
    type = string
}

variable "swarm_discovery_bucket" {
    type = string
}

variable "env" {
    type = string
}

variable "private_subnet_ids" {
    type = list(string)
}

