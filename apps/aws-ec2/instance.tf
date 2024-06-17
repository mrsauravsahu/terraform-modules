resource "aws_instance" "main" {
  # subnet_id = aws_subnet.dev.id
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name = aws_key_pair.main.key_name

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  tags = {
    App = var.app.name
  }
}

resource "aws_key_pair" "main" {
  # TODO: add a hash at the end
  key_name   = "instance-key-pair"
  public_key = tls_private_key.main.public_key_openssh
}
