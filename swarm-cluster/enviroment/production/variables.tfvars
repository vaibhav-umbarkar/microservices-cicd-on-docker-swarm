region = "ap-south-1"
vpc_cidr_block = "13.0.0.0/16"
vpc_name = "swarm-cluster-production-vpc"
env = "production"
author = "Vaibhav Umbarkar"

public_subnet = {
    public_sub1 = {
        cidr = "13.0.1.0/24"
        az = "ap-south-1a"
    }

    public_sub2 = {
        cidr = "13.0.2.0/24"
        az = "ap-south-1b"
    }
}

private_subnet = {
    private_sub1 = {
        cidr = "13.0.3.0/24"
        az = "ap-south-1a"
    }

    private_sub2 = {
        cidr = "13.0.4.0/24"
        az = "ap-south-1b"
    }
}

bastion_ami = "ami-07a00cf47dbbc844c"
bastion_instance_type = "t2.micro"
bastion_key_name = "bastion-host-swarm-cluster"

bucket_name = "vaibhav8485-production"

manager_ami = ""
manager_instance_type = "t2.small"
manager_key_name = "swarm-master"

worker_ami = ""
worker_instance_type = "t2.small"
worker_key_name = "swarm-worker"
