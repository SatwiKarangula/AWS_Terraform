resource "aws_db_instance" "oracle_rds" {

  identifier = var.db_identifier
  engine = "oracle-se2"
  instance_class = var.instance_type
  allocated_storage = 20
  storage_type = "gp2"
  storage_encrypted = true
  username = var.db_username
  password = var.db_password
  backup_retention_period = 1
  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false
  license_model = "bring-your-own-license"
  tags = var.common_tags

}