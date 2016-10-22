https://coderwall.com/p/zguz_w/docker-remove-all-exited-containers

remove all Exited containers
```
sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm
```
