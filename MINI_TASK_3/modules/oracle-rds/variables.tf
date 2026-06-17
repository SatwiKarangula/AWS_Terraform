variable "db_identifier" {
    type = string
}

variable "db_username" {
    type = string
}

variable "db_password" {
    type = string
}

variable "common_tags" {
    type = map(string)
}

variable "instance_class" {
    type = string
}

variable "engine" {
    type = string
}

variable "license_model" {
    type = string 
}

variable "backup_retention" {
    type = number 
}

variable "allocated_storage" {
    type = number   
}