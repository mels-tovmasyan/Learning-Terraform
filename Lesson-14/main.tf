provider "aws" {}


resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "mkdir Nano"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "echo https://github.com/mels-tovmasyan >> ping.txt"
  }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command = "ping google.com"
  }
}

