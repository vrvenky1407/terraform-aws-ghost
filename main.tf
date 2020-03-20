provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "ghostapp" {
  ami           = var.ami-id
  availability_zone = var.availability-zone
  instance_type = var.instance-type
  subnet_id = var.subnet-id
  associate_public_ip_address = true
  vpc_security_group_ids = var.security-groups
  key_name = var.key-name

  root_block_device  {
    volume_type = "gp2"
    volume_size = 30
  }

  tags = {
     Name = "ghost-app"
     env  = "LAB"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

}


