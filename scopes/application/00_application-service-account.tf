module "application_service_account" {
  source  = "terraform-google-modules/service-accounts/google//modules/simple-sa"
  version = "~> 4.0"

  project_id = var.project_id
  name       = "lpt-application"

  project_roles = [
    "roles/iam.workloadIdentityUser",
    "roles/artifactregistry.reader"
  ]
}

resource "google_service_account_key" "state_service_account_key" {
  service_account_id = module.application_service_account.id
  public_key_type    = "TYPE_X509_PEM_FILE"
}