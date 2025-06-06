# Partial configuration. The other settings (e.g., bucket, region) will be
# passed in from a file via -backend-config arguments to 'terraform init'
/*terraform {
  backend "s3" {
    key = "example/terraform.tfstate"
  }
}*/

resource "aws_s3_bucket" "terraform_state" {
  bucket = "the-bucket-residence-state"

  # Prevent accidental deletion of this S3 bucket
  /*lifecycle {
    prevent_destroy = true
  }*/
}

# Enable versioning so you can see the full revision history of your
# state files
resource "aws_s3_bucket_versioning" "disabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Disabled"
  }
}

# Enable server-side encryption by default
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "the-bucket-residence-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Uncomment this null_resource to empty the S3 bucket, doesn't work with versioning enabled
/*resource "null_resource" "empty_bucket" {
  # Use UUID to force this null_resource to be recreated on every
  # call to 'terraform apply'
  triggers = {
    uuid = uuid()
  }

  provisioner "local-exec" {
    command = "aws s3 rm s3://${aws_s3_bucket.terraform_state.id} --recursive"
  }
}*/
