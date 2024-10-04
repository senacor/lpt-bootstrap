data "google_project" "project" {
  project_id = var.project_id
}

resource "google_artifact_registry_repository" "my-repo" {
  location      = var.gcp_region
  repository_id = var.repository_name
  description   = var.repository_desc
  format        = var.repo_format
  kms_key_name  = var.repo_key_name
  depends_on = [
    google_kms_crypto_key_iam_member.crypto_key
  ]
}

resource "google_kms_crypto_key_iam_member" "crypto_key" {
  crypto_key_id = var.repo_key_name
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-artifactregistry.iam.gserviceaccount.com"
}

