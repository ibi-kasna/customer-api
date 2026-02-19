module "cloud_run" {
  source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/cloud-run-v2?ref=v52.0.0"
  project_id = var.gcp_project
  name       = "${var.app_name}-${var.env}"
  region     = var.region
  containers = {
    hello = {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }
  deletion_protection = false
}