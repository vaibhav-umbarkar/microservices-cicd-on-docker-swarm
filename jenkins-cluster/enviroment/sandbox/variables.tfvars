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

bastion_ami="<bastion-host-ami>"
bastion_instance_type = "t2.micro"
bastion_key_name="<bastion-host-jenkins-cluster-pem-key-name>"

jenkins_controller_ami = "<jenkins-controller-ami>"
jenkins_controller_instance_type = "t2.small"
jenkins_controller_key_name = "<jenkins-controller-pem-key-name>"
