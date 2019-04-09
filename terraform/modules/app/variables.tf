variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for Reddit App"
  default = "reddit-app-base"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable name {
  description = "Name instance"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable db_internal_ip {
  description = "Internal DB IP"
}
