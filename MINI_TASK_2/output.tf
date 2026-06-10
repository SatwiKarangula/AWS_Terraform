output "bucket_names" {
  value = keys(aws_s3_bucket.buckets)
}

output "no_of_buckets" {
  value = length(aws_s3_bucket.buckets)
}