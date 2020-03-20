resource "null_resource" "copy-files" {
  depends_on = [aws_instance.ghostapp]

  connection {
    type     = "ssh"
    host     = aws_instance.ghostapp.public_ip
    user     = "ubuntu"
    private_key = file("ghost-keypair.pem")
    timeout = "10m"
  }

  provisioner "file" {
    source      = "node-and-mariadb-secure-install.sh"
    destination = "/tmp/node-and-mariadb-secure-install.sh"
  }

  provisioner "file" {
    source      = "ghost-install.sh"
    destination = "/tmp/ghost-install.sh"
  }
}


resource "null_resource" "install-node-mariadb" {
  depends_on = [null_resource.copy-files]

  connection {
    type     = "ssh"
    host     = aws_instance.ghostapp.public_ip
    user     = "ubuntu"
    private_key = file("ghost-keypair.pem")
    timeout = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/node-and-mariadb-secure-install.sh",
      "/bin/bash /tmp/node-and-mariadb-secure-install.sh > /tmp/node-and-mariadb-secure-install.log",
    ]
  }

}

resource "null_resource" "ghost-install" {
  depends_on = [null_resource.install-node-mariadb]

  connection {
    type     = "ssh"
    host     = aws_instance.ghostapp.public_ip
    user     = "ubuntu"
    private_key = file("ghost-keypair.pem")
    timeout = "10m"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ghost-install.sh",
      "/bin/bash /tmp/ghost-install.sh > /tmp/ghost-install.log",
    ]
  }

}

