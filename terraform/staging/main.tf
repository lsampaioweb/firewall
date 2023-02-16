module "random_target_node" {
  source  = "lsampaioweb/target-node/random"
  version = "1.0.3"

  for_each = var.vm_instance
}

module "proxmox_vm" {
  source  = "lsampaioweb/vm-qemu/proxmox"
  version = "1.0.7"

  for_each = var.vm_instance

  target_node = "kvm-${format("%.2d", module.random_target_node[each.key].result)}"
  clone       = (each.value.clone != null) ? each.value.clone : "pfsense-CE-2.6"
  name        = "${var.environment_short_name}-firewall-${each.key}"
  onboot      = each.value.onboot
  startup     = each.value.startup
  vcpus       = each.value.vcpus
  networks    = each.value.networks

  description = "pfSense firewall - ${var.environment}."
  pool        = var.environment
}

resource "local_file" "ansible_hosts" {
  content = templatefile(local.path_inventory_hosts_template,
    {
      host_list = [
        for key, value in var.vm_instance :
        {
          hostname    = module.proxmox_vm[key].vm_name
          public_ip   = module.proxmox_vm[key].vm_ipv4
          password_id = module.proxmox_vm[key].vm_cloned_from

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
