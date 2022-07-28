terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.default-cloud-id
  folder_id = var.default-folder-id
  zone      = var.default-zone
}
