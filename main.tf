terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "private_key_path" {}


provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "ap-southeast-1"
}




resource "aws_security_group" "ec2_webserver_security_group" {
   name = "Webserver_Assesment_SG"
   description = "Security group for webserver instance"

   ingress {
       from_port= 80
       protocol = "TCP"
       to_port = 80
       cidr_blocks = ["0.0.0.0/0"]

   }

   ingress {
       from_port= 22
       protocol = "TCP"
       to_port = 22
       cidr_blocks = ["0.0.0.0/0"]

   }

   egress {
      from_port= 0
      protocol = "-1"
      to_port = 0
      cidr_blocks = ["0.0.0.0/0"]
   }

}

resource "aws_instance" "Technical-Assesment-EC2" {
  ami           = "ami-03bfba2e75432064e"
  instance_type = "t2.small"
  key_name = "mafa"

#   tags = {
#       name = "Department: Engineering"
#   }
  security_groups = ["${aws_security_group.ec2_webserver_security_group.name}"]
  user_data = file("userdata.tpl")
}

output "publicip" {
    value = "${aws_instance.Technical-Assesment-EC2.*.public_ip}"
}

output "aws_instance_public_dns" {
  value = aws_instance.Technical-Assesment-EC2.public_dns
}