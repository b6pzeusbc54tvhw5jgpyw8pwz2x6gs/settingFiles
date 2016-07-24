# dokcer 로 gitlab 설치하기

gitlab 을 설치하면 여러가지 설치되는 것들이 많은데
이걸 다 host 컴(니컴)에 설치하게되면 지저분해진다.
그래서 이런걸 docker container 안에서 다 해결하고 directory 하나만 volume으로 연결해서 사용하는 방법이 좋다.

[docker-gitlab](https://github.com/sameersbn/docker-gitlab)
docker pull sameersbn/gitlab:8.6.6


