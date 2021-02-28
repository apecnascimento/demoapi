variable "vpc_name" {
  default     = "custom_vcp"
  description = "VPC name"
}

variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR block"
}

variable "public_subnet_name" {
  default     = "custom_public_subnet"
  description = "public subnet name"
}

variable "public_subnet_cidr" {
  default     = "10.0.16.0/24"
  description = "Public Subnet CIDR block"
}

variable "internet_gateway_name" {
  default     = "custom_igw"
  description = "Internet gateway name"
}

variable "elastic_ip_name" {
  default     = "default_EIP"
  description = "Elastic IP Name"
}

variable "public_route_table_name" {
  default     = "custom_public_route_table"
  description = "Public route table name"
}