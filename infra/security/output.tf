output "allow_ssh" {
  value = aws_security_group.allow_ssh.id
}

output "allow_http" {
  value = aws_security_group.http.id
}

output "egress" {
  value = aws_security_group.egress.id
}

output "ssh_key_name" {
  value = var.ssh_key_name
}