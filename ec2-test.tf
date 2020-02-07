provider "aws" {
	region = "us-east-1"
	access_key = "ACCESS_KEY" #AWS Access Key ID
	secret_key = "SECRET_KEY" #AWS Secret key token
}

resource "aws_instance" "myfirstec2" {
	ami = "ami-062f7200baf2fa504"
	instance_type = "t2.micro"
	vpc_security_group_ids = ["${data.aws_security_group.selected.id}"]
	key_name = "KEY_PAIR_NAME" #Existing key pair name
	user_data = <<-EOF
				#! /bin/bash
				sudo su
				yum install httpd -y
				echo "Welcome to Mobile Legends" > /var/www/html/index.html
				yum update -y
				service httpd start
				EOF
	tags = {
		Name = "BricxTerraformEC2"
	}
}

data "aws_security_group" "selected" {
	id = "SECURITY_GROUP_ID" #Existing security group id
}

output "public_ip" {
  value = "${aws_instance.myfirstec2.public_ip}"
}

output "id" {
	value = "${aws_instance.myfirstec2.id}"
}

output "public_dns" {
	value = "${aws_instance.myfirstec2.public_dns}"
}