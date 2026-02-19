variable "gcp_project" {
  description = "The GCP project ID"
  type        = string
}

variable "app_name" {
  description = "The application name"
  type        = string
}

variable "env" {
  description = "The environment (e.g., dev, stage, prod)"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default = "australia-southeast1"
}

variable "terraform_infra_sa" {
  description = "GCP SA for terraform deployment"
  type = string
}
