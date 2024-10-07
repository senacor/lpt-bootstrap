resource "google_storage_bucket" "state" {
  name          = "lpt-schulung-bucket-tfstate"
  force_destroy = false
  location      = "EU"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

module "state_service_account" {
  source  = "terraform-google-modules/service-accounts/google//modules/simple-sa"
  version = "~> 4.0"

  project_id = var.project_id
  name       = "terraform-state-sa"

  project_roles = [
    "roles/storage.admin",
    "roles/iam.workloadIdentityUser"
  ]
}

resource "google_service_account_key" "state_service_account_key" {
  service_account_id = module.state_service_account.id
  public_key_type    = "TYPE_X509_PEM_FILE"
}