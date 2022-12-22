vm_instance = {
  "01" = {
    onboot = true
    vcpus  = 3
    state  = "MASTER"
  },
  "02" = {
    onboot = true
    vcpus  = 3
    state  = "BACKUP"
  }
}

networks = {
  "01" = {
    # WAN
    model    = "virtio"
    bridge   = "vmbr0"
    tag      = -1
    firewall = false
  },
  "02" = {
    # LAN
    model    = "virtio"
    bridge   = "vmbr3"
    tag      = -1
    firewall = false
  },
  "03" = {
    # Sync
    model    = "virtio"
    bridge   = "vmbr4"
    tag      = -1
    firewall = false
  }
}
