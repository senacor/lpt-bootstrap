resource "github_repository" "bootstrap" {
  name        = "lpt-bootstrap"
  description = "Bootstrapping the load and performance test repositories"

  visibility = "public"
  auto_init  = true

  vulnerability_alerts   = false
  delete_branch_on_merge = true

  topics = ["lpt"]
}

resource "github_team_repository" "bootstrap" {
  team_id    = github_team.lpt_developers.id
  repository = github_repository.bootstrap.name
  permission = "admin"
}

resource "github_branch" "main_branch" {
  branch     = "main"
  repository = github_repository.bootstrap.name
}

resource "github_branch_default" "main_branch_default" {
  depends_on = [github_branch.main_branch]
  branch     = github_branch.main_branch.branch
  repository = github_repository.bootstrap.name
}

resource "github_actions_secret" "github_access_token" {
  repository      = github_repository.bootstrap.name
  secret_name     = "API_ACCESS_TOKEN"
  plaintext_value = var.github_token
}

resource "github_actions_secret" "state_bucket_access_public_key" {
  repository      = github_repository.bootstrap.name
  secret_name     = "STATE_BUCKET_ACCESS_PUBLIC_KEY"
  plaintext_value = google_service_account_key.state_service_account_key.public_key
}

resource "github_actions_secret" "state_bucket_access_private_key" {
  repository      = github_repository.bootstrap.name
  secret_name     = "STATE_BUCKET_ACCESS_PRIVATE_KEY"
  plaintext_value = google_service_account_key.state_service_account_key.private_key
}

resource "github_actions_secret" "state_bucket_access_wif_provider" {
  repository      = github_repository.bootstrap.name
  secret_name     = "STATE_BUCKET_ACCESS_WIF_PROVIDER"
  plaintext_value = module.github_wif.provider_name
}

resource "github_actions_secret" "gcp_project_id" {
  repository      = github_repository.bootstrap.name
  secret_name     = "GCP_PROJECT_ID"
  plaintext_value = var.project_id
}

resource "github_actions_secret" "state_service_account_id" {
  repository      = github_repository.bootstrap.name
  secret_name     = "STATE_SERVICE_ACCOUNT_ID"
  plaintext_value = module.state_service_account.id
}