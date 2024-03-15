variable "cloud-id" { default = "b1gig0ogqtnk75jde2q8" }
variable "folder-id" { default = "b1g0lfht258dp97s7jir" }
variable "zone-a" { default = "ru-central1-a" }


variable "token" {
  type        = string
  default     = "yc iam create-token"
}
locals {
  app_subnets = [
    { zone = "ru-central1-a", network = "10.0.1.0/24" },
    { zone = "ru-central1-b", network = "10.0.2.0/24" },
    { zone = "ru-central1-c", network = "10.0.3.0/24" }
  ]
}
