

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




module "vpn" {
  source = "./modules/vpn"
  subnet-id = aws_subnet.tpfinal-subnet.id
  ubuntu-ami = data.aws_ami.ubuntu.id
  vpc-id = aws_vpc.tpfinal.id
  private-ip = "192.168.56.10"

}

module "sqlserver" {
  source = "./modules/sqlserver"
  subnet-id = aws_subnet.tpfinal-subnet.id
  ubuntu-ami = data.aws_ami.ubuntu.id
  vpc-id = aws_vpc.tpfinal.id
  private-ip = "192.168.56.11"

}

module "glpi" {
  source = "./modules/glpi"
  subnet-id = aws_subnet.tpfinal-subnet.id
  ubuntu-ami = data.aws_ami.ubuntu.id
  vpc-id = aws_vpc.tpfinal.id
  private-ip = "192.168.56.12"

}

module "nextcloud" {
  source = "./modules/nextcloud"
  subnet-id = aws_subnet.tpfinal-subnet.id
  ubuntu-ami = data.aws_ami.ubuntu.id
  vpc-id = aws_vpc.tpfinal.id
  private-ip = "192.168.56.13"

}

module "mattermost" {
  source = "./modules/mattermost"
  subnet-id = aws_subnet.tpfinal-subnet.id
  ubuntu-ami = data.aws_ami.ubuntu.id
  vpc-id = aws_vpc.tpfinal.id
  private-ip = "192.168.56.14"

}
