variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}

variable "ssh_key_name" {
  type        = string
  default     = "deployer"
  description = "AWS key pair name"
}

//If you set as "false" the variable "ssh_key_name" must be a existent EC2 keypair
variable "auto_create_ssh_key" {
  default = true
  description = "Auto generate EC2 keypair keys"
}