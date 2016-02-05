
https://www.dropbox.com/install?os=lnx
https://www.dropbox.com/help/9192?path=desktop_client_and_web_app
```
sudo dpkg -i 파일명
dropbox start -i
```

Note: python-gpgme is not installed, we will not be able to verify binary signatures. [y/n] n

`$ sudo apt-get install python-gpgme` 명령어로 깔아주니

In order to use Dropbox, you must download the proprietary daemon. [y/n] y

`~/.dropbox-dist/dropboxd` 실행하면 (이미 실행되어있다면 `sudo kill -9 pid` 로 죽이고)
아래 링크를 볼수 있고 접속해서 허가하면 끝.
This client is not linked to any account... Please visit https://www.dropbox.com/cli_link?host_id=7d44a557aa58f285f2da0x67334d02c1 to link this machine.

`ctrl+c` 로 빠져나와 dropbox start 로 시작하면됨.

### 다 필요없고 요기 따라하면됨.
http://www.dropboxwiki.com/tips-and-tricks/install-dropbox-in-an-entirely-text-based-linux-environment
