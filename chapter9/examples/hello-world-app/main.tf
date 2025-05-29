# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via -backend-config arguments to 'terraform init'
terraform {
  backend "s3" {
    key = "stage/services/hello-world-app/terraform.tfstate"
  }
}

module "hello_world_app" {
  source = "../../modules/services/hello-world-app"

  environment            = "stage"
  db_remote_state_bucket = "the-bucket-residence-state"
  db_remote_state_key    = "stage/data-stores/my-sql/terraform.tfstate"

  instance_type      = "m4.large"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = true

  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}
