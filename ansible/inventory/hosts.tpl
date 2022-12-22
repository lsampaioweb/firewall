[master]
%{ for item in host_list ~}
${item.hostname} ansible_host=${item.public_ip} password_id=${item.password_id} hostname=${item.hostname} state=${item.state}
%{ endfor ~}
