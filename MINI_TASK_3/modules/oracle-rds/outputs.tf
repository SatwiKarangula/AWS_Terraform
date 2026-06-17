output "rds_endpoint" {
  value = split(":",aws_db_instance.oracle_rds.endpoint)[0]
}

output "rds_port" {
  value = aws_db_instance.oracle_rds.port
}

output "rds_identifier" {
  value = aws_db_instance.oracle_rds.id
}

