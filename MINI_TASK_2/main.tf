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
    count = var.bucket_count
    bucket = "${var.base_bucket_name}-${count.index + 1}"
    tags = local.common_tags
}

resource "aws_s3_object" "sample_file" {
    count = var.bucket_count
    bucket = aws_s3_bucket.buckets[count.index].id
    key    = var.object_file_upload
    source = var.object_file_upload
    etag = filemd5(var.object_file_upload)
}