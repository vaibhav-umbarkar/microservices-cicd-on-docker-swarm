# Bastion Host
resource "aws_instance" "bastion_host" {
    ami = var.bastion_ami
    instance_type = var.bastion_instance_type
    key_name = var.bastion_key_name
    subnet_id = var.public_subnet_ids[0]
    vpc_security_group_ids = [var.bastion_sg_id]
    associate_public_ip_address = true

    tags = {
        Name = "bastion-host-swarm-cluster"
    }
}
