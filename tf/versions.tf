terraform {
  required_version = "~> 1.4.6"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.25.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}
