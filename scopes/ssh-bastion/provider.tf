terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6"
    }
  }

  backend "gcs" {
    bucket = "lpt-schulung-bucket-tfstate"
    prefix = "ssh_bastion"
  }
}

provider "google" {
  project = var.project_id
  region  = var.gcp_region
}
