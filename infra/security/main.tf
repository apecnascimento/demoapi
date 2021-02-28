# ---------------------------------------------------------------------------------------------------------------------
#  CREATE A PRIVATE KEY
# ---------------------------------------------------------------------------------------------------------------------

resource "tls_private_key" "private_key" {
  count     = var.auto_create_ssh_key ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ansible_key" {
  count           = var.auto_create_ssh_key ? 1 : 0
  content         = tls_private_key.private_key[count.index].private_key_pem
  filename        = format("./ansible/%s.pem", var.ssh_key_name)
  file_permission = "0600"
  depends_on      = [tls_private_key.private_key]
}

resource "aws_key_pair" "deployer" {
  count      = var.auto_create_ssh_key ? 1 : 0
  key_name   = var.ssh_key_name
  public_key = tls_private_key.private_key[count.index].public_key_openssh
  depends_on = [tls_private_key.private_key]
}

# ---------------------------------------------------------------------------------------------------------------------
#  CREATE SECURITY GROUPS
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }

}


resource "aws_security_group" "http" {
  name        = "allow_http"
  description = "Allow http and https inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }

}

resource "aws_security_group" "egress" {
  name        = "egress_all"
  description = "Egress all"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "egress_all"
  }

}