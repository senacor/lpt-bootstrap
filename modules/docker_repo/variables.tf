
variable "project_id" {
  description = "Project id"
  type        = string
}

variable "repository_name" {
  description = "Repository Name (Part)"
  type        = string
}

variable "repository_desc" {
  description = "Repository Description"
  type        = string
  default     = "LPT Repo"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default = "europe-west1"
}

variable "repo_key_name" {
  description = "Repository Description"
  type        = string
}

variable "repo_format" {
  description = "Repository format"
  type        = string
  default     = "DOCKER"
}

variable "application_sa" {
  description = "Application Service Account requiring access to repo"
  default = ""
}