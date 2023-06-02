#!/bin/bash

sudo pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat archlinux-keyring ebtables iptables libguestfs vim

sudo systemctl enable libvirtd.service

sudo systemctl start libvirtd.service

sudo sed -i "s/\#unix_sock_group/unix_sock_group/g" /etc/libvirt/libvirtd.conf

sudo sed -i "s/\#unix_sock_rw_perms/unix_sock_rw_perms/g" /etc/libvirt/libvirtd.conf

sudo usermod -a -G libvirt $(whoami)

sudo systemctl restart libvirtd.service

sudo modprobe -r kvm_amd

sudo modprobe kvm_amd nested=1

echo "options kvm-amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf

systool -m kvm_amd -v | grep nested

sudo virsh net-start default
