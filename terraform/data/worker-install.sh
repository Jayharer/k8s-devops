#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

apt-get update -y 
# apt-transport-https may be a dummy package; if so, you can skip that package
apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list

# install containerd 
apt install containerd -y 
mkdir -p /etc/containerd 
containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' | tee /etc/containerd/config.toml
systemctl restart containerd

# Kubernetes requires IP forwarding to be enabled so that pods and 
# services can communicate across the network.
echo "net.ipv4.ip_forward = 1" | tee /etc/sysctl.d/99-kubernetes-ip-forward.conf
sysctl --system
# verify setting 
cat /proc/sys/net/ipv4/ip_forward

# change permissions
chmod 777 /var/run/containerd/containerd.sock

# load module
modprobe br_netfilter
# verify loaded
lsmod | grep br_netfilter
# make persistent change 
echo br_netfilter | tee /etc/modules-load.d/br_netfilter.conf

# install 
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
systemctl start kubelet

# Mount the EFS Volume on the Host
mkdir -p /mnt/efs
mount -t efs -o tls ${EFS_ID}:/ /mnt/efs
# assign read/write permissions to container user 
chown -R 1000:1000 /mnt/efs  # if container runs as UID 1000


