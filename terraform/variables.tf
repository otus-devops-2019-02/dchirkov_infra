variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default = "europe-west1"
}

variable storage-bucket {
  type = "list"
  description = "Storage bucket"
}
