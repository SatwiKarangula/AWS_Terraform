output "oracle_endpoint" {
  value = module.oracle_rds.rds_endpoint
}

output "oracle_identifier" {
  value = module.oracle_rds.rds_identifier
}

output "oracle_port" {
  value = module.oracle_rds.rds_port
}

output "oracle_db_name"{
  value = module.oracle_rds.rds_db_name
}

output "secret_name" {
  value = aws_secretsmanager_secret.oracle_rds_secret.name
}
