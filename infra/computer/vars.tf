variable "ami" {
  default = "ami-03d315ad33b9d49c4"
}
variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {
  default = "DemoAPI"
}
variable "public_subnet_id" {
  type        = string
  description = "Public subnet id"
}
variable "security_groups" {
  type        = list(any)
  description = "Security groups ID list"

}
variable "ssh_key_name" {
  type        = string
  default     = "terraform"
  description = "AWS key pair name"
}





