data "google_project" "project" {
  project_id = var.project_id
}

resource "google_firestore_database" "database" {
  project                           = data.google_project.project.project_id
  name                              = var.database_name
  location_id                       = var.gcp_region
  type                              = "FIRESTORE_NATIVE"
  concurrency_mode                  = "OPTIMISTIC"
  app_engine_integration_mode       = "DISABLED"
  point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_DISABLED"
  delete_protection_state           = "DELETE_PROTECTION_DISABLED"
  deletion_policy                   = "DELETE"
}


resource "google_project_iam_member" "firestore_sa_member" {
  project = data.google_project.project.project_id
  role    = "roles/firebase.developAdmin"
  member  = var.application_sa
}