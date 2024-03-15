resource "yandex_vpc_network" "network" {
  name        = "my_network-hello"
  description = "my-network created via terraform"
}
resource "yandex_vpc_subnet" "subnet" {
  count          = length(local.app_subnets)
  name           = join("_", ["my_subnet_hello", count.index])
  zone           = element(local.app_subnets.*.zone, count.index)
  v4_cidr_blocks = [element(local.app_subnets.*.network, count.index)]
  network_id     = yandex_vpc_network.network.id
}
resource "yandex_compute_image" "ubuntu" {
  source_family = "ubuntu-2004-lts"
}
resource "yandex_compute_instance" "bot" {
  name                      = "bot"
  platform_id               = "standard-v3"
  zone                      = var.zone-a
  # service_account_id        = var.sa-id
  allow_stopping_for_update = true
  hostname                  = "bot"
  labels                    = {os = "bot"}
  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu.id
      size     = 15
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[0].id 
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

resource "yandex_compute_instance" "hello-app" {
  name                      = "hello-app"
  platform_id               = "standard-v3"
  zone                      = var.zone-a
  # service_account_id        = var.sa-id
  allow_stopping_for_update = true
  hostname                  = "hello-app"
  labels                    = {os = "hello-app"}
  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.ubuntu.id
      size     = 15
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[0].id 
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
