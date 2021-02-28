provider "aws" {
  region = "us-east-1"
}

module "networks" {
  source = "./networks"
}

module "security" {
  source          = "./security"
  vpc_id          = module.networks.vpc_id
  vpc_cidr_block  = module.networks.vpc_cidr_block
  depends_on      = [module.networks]
}

module "computer" {
  source           = "./computer"
  public_subnet_id = module.networks.public_subnet_id
  ssh_key_name = module.security.ssh_key_name
  security_groups = [
    module.security.allow_ssh,
    module.security.allow_http,
    module.security.egress
  ]
  depends_on = [module.security]
}




