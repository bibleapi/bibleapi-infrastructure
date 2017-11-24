resource "aws_s3_bucket" "bibleapi_rest_terraform_remote_state" {
  bucket = "bibleapi-rest-terraform-remote-state"
  acl = "private"
  versioning {
    enabled = true
  }
}

terraform {
  backend "s3" {
    bucket = "bibleapi-rest-terraform-remote-state"
    key    = "terraform.tfstate"
    region = "ap-southeast-2"
  }
}