## ubuntu 14.04

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


## os x 10.11 El Capitan

http://blog.brianjohn.com/forwarding-ports-in-os-x-el-capitan.html
https://gist.github.com/f1sherman/843f85ea8e2cbcdb40af

Add the following to `/etc/pf.anchors/myname`:
```shell
rdr pass on lo0 inet proto tcp from any to any port 80 -> 127.0.0.1 port 4000
rdr pass on lo0 inet proto tcp from any to any port 443 -> 127.0.0.1 port 4001
```

Add the following to `/etc/pf-myname.conf`:
```shell
rdr-anchor "forwarding"
load anchor "forwarding" from "/etc/pf.anchors/myname"
```

Add the following to `/Library/LaunchDaemons/com.apple.pfctl-myname.plist`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
     <key>Label</key>
     <string>com.apple.pfctl-myname</string>
     <key>Program</key>
     <string>/sbin/pfctl</string>
     <key>ProgramArguments</key>
     <array>
          <string>pfctl</string>
          <string>-e</string>
          <string>-f</string>
          <string>/etc/pf-myname.conf</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>KeepAlive</key>
     <false/>
</dict>
</plist>
```

Run the following command to have it start at boot:
```shell
sudo launchctl load -w /Library/LaunchDaemons/com.apple.pfctl-myname.plist
```
