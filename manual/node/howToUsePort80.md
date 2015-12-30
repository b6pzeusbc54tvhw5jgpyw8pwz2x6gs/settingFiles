[refer to that blog post](https://www.digitalocean.com/community/tutorials/how-to-use-pm2-to-setup-a-node-js-production-environment-on-an-ubuntu-vps)

useradd -s /bin/bash -m -d /home/safeuser -c "safe user" safeuser
usermod -aG sudo <username>

sudo apt-get install libcap2-bin
sudo setcap cap_net_bind_service=+ep /usr/local/bin/node
