resource "yandex_compute_image" "ubuntu" {
  source_family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "app" {
  name                      = "app"
  platform_id               = "standard-v3"
  zone                      = var.default-zone
  service_account_id        = var.sa-id
  allow_stopping_for_update = true
  hostname                  = "app"
  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu.id
      size     = 15
    }
  }
  network_interface {
    subnet_id = var.subnet-id
    nat       = true
    ipv4      = true
    ipv6      = false
  }
  resources {
    cores  = 2
    memory = 2
  }

  metadata = {
    ssh-keys           = "username:${file("~/.ssh/id_rsa.pub")}"
    user-data          = "${file("./userdata.yaml")}"
    serial-port-enable = 1
  }
}
