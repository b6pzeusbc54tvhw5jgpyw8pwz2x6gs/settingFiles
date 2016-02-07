# git 서버

https://git-scm.com/book/en/v2/Git-on-the-Server-Git-Daemon
https://git-scm.com/book/ko/v1/Git-%EC%84%9C%EB%B2%84-%EC%84%9C%EB%B2%84%EC%97%90-Git-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0

git-scm.com 의 가이드를 참조하며 작업함.

## 왜 갑자기?
개인 프로젝트에서 형상관리가 되는 파일들을 사용할 요구가 있는데,
익숙하게 사용하던 svn 으로는 여러가지 문제가 있어 git 서버를 설치하고자 한다.

svn 의 문제

1. local 에서만 형상관리가 되지 않는다. 형상관리를 하기 위해선 항상 원격 저장소에 커밋해야한다. 이때 충돌처리를 해야하는데 익숙한 사용자가 아니면 하기 힘들다.
익숙한 사용자가 아니라는 것은 비개발자인 디자이너나 퍼블리셔 또는 비전공자인 일반인을 말한다.
또한 git 을 사용하면 node 서버등과 연동하여 파일처리를 할때 이런 충돌 상황을 고려하지 않아도 되는것이 큰 장점이다.
물론 원격지의 다른 유저와 함께 사용하는 파일이라면 익숙한 관리자가 가끔 적당한 커밋 단위로 push & merge 를 해줘야함.

2. node 서버와 연동해서 사용할 예정인데 git-svn wrapper 라이브러리보다 git-node wrapper 라이브러리가 더 잘 관리되고 있고 https://github.com/nodegit/nodegit
그래서 더 안정화 되어있을 것 같다.

3. git 은 세상에서 가장 똑똑한 사람들이 만든 SW계의 첨단 기술, 첨단 도구이다. git을 이해하고 자유롭게 사용하기만 하여도
말도안되는 알고리즘 시험문제를 푸는 것보다 실생활이나 업무에서의 문제 해결 능력이나 일처리 능력을 드라마틱하게 끌어올릴수 있다.
또한 git 은 svn 을 완벽하게 대체할 수 있는 좋은 도구이다. github는 말할것도 없다.
예전에 git에 익숙하지 않을땐 '작은 프로젝트에선 svn 도 문제없어' 라며 익숙한 svn 을 즐겨 썼는데,
작은 프로젝트에서도 익숙한 git 을 사용하기 위한 노력을 하는 중이다.

## 목표
서버에 git 저장소 만들고 원격지에서 git clone, git pull, git push 명령어 성공하기.

## Step 1

로컬서버에 새로운 플젝을 만들자. (필자는 parallels-comment 라는 이름의 프로젝트를 만든다)
```
local$ mkdir paralleles-comment
local$ cd parallels-comment
local$ git init
local$ echo init > README.md
local$ git add .
local$ git commit -m "init project"
```
혹시 몰라 파일하나를 생성하여 커밋까지 완료해두었다. 그러면 이제 --bare 옵션을 주고 bare저장소를 만들어보자.

```
local$ cd ..
local$ git clone --bare parallels-comment parallels-comment.git
```

서버에 bare 저장소를 넣어보자
scp 접속이 되야하고 저장소를 만들 디렉토리에 쓰기 권한이 있어야한다.
### server 에 /media/UbuntuSWRaid01/gitRepos 디렉토리가 존재해야한다. 그렇지 않으면 시행착오1 로 빠진다.
```
local$ scp -r parallels-comment.git ssohjiro@utopos.me:/media/UbuntuSWRaid01/gitRepos
ssohjiro@utopos.me's password:
config                                                           100%  178     0.2KB/s   00:00
description                                                      100%   73     0.1KB/s   00:00
HEAD                                                             100%   23     0.0KB/s   00:00
applypatch-msg.sample                                            100%  452     0.4KB/s   00:00
commit-msg.sample                                                100%  896     0.9KB/s   00:00
post-update.sample                                               100%  189     0.2KB/s   00:00
pre-applypatch.sample                                            100%  398     0.4KB/s   00:00
pre-commit.sample                                                100% 1642     1.6KB/s   00:00
pre-push.sample                                                  100% 1352     1.3KB/s   00:00
pre-rebase.sample                                                100% 4951     4.8KB/s   00:00
prepare-commit-msg.sample                                        100% 1239     1.2KB/s   00:00
update.sample                                                    100% 3611     3.5KB/s   00:00
exclude                                                          100%  240     0.2KB/s   00:00
c95f89a0e43e9a4af2e2430bc06e234bd0e217                           100%  148     0.1KB/s   00:00
825dc642cb6eb9a060e54bf8d69288fbee4904                           100%   15     0.0KB/s   00:00
8561e89ea657b6ad0f3c1905c7434c67907de1                           100%   54     0.1KB/s   00:00
b716105590454bfc4c0247f193a04088f39c7f                           100%   20     0.0KB/s   00:00
packed-refs                                                      100%   98     0.1KB/s   00:00
```

### 시행착오1
```
other_local$ git clone ssohjiro@utopos.me:/media/UbuntuSWRaid01/gitRepos/parallels-comment.git
```
명령어로 clone 이 불가능하다. 
```
other_local$ git clone ssohjiro@utopos.me:/media/UbuntuSWRaid01/gitRepos
```
이 명령이 잘 동작하고 아까 만든 README.md 파일을 잘 clone 해오는 것을 보아
서버에 gitRepos 라는 디렉토리가 없었던 상태여서 그런지
gitRepos 아래 parallels-comment.git 이 있는 것이 아니라 parallels-comment 가 gitRepos 으로 되었다.


## Step 2
```
other_local$ git clone ssohjiro@utopos.me:/media/UbuntuSWRaid01/gitRepos/parallels-comment.git
```
잘 되는지 확인 (ssh 접근 및 해당 디렉토리 읽기 권한이 있어야함)
서버에 svnserve 같은 데몬을 따로 실행하지 않아도 ssh 를 통해 clone 이 성공하였다.
쓰기권한이 있는 사용자로 push 테스트도 바로 성공하였다.

### 참고1 - [--shared](https://git-scm.com/book/ko/v1/Git-%EC%84%9C%EB%B2%84-%EC%84%9C%EB%B2%84%EC%97%90-Git-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0#서버에-Bare-저장소-넣기)
이 서버에 SSH로 접근할 수 있는 사용자가 /opt/git/my_project.git 디렉토리에 쓰기 권한까지 가지고 있으면 바로 Push할 수 있다. git init 명령에 --shared 옵션을 추가하면 Git은 자동으로 그룹 쓰기 권한을 추가한다:
```
$ ssh user@git.example.com
$ cd /opt/git/my_project.git
$ git init --bare --shared
```

### 참고2 -[SSH 접근](https://git-scm.com/book/ko/v1/Git-%EC%84%9C%EB%B2%84-%EC%84%9C%EB%B2%84%EC%97%90-Git-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0#바로-설정하기)
만약 모든 개발자가 SSH로 접속할 수 있는 서버가 있으면 너무 쉽게 저장소를 만들 수 있다. 앞서 말했듯이 할 일이 별로 없다. 저장소의 권한을 꼼꼼하게 관리해야 하면 그냥 운영체제의 파일시스템 권한관리를 이용한다. 동료가 저장소에 쓰기 접근을 해야 하는 데 아직 SSH로 접속할 수 있는 서버가 없으면 하나 마련해야 한다. 아마 독자에게 서버가 있다면 그 서버에는 이미 SSH 서버가 설치돼 있어서 이미 SSH로 접속하고 있을 것이다.

동료가 접속하도록 하는 방법은 몇 가지가 있다. 첫째로 모두에게 계정을 만들어 주는 방법이 있다. 이 방법이 제일 단순하지만 다소 귀찮은 방법이다. 팀원마다 adduser를 실행시키고 임시 암호를 부여해야 하기 때문에 보통 이 방법을 쓰고 싶어 하지 않는다.

둘째로 서버마다 git이라는 계정을 하나씩 만드는 방법이 있다. 쓰기 권한이 필요한 사용자의 SSH 공개키를 모두 모아서 git 계정의 ~/.ssh/authorized_keys파일에 모든 키를 입력한다. 그러면 모두 git 계정으로 그 서버에 접속할 수 있다. 이 git 계정은 커밋 데이터에는 아무런 영향을 주지 않는다. 다시 말해서 접속하는 데 사용한 SSH 계정과 커밋에 저장되는 사용자는 아무 상관없다.

이미 LDAP 서버 같은 중앙집중식 인증 소스를 가지고 있으면 SSH 서버가 해당 인증을 이용하도록 할 수도 있다. SSH 인증 메커니즘 중 아무거나 하나 이용할 수 있으면 그 서버에 접속이 가능하다.



## Step 3
ssh 로 client 의 공개키를 하나씩 등록하여 사용하는건 별로 개발자스럽지 못하다.
gitosis, gitolite 가 이 git repo 관리를 쉽게해준다.
[gitosis vs gitolite](http://stackoverflow.com/questions/10888300/gitosis-vs-gitolite)주제의 stackoverflow 하나를 보면
gitosis 는 obsolete 되었으며 
[또다른 stackoverflow](http://stackoverflow.com/questions/579714/using-gitosis-to-specify-permissions-per-branch)에서는
gitolate 에서도 gitweb, git-daemon 을 지원한다고한다. 그렇다면 선택은 gitolite !!


## 결론
보안에 민감한 회사에 다니지 않아서 github private 등을 자유롭게 쓸 수 있다면 그렇게해라.
한달에 몇만원으로 수십시간을 살 수 있다.
