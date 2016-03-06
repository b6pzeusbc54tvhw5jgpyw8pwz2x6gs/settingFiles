# gitlab ci node 스크립트 실행

## Try

hello_world 용 .gitlab-ci.yml 을 수정하자
```
before_script:
  - echo "hello before_script"
  - echo "nvm use 4.2.6"
  - nvm use 4.2.6
  - echo "node hello.js"
  - node hello.js

test:
  script:
    - echo "hello test"

build:
  script:
    - echo "hello build"
```
왜나면 

hello.js 파일도 추가하여 커밋 - 푸쉬하자.
```
console.log('hello node');
```

Builds 메뉴를 다시 들어가보면 failed 가 떠있다.
```
gitlab-ci-multi-runner 1.0.4 (014aa8c)
Using Shell executor...
Running on ssohjiroSeoul...
Fetching changes...
HEAD is now at 06fdc29 ci test #4
From http://utopos.me:8070/gmw/devportal-server
   06fdc29..db00efa  master     -> origin/master
Checking out db00efac as master...
Previous HEAD position was 06fdc29... ci test #4
HEAD is now at db00efa... ci test #5
$ echo "hello before_script"
hello before_script
$ nvm use 4.2.6
-su: line 29: nvm: command not found

ERROR: Build failed with: exit status 1
```

exit status 1 은 error 와 함께 프로세스가 종료되었다는 것이다.
nodejs 문서를 참고

>process.exit([code])#
>Ends the process with the specified code. If omitted, exit uses the 'success' code 0.
```
To exit with a 'failure' code:
```
>process.exit(1);
>The shell that executed Node.js should see the exit code as 1.


## 삽질
왠지 이 프로세스를 실행시키는 gitlab-runner user로 접속해서 nvm 을 깔아놓으면 되지 않을까?
`sudo passwd gitlab-runner` 로 패스워드를 설정 한후 `su gitlab-runner` 로 로긴해보자.
[su 사용할때 현재유저의 환경변수에 영향받지 않도록 해야한다](https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/blob/master/manual/ubuntu/change_user_clean_bash_env.sh)

들어가서 [nvm](https://github.com/creationix/nvm) 을 설치하고 node 4.2.6 을 설치한다.
실패한 Builds 메뉴에서 실패한 빌드 옆의 재시도 버튼을 누르자.
안된다.
후..

gitlab-ci-multi-runner 메뉴얼을 보자.

삽질하다 발견.
gitlab-runner 유저로 들어가서 `gitlab-ci-multi-runner register` 하면 등록은 잘 되지만,
자동으로 build를 시작하지 못한다.
`gitlab-runner --debug run` 으로 시작할 수 있으며 로그를 볼 수 있다.

## 드디어 성공

register 를 할때 --shell 옵션을 줄수 있는데 bash 라고 줘야한다.
`#!/usr/bin/env bash` <- 요기 bash 라고 쓰려고 하나보다. TODO study!

```
gitlab-ci-multi-runner register --shell /bin/bash // x
gitlab-ci-multi-runner register --shell bash // o
```

그리고 nvm 을 이용하여 nvm, node, npm 등의 명령어를 올리는 것이 쉽지 않았다.
권한을 주고 절대경로를 사용하는 하드한 방법을 사용한다면 좀 더 쉽게 했겠지만 나중에 고달파진다.
그래서 쓴 방법이 `. ~/.nvm/nvm.sh` nvm.sh 를 실행하면 nvm 명령어를 현재 프로세스에 등록? 하나보다. TODO study
.gitlab-ci.yml 을 보자.

```
before_script:
  - echo "hello before_script"
  - . ~/.nvm/nvm.sh ; nvm use 4.2.6
  - node hello.js
    #- nvm use 4.2.6
    #- node hello.js

test:
  script:
    - echo "hello test"

build:
  script:
    - echo "hello build"
```

커밋하고 푸쉬하니 
```
gitlab-ci-multi-runner 1.0.4 (014aa8c)
Using Shell executor...
Running on ssohjiroSeoul...
Fetching changes...
HEAD is now at 8a27df1 ci test #9
From http://utopos.me:8070/gmw/devportal-server
   8a27df1..57a695a  master     -> origin/master
Checking out 57a695a4 as master...
Previous HEAD position was 8a27df1... ci test #9
HEAD is now at 57a695a... ci test #10
$ echo "hello before_script"
hello before_script
$ . ~/.nvm/nvm.sh ; nvm use 4.2.6
Now using node v4.2.6 (npm v2.14.12)
$ node hello.js
hello node
$ echo "hello test"
hello test

Build succeeded.
```

자동으로 다시 러너가 듣게하기 위해, (gitlab-runner 계정으로 runner를 등록시키면 수동으로 run 을 해줘야한다)
gitlab-runner 계정에서 run 으로 돌리던 러너를 끄고, gitlab Builds 메뉴에서 remove runner를 하고 다시
`sudo gitlab-ci-multi-runner register --shell bash` 러너 등록

아까 성공했던 빌드가 잘 실행되는지 재시도 버튼으로 확인.
성공.!

## 자 이제
본격적으로 .gitlab-ci.yml 파일을 작성해보자.
[공식 가이드](http://doc.gitlab.com/ce/ci/yaml/README.html)
