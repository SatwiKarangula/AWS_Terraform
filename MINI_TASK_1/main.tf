provider "aws" {
  region = var.aws_region
}
locals {
  common_tags = {
        name = "Satwik",
        role = "Intern"
  }  
}

resource "aws_s3_bucket" "project_bucket" {
  bucket = var.bucket_name
  tags = local.common_tags
}


resource "aws_iam_user" "project_user" {
  name = "terraform-user"
  tags = local.common_tags
}