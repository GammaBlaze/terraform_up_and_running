data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "the-bucket-residence-state"
    key    = "stage/data-stores/my-sql/terraform.tfstate"
    region = "us-east-2"
  }
}
