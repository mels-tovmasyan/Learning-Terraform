output "server_info" {
  value = "Webserver(${aws_instance.secured_server.id}) IP is ${aws_instance.secured_server.public_ip}"
}

output "public_ip" {
  value = aws_instance.secured_server.public_ip
}
