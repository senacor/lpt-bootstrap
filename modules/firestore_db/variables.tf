variable "project_id" {
  description = "Project id"
  type        = string
}

variable "database_name" {
  description = "Database name"
  type = string
  # database_id should be 4-63 characters, and valid characters are /[a-z][0-9]-/
  default     = "lpt-nosql"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "application_sa" {
  description = "Application Service Account requiring access to firestore"
  default     = ""
}
