locals {
  common_tags = {
    Name = "Satwik"
    Role = "Intern"
  }
}


module "oracle_rds" {
  source = "./module/oracle-rds"
  db_identifier = var.db_identifier
  db_username = var.db_username
  db_password = var.db_password
  common_tags = local.common_tags
  instance_type = var.instance_type
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-nameless-bucket-of-the-bucket"
  tags = local.common_tags
}

resource "aws_secretsmanager_secret" "oracle_rds_secret" {

  name = "satwik/oracle-rds/master-credentials"
  description = "Oracle RDS Master Credentials and Connection Details"
  tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "oracle_rds_secret_value" {

  secret_id = aws_secretsmanager_secret.oracle_rds_secret.id
  secret_string = jsonencode({
    endpoint = module.oracle_rds.rds_endpoint
    port = module.oracle_rds.rds_port
    database_name = module.oracle_rds.rds_db_name
    master_username = var.db_username
    password = var.db_password

  })
}