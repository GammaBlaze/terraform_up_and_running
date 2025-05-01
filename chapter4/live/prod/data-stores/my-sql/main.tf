# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via -backend-config arguments to 'terraform init'
terraform {
  backend "s3" {
    key = "prod/data-stores/my-sql/terraform.tfstate"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running-prod"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"

  username = var.db_username
  password = var.db_password
}
