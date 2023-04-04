resource "aws_instance" "main" {
  subnet_id = aws_subnet.dev.id
  associate_public_ip_address = var.instance.is_public
  ami           = var.ami_id
  instance_type = "t3.micro"

  tags = {
    App = var.app.name
  }
}
