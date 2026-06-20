# Bastion Host Security Group ID
output "bastion_sg_id" {
    value = aws_security_group.bastion_sg.id
}

# Manager Security Group ID
output "manager_sg_id" {
    value = aws_security_group.manager_sg.id
}

# Worker Security Group ID
output "worker_sg_id" {
    value = aws_security_group.worker_sg.id
}

# Swarm Security Group ID
output "swarm_alb_sg_id" {
    value = aws_security_group.swarm_alb_sg.id
}
