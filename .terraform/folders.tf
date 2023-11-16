######
###
# Creation of Google Cloud Folder
###
######

resource "google_folder" "playground" {
  display_name = "Playground"
  parent       = "organizations/${var.gcp-org-id}"
}

