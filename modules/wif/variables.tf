
variable "project_id" {
  description = "Project id"
  type        = string
}

variable "gh_repository_full_name" {
  description = "Database name"
  type        = string
  default = "lpt_showcase"
}

variable "state_service_account_id" {
  description = "Id of TF state service account"
  type        = string
}

