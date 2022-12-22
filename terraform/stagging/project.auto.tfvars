vm_instance = {
  "01" = {
    state  = "MASTER"
    onboot = true
    vcpus  = 3
    networks = {
      "01" = {
        # WAN
        model   = "virtio"
        bridge  = "vmbr0"
        macaddr = "C6:61:89:85:B9:04"
      },
      "02" = {
        # LAN
        model  = "virtio"
        bridge = "vmbr3"
      },
      "03" = {
        # Sync
        model  = "virtio"
        bridge = "vmbr4"
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
        model   = "virtio"
        bridge  = "vmbr0"
        macaddr = "B6:00:4C:7F:E1:9A"
      },
      "02" = {
        # LAN
        model  = "virtio"
        bridge = "vmbr3"
      },
      "03" = {
        # Sync
        model  = "virtio"
        bridge = "vmbr4"
      }
    }
  }
}
