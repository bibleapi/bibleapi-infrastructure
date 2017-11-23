provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "bibleapi_security_group" {
  name = "bibleapi_security_group"
  description = "Bible API security group"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "administrator-key" {
  key_name   = "administrator-key"
  public_key = ""
}