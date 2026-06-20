# Worker Template
resource "aws_launch_template" "worker_template" {
    name_prefix = "swarm-worker-"
    image_id = var.worker_ami
    instance_type = var.worker_instance_type

    key_name = var.worker_key_name

    vpc_security_group_ids = [
        var.worker_sg_id
    ]

    iam_instance_profile {
        name = var.instance_profile_name
    }

    user_data = base64encode(templatefile(
        "${path.module}/scripts/worker-userdata.sh",
        {
            swarm_discovery_bucket = var.swarm_discovery_bucket
            swarm_name = var.env
        }
    ))

    block_device_mappings {
        device_name = "/dev/xvda"

        ebs {
            volume_size = 20
            volume_type = "gp3"
        }
    }
}

# Worker ASG
resource "aws_autoscaling_group" "worker_asg" {
    desired_capacity = 2
    min_size = 2
    max_size = 5

    vpc_zone_identifier = var.private_subnet_ids

    launch_template {
        id = aws_launch_template.worker_template.id
        version = "$Latest"
    }

    tag {
        key = "Name"
        value = "worker-${var.env}"
        propagate_at_launch = true
    }
}
