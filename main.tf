terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
}

resource "tls_private_key" "key-ansible" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key-pair-ansible" {
  key_name   = "key-ansible"
  public_key = tls_private_key.key-ansible.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key-ansible.private_key_pem}' > ${path.module}/key.pem && chmod 0700 ${path.module}/key.pem"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_public" {
  filter { 
    name = "vpc-id"         
    values = [data.aws_vpc.default.id] 
    }
  filter { 
    name = "default-for-az" 
  values = ["true"] 
  }
}


locals {
  hosts = {
    vm1 = { az_index = 0, sjsu_id = 1 }
    vm2 = { az_index = 1, sjsu_id = 2 }
  }
}

resource "aws_instance" "vm" {
  for_each               = local.hosts
  ami =  data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.key-pair-ansible.key_name

  
  vpc_security_group_ids    = [aws_security_group.allow_ssh_http.id]
  associate_public_ip_address = true

}


output "public_ips" {
  value = { for k, i in aws_instance.vm : k => i.public_ip }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}