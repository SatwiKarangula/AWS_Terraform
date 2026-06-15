output "rds_endpoint" {
  value = aws_db_instance.oracle_rds.endpoint
}

output "rds_identifier" {
  value = aws_db_instance.oracle_rds.id
}

output "rds_port" {
  value = aws_db_instance.oracle_rds.port
}

output "rds_db_name" {
  value = aws_db_instance.oracle_rds.db_name
}