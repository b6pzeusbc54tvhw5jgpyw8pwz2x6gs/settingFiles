# 바이너리로 깔아서 실행하기

보수적인 apt-get 등의 패키지 매니저에선 최신버전을 바로바로 사용할 수 없다.
binary 를 걍 직접 받아
`/usr/local/bin/docker` 로 실행가능하게 복사하고 아래 디펜던시 설치해준후
```
$ sudo apt-get update
$ sudo apt-get install cgroup-lite linux-image-extra-3.13.0-74-generic linux-image-extra-virtual git git-man liberror-perl libsystemd-journal0
```

타이핑 매번 하기 귀찮으니 아래 alias 설정후
```
alias dockerd='sudo HTTP_PROXY=http://company.proxy.address:port HTTPS_PROXY=http://company.proxy.address:prot docker daemon &'
alias docker='sudo docker'
```

```
dockerd
docker search ubuntu
```

이런식으로 사용하면됨
