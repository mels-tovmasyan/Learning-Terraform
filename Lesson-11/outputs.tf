output "webserver_instance_id" {
  value = aws_instance.webserver.id
}

output "webserver_ip" {
  value = aws_eip.static_ip.public_ip
}

output "webserver_sg_id" {
  value = aws_security_group.webserver_sg.id
}
