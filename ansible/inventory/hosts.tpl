[ControlMachine]
localhost ansible_connection=local

[target]
template ansible_host=<ip>

[target:vars]
hostname=pfsense-CE-2.6
ansible_python_interpreter=/usr/local/bin/python3.8

[proxmox]
kvm-01 ansible_host=192.168.0.11
kvm-02 ansible_host=192.168.0.12
kvm-03 ansible_host=192.168.0.13
kvm-04 ansible_host=192.168.0.14
kvm-05 ansible_host=192.168.0.15
kvm-06 ansible_host=192.168.0.16
kvm-07 ansible_host=192.168.0.17

[proxmox:vars]
ansible_python_interpreter=/usr/bin/python3.9

[master]
%{ for item in host_list ~}
%{ if item.state == "MASTER" ~}
${item.hostname} ansible_host=${item.public_ip} hostname=${item.hostname} password_id=${item.password_id} state=${item.state}
%{ endif ~}
%{ endfor ~}

[backup]
%{ for item in host_list ~}
%{ if item.state == "BACKUP" ~}
${item.hostname} ansible_host=${item.public_ip} hostname=${item.hostname} password_id=${item.password_id} state=${item.state}
%{ endif ~}
%{ endfor ~}

[pfsense:children]
master
backup

[pfsense:vars]
ansible_python_interpreter=/usr/local/bin/python3.8
