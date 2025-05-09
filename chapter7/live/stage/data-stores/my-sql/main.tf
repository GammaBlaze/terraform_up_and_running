# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via -backend-config arguments to 'terraform init'
terraform {
  backend "s3" {
    key = "stage/data-stores/my-sql/terraform.tfstate"
  }
}

module "mysql_primary" {
  source = "../../../../modules/data-stores/my-sql"

  providers = {
    aws = aws.primary
  }

  db_name     = "stg_db"
  db_username = var.db_username
  db_password = var.db_password
}
