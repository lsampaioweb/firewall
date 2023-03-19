# Firewall - pfsense CE 2.6
Project that will create the VMs that will work as the Firewall of the HomeLab.

This project uses my Terraform Module. It has some commands that should be executed.

Run these commands on the computer that is running Terraform:
```bash
  01 - Initialize the project
    cd terraform/
    terraform init

  02 - Run Terraform to create the VM. This bash is just a helper.
    ./tf.sh plan staging
    ./tf.sh apply staging -auto-approve
    ./tf.sh destory staging
```

# Created by: 

1. Luciano Sampaio.
