variable "github_token" {
  description = "Github token to access and change ressource through the API"
  type        = string
}

variable "project_id" {
  description = "Project ID to apply and identify infrastructure code"
  type        = string
}

variable "gcp_region" {
  description = "GCP region to create resources in"
  type = string
  default = "europe-west1"
}