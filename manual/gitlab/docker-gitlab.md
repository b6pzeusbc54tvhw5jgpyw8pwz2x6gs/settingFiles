# docker 이미지로 gitlab 사용하기

## 두가지 버전이 있다.
[sameersbn](https://github.com/sameersbn/docker-gitlab) 버전, [공식](https://hub.docker.com/r/gitlab/gitlab-ce/) 버전

## sameersbn 버전을 사용했다. 왜?
gitlab 공식 gitlab-runner 에서 큰 삽질을 했었었는데(10시간정도), 이때 sameersbn 버전으로 깔끔하게 해결한 경험이 있어서.

$ docker pull sameersbn/gitlab:8.6.3
$ wget https://raw.githubusercontent.com/sameersbn/docker-gitlab/master/docker-compose.yml

docker-compose 안에 몇가지 설정을 하고
```
GITLAB_HOST=
GITLAB_SECRESTS_DB_KEY_BASE=무작위키(pwgen -Bsv1 64 로 생성하면 좋음)
```

$ docker-compose up
