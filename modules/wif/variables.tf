
variable "project_id" {
  description = "Project id"
  type        = string
}

variable "database_name" {
  description = "Database name"
  type        = string
  default = "lpt_showcase"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default = "europe-west1"
}

