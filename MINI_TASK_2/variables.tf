variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_count"{
  description = "Number of S3 buckets to create"
  type = number
}

variable "base_bucket_name" {
  description = "Base bucket name"
  type        = string
}

variable "object_file_upload" {
  description = "Upload file into S3 bucket"
  type        = string
}