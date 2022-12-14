build_name           = "firewall"
vm_id                = 905
vm_name              = "pfsense-CE-2.6"
iso_file             = "pfSense-CE-2.6.0.iso"
template_description = "Firewall pfSense template with the default configuration generated by Packer on {{ isotime `2006-01-02` }}."

network_adapters = {
  "01" = {
    # WAN
    bridge   = "vmbr0"
    model    = "virtio"
    vlan_tag = ""
    firewall = false
  },
  "02" = {
    # LAN
    bridge   = "vmbr2"
    model    = "virtio"
    vlan_tag = ""
    firewall = false
  },
  "03" = {
    # Sync - Cluster
    bridge   = "vmbr3"
    model    = "virtio"
    vlan_tag = ""
    firewall = false
  },
  "04" = {
    # VMs
    bridge   = "vmbr4"
    model    = "virtio"
    vlan_tag = ""
    firewall = false
  }
}
