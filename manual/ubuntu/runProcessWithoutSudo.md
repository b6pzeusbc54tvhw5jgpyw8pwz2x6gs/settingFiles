
sudo apt-get install 
In above, if you want to remove sudo
```
sudo setcap cap_net_bind_service=+ep `which apt-get`
```

ex)
```
sudo setcap cap_net_bind_service=+ep /usr/local/bin/node
or
sudo setcap cap_net_bind_service=+ep `which node`
```
