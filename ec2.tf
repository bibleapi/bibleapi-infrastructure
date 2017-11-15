provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_security_group" "bibleapi-security-group" {
  name = "bibleapi-security-group"
  description = "Bible API security group"
  vpc_id = ""
}

resource "aws_security_group_rule" "ssh_ingress_access" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = "${aws_security_group.bibleapi-security-group.id}"
}

resource "aws_security_group_rule" "egress_access" {
  type = "egress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = "${aws_security_group.bibleapi-security-group.id}"
}

resource "aws_instance" "bibleapi-rest-instance" {
  ami = "ami-41c12e23" # http://cloud-images.ubuntu.com/locator/ec2/
  availability_zone = "ap-southeast-2a" # https://gist.github.com/neilstuartcraig/0ccefcf0887f29b7f240
  instance_type = "t2.nano"
  vpc_security_group_ids = [ "${aws_security_group.bibleapi-security-group.id}" ]
  associate_public_ip_address = true
  subnet_id = ""
  tags {
    Name = "bibleapi-rest"
  }
}