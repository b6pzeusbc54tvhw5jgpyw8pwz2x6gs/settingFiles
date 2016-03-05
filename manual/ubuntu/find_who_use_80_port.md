```
sudo netstat -pan | grep ":80"
```
```
tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      6559/config.ru
tcp6       0      0 :::80                   :::*                    LISTEN      24106/www
```

And then,

```
ps -ef | grep 24106
```
```
ssohjiro 24106  6055  0 Feb06 ?        00:22:36 node /home/ssohjiro/runningServer/staticServer/bin/www
```
