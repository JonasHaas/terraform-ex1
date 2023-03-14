# Config VPC
resource "aws_vpc" "nf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name    = "Terraform VPC"
    Context = "NF-Bootcamp"
  }
}

# Config Public Subnet
resource "aws_subnet" "nf_public_subnet" {
  vpc_id     = aws_vpc.nf_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name    = "Terraform VPC > Public-Subnet"
    Context = "NF-Bootcamp"
  }
}

# Config Private Subnet
resource "aws_subnet" "nf_private_subnet" {
  vpc_id     = aws_vpc.nf_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name    = "Terraform VPC > Public-Subnet"
    Context = "NF-Bootcamp"
  }
}

# Config Internet Gateway
resource "aws_internet_gateway" "nf_igw" {
  vpc_id = aws_vpc.nf_vpc.id

  tags = {
    Name    = "Terraform VPC > Internet gateway"
    Context = "NF-Bootcamp"
  }
}

#Config Route Table
resource "aws_route_table" "nf_public_route_table" {
  vpc_id = aws_vpc.nf_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nf_igw.id
  }
  tags = {
    Name    = "Terraform VPC > Public Route-Table"
    Context = "NF-Bootcamp"
  }
}

resource "aws_route_table_association" "nf_public_subnet_association" {
  subnet_id      = aws_subnet.nf_public_subnet.id
  route_table_id = aws_route_table.nf_public_route_table.id
}

# Config Security Group
resource "aws_security_group" "nf_allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.nf_vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform VPC > allow_ssh"
    Context = "NF-Bootcamp"
  }
}

resource "aws_instance" "nf_some_instance" {
  ami           = "ami-06616b7884ac98cdd"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.nf_public_subnet.id
  vpc_security_group_ids = [aws_security_group.nf_allow_ssh.id]
  key_name = "vockey"
  associate_public_ip_address = true

  tags = {
    Name = "Terraform VPC > EC2"
    Context = "NF-Bootcamp"
  }
}

## outputs the ip after creation
output "public_ip" {
  value = aws_instance.nf_some_instance.public_ip
}