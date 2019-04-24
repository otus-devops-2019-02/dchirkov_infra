provider "google" {
  version = "2.3.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  name             = "reddit-app-prod"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  private_key_path = "${var.private_key_path}"
  db_internal_ip   = "${module.db.db_internal_ip}"
}

module "db" {
  source           = "../modules/db"
  name             = "reddit-db-prod"
  public_key_path  = "${var.public_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  private_key_path = "${var.private_key_path}"
}

module "vpc" {
  source        = "../modules/vpc"
//  source_ranges = ["94.158.100.200/32"]
}
