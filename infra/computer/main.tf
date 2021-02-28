
resource "aws_instance" "vm" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = var.security_groups
  tags = {
    "Name" = var.instance_name
  }
  key_name = var.ssh_key_name

}

resource "local_file" "ansible_inventory" {
  content    = format("[ec2]\n%s", aws_instance.vm.public_ip)
  filename   = "./ansible/inventory"
  depends_on = [aws_instance.vm]
}





