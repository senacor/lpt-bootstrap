data "google_project" "project" {
  project_id = var.project_id
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.gcp_region
  repository_id = var.repository_name
  description   = var.repository_desc
  format        = var.repo_format
  kms_key_name  = var.repo_key_name
  depends_on = [
    google_kms_crypto_key_iam_policy.crypto_key
  ]
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
      "serviceAccount:${var.key_member_sa}",
      "serviceAccount:workflow-automation@${var.project_id}.iam.gserviceaccount.com",
    ]
  }
}

resource "google_kms_crypto_key_iam_policy" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.key.id
  policy_data = data.google_iam_policy.cryptoKeyAccess.policy_data
}

