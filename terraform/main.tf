terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
      version = "0.1.0"
    }
  }
}

provider "incus" {
  generate_client_certificates = true
  accept_remote_certificate    = true
}

variable "instance_names" {
  type = list(string)
  default = [
    "icingamaster",
    "icingasat1",
    "icingasat2",
    "icingaep1",
    "icingaep2",
    "icingaep3",
    "icingaep4"
  ]
}

resource "incus_instance" "icinga" {
  count     = length(var.instance_names)
  name      = var.instance_names[count.index]
  image     = "images:ubuntu/20.04/cloud"
  type      = "virtual-machine"
  ephemeral = false

  config = {
    "boot.autostart" = true
  }

  limits = {
    cpu    = 2
    memory = "2GB"
  }

  profiles = ["access"]
}