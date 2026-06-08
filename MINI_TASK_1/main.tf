provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = var.bucket_name
}


resource "aws_iam_user" "project_user" {
  name = "terraform-user"
}