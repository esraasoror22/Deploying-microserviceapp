
module "networking" {

    source = "./modules/vpc"
    vpc_cidr = "10.6.0.0/16"
    public_subnet_cidr = ["10.6.16.0/20","10.6.32.0/19","10.6.64.0/18"]
    public_subnet_names = ["cluster-public-subnet-a","cluster-public-subnet-b","cluster-public-subnet-c"]
    availability_zone = ["us-east-2a","us-east-2b","us-east-2c"]
    private_subnet_cidr = ["10.6.128.0/19", "10.6.160.0/20", "10.6.176.0/21"]
    private_subnet_names = ["cluster-private-subnet-a","cluster-private-subnet-b","cluster-private-subnet-c"]
}

module "seurity" {
    source = "./modules/security-Group"
    vpc_id = module.networking.vpc_id
    vpc_cidr = module.networking.vpc_cidr

}
module "ec2_instances" {

    source = "./modules/Ec2"
    pub_ec2_names = ["Bastion_host","traefik-server"]
    public_ec2_subnets = [module.networking.pub_subnets_id[0],module.networking.pub_subnets_id[2]]
    sgg = [module.seurity.public_ecs_security]
    private_ec2_subnets = module.networking.private_subnets_ids
    private_ec2_SG = [module.seurity.private_ec2_Security]
    private_ec2_names = ["Jenkins_server","Dev","Test"]
}

