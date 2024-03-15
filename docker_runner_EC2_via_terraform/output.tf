output "instance_bot" {
  value = yandex_compute_instance.bot.network_interface[0].nat_ip_address
}


output "instance_hello-app" {
  value = yandex_compute_instance.hello-app.network_interface[0].nat_ip_address
}
