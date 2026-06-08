provider "aws" {
    region = var.aws_region
}

locals {
    common_tags = {
        Name = "Satwik"
        Role = "Intern"
  }
}



resource "aws_s3_bucket" "buckets" {
    count = 3
    bucket = "${var.base_bucket_name}-${count.index + 1}"
    tags = local.common_tags
}

resource "aws_s3_object" "sample_file" {
    count = 3
    bucket = aws_s3_bucket.buckets[count.index].id
    key    = "sample.txt"
    source = "sample.txt"
    etag = filemd5("sample.txt")
}