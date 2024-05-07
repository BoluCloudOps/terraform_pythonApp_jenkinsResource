
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-central-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

env_prefix           = "Jenkins:Ubuntu Linux EC2"

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDpCbVxiAti4INq1TFWyzAw+96HwVi4lyqKJNiopoOpsZylsI2KicxgRnW/Dz8i4JNvXlUkYXJQH6wHPbrUCxh5pQwS50c2+nclmk9IHoRpJiwM2K+QPLIkPCJNwPuFPFqA6IoaPfb2tj8Wiyvk7pKgr+AzX0RS5aaIXJqP5bOnvzjQ0po1VbBCmeK7c8FjEZbnBUUXUcYRqtSoS9EjbC/cv7z52okqJz0pX4pC1a75rGDJALx6ItHn1EPhopLezcwMtT519rvU0q+59LBheE3d5eb13N7nGwXtNtgBPKat12ix+vcCEwHoHjw3rzxzrkkJjlRtZCbOM4D6hMjG+5GV"
# ec2_ami_id     = "ami-06dd92ecc74fdfb36"

ec2_user_data_install_apache = ""

domain_name = "Jenkins.boluwaji.org"