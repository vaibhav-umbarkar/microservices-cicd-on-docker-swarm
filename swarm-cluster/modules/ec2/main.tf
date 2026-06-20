locals {
    managers = {
        manager1 = {
            subnet_id = var.private_subnet_ids[0]
        }

        manager2 = {
            subnet_id = var.private_subnet_ids[1]
        }

        manager3 = {
            subnet_id = var.private_subnet_ids[0]
        }
    }
}

resource "aws_instance" "swarm_manager" {
    for_each = local.managers

    ami = var.manager_ami
    instance_type = var.manager_instance_type
    key_name = var.manager_key_name

    subnet_id = each.value.subnet_id

    vpc_security_group_ids = [var.manager_sg_id]

    associate_public_ip_address = false

    iam_instance_profile = var.instance_profile_name

    user_data = templatefile(
        "${path.module}/scripts/manager-userdata.sh",
        {
            swarm_discovery_bucket = var.swarm_discovery_bucket
            swarm_name = var.env
        }
    )

    tags = {
        Role = "Manager"
        Name = each.key
    }
}
