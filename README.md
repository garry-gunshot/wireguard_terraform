# Terraform WireGuard
Fast and easy way to setup WireGuard on AWS using terraform.
Based on [wg-easy](https://github.com/wg-easy/wg-easy)

WireGuard® is an extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography. 
It aims to be faster, simpler, leaner, and more useful than IPsec, while avoiding the massive headache. 
It intends to be considerably more performant than OpenVPN. 

## Requirements
* Terraform with version 1.0.0 and above
* AWS credentials. Default location: ~/.aws/credentials
* SSH public and private keys. Default location: ~/.ssh
* WireGuard client (see the links below).

## Setup
### 1. Define admin password for WireGuard Web UI"
```shell
export TF_VAR_wg_admin_password=p@ssw0rd
```
### 2.  Apply terraform code
```shell
terraform init
terraform apply
```
### 3. Log in to WireGuard Web UI
Once terraform apply completed log in to WireGuard Web UI via web_ui URL from Outputs and admin password defined before.
Create new client and export configuration file to your WireGuard client.

### 3. Client install
[Install](https://www.wireguard.com/install/)

## Options

These options can be configured by passing variables to module "vpn"

| Module variable | Default  | Description                                                                        |
| - | - |--------------------------------------------------------------------------------------------------|
| `service_name` | `wireguard` |  Name of the service UI.                                                             |
| `tags` | `` | Tags                                      |
| `restricted_web_ui` | false | If set to true wireguard web ui page will be reachable from your external ip address only. By default it is reachable from everywhere                                  |
| `restricted_ssh` | false | If set to true wireguard web ui page will be reachable from your external ip address only. By default it is reachable from everywhere                                   |
| `web_ui_language` | en | Web UI language. The value must be one of the following: en, ua, tr, no, pl, fr, de, ca, es, ko, vi, nl, is, pt, chs, cht, it, th, hi, ja, si                                 |
| `instance_type` | t3.nano | EC2 instance type                                    |
| `ec2_username` | admin | Default username for debian based AWS AMI. May diffres for any other distributions                                      |

By default VPN server runs in European region (Ireland). To setup it in another region update aws provider of module with provider alias defined in [provider.tf](https://github.com/garry-gunshot/wireguard_terraform/blob/main/provider.tf).

module "vpn" {
  providers = {
    aws = **aws.eu_west_1**
  }
...
}
