locals {
  restricted_ssh    = var.restricted_ssh ? "${data.http.my_external_ip[0].response_body}/32" : var.ssh_inbound_cidr
  restricted_web_ui = var.restricted_web_ui ? "${data.http.my_external_ip[0].response_body}/32" : var.web_ui_inbound_cidr
}