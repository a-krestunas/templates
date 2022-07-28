variable "default-folder-id" { default = "" }
variable "default-cloud-id" { default = "" }
variable "default-zone" { default = "" }
variable "network-id" { default = "" }
variable "subnet-id" { default = "" }
variable "sa-id" { default = "" }

variable "token" {
  type        = string
  description = "generate token with YC CLI (yc --profile <your_profile_name> iam create token) and paste into default"
  default     = ""
}
