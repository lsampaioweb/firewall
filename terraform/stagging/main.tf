module "random-target-node" {
  source = "../modules/random-target-node"

  for_each = var.vm_instance
}

module "proxmox-ubuntu-22-04" {
  source = "../modules/proxmox-ubuntu-22-04"

  for_each = var.vm_instance

  target_node = "kvm-0${module.random-target-node[each.key].result}"
  clone       = "ubuntu-22-04-server-std-docker"
  name        = "stg-firewall-${each.key}"
  onboot      = each.value.onboot
  vcpus       = each.value.vcpus

  description = "pfSense firewall"
  pool        = "Stagging"
}

resource "local_file" "ansible_hosts" {
  content = templatefile(local.path_inventory_hosts_template,
    {
      host_list = [
        for key, value in var.vm_instance :
        {
          hostname    = module.proxmox-ubuntu-22-04[key].vm_name
          public_ip   = module.proxmox-ubuntu-22-04[key].vm_ipv4
          password_id = module.proxmox-ubuntu-22-04[key].vm_cloned_from

          state          = value.state
          priority       = value.priority
        }
      ]
    }
  )
  filename = local.path_inventory_hosts

  directory_permission = "0644"
  file_permission      = "0644"

  provisioner "local-exec" {
    working_dir = local.path_ansible_scripts

    command = "ansible-playbook provision.yml"
  }

  # provisioner "local-exec" {
  #   when = destroy

  #   working_dir = local.path_ansible_scripts

  #   command = "ansible-playbook destroy.yml"
  # }
}
