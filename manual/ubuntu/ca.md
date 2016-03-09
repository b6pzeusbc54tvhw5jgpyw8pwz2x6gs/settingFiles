```
$ sudo mkdir /usr/share/ca-certificates/mycompany
$ sudo cp samsung.crt /usr/share/ca-certificates/mycompany/mycompany.crt
# (not cer, but crt!)

$ sudo dpkg-reconfigure ca-certificates
$ sudo update-ca-certificates
```

in Chrome
chrome - setting - https/ssl - Authoriries - import - select "mycompany.crt" - check all checkbox

in Firefox
edit > preferences > advanced > view certificates > authories

안되면 소유자 확인
```
chown ssohjiro /usr/share/ca-certificates/mycompany
```
