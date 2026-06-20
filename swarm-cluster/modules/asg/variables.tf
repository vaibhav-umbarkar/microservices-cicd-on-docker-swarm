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

variable "worker_ami" {
    type = string
}

variable "worker_instance_type" {
    type = string
}

variable "worker_key_name" {
    type = string
}

variable "worker_sg_id" {
    type = string
}
