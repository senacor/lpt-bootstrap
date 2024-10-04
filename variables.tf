variable "github_token" {
  description = "Github token to access and change ressource through the API"
  type        = string
}

variable "project_id" {
  description = "Project ID to apply and identify infrastructure code"
  type        = string
}

variable "region" {
  description = "Region the infrastructure should be deployed in"
  type        = string
  default     = "europe-west1"
}