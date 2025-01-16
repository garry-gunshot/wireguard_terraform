variable "service_name" {
  description = "Name of the service"
  type    = string
  default = "wireguard"
}

variable "tags" {
  type = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "wg_admin_password" {
  description = "Admin password for wireguard Web UI"
  type = string
}

variable "ec2_username" {
  description = "Default username for debian based AWS AMI. May diffres for any other distributions"
  type    = string
  default = "admin"
}

variable "instance_type" {
  description = "The low-cost EC2 instance: about $3 per month"
  type        = string
  default     = "t3.nano"
}

variable "playbook_file" {
  type    = string
  default = "files/playbook_debian.yml"
}

variable "ssh_public_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "wg_docker_image" {
  type    = string
  default = "ghcr.io/wg-easy/wg-easy:14"
}

variable "restricted_web_ui" {
  description = "If set to true wireguard web ui page will be reachable from your external ip address only. By default it is reachable from everywhere"
  type    = bool
  default = "false"
}

variable "restricted_ssh" {
  description = "If set to true wireguard web ui page will be reachable from your external ip address only. By default it is reachable from everywhere"
  type    = bool
  default = "false"
}

variable "web_ui_language" {
  description = "Web UI language" 
  type    = string
  default = "en"
  validation {
    condition     = contains(["en", "ua", "tr", "no", "pl", "fr", "de", "ca", "es", "ko", "vi", "nl", "is", "pt", "chs", "cht", "it", "th", "hi", "ja", "si"], var.web_ui_language)
    error_message = "The value must be one of the following: en, ua, tr, no, pl, fr, de, ca, es, ko, vi, nl, is, pt, chs, cht, it, th, hi, ja, si."
  }
}


variable "web_ui_port" {
  type    = number
  default = 51821
}

variable "wg_port" {
  type    = number
  default = 51820
}

variable "ssh_inbound_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "web_ui_inbound_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "wg_inbound_cidr" {
  type    = string
  default = "0.0.0.0/0"
}


## Outputs
output "web_ui" {
  value = "http://${module.ec2.public_dns}:51821"
}

output "admin_password" {
  value = bcrypt(var.wg_admin_password)
}

output "dns_ssh_connect" {
  value = "ssh ${var.ec2_username}@${module.ec2.public_dns}"
}