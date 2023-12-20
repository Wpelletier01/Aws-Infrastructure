terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  
  }
}

provider "aws" {

  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]

}

resource "aws_security_group" "glpi" {
  name = "glpi"
  vpc_id = var.vpc-id
}

resource "aws_security_group_rule" "all" {

  type = "egress"
  security_group_id = aws_security_group.glpi.id 
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

}


resource "aws_security_group_rule" "ssh" {

  type = "ingress"
  security_group_id = aws_security_group.glpi.id
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

}

resource "aws_security_group_rule" "https" {

  type = "ingress"
  security_group_id = aws_security_group.glpi.id
  from_port        = 443
  to_port          = 443
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

}

resource "aws_security_group_rule" "http" {

  type = "ingress"
  security_group_id = aws_security_group.glpi.id
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

}


resource "aws_security_group_rule" "icmp" {

  type = "ingress"
  security_group_id = aws_security_group.glpi.id
  from_port = -1
  to_port = -1
  protocol = "icmp"
  cidr_blocks = ["192.168.56.0/24"]
  
}


data "cloudinit_config" "glpi-config" {
  gzip = true
  base64_encode = true 
  part {
    content_type = "text/cloud-config"
    content = file("${path.root}/../script/cloud-init/glpi.yml")
  }
}



resource "aws_instance" "glpi" {

  vpc_security_group_ids = [aws_security_group.glpi.id]
  subnet_id = var.subnet-id
  ami = var.ubuntu-ami
  instance_type = "t2.small"
  private_ip = var.private-ip
  user_data = data.cloudinit_config.glpi-config.rendered
  associate_public_ip_address = true

  tags = {
    Name = "Srv-GLPI"
  }

  # init 
  


  connection {
    type = "ssh"
    user = "will"
    private_key = file("/home/will/.ssh/tpfinal")
    host = self.public_ip
  }

  provisioner "file" {
    source = "${path.root}/../script/glpi.sh"
    destination = "/home/will/glpi.sh"
  }

  provisioner "remote-exec" {

    inline = [ 
      "echo crosemont | sudo -S chmod +x ./glpi.sh",
      "echo crosemont | sudo -S ./glpi.sh"

    ]

  }
  

}