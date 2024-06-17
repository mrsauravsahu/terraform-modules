provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    App = var.app.name
  }
}

resource "aws_subnet" "dev" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    App = var.app.name
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    App = var.app.name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    App = var.app.name
  }
}

resource "aws_eip" "instance_ip" {
  vpc                       = true
  network_interface         = aws_network_interface.main.id
  associate_with_private_ip = "10.0.0.4"

  tags = {
    App = var.app.name
  }
}

resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.dev.id
  private_ips = ["10.0.0.4"]

  security_groups = [
    aws_security_group.allow_ssh.id
  ]

  tags = {
    App = var.app.name
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
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
    App = var.app.name
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.example.id
}
