# Firewall - pfsense CE 2.6
Project that will create the VMs that will work as the Firewall of the HomeLab.

Run these commands on the Proxmox node (just once and on any node):
```bash
  01 - Create the user that Terraform will use.
    pveum user add terraform@pve --firstname "Terraform" --email "lsampaioweb@gmail.com" --comment "The user that Terraform will use."

  02 - Create a password for the user.
    uuid
    pveum passwd terraform@pve

  03 - Create a token for the user.
    pveum user token add terraform@pve terraform --comment "The token that Terraform will use."

  04 - Create a role for the user and set the permissions.
    pveum roleadd Terraform -privs "Datastore.AllocateSpace, Datastore.Audit, Group.Allocate, Pool.Audit, Pool.Allocate, Sys.Audit, Sys.Modify, VM.Allocate, VM.Audit, VM.Clone, VM.Config.CDROM, VM.Config.CPU, VM.Config.Cloudinit, VM.Config.Disk, VM.Config.HWType, VM.Config.Memory, VM.Config.Network, VM.Config.Options, VM.Console, VM.Monitor, VM.PowerMgmt"

  05 - Set the role to the user and API Token.
    pveum acl modify / -user terraform@pve -role Terraform
    pveum acl modify / -token 'terraform@pve!terraform' -role Terraform
```

Run these commands on the computer that is running Terraform:

```bash
  01 - Save the password in the secret manager.
    secret-tool store --label="proxmox-terraform-password" password proxmox-terraform-password

  02 - Save the API token in the secret manager.
    secret-tool store --label="proxmox-terraform-token" token proxmox-terraform-token

  03 - Add the API token of the user to the ~/.bashrc file.
    nano ~/.bashrc
    export PM_API_TOKEN_SECRET=$(secret-tool lookup token "proxmox-terraform-token")

  04 - Run the source command on the terminal.
    source ~/.bashrc  

  05 - Run Terraform to create the VM.
    cd terraform/{staging or production}
    terraform init

    terraform plan
    terraform apply
```

# Created by: 

1. Luciano Sampaio.
