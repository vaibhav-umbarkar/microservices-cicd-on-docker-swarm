# Bastion Host Public IP
output "bastion_host_public_ip" {
    value = module.bastion.bastion_host_ip
}

