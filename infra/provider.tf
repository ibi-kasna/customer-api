

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.17.0, < 8.0.0"
    }
  }
  backend "gcs" {}
}

provider "google" {
  project                     = var.gcp_project
  impersonate_service_account = var.terraform_infra_sa
}
