packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "jenkins-master" {
  ami_name      = "jenkins-master-ami"
  instance_type = "t3.small"
  region        = "ap-south-1"
  source_ami    = "ami-05d2d839d4f73aafb"
  ssh_username  = "ubuntu"
  vpc_id        = "vpc-02677236ad4c43070"
  subnet_id     = "subnet-0b2d1d30510a086ee"
}

build {
  name    = "jenkins-master-ami-build"
  sources = ["source.amazon-ebs.jenkins-master"]

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install fontconfig openjdk-21-jre -y",
      "sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key",
      "echo 'deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]' https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt update",
      "sudo apt install jenkins -y",
      "sudo mkdir -p /var/lib/jenkins/init.groovy.d"
    ]
  }

  provisioner "file" {
    source      = "./script/create-user.groovy"
    destination = "/tmp/create-user.groovy"
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/create-user.groovy /var/lib/jenkins/init.groovy.d/create-user.groovy",
      "sudo chown jenkins:jenkins /var/lib/jenkins/init.groovy.d/create-user.groovy",
      "sudo chmod 644 /var/lib/jenkins/init.groovy.d/create-user.groovy",

      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]
  }
}
