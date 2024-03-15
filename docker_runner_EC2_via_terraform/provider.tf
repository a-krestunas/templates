terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">=0.112.0"
    }
  }
}
provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud-id
  folder_id = var.folder-id
  zone      = var.zone-a
}