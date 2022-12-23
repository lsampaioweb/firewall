vm_instance = {
  "01" = {
    state  = "MASTER"
    onboot = true
    vcpus  = 3
    networks = {
      "01" = {
        # WAN
        bridge  = "vmbr0"
        model   = "virtio"
        macaddr = "C6:61:89:85:B9:04"
      },
      "02" = {
        # LAN
        bridge = "vmbr2"
        model  = "virtio"
      },
      "03" = {
        # Sync - Cluster
        bridge = "vmbr3"
        model  = "virtio"
      },
      "04" = {
        # VMs
        bridge = "vmbr4"
        model  = "virtio"
      }
    }
  },
  "02" = {
    state  = "BACKUP"
    onboot = true
    vcpus  = 3
    networks = {
      "01" = {
        # WAN
        bridge  = "vmbr0"
        model   = "virtio"
        macaddr = "B6:00:4C:7F:E1:9A"
      },
      "02" = {
        # LAN
        bridge = "vmbr2"
        model  = "virtio"
      },
      "03" = {
        # Sync - Cluster
        bridge = "vmbr3"
        model  = "virtio"
      },
      "04" = {
        # VMs
        bridge = "vmbr4"
        model  = "virtio"
      }
    }
  }
}
