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
#     "roles/storage.admin"
  ]
}