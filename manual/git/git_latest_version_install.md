특정 버전을 원할댄 source 로 직접 하는 방법도 있는데,

어이없게도 libcurl4 등 https helper 가 없다는 


```
sudo add-apt-repository ppa:git-core/ppa
# 프록시 환경일땐,
apt-cache policy git
sudo apt-get install git=1:2.8.3-0ppa1~ubuntu14.04.1
```
