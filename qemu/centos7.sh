#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

info() { printf "%b[info]%b %s\n" '\e[0;32m\033[1m' '\e[0m' "$*" >&2; }
warn() { printf "%b[warn]%b %s\n" '\e[0;33m\033[1m' '\e[0m' "$*" >&2; }
erro() { printf "%b[erro]%b %s\n" '\e[0;31m\033[1m' '\e[0m' "$*" >&2; }

# sudo yum list installed > packages.txt
# sudo yum -y install $(cat packages.txt)

vm=centos7
vm_hostname=$vm
vm_instance_id=$vm
vm_user=$(id -un)
vm_mem=$((24 * 1024))
vm_cpus=$(nproc)

vmdir=/var/lib/libvirt/images/$vm
image=CentOS-7-x86_64-GenericCloud.qcow2

if [ ! -f $image ]; then
    info "Download CentOS 7 cloud image from https://cloud.centos.org/centos/7/images/"
    wget https://cloud.centos.org/centos/7/images/$image.xz

    info "Extract the image"
    xz -d -v $image.xz
fi

sudo mkdir -vp $vmdir
info "Copy the image to $vmdir"
sudo cp CentOS-7-x86_64-GenericCloud.qcow2 $vmdir/$vm.qcow2

cat <<EOF | sudo tee $vmdir/meta-data
instance-id: $vm_instance_id
local-hostname: $vm_hostname
EOF

cat <<EOF | sudo tee $vmdir/user-data
# Hostname management
preserve_hostname: False
hostname: $vm_hostname
fqdn: $vm_hostname.local

# Create users
users:
    - default
    - name: $vm_user
      groups: ['wheel']
      shell: /bin/bash
      sudo: ALL=(ALL) NOPASSWD:ALL
      ssh-authorized-keys:
        - $(cat ~/.ssh/id_rsa.pub)
 
# Configure interaction with ssh server
ssh_genkeytypes: ['ed25519', 'rsa']
 
# Install public ssh key to the first user-defined user configured in cloud.cfg in the template (optional)
ssh_authorized_keys:
  - $(cat ~/.ssh/id_rsa.pub)
 
# Set timezone for VM
timezone: Asia/Chongqing
 
# Remove cloud-init 
runcmd:
  - systemctl stop network && systemctl start network
  - yum -y remove cloud-init

# Configure where output will go
output:
  all: ">> /var/log/cloud-init.log"
EOF

info "Resize the image"
sudo qemu-img resize $vmdir/$vm.qcow2 +60G

info "Create the cloud-init iso"
# sudo apt install mkisofs
sudo mkisofs -o $vmdir/$vm-cidata.iso -V cidata -r -J $vmdir/meta-data $vmdir/user-data

info "Create the VM"
# sudo apt install virt-manager
sudo virt-install --import --name $vm \
    --memory "$vm_mem" \
    --vcpus "$vm_cpus" \
    --cpu host \
    --disk $vmdir/$vm.qcow2,format=qcow2,bus=virtio \
    --disk $vmdir/$vm-cidata.iso,device=cdrom \
    --network bridge=virbr0,model=virtio \
    --os-variant=rhel7.5 \
    --graphics spice \
    --noautoconsole

# sudo virsh change-media $vm sda --eject --config
# sudo rm -rf $vmdir/meta-data $vmdir/user-data $vmdir/$vm-cidata.iso
 
info "Find the ip address of the VM"
vm_mac=$(sudo virsh dumpxml centos7 | grep -Po "(?<=mac address=').*(?='.*)")
info "VM $vm mac address: $vm_mac"

retries=10
for i in $(seq 1 $retries); do
    vm_ip=$(sudo virsh net-dhcp-leases default --mac "$vm_mac" | grep -Po '(\d+\.){3}\d+' || true)
    if [ -n "$vm_ip" ]; then
        break
    fi
    info "Try to get VM $vm ip address again($i/$retries)"
    sleep 3
done

if [ -z "$vm_ip" ]; then
    erro "Failed to get VM $vm ip address"
    exit 1
fi
info "VM $vm ip address:  $vm_ip"

# sudo apt install libguestfs-tools
