resource "google_compute_instance" "db" {
  name         = "${var.name}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type = "ssh"
    user = "appuser"
    #agent = true
    #agent_identity = "yt4SbTtHFAYhnKsYyxTtZ1EA9ROvyqpKKEhGe4W1vgI"
    agent = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sed -i s/127.0.0.1/0.0.0.0/ /etc/mongod.conf",
      "sudo systemctl restart mongod"
    ]
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
  source_tags = ["reddit-app"]
  target_tags = ["reddit-db"]
}
