provider "aws" {
  region = "us-east-2"
}

module "mysql" {
  source = "../../modules/data-stores/my-sql"

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
