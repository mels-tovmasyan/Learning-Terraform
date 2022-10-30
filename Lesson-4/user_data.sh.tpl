#!/bin/bash
yum update -y
yum install httpd.x86_64 -y
systemctl start httpd.service
systemctl enable httpd.service
cat <<EOF > /var/www/html/index.html

<html>
<h2>Build with Terraform</h2>
Owner ${f_name} ${l_name}<br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}

</html>
EOF