######
###
# Creation of Google Cloud run ressources
###
######

# Cloud Run for tenable-api
resource "google_cloud_run_service" "tenable-back-service" {
  project  = google_project.tech-test.project_id
  name     = "tenable-back"
  location = var.gcp-region

  metadata {
    namespace = google_project.tech-test.project_id
    labels = {
      "id"         = "test"
      "managed-by" = "terraform"
    }

    annotations = {
      "run.googleapis.com/ingress" = "all"
      # limit scale up to prevent any cost blow outs!
      "autoscaling.knative.dev/maxScale" = "2"
      # use the VPC Connector above
      "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.front-connector.name
      # all egress from the service should go through the VPC Connector
      "run.googleapis.com/vpc-access-egress" = "all"
    }
  }

  template {
    spec {
      containers {
        image = "wbarmis/tenable-back:latest"
        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_compute_subnetwork.tenable-back-subnet]
}

# Cloud Run for tenable-front
resource "google_cloud_run_service" "tenable-front-service" {
  project  = google_project.tech-test.project_id
  name     = "tenable-front"
  location = var.gcp-region

  metadata {
    namespace = google_project.tech-test.project_id
    labels = {
      "id"         = "test"
      "managed-by" = "terraform"
    }

    annotations = {
      "run.googleapis.com/ingress" = "all"
      # limit scale up to prevent any cost blow outs!
      "autoscaling.knative.dev/maxScale" = "2"
      # use the VPC Connector above
      "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.front-connector.name
      # all egress from the service should go through the VPC Connector
      "run.googleapis.com/vpc-access-egress" = "all"
    }
  }

  template {
    spec {
      containers {
        # image = "gcr.io/cloudrun/hello"
        image = "wbarmis/tenable-front:latest"

        ports {
          container_port = 443
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_compute_subnetwork.tenable-front-subnet]
}