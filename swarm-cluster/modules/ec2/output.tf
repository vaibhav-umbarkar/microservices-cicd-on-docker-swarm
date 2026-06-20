output "manager_private_ips" {
    value = {
        for name, instance in aws_instance.swarm_manager :
        name => instance.private_ip
    }
}