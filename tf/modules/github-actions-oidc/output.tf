output "pipeline_iam_role_arn" {
  value = aws_iam_role.github_actions.arn
}