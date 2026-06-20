# Bastion Host Security Group
resource "aws_security_group" "bastion_sg" {
    name = "bastion-host-sg-swarm-cluster"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22 # Allow SSH to All
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bastion-host-sg-swarm-cluster"
    }   
}

# Swarm Manager Security Group
resource "aws_security_group" "manager_sg" {
    name = "swarm-master-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }

    ingress {
        from_port = 2377
        to_port = 2377
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    ingress {
        from_port = 7946
        to_port = 7946
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    ingress {
        from_port = 7946
        to_port = 7946
        protocol = "udp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    ingress {
        from_port = 4789
        to_port = 4789
        protocol = "udp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "swarm-master-sg"
    }
}

# Swarm Worker Security Group
resource "aws_security_group" "worker_sg" {
    name = "swarm-worker-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.swarm_alb_sg.id]
    }

    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        security_groups = [aws_security_group.swarm_alb_sg.id]
    }

    ingress {
        from_port = 7946
        to_port = 7946
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    ingress {
        from_port = 7946
        to_port = 7946
        protocol = "udp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    ingress {
        from_port = 4789
        to_port = 4789
        protocol = "udp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    ingress {
        from_port = 2377
        to_port = 2377
        protocol = "tcp"
        cidr_blocks = [var.vpc_cidr_block]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "swarm-worker-sg"
    }
}

# Application Load Balancer Security Group
resource "aws_security_group" "swarm_alb_sg" {
    name = "swarm-alb-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "swarm-alb-sg"
    }
}
