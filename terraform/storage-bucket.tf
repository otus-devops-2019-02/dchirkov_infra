provider "google" {
  version = "2.3.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.1.1"
  name = "${var.storage-bucket}"
  force_destroy = true
}

output storage-bucket_url {
  value = "${module.storage-bucket.url}"
}
