output "id" {
  description = "Container VM ID"
  value       = proxmox_virtual_environment_container.this.vm_id
}

output "ipv4_address" {
  description = "IPv4 address of the container"
  value       = proxmox_virtual_environment_container.this.ipv4
}
