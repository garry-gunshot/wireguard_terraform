data "aws_ami" "debian" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["debian-12-amd64-20240717-1811"]
  }
}

data "aws_region" "current" {}

data "http" "my_external_ip" {
  count = var.restricted_web_ui ? 1 : 0
  url   = "http://ifconfig.me"
}
