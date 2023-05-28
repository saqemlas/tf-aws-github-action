data "aws_iam_policy_document" "github_repo_trust" {
  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"
      identifiers = [
        var.oidc_provider_arn
      ]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:${var.owner}/${var.repo_name}:ref:refs/heads/main",
        "repo:${var.owner}/${var.repo_name}:pull_request"
      ]
    }
  }
}

resource "aws_iam_role" "github_actions" {
  assume_role_policy = data.aws_iam_policy_document.github_repo_trust.json
  name               = "github.${var.owner}.${var.repo_name}"
  description        = "Role for Github Actions workflows defined in github.com"

  tags = var.tags
}

resource "aws_iam_role_policy" "github_repo_access" {
  name   = "GithubActionsOIDC"
  role   = aws_iam_role.github_actions.id
  policy = var.policy_document
}

resource "github_actions_secret" "repo_secret" {
  repository      = var.repo_name
  secret_name     = "PIPELINE_ROLE_ARN"
  plaintext_value = aws_iam_role.github_actions.arn
}
