output "oracle_endpoint" {
  value = module.aws_db_instance.rds_endpoint
}

output "oracle_port" {
  value = module.aws_db_instance.rds_port
}

output "oracle_identifier" {
  value = module.aws_db_instance.rds_identifier
}

