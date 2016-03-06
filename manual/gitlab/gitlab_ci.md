# GitLab Continuous Integration
GitLab has integrated CI to test, build and deploy your code

## 서론
더 나은 개발자 환경을 위해 힘들게 gitlab을 깔았다면 조금 더 화이팅해서 gitlab_ci 를 사용해보자.

![](https://gitlab.com/gitlab-com/www-gitlab-com/raw/1f3abd0cbbe4c10f509f56422514e3997cdc7365/source/images/ci/arch-1.jpg)

gitlab runner 들이 gitlab CI Server 에서 제공하는 API를 사용하여
새로운 코드가 푸쉬되었을때 빌드, 테스트, 배포를 자동화해주는 시스템이다.


## 1. Go - Hello world

Hello world를 해보자. 복잡한 빌드, 테스트, 배포 스크립트 코드를 만드는 것도 중요하지만,
코드가 푸쉬 되었을때 runner 가 이를 감지하여 hello world 라고 로그를 남기게 하는 것이,
hello world, 시작은 반이라고 하지만 여기선 그게 전부이다. (빌드, 테스트, 배포 스크립트 는 이미 가지고 있었을테니까)

### 1.1. 러너 설치
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

### 1.2. runner 셋업
설치가 끝나면 가이드에 나와있는것처럼 `sudo gitlab-ci-multi-runner register` 실행
`Please enter the gitlab-ci token for this runner:` 요기에는gitlab 에 들어가서 ci 를 연결시킬 project - settings- CI token
![](https://raw.githubusercontent.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/master/manual/gitlab/gitlab_ci.001.png)
요 토큰을 적어준다.
`Please enter the executor: docker-ssh, virtualbox, ssh, shell, parallels, docker:` 어떤 환경에서 실행될건지를 물어보는데
난 그냥 shell 이면 될듯 하다. virtualbox, parallels, docker 등 빌드나 배포가 외부 요인에 영향을 받지 않는 완전히 독립된 머신에서 돌아간다면 더 멋질듯하다. 특히 요즘 여기저기 입에 오르는 docker 는 다음에 시간이 되면 꼭 한번 경험해봐야겠다. 

하지만 난 쾌적한 서울 데이터센터를 가지고 있고 구축비용 본전을 뽑아야하기 때문에 shell 를 사용.
([같은 머신에 runner를 운영하는 것에 대한 얘기](http://programmers.stackexchange.com/questions/237238/ci-runner-on-same-server-of-gitlab))

### 1.3. runner 프로세스 확인

```
$ ps -ef | grep runner

root     22115     1  0 19:37 ?        00:00:00 /usr/bin/gitlab-ci-multi-runner run --working-directory /home/gitlab-runner --config /etc/gitlab-runner/config.toml --service gitlab-runner --user gitlab-runner --syslog
```

돌린적도 없는데 잘 돌아가고 있다. 보아하니 설치 스크립트가 gitlab-runner 계정을 만들었다보다. 아래 명령어로도 러너가 잘 돌아가고 있음을 확인해보자. 
```
ssohjiro@ssohjiroSeoul:~$ sudo gitlab-ci-multi-runner status
[sudo] password for ssohjiro:
gitlab-runner: Service is running!
ssohjiro@ssohjiroSeoul:~$ sudo gitlab-ci-multi-runner verify
Running in system-mode.

Veryfing runner... is alive                         runner=ff0938a4
```

sudo gitlab-ctl tail 을 보면
```
==> /var/log/gitlab/gitlab-rails/production.log <==
Started POST "/ci/api/v1/builds/register.json" for 127.0.0.1 at 2016-03-06 20:23:26 +0900

==> /var/log/gitlab/gitlab-workhorse/current <==
2016-03-06_11:23:26.28588 utopos.me:8070 @ - - [2016-03-06 20:23:26.272057808 +0900 KST] "POST /ci/api/v1/builds/register.json HTTP/1.1" 404 27 "" "Go 1.1 package http" 0.013801

==> /var/log/gitlab/nginx/gitlab_access.log <==
192.168.0.1 - - [06/Mar/2016:20:23:26 +0900] "POST /ci/api/v1/builds/register.json HTTP/1.1" 404 58 "-" "Go 1.1 package http"
```
예전에 못봤던 이런 로그가 계속 찍히는것을 볼 수 있다. 아마 헬시체크 및 빌드할게 있나 runner 에서 계속 물어보는게 아닐까?

이런 확인은 마치 cp 명령어로 파일을 카피 한 후 ls 명렁어로 파일이 잘 카피 되었는지 확인하는 것과 같다. 무슨 작업을 하든 정말 중요한 일이니 자동으로든 수동으로든 반드시 체크하자.

### 1.4. .gitlab-ci.yml
자 이제 runner 를 설치하였으니 [gitlab_ci 공식가이드](http://doc.gitlab.com/ce/ci/quick_start/README.html) 로 가보자.

ci를 연결할 project 최상위 디렉토리에 아래 .gitlab-ci.yml 파일을 commit 후 push 하자


```yaml
before_script:
  - echo "hello before_script"

test:
  script:
    - echo "hello test"
    
build:
  script:
    - echo "hello build"
```

prject - builds 에 가보면 fail 결과를 볼 수 있었다.
![](https://raw.githubusercontent.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/master/manual/gitlab/gitlab_ci.002.png)

### 1.4. gitlab CI 셋팅


## 결론
