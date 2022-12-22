[master]
%{ for item in host_list ~}
${item.hostname} ansible_host=${item.public_ip} password_id=${item.password_id} hostname=${item.hostname} state=${item.state}
%{ endfor ~}

[all:vars]
host_key_checking = False
ansible_python_interpreter=/usr/local/bin/python3.8