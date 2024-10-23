variable "project_id" {
  description = "Project ID to apply and identify infrastructure code"
  type        = string
  default     = "vbdev-436712"
}

variable "gcp_region" {
  description = "Region the infrastructure should be deployed in"
  type        = string
  default     = "europe-west1"
}
