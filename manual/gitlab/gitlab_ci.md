# GitLab Continuous Integration
GitLab has integrated CI to test, build and deploy your code

## 서론
더 나은 개발자 환경을 위해 힘들게 gitlab을 깔았다면 조금 더 화이팅해서 gitlab_ci 를 사용해보자.

![](https://gitlab.com/gitlab-com/www-gitlab-com/raw/1f3abd0cbbe4c10f509f56422514e3997cdc7365/source/images/ci/arch-1.jpg)

gitlab runner 들이 gitlab CI Server 에서 제공하는 API를 사용하여
새로운 코드가 푸쉬되었을때 빌드, 테스트, 배포를 자동화해주는 시스템이다.


## Go

### 1. Hello world
Hello world를 해보자. 복잡한 빌드, 테스트, 배포 스크립트 코드를 만드는 것도 중요하지만,
코드가 푸쉬 되었을때 runner 가 이를 감지하여 hello world 라고 로그를 남기게 하는 것이,
hello world, 시작은 반이라고 하지만 여기선 그게 전부이다. (빌드, 테스트, 배포 스크립트 는 이미 가지고 있었을테니까)

- 1.1. 러너 설치
필자의 환경은 원격 Ubuntu 14.04 머신이 있는 seoulDataCenter 에 ssh 를 사용하여 작업한다. 이곳에 gitlab이 있고 runner 또한 이곳에 놓아둘 생각이다. 공식 지원 가이드를 참고하여 러너를 설치해보자.

[공식 gitlab-ci-multi-runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner)

* [Install using GitLab's repository for Debian/Ubuntu/CentOS/RedHat (preferred)](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-repository.md)
* [Install on OSX (preferred)](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/osx.md)
* [Install on Windows (preferred)](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/windows.md)
* [Install as Docker Service](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/docker.md)
* [Use on FreeBSD](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/freebsd.md)
* [Manual installation (advanced)](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/linux-manually.md)
* [Bleeding edge (development)](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/install/bleeding-edge.md)
* [Install development environment](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/blob/master/docs/development/README.md)

1.2. 셋업
설치가 끝나면 가이드에 나와있는것처럼 `sudo gitlab-ci-multi-runner register` 실행
gitlab-ci token 에 


## 결론
