terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.13"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://kvm.homelab:8006/api2/json"
  pm_api_token_id = "terraform@pve!terraform"
}
