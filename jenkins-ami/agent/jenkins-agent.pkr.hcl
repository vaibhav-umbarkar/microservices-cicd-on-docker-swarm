packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "jenkins-agent" {
  ami_name      = "jenkins-agent-ami"
  region        = "ap-south-1"
  ssh_username  = "ubuntu"
  instance_type = "t3.small"
  source_ami    = "ami-07a00cf47dbbc844c"
  vpc_id        = "vpc-02677236ad4c43070"
  subnet_id     = "subnet-0b2d1d30510a086ee"
}

build {
  name    = "jenkins-agent-ami-build"
  sources = ["source.amazon-ebs.jenkins-agent"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install -y openjdk-21-jdk",
      "sudo apt install -y git curl unzip",
      "sudo apt install -y docker.io",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo usermod -aG docker ubuntu",
      "sudo mkdir -p /home/ubuntu/jenkins",
      "sudo chown -R ubuntu:ubuntu /home/ubuntu/jenkins",
      "sudo apt clean"
    ]
  }
}
