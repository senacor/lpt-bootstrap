module "lpt-firestore" {
  source = "../../modules/firestore_db"
  project_id = var.project_id
  gcp_region = var.gcp_region

  providers = {
    google = google
  }
}