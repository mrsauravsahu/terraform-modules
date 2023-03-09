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

resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.dev.id
  private_ips = ["10.0.0.4"]

  tags = {
    App = var.app.name
  }
}

