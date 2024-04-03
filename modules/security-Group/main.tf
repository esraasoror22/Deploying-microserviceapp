resource "aws_security_group" "SG" {
  # ... other configuration ...
  name = "SG_allow_SSH_Http"
  vpc_id = var.vpc_id
  #how to get id of resource created on other module using output
  dynamic "ingress" {
    for_each = local.inbound_ports
    content{
        from_port       = ingress.value
        to_port         = ingress.value
        protocol        = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
  }
  egress {

    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


#Create SG for only private subnets 
resource "aws_security_group" "privatee_ec2_SG" {
  # ... other configuration ...
  name = "SG_allow_SSH_from_VPC_CIDR"
  vpc_id = var.vpc_id
   ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks = [var.vpc_cidr]

    }
  
  egress {

    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}