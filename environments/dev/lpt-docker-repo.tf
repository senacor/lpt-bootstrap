module "lpt_docker_repo" {
  source = "../../modules/docker_repo"
  project_id = var.project_id
  gcp_region = var.gcp_region
  repo_key_name = "lpt_repo"
  repository_name = "lpt"

  providers = {
    google = google
  }
}