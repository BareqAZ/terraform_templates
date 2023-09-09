resource "aws_key_pair" "default" {
  key_name   = var.owner
  public_key = file("~/.ssh/aws_key.pub")

  tags = {
    owner = var.owner
  }
}

resource "aws_instance" "default" {
  instance_type          = "t3.micro"
  ami                    = data.aws_ami.default.id
  key_name               = aws_key_pair.default.id
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id              = aws_subnet.default.id
  user_data              = file("./after_init.tpl")

  root_block_device {
    volume_size = 12
  }

  provisioner "local-exec" {
    command = templatefile("${var.local_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ec2-user",
      identityfile = "~/.ssh/aws_key"
    })
    interpreter = var.local_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]
  }

  tags = {
    Name  = var.name
    owner = var.owner
  }
}

output "IPs" {
  value = aws_instance.default.public_ip
}
