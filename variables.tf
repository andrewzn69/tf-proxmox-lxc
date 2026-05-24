# container

variable "description" {
  type        = string
  description = "Container description"
  default     = "null"
}

variable "hostname" {
  type        = string
  description = "Container hostname"
}

variable "node_name" {
  type        = string
  description = "Proxmox node to create the container on"
}

variable "os_type" {
  type        = string
  description = "Operating system type"
  default     = "unmanaged"

  validation {
    condition     = contains(["alpine", "archlinux", "centos", "debian", "devuan", "fedora", "gentoo", "nixos", "opensuse", "ubuntu", "unmanaged"], var.os_type)
    error_message = "os_type must be one of: alpine, archlinux, centos, debian, devuan, fedora, gentoo, nixos, opensuse, ubuntu, unmanaged"
  }
}

variable "tags" {
  type        = list(string)
  description = "List of tags to assign to the container"
  default     = []
}

variable "template_datastore_id" {
  type        = string
  description = "Proxmox datastore to download the container template into"
  default     = "local"
}

variable "template_url" {
  type        = string
  description = "URL of the LXC container template to download"

  validation {
    condition     = can(regex("^https?://", var.template_url))
    error_message = "template_url must be a valid http or https URL"
  }
}

variable "vm_id" {
  type        = number
  description = "Container ID, null for auto-assignment"
  default     = null
}

# cpu

variable "cpu_cores" {
  type        = number
  description = "Number of CPU cores"
  default     = 1

  validation {
    condition     = var.cpu_cores >= 1
    error_message = "cpu_cores must be at least 1"
  }
}

# disk

variable "datastore_id" {
  type        = string
  description = "Proxmox storage pool for the root filesystem"
  default     = "local-lvm"
}

variable "disk_size" {
  type        = number
  description = "Root filesystem size in GB"
  default     = 4

  validation {
    condition     = var.disk_size >= 1
    error_message = "disk_size must be at least 1"
  }
}

# features

variable "nesting" {
  type        = bool
  description = "Whether to enable container nesting"
  default     = false
}

variable "unprivileged" {
  type        = bool
  description = "Whether the container runs as unprivileged on the host"
  default     = true
}

# memory

variable "memory" {
  type        = number
  description = "Dedicated memory in MB"
  default     = 512

  validation {
    condition     = var.memory >= 16
    error_message = "memory must be at least 16 MB"
  }
}

variable "swap" {
  type        = number
  description = "Swap size in MB"
  default     = 0

  validation {
    condition     = var.swap >= 0
    error_message = "swap must be 0 or greater"
  }
}

# network

variable "bridge" {
  type        = string
  description = "Network bridge for the container"
  default     = "vmbr0"
}

variable "gateway_ip" {
  type        = string
  description = "IPv4 gateway, required when ip_address is not dhcp"
  default     = null
}

variable "ip_address" {
  type        = string
  description = "IPv4 address in CIDR notation or dhcp"
  default     = "dhcp"
}

variable "network_interface_name" {
  type        = string
  description = "Name of the network interface inside the container"
  default     = "eth0"
}

# user

variable "password" {
  type        = string
  description = "Root account password"
  default     = null
  sensitive   = true
}

variable "ssh_keys" {
  type        = list(string)
  description = "SSH public keys for the root account"
  default     = []
}
