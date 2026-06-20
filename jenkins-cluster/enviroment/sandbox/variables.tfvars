region="ap-south-1"
author="Vaibhav Umbarkar"
vpc_cidr_block="10.0.0.0/16"
vpc_name="jenkins-cluster-vpc"
public_subnets_count=2
private_subnets_count=2
availability_zones = [ 
    "ap-south-1a",
    "ap-south-1b"
]

bastion_ami="ami-01a00762f46d584a1"
bastion_instance_type = "t2.micro"
bastion_key_name="bastion-host-jenkins-cluster"

jenkins_controller_ami = "ami-06a64e5bf749a6618"
jenkins_controller_instance_type = "t2.small"
jenkins_controller_key_name = "jenkins-master"
