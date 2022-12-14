module "random-target-node" {
  source = "github.com/lsampaioweb/terraform-random-target-node.git?ref=v1.0"

  for_each = var.vm_instance
}

module "proxmox-vm" {
  source = "github.com/lsampaioweb/terraform-proxmox-vm-module.git?ref=v1.1"

  for_each = var.vm_instance

  target_node = "kvm-0${module.random-target-node[each.key].result}"
  clone       = "pfsense-CE-2.6"
  name        = "stg-firewall-${each.key}"
  onboot      = each.value.onboot
  vcpus       = each.value.vcpus
  networks    = each.value.networks

  description = "pfSense firewall"
  pool        = "Staging"
}

resource "local_file" "ansible_hosts" {
  content = templatefile(local.path_inventory_hosts_template,
    {
      host_list = [
        for key, value in var.vm_instance :
        {
          hostname    = module.proxmox-vm[key].vm_name
          public_ip   = module.proxmox-vm[key].vm_ipv4
          password_id = module.proxmox-vm[key].vm_cloned_from

          state = value.state
        }
      ]
    }
  )
  filename = local.path_inventory_hosts

  directory_permission = "0644"
  file_permission      = "0644"

  provisioner "local-exec" {
    working_dir = local.path_ansible_scripts

    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook provision.yml"
  }

  # provisioner "local-exec" {
  #   when = destroy

  #   working_dir = "../../ansible"

  #   command = "ansible-playbook destroy.yml"
  # }
}
