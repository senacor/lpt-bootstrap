data "google_project" "project" {
  project_id = var.project_id
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.gcp_region
  repository_id = var.repository_name
  description   = var.repository_desc
  format        = var.repo_format
  project       = data.google_project.project.project_id
  # Has the form: projects/my-project/locations/my-region/keyRings/my-kr/cryptoKeys/my-key:
  kms_key_name  = google_kms_crypto_key.key.id

  depends_on = [
    google_kms_crypto_key_iam_policy.crypto_key.id
  ]
}

resource "google_artifact_registry_repository_iam_member" "member" {
  project = var.project_id
  location = var.gcp_region
  repository = google_artifact_registry_repository.repo.id
  role = "roles/artifactregistry.writer"
  member = var.application_sa
}

resource "google_kms_key_ring" "keyring" {
  name     = "lpt-keyring"
  location = var.gcp_region
}

resource "google_kms_crypto_key" "key" {
  name            = var.repo_key_name
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = "7776000s"
  lifecycle {
    prevent_destroy = true
  }
}

data "google_iam_policy" "cryptoKeyAccess" {
  binding {
    role = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

    members = [
      var.application_sa,
      "serviceAccount:workflow-automation@${var.project_id}.iam.gserviceaccount.com",
    ]
  }
}

resource "google_kms_crypto_key_iam_policy" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.key.id
  policy_data = data.google_iam_policy.cryptoKeyAccess.policy_data
}

