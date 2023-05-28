provider "github" {
  # set GITHUB_OWNER and GITHUB_TOKEN as env variables
  # otherwise fetching fetching certain resources fails
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
