locals {
    common_tags = {
        Name = "Satwik"
        Role = "Intern"
  }
}



resource "aws_s3_bucket" "buckets" {
    for_each = toset(var.bucket_names) 
    bucket = each.value
    tags = local.common_tags
}

resource "aws_s3_object" "sample_file" {
    for_each = aws_s3_bucket.buckets
    bucket = each.value.id
    key    = var.object_file_upload
    source = var.object_file_upload
    etag = filemd5(var.object_file_upload)
}