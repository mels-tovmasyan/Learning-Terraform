// Print all info of users
output "aws_iam_users_all" {
  value = aws_iam_user.users
}

// Print user_ids of all(*) users
output "aws_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

// Print arns of users
output "iam_users_custom_list" {
  value = [
    for user in aws_iam_user.users :
    "${user.name}'s ARN is: ${user.arn}"
  ]
}

// Print users unique ids
output "iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.unique_id => user.id
  }
}

// Print only 4 characters long names
output "custom_if_length" {
  value = [
    for x in aws_iam_user.users :
    x.name
    if length(x.name) == 4
  ]
}


// print IPs and ids of servers
output "aws_instance_info" {
  value = [
    for x in aws_instance.servers :
    "${x.id}'s public ip is: ${x.public_ip}"
  ]
}
