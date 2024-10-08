module "lpt-firestore" {
  source = "../../modules/firestore_db"
  project_id = var.project_id
  gcp_region = var.gcp_region
  application_sa = module.application_service_account.iam_email

  providers = {
    google = google
  }
}