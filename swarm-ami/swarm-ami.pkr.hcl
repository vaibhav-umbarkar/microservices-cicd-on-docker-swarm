packer {
    required_plugins {
        amazon = {
            source = "github.com/hashicorp/amazon"
            version = "~> 1"
        }
    }
}

source "amazon-ebs" "docker-swarm" {
    ami_name = "docker-swarm"
    region = "ap-south-1"
    instance_type = "t3.small"
    source_ami = "ami-07a00cf47dbbc844c"
    ssh_username = "ubuntu"
    vpc_id = "vpc-02677236ad4c43070"
    subnet_id = "subnet-0b2d1d30510a086ee"
}

build {
    name = "docker-swarm-ami-build"
    sources = ["source.amazon-ebs.docker-swarm"]

    provisioner "shell" {
        inline = [
            "sudo apt update",
            "sudo apt install -y docker.io",
            "sudo apt install -y awscli",
            "sudo systemctl enable docker",
            "sudo systemctl start docker",
            "sudo usermod -aG docker ubuntu",
            "sudo apt clean"
        ]
    }
}
