[refer to that blog post](https://www.digitalocean.com/community/tutorials/how-to-use-pm2-to-setup-a-node-js-production-environment-on-an-ubuntu-vps)

```
useradd -s /bin/bash -m -d /home/safeuser -c "safe user" safeuser
usermod -aG sudo <username>

sudo apt-get install libcap2-bin
sudo setcap cap_net_bind_service=+ep /usr/local/bin/node
or
sudo setcap cap_net_bind_service=+ep `which node`
```

보통 우분투 14.04 기준으로 현재 유저로 80포트를 실행시키고 싶을때, 맨 마지막줄
```
sudo setcap cap_net_bind_service=+ep /usr/local/bin/node
```
요거 하나만 실행하면 된다.
