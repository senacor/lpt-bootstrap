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

resource "github_actions_secret" "github_access_token" {
  repository      = github_repository.bootstrap.name
  secret_name     = "API_ACCESS_TOKEN"
  plaintext_value = var.github_token
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