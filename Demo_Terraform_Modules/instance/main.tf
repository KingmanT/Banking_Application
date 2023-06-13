# create instance
resource "aws_instance" "web_server01" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.web_ssh.id]
  subnet_id = var.subnet_id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  user_data = "${file("deploy.sh")}"

  tags = {
    "Name" : var.instance_name
  }
  
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.role.name
}

# create security groups

resource "aws_security_group" "web_ssh" {
  name        = "ssh-access"
  description = "open ssh traffic"
  vpc_id = var.vpc_id
 

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" : var.security_group_name
    "Terraform" : "true"
  }
  
}

output "instance_ip" {
  value = aws_instance.web_server01.public_ip
  
}
