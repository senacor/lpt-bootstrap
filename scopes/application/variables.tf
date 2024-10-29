

variable "project_id" {
  description = "Project ID to apply and identify infrastructure code"
  type        = string
}

variable "gcp_region" {
  description = "Region the infrastructure should be deployed in"
  type        = string
  default     = "europe-west1"
}

variable "ui_bucket_name" {
  description = "Name of cloud storage bucket for UI hosting"
  type        = string
  default     = "lpt-ui"
}