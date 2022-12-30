variable "boot_wait" {
  description = "Gives the virtual machine some time to actually load the ISO."
  type        = string
  default     = "40s"
}

locals {
  boot_command = [
    # Accept copyright.
    "<enter><wait2s>",
    # Options: Install, Rescue Shell, Recover config.xml
    # Enter to install.
    "<enter><wait2s>",
    # Select keyboard layout, default US.
    "<enter><wait2s>",
    # Options: Auto (ZFS), Auto (UFS) Bios, Auto (UFS) UEFI, Manual, Shell
    # Enter for Auto (ZFS).
    "<enter><wait2s>",
    # Enter to proceed with installation.
    "<enter><wait2s>",
    # Select stripe with no redundancy.
    "<enter><wait2s>",
    # Select the vtbd0 as the block Device.
    "<spacebar><wait1s><enter><wait2s>",
    # Confirm the ZFS configuration.
    "<left><wait1s><enter><wait40s>",
    # Manual Configuration menu
    # Default No, Left for Yes
    "<enter><wait2s>",
    # Enter to reboot.
    "<enter><wait60>",
    # n to setting up vlan.
    "n<enter><wait2s>",
    # vtnet0 for WAN interface name.
    "vtnet0<enter><wait2s>",
    # blank for LAN interface.
    "<enter><wait2s>y<enter><wait50s>",
    # 14 -> y to enable sshd.
    "14<enter><wait2s>y<enter><wait2s>",
    # 8 -> Enter shell.
    "8<enter><wait2s>",
    # Instala o pacote do qemu no shell.
    "pkg update<enter><wait10s>",
    "pkg install -y sudo<enter><wait10s>",
    "pkg install -y qemu-guest-agent<enter><wait10s>",
    "service qemu-guest-agent onestart<enter><wait2s>",
    # Change the password.
    "passwd admin<enter><wait1s>",
    "${local.ssh_password}<enter><wait1s>",
    "${local.ssh_password}<enter><wait1s>",
    # Return to the main menu.
    "exit<enter><wait2s>"
  ]
}

variable "http_directory" {
  description = "Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine."
  type        = string
  default     = "iso/autoinstall"
}
