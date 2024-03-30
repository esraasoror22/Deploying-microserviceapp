
module "networking" {

    source = "./modules/vpc"
    vpc_cidr = "10.6.0.0/16"
}