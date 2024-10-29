data "google_project" "lpt_proj" {
  project_id = var.project_id
}

resource "google_storage_bucket" "lpt_ui" {
  name     = var.ui_bucket_name
  location = var.gcp_region
  project = data.google_project.lpt_proj.project_id
  public_access_prevention = "false"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_iam_member" "public_rule" {
  bucket = google_storage_bucket.lpt_ui.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}