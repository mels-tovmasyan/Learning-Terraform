#!/bin/bash
yum update -y
yum install httpd.x86_64 -y
systemctl start httpd.service
systemctl enable httpd.service
cat <<EOF > /var/www/html/index.html

<html>
<h2>Build with Terraform.</h2><br>
Owner ${f_name} ${l_name}<br><br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br><br>
%{ endfor ~}

</html>
EOF