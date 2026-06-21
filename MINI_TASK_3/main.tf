locals {
    common_tags =  {
        Name = "Satwik"
        Role = "Intern" 
  }
}

module "aws_db_instance" {
    source = "./modules/oracle-rds"

    db_identifier = var.db_identifier               
    db_username = var.db_username                   
    db_password = var.db_password
    common_tags = local.common_tags
    instance_class = var.instance_class                 
    engine = var.engine
    license_model = var.license_model
    allocated_storage = var.allocated_storage
    backup_retention = var.backup_retention

}

resource "aws_secretsmanager_secret" "my_little_secret" {

    name = var.aws_secrets_directory
    tags = local.common_tags
}

resource "aws_secretsmanager_secret_version" "oracle_secret_value" {

  secret_id = aws_secretsmanager_secret.my_little_secret.id
  secret_string = jsonencode({
    endpoint = module.aws_db_instance.rds_endpoint
    port = module.aws_db_instance.rds_port
    database_name = var.aws_secrets_db_name
    master_username = var.db_username
    password = var.db_password
  })
}

resource "null_resource" "user_provisioning" {
  depends_on = [ 
    aws_secretsmanager_secret_version.oracle_secret_value,
    module.aws_db_instance
   ] 
   triggers = {
     always_run = timestamp()
   }
   provisioner "local-exec" {
    command = "python scripts/create_user.py"    
   }
}

resource "null_resource" "user_verification" {
  depends_on = [ null_resource.user_provisioning ]
  provisioner "local-exec" {
    command = "python scripts/verify_users.py"
  }  
}