######
###
# Creation of ns and mapping domains
###
######

resource "google_cloud_run_domain_mapping" "dns-tenable-front" {
  project  = google_project.tech-test.project_id
  name     = "dwaves-api-test.tonfrere.fr"
  location = google_cloud_run_service.tenable-front-service.location
  metadata {
    namespace = google_project.tech-test.project_id
  }
  spec {
    route_name = google_cloud_run_service.tenable-front-service.name
  }

  depends_on = [
    google_cloud_run_service.tenable-front-service
  ]
}