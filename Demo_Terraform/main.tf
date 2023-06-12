variable "aws_access_key" {}
variable "aws_secret_key" {}

# configure aws provider
provider "aws" {
  region = var.region
  #profile = "Admin"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# create vpc
module "vpc" {
  source       = "../Demo_Terraform_Modules/vpc"
  region       = var.region
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

}

#create instance
module "instance" {
  source              = "../Demo_Terraform_Modules/instance"
  ami                 = var.ami
  instance_type       = var.instance_type
  instance_name       = var.instance_name
  key_name            = var.key_name
  security_group_name = var.security_group_name
  subnet_id           = module.vpc.subnet_id
  vpc_id              = module.vpc.vpc_id
}
