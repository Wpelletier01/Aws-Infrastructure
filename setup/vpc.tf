

resource "aws_vpc" "tpfinal" {
  
  tags = {
    Name = "tpfinal"
  }

  enable_dns_hostnames = true
  enable_dns_support = true 
  cidr_block = "192.168.0.0/16" 

}

resource "aws_internet_gateway" "tpfinal-gw" {
  
  vpc_id = aws_vpc.tpfinal.id 
  tags = {
    Name = "tpfinal-gw"
  }

}

resource "aws_route_table" "tpfinal-rt" {
  
  vpc_id = aws_vpc.tpfinal.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tpfinal-gw.id 
  }

  tags = {
    Name = "tpfinal-rt"
  }

}


resource "aws_subnet" "tpfinal-subnet" {
  tags = {
    Name = "tpfinal-subnet"
  }

  
  cidr_block = "192.168.56.0/24"
  vpc_id = aws_vpc.tpfinal.id


}


resource "aws_route_table_association" "subnet-association" {
  
  subnet_id = aws_subnet.tpfinal-subnet.id 
  route_table_id = aws_route_table.tpfinal-rt.id

}