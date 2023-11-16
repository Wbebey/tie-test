######
###
# Networking
###
######

resource "google_compute_network" "vpc-network" {
  project = google_project.tech-test.project_id
  name    = "tenable-vpc-network"
  # auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "tenable-front-subnet" {
  name          = "front-subnet"
  project       = google_project.tech-test.project_id
  network       = google_compute_network.vpc-network.name
  ip_cidr_range = "10.0.0.0/28"

  depends_on = [google_compute_network.vpc-network]
}

resource "google_compute_subnetwork" "tenable-back-subnet" {
  name          = "back-subnet"
  project       = google_project.tech-test.project_id
  network       = google_compute_network.vpc-network.name
  ip_cidr_range = "10.0.1.0/28"

  depends_on = [google_compute_network.vpc-network]
}

resource "google_vpc_access_connector" "front-connector" {
  name    = "front-vpcconn"
  project = google_project.tech-test.project_id
  region  = var.gcp-region
  subnet {
    name = google_compute_subnetwork.tenable-front-subnet.name
  }

  depends_on = [google_compute_network.vpc-network]
}

resource "google_vpc_access_connector" "back-connector" {
  name    = "back-vpcconn"
  project = google_project.tech-test.project_id
  region  = var.gcp-region
  subnet {
    name = google_compute_subnetwork.tenable-back-subnet.name
  }

  depends_on = [google_compute_network.vpc-network]
}