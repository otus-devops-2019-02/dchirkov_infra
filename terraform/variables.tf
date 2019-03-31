variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "europe-west1"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable public_key_path_appuser1 {
  description = "Path to the public key appuser1 used for provisioner ssh access"
}

variable public_key_path_appuser2 {
  description = "Path to the public key appuser2 used for provisioner ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "Path to the private key used for provisioner ssh access"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
