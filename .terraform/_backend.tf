terraform {
  backend "gcs" {
    bucket = "tech-test-gcp-terraform-state"
    prefix = "terraform-state"
  }
}

resource "google_storage_bucket" "terraform-state" {
  project       = google_project.tech-test.project_id
  name          = "tech-test-gcp-terraform-state"
  location      = var.gcp-region
  storage_class = "REGIONAL"

  versioning {
    enabled = true
  }

  labels = {
    "managed-by" = "terraform"
    "status"     = "critical"
    "id"         = "test"
  }
}