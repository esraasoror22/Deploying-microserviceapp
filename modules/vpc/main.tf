
resource "aws_vpc" "mainvpc" {

  cidr_block = var.vpc_cidr
  tags = {
    Name = "cluster_vpc"
  }
  enable_dns_hostnames = true
  
}

