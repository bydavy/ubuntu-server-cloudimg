# Ubuntu cloudimage for Proxmox

This adds some packages to the cloudimage such as:

- qemu-guest-agent

## Import in Proxmox

1. Push the img file to proxmox via SCP.
2. Execute the following in proxmox:
```bash
# Create VM
qm create 9000 --memory 2048 -cores 1 -sockets 1 --net0 virtio,bridge=vmbr0 --name Ubuntu21.10
# Import image
qm importdisk 9000 impish-server-cloudimg-amd64.img local-lvm
# Set disk on VM
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-1
# Set boot order
qm set 9000 --boot c --bootdisk scsi0
# Set serial
qm set 9000 -serial0 socket --vga serial0
# Enable QEMU agent
qm set 9000 -agent 1
# Add cloudinit
qm set 9000 --ide2 local-lvm:cloudinit
# Set cloudinit user
qm set 9000 --ciuser="USER" --cipassword="PWD"
# Set cloudinit ssh key
qm set 9000 --sshkey ~/.ssh/id_rsa.pub
# Set cloudinit ip address
qm set 9000 --ipconfig0 ip=192.168.1.100/24,gw=192.168.1.254
# Increase disk space by 20GB
qm resize 9000 scsi0 +20G
# Create a template from this VM
qm template 9000
```
