module "application_service_account" {
  source  = "terraform-google-modules/service-accounts/google//modules/simple-sa"
  version = "~> 4.0"

  project_id = var.project_id
  name       = "lpt-application"

  project_roles = [
    "roles/iam.workloadIdentityUser"
  ]
}