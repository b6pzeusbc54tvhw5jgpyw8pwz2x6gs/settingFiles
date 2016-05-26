

```
sudo add-apt-repository ppa:git-core/ppa
# 프록시 환경일땐, http_proxy https_proxy env 로 세팅하고
sudo -E add-apt-repository ppa:git-core/ppa

apt-cache policy git

# 버전을 알아낸 다음,
sudo apt-get install git=1:2.8.3-0ppa1~ubuntu14.04.1
```
