provider "aws"{
    access_key = "***"
    secret_key = "***"
    region = "eu-central-1"
}
resource "aws_instance" "my_ubuntu" {
  ami = "ami-06148e0e81e5187c8"
  instance_type = "t3.micro"
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "my_pub_key"

  tags = {
    Name = "Terraform"
    Owner = "Iryna Kopchak"
  }
}

#securitygroup using Terraform

resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-0102c55ada6f6c220"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "TF_SG"
  }
}
resource "aws_key_pair" "keys" {
    key_name = "my_pub_key"
    public_key = "ssh-rsa *** iryna@iryna-VirtualBox"
}