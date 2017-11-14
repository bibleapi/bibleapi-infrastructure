provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "bibleapi-rest" {
  ami           = "ami-41c12e23" # http://cloud-images.ubuntu.com/locator/ec2/
  instance_type = "t2.micro"
  tags {
    Name = "Bible API RESTful Web Service"
  }
}