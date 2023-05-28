data "aws_iam_policy_document" "pipeline_policy" {
  version = "2012-10-17"

  statement {
    actions = [
      "*",
    ]

    resources = ["*"]
  }
}

module "repo_pipeline" {
  source = "./modules/github-actions-oidc"

  repo_name         = "example"

  oidc_provider_arn = aws_iam_openid_connect_provider.oidc.arn
  owner             = var.base_configuration.owner

  policy_document   = data.aws_iam_policy_document.pipeline_policy.json
  aws_account_id    = data.aws_caller_identity.current.account_id

  tags = var.base_configuration.tags
}

resource "github_actions_secret" "pipeline_github_token" {
  repository      = var.repo_name
  secret_name     = "TOKEN_GITHUB"
  plaintext_value = file("./token.txt")
}

resource "github_actions_secret" "pipeline_github_owner" {
  repository      = var.repo_name
  secret_name     = "OWNER_GITHUB"
  plaintext_value = var.base_configuration.owner
}
