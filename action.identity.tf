module "github_wif" {
  source     = "Cyclenerd/wif-github/google"
  version    = "~> 1.0.0"
  project_id = var.project_id
  attribute_condition = "assertion.repository_owner == 'senacor'"
}

module "wif_lpt_bootstrap" {
  source     = "Cyclenerd/wif-service-account/google"
  version    = "~> 1.0.0"
  project_id = var.project_id
  pool_name  = module.github_wif.pool_name
  account_id = module.state_service_account.id
  repository = github_repository.bootstrap.full_name
}