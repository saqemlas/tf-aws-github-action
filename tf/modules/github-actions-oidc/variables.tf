variable "oidc_provider_arn" {
  type = string
}

variable "owner" {
  type = string
}

variable "repo_name" {
  type = string
}

variable "is_main_branch" {
  type = bool
}

variable "policy_document" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "tags" {
  type = map(any)
}
