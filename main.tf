
module "networking" {

    source = "./modules/vpc"
    vpc_cidr = "10.6.0.0/16"
    public_subnet_cidr = ["10.6.16.0/20","10.6.32.0/19","10.6.64.0/18"]
    public_subnet_names = ["cluster-public-subnet-a","cluster-public-subnet-b","cluster-public-subnet-c"]
    availability_zone = ["us-east-2a","us-east-2b","us-east-2c"]
    private_subnet_cidr = ["10.6.128.0/19", "10.6.160.0/20", "10.6.176.0/21"]
    private_subnet_names = ["cluster-private-subnet-a","cluster-private-subnet-b","cluster-private-subnet-c"]
}
