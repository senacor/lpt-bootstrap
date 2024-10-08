data "google_project" "project" {
  project_id = var.project_id
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.gcp_region
  repository_id = var.repository_name
  description   = var.repository_desc
  format        = var.repo_format
  project       = data.google_project.project.project_id
}

resource "google_artifact_registry_repository_iam_member" "member" {
  project    = var.project_id
  location   = var.gcp_region
  repository = google_artifact_registry_repository.repo.id
  role       = "roles/artifactregistry.writer"
  member     = var.application_sa
}


resource "google_artifact_registry_repository_iam_member" "member_workflow" {
  project    = var.project_id
  location   = var.gcp_region
  repository = google_artifact_registry_repository.repo.id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${var.worfklow_sa}"
}