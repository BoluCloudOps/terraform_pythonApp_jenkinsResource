variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_for_jenkins" {}
variable "enable_public_ip_address" {}
variable "user_data_install_jenkins" {}

#Dynamically Fetch AMI Image
data "aws_ami" "latest-ubuntu-image" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# data "vault_kv_secret_v2" "vault_data_src" {
#   mount = "terraform" // change it according to your mount
#   name  = "aws/sshkey" // change it according to your secret
# }

# output "vault-v" {
#   value = data.vault_kv_secret_v2.vault_data_src
# }
output "test" {
  value = data.aws_ami.latest-ubuntu-image
}
output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /Users/bolu/.ssh/project1key ubuntu@", aws_instance.jenkins_ec2_instance_ip.public_ip)
}

output "jenkins_ec2_instance_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.id
}

output "dev_proj_1_ec2_instance_public_ip" {
  value = aws_instance.jenkins_ec2_instance_ip.public_ip
}

resource "aws_instance" "jenkins_ec2_instance_ip" {
  ami           = data.aws_ami.latest-ubuntu-image.id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
    Secret = data.vault_kv_secret_v2.vault_data_src.data["public_key"]
  }
  key_name                    = "project1key"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.sg_for_jenkins
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_jenkins

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
  key_name   = "project1key"
  public_key = var.public_key
}




# variable "ami_id" {}
# variable "instance_type" {}
# variable "tag_name" {}
# variable "public_key" {}
# variable "subnet_id" {}
# variable "sg_for_jenkins" {}
# variable "enable_public_ip_address" {}
# variable "user_data_install_jenkins" {}

# #Dynamically Fetch AMI Image
# data "aws_ami" "latest-ubuntu-image" {
#   most_recent = true
#   owners      = ["099720109477"] # Canonical
#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }
# }

# data "vault_kv_secret_v2" "vault_data_src" {
#   mount = "terraform" // change it according to your mount
#   name  = "aws/sshkey" // change it according to your secret
# }

# output "vault-v" {
#   value = data.vault_kv_secret_v2.vault_data_src
# }
# output "test" {
#   value = data.aws_ami.latest-ubuntu-image
# }
# output "ssh_connection_string_for_ec2" {
#   value = format("%s%s", "ssh -i /Users/bolu/.ssh/project1key ubuntu@", aws_instance.jenkins_ec2_instance_ip.public_ip)
# }

# output "jenkins_ec2_instance_ip" {
#   value = aws_instance.jenkins_ec2_instance_ip.id
# }

# output "dev_proj_1_ec2_instance_public_ip" {
#   value = aws_instance.jenkins_ec2_instance_ip.public_ip
# }

# resource "aws_instance" "jenkins_ec2_instance_ip" {
#   ami           = data.aws_ami.latest-ubuntu-image.id
#   instance_type = var.instance_type
#   tags = {
#     Name = var.tag_name
#     Secret = data.vault_kv_secret_v2.vault_data_src.data["public_key"]
#   }
#   key_name                    = "project1key"
#   subnet_id                   = var.subnet_id
#   vpc_security_group_ids      = var.sg_for_jenkins
#   associate_public_ip_address = var.enable_public_ip_address

#   user_data = var.user_data_install_jenkins

#   metadata_options {
#     http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
#     http_tokens   = "required" # Require the use of IMDSv2 tokens
#   }
# }

# resource "aws_key_pair" "jenkins_ec2_instance_public_key" {
#   key_name   = "project1key"
#   public_key = var.public_key
# }