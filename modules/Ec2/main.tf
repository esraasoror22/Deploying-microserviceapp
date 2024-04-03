#create public && private key
resource "tls_private_key" "test_key_pair" {
  algorithm   = "RSA"
  rsa_bits    = 2048
}


resource "null_resource" "store_public_key" {
  provisioner "local-exec" {
    command = "echo '${tls_private_key.test_key_pair.private_key_pem}' > test_key.pem"
  }

  depends_on = [tls_private_key.test_key_pair]
}

#tls_private_key.example_key_pair.private_key_pem




#create key
resource "aws_key_pair" "example_key_pair" {
  key_name   = "test-key" # Update with your desired key pair name
  public_key = tls_private_key.test_key_pair.public_key_openssh
  depends_on = [tls_private_key.test_key_pair]
}



#create public instances
resource "aws_instance" "Public_instances" {
  count = 2
  ami  = "ami-0b8b44ec9a8f90422"
  instance_type = "t3.micro"
  key_name = aws_key_pair.example_key_pair.key_name
  subnet_id = var.public_ec2_subnets[count.index]
  vpc_security_group_ids = var.sgg
  tags = {
    Name = var.pub_ec2_names[count.index]
  }

}


#create private instances
resource "aws_instance" "Private_instances" {
  count = 3
  ami  = "ami-0b8b44ec9a8f90422"
  instance_type = "t3.micro"
  key_name = aws_key_pair.example_key_pair.key_name
  subnet_id = var.private_ec2_subnets[count.index]
  vpc_security_group_ids = var.private_ec2_SG
  tags = {
    Name = var.private_ec2_names[count.index]
  }
  
}
