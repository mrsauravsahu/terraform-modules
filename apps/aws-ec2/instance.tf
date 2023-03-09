resource "aws_instance" "main" {
  subnet_id = aws_subnet.dev.id
  ami           = var.ami_id
  instance_type = "t3.micro"

  tags = {
    App = var.app.name
  }
}
