resource "aws_instance" "main" {
  subnet_id = aws_subnet.dev.id
  associate_public_ip_address = var.instance.is_public
  ami           = var.ami_id
  instance_type = "t3.micro"
  key_name = aws_key_pair.main.key_name

  security_groups = [
    aws_security_group.allow_ssh.id
  ]

  tags = {
    App = var.app.name
  }
}

resource "aws_key_pair" "main" {
  # TODO: add a hash at the end
  key_name   = "instance-key-pair"
  public_key = tls_private_key.main.public_key_openssh
}
