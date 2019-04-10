variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for Reddit DB"
  default = "reddit-db-base"
}

variable zone {
  description = "Zone"
  default = "europe-west1-b"
}

variable name {
  description = "Name instance"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}
