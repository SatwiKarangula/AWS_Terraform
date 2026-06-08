output "bucket_name" {
  value = aws_s3_bucket.project_bucket.bucket
}


output "iam_user" {
  value = aws_iam_user.project_user.name
}
