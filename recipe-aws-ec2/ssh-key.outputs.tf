output "instance_key_pair_private_tls_key" {
  value = tls_private_key.main.private_key_openssh
  sensitive = true
}
