variable "wg_admin_password" {
  description = "Admin password for wireguard Web UI"
  type = string
}


## Outputs
output "web_ui" {
  value = module.vpn.web_ui
}

output "dns_ssh_connect" {
  value = module.vpn.dns_ssh_connect
}