resource "aws_s3_bucket" "bootstrap_state" {
  bucket = "terraform-state-${var.service}-bucket"

  tags = var.tags

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_s3_bucket_ownership_controls" "bootstrap_state" {
  bucket = aws_s3_bucket.bootstrap_state.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "bootstrap_state" {
  bucket = aws_s3_bucket.bootstrap_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "bootstrap_state" {
  name         = "terraform-state-${var.service}-lock-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags

  # lifecycle {
  #   prevent_destroy = true
  # }
}
