resource "github_repository" "application_service" {
  name        = "lpt-application-service"
  description = "Backend application-service use for the credit application application, orchestrating the process to apply for a credit"

  visibility = "public"
  auto_init  = true

  vulnerability_alerts   = false
  delete_branch_on_merge = true

  topics = ["lpt"]
}

resource "github_team_repository" "application_service" {
  team_id    = github_team.lpt_developers.id
  repository = github_repository.application_service.name
  permission = "admin"
}

resource "github_branch" "service_main_branch" {
  branch     = "main"
  repository = github_repository.application_service.name
}

resource "github_branch_default" "service_main_branch_default" {
  depends_on = [github_branch.service_main_branch]
  branch     = github_branch.service_main_branch.branch
  repository = github_repository.application_service.name
}

/*
resource "github_actions_secret" "service_gke_access_public_key" {
  repository      = github_repository.application_service.name
  secret_name     = "GKE_ACCESS_PUBLIC_KEY"
  plaintext_value = google_service_account_key.gke_service_account_key.public_key
}

resource "github_actions_secret" "service_gke_access_private_key" {
  repository      = github_repository.application_service.name
  secret_name     = "GKE_ACCESS_PRIVATE_KEY"
  plaintext_value = google_service_account_key.gke_service_account_key.private_key
}
*/
