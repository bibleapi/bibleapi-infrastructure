provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "bibleapi_security_group" {
  name = "bibleapi_security_group"
  description = "Bible API security group"
  vpc_id = "${var.vpc_id}"

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress access within this security group
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }
}

resource "aws_key_pair" "administrator-key" {
  key_name   = "administrator-key"
  public_key = ""
}