[master]
%{ for item in hosts_list ~}
%{ if item.state == "MASTER" ~}
${item.hostname} ansible_host=${item.public_ip} password_id=${item.password_id} hostname=${item.hostname} state=${item.state} priority=${item.priority}
%{ endif ~}
%{ endfor ~}

[backup]
%{ for item in hosts_list ~}
%{ if item.state == "BACKUP" ~}
${item.hostname} ansible_host=${item.public_ip} password_id=${item.password_id} hostname=${item.hostname} state=${item.state} priority=${item.priority}
%{ endif ~}
%{ endfor ~}
