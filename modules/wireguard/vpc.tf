### VPC
module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "5.17.0"
  name           = var.service_name
  cidr           = "10.0.0.0/16"
  azs            = ["${data.aws_region.current.id}a"]
  public_subnets = ["10.0.0.0/24"]
  tags           = var.tags
}

resource "aws_security_group" "allow_wg" {
  name   = "${var.service_name}-allow"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_wg.id
  cidr_ipv4         = local.restricted_ssh
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_wg_udp" {
  security_group_id = aws_security_group.allow_wg.id
  cidr_ipv4         = var.wg_inbound_cidr
  from_port         = var.wg_port
  ip_protocol       = "udp"
  to_port           = var.wg_port
}
resource "aws_vpc_security_group_ingress_rule" "allow_wg_tcp" {
  security_group_id = aws_security_group.allow_wg.id
  cidr_ipv4         = local.restricted_web_ui
  from_port         = var.web_ui_port
  ip_protocol       = "tcp"
  to_port           = var.web_ui_port
}
resource "aws_vpc_security_group_egress_rule" "allow_outbound" {
  security_group_id = aws_security_group.allow_wg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}