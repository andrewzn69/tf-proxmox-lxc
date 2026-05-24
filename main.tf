locals {
  is_dhcp = var.ip_address == "dhcp"
}

resource "proxmox_download_file" "template" {
  node_name    = var.node_name
  content_type = "vztmpl"
  datastore_id = var.template_datastore_id
  file_name    = basename(var.template_url)
  url          = var.template_url
}

resource "proxmox_virtual_environment_container" "this" {
  description  = var.description
  node_name    = var.node_name
  vm_id        = var.vm_id
  unprivileged = var.unprivileged
  tags         = var.tags

  features {
    nesting = var.nesting
  }

  cpu {
    cores = var.cpu_cores
  }

  memory {
    dedicated = var.memory
    swap      = var.swap
  }

  disk {
    datastore_id = var.datastore_id
    size         = var.disk_size
  }

  initialization {
    hostname = var.hostname

    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = local.is_dhcp ? null : var.gateway_ip
      }
    }

    user_account {
      keys     = var.ssh_keys
      password = var.password
    }
  }

  network_interface {
    name   = var.network_interface_name
    bridge = var.bridge
  }

  operating_system {
    template_file_id = proxmox_download_file.template.id
    type             = var.os_type
  }
}
