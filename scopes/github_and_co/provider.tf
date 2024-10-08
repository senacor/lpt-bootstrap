terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6"
    }
    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
  }

  backend "gcs" {
    bucket = "lpt-schulung-bucket-tfstate"
    prefix = "github_and_co"
  }
}

provider "google" {
  project = var.project_id
  region  = var.gcp_region
}

provider "github" {
  owner = "senacor"
  token = var.github_token
}