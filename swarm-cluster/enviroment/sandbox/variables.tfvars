region = "ap-south-1"
vpc_cidr_block = "11.0.0.0/16"
vpc_name = "swarm-cluster-sandbox-vpc"
env = "sandbox"
author = "Vaibhav Umbarkar"

public_subnet = {
    public_sub1 = {
        cidr = "11.0.1.0/24"
        az = "ap-south-1a"
    }

    public_sub2 = {
        cidr = "11.0.2.0/24"
        az = "ap-south-1b"
    }
}

private_subnet = {
    private_sub1 = {
        cidr = "11.0.3.0/24"
        az = "ap-south-1a"
    }

    private_sub2 = {
        cidr = "11.0.4.0/24"
        az = "ap-south-1b"
    }
}

bastion_ami = "ami-01a00762f46d584a1"
bastion_instance_type = "t2.micro"
bastion_key_name = "bastion-host-swarm-cluster"

bucket_name = "vaibhav8485-sandbox"

manager_ami = "ami-0c4490ec57c03397c"
manager_instance_type = "t2.small"
manager_key_name = "swarm-master"

worker_ami = "ami-0c4490ec57c03397c"
worker_instance_type = "t2.small"
worker_key_name = "swarm-worker"
