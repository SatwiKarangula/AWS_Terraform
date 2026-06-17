resource "aws_db_instance" "oracle_rds" {

  identifier = var.db_identifier
  engine = var.engine
  license_model = var.license_model
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = true
  username = var.db_username
  password = var.db_password
  backup_retention_period = var.backup_retention
  skip_final_snapshot = true
  publicly_accessible = true
  deletion_protection = false

  tags = var.common_tags
}