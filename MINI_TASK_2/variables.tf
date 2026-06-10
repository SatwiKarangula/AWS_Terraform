variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "bucket_names" {
  description = "Consists of different bucket names"
  type        = list(string)
}

variable "object_file_upload" {
  description = "Upload file into S3 bucket"
  type        = string
}