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
또한 git 을 사용하면 node 서버등과 연동하여 파일처리를 할때 이런 충돌 상황을 고려하지 않아도 되는것이 큰 장점이 되겠다.
물론 원격지의 다른 유저와 함께 사용하는 파일이라면 익숙한 관리자가 가끔 커밋 단위로 push 하고 머지를 잘 해주면된다.

2. node 서버와 연동해서 사용할 예정인데 git-svn wrapper 라이브러리보다 git-node wrapper 라이브러리가 더 잘 관리되고 있고 https://github.com/nodegit/nodegit
그래서 더 안정화 되어있을 것 같다.

3. git 은 세상에서 가장 똑똑한 사람들이 만든 SW계의 첨단 기술, 첨단 도구이다. git을 이해하고 자유롭게 사용하기만 하여도
말도안되는 알고리즘 시험문제를 푸는 것보다 실생활이나 업무에서의 문제 해결 능력이나 일처리 능력을 드라마틱하게 끌어올릴수 있다.
또한 git 은 svn 을 완벽하게 대체할 수 있는 좋은 도구이다. github는 말할것도 없다.
예전에 git에 익숙하지 않을땐 '작은 프로젝트에선 svn 도 문제없어' 라며 익숙한 svn 을 즐겨 썼는데,
작은 프로젝트에서도 익숙한 git 을 사용하기 위한 노력을 하는 중이다.

## 목표
서버에 git 저장소 만들고 원격지에서 git clone, git pull, git push 명령어 성공하기.

## ㄱ

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


