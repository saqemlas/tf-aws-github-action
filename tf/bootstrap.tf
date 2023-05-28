module "bootstrap_state" {
  source = "./modules/bootstrap-state"

  service        = var.base_configuration.service
  aws_account_id = data.aws_caller_identity.current.account_id

  tags = var.base_configuration.tags
}
