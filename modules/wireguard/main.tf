module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.7.1"
  name                        = var.service_name
  ami                         = data.aws_ami.debian.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ec2.id
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.allow_wg.id]
  associate_public_ip_address = true
  subnet_id                   = module.vpc.public_subnets[0]
  tags                        = var.tags
}

resource "aws_key_pair" "ec2" {
  key_name   = "${var.service_name}-ec2-key"
  public_key = file(var.ssh_public_key)
}

resource "time_sleep" "wait_15_seconds" {
  # EC2 instance needs some time to run SSH server
  create_duration = "15s"
}

resource "ansible_playbook" "playbook" {
  depends_on = [
    module.ec2, 
    time_sleep.wait_15_seconds
    ]
  playbook   = var.playbook_file
  name       = module.ec2.public_dns
  extra_vars = {
    ansible_hostname             = module.ec2.public_dns
    ansible_user                 = var.ec2_username,
    ansible_ssh_private_key_file = var.ssh_private_key,
    wg_docker_image              = var.wg_docker_image
    wg_admin_password            = bcrypt(var.wg_admin_password)
    web_ui_language              = var.web_ui_language
    web_ui_port                  = var.web_ui_port
    wg_port                      = var.wg_port

  }
  replayable = true
}

resource "ansible_host" "ec2" {
  name   = module.ec2.public_dns
  groups = ["ec2"]
  variables = {
    ansible_user                 = var.ec2_username,
    ansible_ssh_private_key_file = var.ssh_private_key,
    ansible_python_interpreter   = "/usr/bin/python3",
  }
}



