data "template_file" "puma" {
  template = "${file("${path.module}/files/puma.service")}"
  vars = {
    db_internal_ip = "${var.db_internal_ip}:27017"
  }
}

resource "google_compute_instance" "app" {
  name         = "${var.name}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

//  connection {
//    type = "ssh"
//    user = "appuser"
//    #agent = true
//    #agent_identity = "yt4SbTtHFAYhnKsYyxTtZ1EA9ROvyqpKKEhGe4W1vgI"
//    agent = false
//    private_key = "${file(var.private_key_path)}"
//  }

//  provisioner "file" {
//    content = "${data.template_file.puma.rendered}"
//    destination = "/tmp/puma.service"
//  }

//  provisioner "remote-exec" {
//    script = "${path.module}/files/deploy.sh"
//  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["reddit-app"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
