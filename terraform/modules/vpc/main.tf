resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  description = "Allow SSH from anywhere"
  priority    = 65534
  network     = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["${var.source_ranges}"]
}

resource "google_compute_firewall" "firewall_http" {
  name        = "reddit-allow-http"
  description = "Allow HTTP from anywhere"
  priority    = 1000
  network     = "default"
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["${var.source_ranges}"]
}
