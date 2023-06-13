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

    
resource "aws_iam_policy" "cloudwatch_policy" {
  name = "cloudwatch_policy"
  description = "Policy to grant ec2 cloud watch permissions"
  policy = data.aws_iam_policy_document.cloudwatch_server_role.json
}

resource "aws_iam_policy_attachment" "cloudwatch_attachment" {
  name = "Cloudwatch_Attachment"
  roles = [ aws_iam_role.role.name ]
  policy_arn = aws_iam_policy.cloudwatch_policy.arn
}
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.role.name
}
