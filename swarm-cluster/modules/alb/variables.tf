variable "swarm_alb_sg_id" {
    type = string
}

variable "public_subnet_ids" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}

variable "worker_asg_name" {
    type = string
}