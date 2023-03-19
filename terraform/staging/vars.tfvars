vm_instance = {
  "01" = {
    # VM
    networks = {
      "01" = {
        # WAN
        bridge  = "vmbr0"
        macaddr = "C6:61:89:85:B9:04"
      },
      "02" = {
        # LAN
        bridge = "vmbr2"
      },
      "03" = {
        # Sync - Cluster
        bridge = "vmbr3"
      }
    }
    
    # Project
    state  = "MASTER"
  },
  "02" = {
    # VM
    networks = {
      "01" = {
        # WAN
        bridge  = "vmbr0"
        macaddr = "B6:00:4C:7F:E1:9A"
      },
      "02" = {
        # LAN
        bridge = "vmbr2"
      },
      "03" = {
        # Sync - Cluster
        bridge = "vmbr3"
      }
    }

    # Project
    state  = "BACKUP"
  }
}
