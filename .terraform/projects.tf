# ######
###
# Creation of Google Cloud Projects for School purpose
###
######

# Google Projects
resource "google_project" "tech-test" {
  name            = "test-404234565"
  project_id      = var.gcp-project-id
  folder_id       = google_folder.playground.name
  billing_account = var.gcp-billing-account-id
  labels = {
    "managed-by" = "terraform"
    "id"         = "test"
  }
}