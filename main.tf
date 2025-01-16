module "vpn" {
  providers = {
    aws = aws.eu_west_1
  }
  source            = "./modules/wireguard"
  wg_admin_password = var.wg_admin_password
}

