terraform {
  required_version = ">= 1.1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
    }
  }
}

provider "google" {
  region      = var.gcp-region
  credentials = file(var.gcp-auth-file)
}
