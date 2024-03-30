
#create vpc
resource "aws_vpc" "mainvpc" {

  cidr_block = var.vpc_cidr
  tags = {
    Name = "cluster_vpc"
  }
  enable_dns_hostnames = true
  
}

#create public subnets
resource "aws_subnet" "public-subnet" {
  count = 3
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone  = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = var.public_subnet_names[count.index]
  }
}

#create internet-gw
resource "aws_internet_gateway" "cluster_igw" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {

    Name = "cluster-x-igw"

  }
}

#create routetable for public subnets
resource "aws_route_table" "cluster-pub-subnet-rt" {
  vpc_id = aws_vpc.mainvpc.id


  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = aws_vpc.mainvpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cluster_igw.id
  }

}

#public-subnets rt association
resource "aws_route_table_association" "a" {
  count = 3
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.cluster-pub-subnet-rt.id
}


#Create private subnets
resource "aws_subnet" "private-subnet" {
  count = 3
  vpc_id     = aws_vpc.mainvpc.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone  = var.availability_zone[count.index]
  tags = {
    Name = var.private_subnet_names[count.index]
  }
}


#create aws-aws_eip
resource "aws_eip" "fixed" {
  domain   = "vpc"
  tags = {
    Name = "VIP"
  }
  depends_on = [aws_internet_gateway.cluster_igw]
}

#create natgatway
resource "aws_nat_gateway" "cluster_ngw" {
  allocation_id = aws_eip.fixed.id
  subnet_id     = aws_subnet.public-subnet[2].id

  tags = {
    Name = "cluster-NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.cluster_igw]
}

#create private rt
resource "aws_route_table" "cluster-private-subnet-rt" {
  vpc_id = aws_vpc.mainvpc.id


  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = aws_vpc.mainvpc.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.cluster_ngw.id
  }

}

#public-subnets rt association
resource "aws_route_table_association" "b" {
  count = 3
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.cluster-private-subnet-rt.id
}
