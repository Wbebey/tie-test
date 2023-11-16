######
###
# Firewall
###
######

resource "google_compute_firewall" "allow-front" {
  name    = "allow-front"
  project = google_project.tech-test.project_id
  network = google_compute_network.vpc-network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-back" {
  name    = "allow-back"
  project = google_project.tech-test.project_id
  network = google_compute_network.vpc-network.name

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  # Define IP ranges or subnetworks that can access the API (e.g., frontend subnet)
  source_ranges = [google_compute_subnetwork.tenable-front-subnet.ip_cidr_range]

  depends_on = [google_compute_subnetwork.tenable-front-subnet]
}