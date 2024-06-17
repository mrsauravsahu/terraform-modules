output "instance_ip" {
  value = aws_eip.instance_ip.public_ip
}
