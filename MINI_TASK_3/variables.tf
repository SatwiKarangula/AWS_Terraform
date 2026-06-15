variable "aws_region" {
  default = "us-east-1"
}

variable "db_identifier" {
  type = string
}

variable "db_username" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}