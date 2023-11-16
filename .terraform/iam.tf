# Allow only the Cloud Run service account to invoke the service
resource "google_cloud_run_service_iam_policy" "tenable-back-service-iam-policy" {
  project  = google_cloud_run_service.tenable-back-service.project
  location = google_cloud_run_service.tenable-back-service.location
  service  = google_cloud_run_service.tenable-back-service.name

  policy_data = jsonencode({
    bindings = [
      {
        role = "roles/run.invoker"
        members = [
          "serviceAccount:test-to-remove@${google_project.tech-test.project_id}.iam.gserviceaccount.com",
          "serviceAccount:119817695890-compute@developer.gserviceaccount.com"
        ]
      }
    ]
  })

  depends_on = [
    google_cloud_run_service.tenable-back-service
  ]
}

# Allow unauthenticated users to invoke the service
resource "google_cloud_run_service_iam_member" "iam-run-tenable-front" {
  project  = google_cloud_run_service.tenable-front-service.project
  service  = google_cloud_run_service.tenable-front-service.name
  location = google_cloud_run_service.tenable-front-service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
  depends_on = [
    google_cloud_run_service.tenable-front-service
  ]
}

# # Allow unauthenticated users to invoke the service
# resource "google_cloud_run_service_iam_member" "iam-run-tenable-back" {
#   project  = google_cloud_run_service.tenable-back-service.project
#   service  = google_cloud_run_service.tenable-back-service.name
#   location = google_cloud_run_service.tenable-back-service.location
#   role     = "roles/run.invoker"
#   member   = "serviceAccount:${google_cloud_run_service.tenable-back-service.project_number}-compute@developer.gserviceaccount.com"
#   depends_on = [
#     google_cloud_run_service.tenable-back-service
#   ]
# }