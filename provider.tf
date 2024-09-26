terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.4.0"
    }
    github = {
      source  = "integrations/github"
      version = "6.3.0"
    }
  }

  backend "gcs" {
    bucket = "lpt-schulung-bucket-tfstate"
    prefix = "bootstrap"
  }
}

provider "google" {
  project = var.project_id
  region  = "eu-west1"
}

provider "github" {
  owner = "senacor"
  token = var.github_token
}