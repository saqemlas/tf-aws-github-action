terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "terraform-state-example-bucket"
    key            = "terraform-state/example.tfstate"
    encrypt        = "true"
    dynamodb_table = "terraform-state-example-lock-table"
  }
}
