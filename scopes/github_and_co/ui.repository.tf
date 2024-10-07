resource "github_repository" "application_ui" {
  name        = "lpt-application-ui"
  description = "UI used for the credit application application, fetching the credit data of a customer"

  visibility = "public"
  auto_init  = true

  vulnerability_alerts   = false
  delete_branch_on_merge = true

  topics = ["lpt"]
}

resource "github_team_repository" "application_ui" {
  team_id    = github_team.lpt_developers.id
  repository = github_repository.application_ui.name
  permission = "admin"
}

resource "github_branch" "ui_main_branch" {
  branch     = "main"
  repository = github_repository.application_ui.name
}

resource "github_branch_default" "ui_main_branch_default" {
  depends_on = [github_branch.ui_main_branch]
  branch     = github_branch.ui_main_branch.branch
  repository = github_repository.application_ui.name
}

resource "github_actions_secret" "ui_gke_access_public_key" {
  repository      = github_repository.application_ui.name
  secret_name     = "GKE_ACCESS_PUBLIC_KEY"
  plaintext_value = google_service_account_key.gke_service_account_key.public_key
}

resource "github_actions_secret" "ui_gke_access_private_key" {
  repository      = github_repository.application_ui.name
  secret_name     = "GKE_ACCESS_PRIVATE_KEY"
  plaintext_value = google_service_account_key.gke_service_account_key.private_key
}
