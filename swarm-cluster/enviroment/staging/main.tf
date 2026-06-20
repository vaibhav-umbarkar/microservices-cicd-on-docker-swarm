module "vpc" {
    source = "../../modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_name = var.vpc_name
    author = var.author
}

module "subnets" {
    source = "../../modules/subnets"
    vpc_id = module.vpc.vpc_id
    public_subnet = var.public_subnet
    private_subnet = var.private_subnet
}

module "ig" {
    source = "../../modules/ig"
    vpc_id = module.vpc.vpc_id
}

module "nat" {
    source = "../../modules/nat"
    public_subnet_ids = module.subnets.public_subnet_ids
}

module "rt" {
    source = "../../modules/rt"
    vpc_id = module.vpc.vpc_id
    ig_id = module.ig.ig_id
    nat_id = module.nat.nat_id
    public_subnet_ids = module.subnets.public_subnet_ids
    private_subnet_ids = module.subnets.private_subnet_ids
}

module "sg" {
    source = "../../modules/sg"
    vpc_id = module.vpc.vpc_id
    vpc_cidr_block = var.vpc_cidr_block
}

module "bastion" {
    source = "../../modules/bastion"
    bastion_ami = var.bastion_ami
    bastion_instance_type = var.bastion_instance_type
    bastion_key_name = var.bastion_key_name
    bastion_sg_id = module.sg.bastion_sg_id
    public_subnet_ids = module.subnets.public_subnet_ids
}

module "s3" {
    source = "../../modules/s3"
    bucket_name = var.bucket_name
    env = var.env
}

module "iam" {
    source = "../../modules/iam"
    env = var.env
    bucket_arn = module.s3.bucket_arn
}

module "ec2" {
    source = "../../modules/ec2"
    manager_ami = var.manager_ami
    manager_instance_type = var.manager_instance_type
    manager_key_name = var.manager_key_name
    manager_sg_id = module.sg.manager_sg_id
    instance_profile_name = module.iam.instance_profile_name
    swarm_discovery_bucket = module.s3.bucket_name
    env = var.env
    private_subnet_ids = module.subnets.private_subnet_ids

}

module "asg" {
    source = "../../modules/asg"
    instance_profile_name = module.iam.instance_profile_name
    swarm_discovery_bucket = module.s3.bucket_name
    private_subnet_ids = module.subnets.private_subnet_ids
    worker_ami = var.worker_ami
    worker_instance_type = var.worker_instance_type
    worker_key_name = var.worker_key_name
    worker_sg_id = module.sg.worker_sg_id
    env = var.env
}

module "alb" {
    source = "../../modules/alb"
    vpc_id = module.vpc.vpc_id
    swarm_alb_sg_id = module.sg.swarm_alb_sg_id
    public_subnet_ids = module.subnets.public_subnet_ids
    worker_asg_name = module.asg.worker_asg_name
}
