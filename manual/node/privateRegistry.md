# privateRegistry.md

큰 조직에서 일하게 될때면 작은 과제도 여러 모듈로 전문성있게 나눠 작업할때가 많다.

서버 - 클라이언트는 물론 우리회사는 dba, backend-server, front-server, front end client, publishing, ui 등등 
풀스택 개발자 한명이 다 할수도 있는 일을 보다 전문성을 살리고 분업화하여 최고효율을 낼수 있도록..

하지만 여기저기서 줄줄 세는 비효율에 개발속도도 그렇게 빠르지 않으면서 매일 야근이 반복된다.
앱을 최종 배포하는 개발팀에는 정말 비효율 천지이다.

메인인 개발 업무 이외의 이미지, 다국어문구, 퍼블리싱, 각종 셋팅 등등 여기저기서 나온 산출물을
잘 통합하여 빠진것은 없는지 확인 한 후 최종 확인한다.
당연히 문제는 많은 곳에서 발생하고 리포팅을 해주어야 한다.

살펴보다.
UI팀에서 이미지를 업데이트 해줬다.
zip으로 압축해서 메일로 보냈다. 코드에 적용시키려면?

1. 메일페이지에 접속
2. 메일 찾기
3. 첨부파일 zip 다운로드
4. zip파일 찾기위해 폴더이동
5. 압축해제
6. 해제한 파일을 프로젝트 디렉토리에 복사
7. 확인
8. 휴먼오류발생. 압축파일이 옛날꺼임.
9. 빠진 파일 재요청 메일 작성 등
10 메일 찾기
11. 첨부파일 zip 다운로드
12. zip파일 찾기위해 폴더이동
13. 압축해제
14. 해제한 파일을 프로젝트 디렉토리에 복사
15. 확인
16. 휴먼오류발생. 파일이름이 틀려서 로드를 못함
17. 파일이름 고침
18. 메일로 파일이름 틀렸다는것을 알려줌
19. 확인
20. svn 에 커밋

위 과정이 뭐가 어때서? 라고 생각한다면,
강요할 생각은 없다 그냥 평생 그렇게 하던데로 하면된다ㅎㅎ

내가 이상적인 방법은 이렇다.

1. npm i uiAsset
참고로 i 는 install 의 alias이고 npm은 오른손 두번째 세번째 손가락으로 타이핑을 쉽게 할수 있다.
실제로 네이밍을 할때 오른손잡이를 고려했다나 뭐라나 ㅎㅎ
암튼 2초정도에 걸려서 저 한줄을 치면 모든 어셋들을 node_modules/uiAsset 디렉토리에 업데이트 한다.
압축을 하지 않으므로 8번 오류는 발생하지 않는다.
파일이 빠졌다고 하자.
2. 파일빠졌다고 메일
3. npm i uiAsset
4. npm publish
5. svn 커밋

npm publish를 잘 살펴보자.
중앙코드에서 다른 모듈들을 npm i 로 내려받는 것이 아니라 자기자신 자체도 하나의 모듈로 publish 해버린다.
이말은 uiAsset 부서에서 asset 업데이트를 한 후 

assetDir$ npm publish 
main$ npm i mainCode --production

이런식으로 자신들의 assetDir을 스스로 검증할 수 있는 환경을 겨우 타이핑 1줄로 제공해주는 것이다.
물론 mainCode 내에 asset들을 검증할 수 있는 환경은 구축되어 있어야한다.

자 그렇다면 위의 2. 파일 빠지는 실수도 잘 빨생하지 않을 것이다.
메일로 업데이트를 알려주기 전 검증을 한다면 거기서 발견되고 고친 후 업데이트를 알려줄 테니
내가 낸 실수를 다른곳에서 발견하여 그걸 나에게 메일로 설명을 해주고 난 또 메일을 열어 그걸 보며 이해하는건
남에 일 참겨하는게 삶의 낙인 친구들을 빼곤 정말로 극심한 비효율중에 비효율이다.
물론 어떤 실수는 다른 모듈들과 함께 조립되어서 발견되는 그런 실수도 있을것이다. 예기치못한...

대략 피곤한 20 가지 일이 간단한 3가지 명령어로 줄어들었다.
하지만 아래 세가지 사전작업이 있고 이것은 꽤 공수가 많이 들 수 있다.

1. 사설 npm 을 설치해야한다.
2. npm 을 익혀야한다.
3. 테스트 모듈 기능을 구축해야한다.

1번은 한번만 뚫어놓으면 이후에는 쉽게 쉽게 할수 있는 부분이다.
2번은 그렇게 어렵지 않다. 1번 세미나 혹은 인터넷을 통해 1시간 내외로 익힐수 있는 수준이다.
3번은 공수가 꽤 많이든다. 역시 노하우 및 자신의 코드자산들이 쌓이면 조금씩 편해진다.

# 사설 npm 설치

## 먼저 couchDB 가 설치되어 있어야한다. 우분투 14.04 를 기준으로 한다.

https://launchpad.net/~couchdb/+archive/ubuntu/stable 페이지에 들어가 참고하면서 아래를 실행시키자
```shell
# install the ppa-finding tool
sudo apt-get install software-properties-common -y

# add the ppa
sudo add-apt-repository ppa:couchdb/stable -y

# update cached list of packages
sudo apt-get update -y

# remove any existing couchdb binaries
sudo apt-get remove couchdb couchdb-bin couchdb-common -yf

# see my shiny goodness - note the version number displayed and ensure its what you expect
sudo apt-get install -V couchdb
```

`couchdb -V` 를 통해 1.6.1 이 깔린것을 확인 하고 실행시키자

```
# manage via upstart
sudo stop couchdb
  couchdb stop/waiting
# update /etc/couchdb/local.ini with 'bind_address=0.0.0.0' as needed
sudo start couchdb
```

다음에 뭐를 할까 npm help registry 를 살펴보자
`https://github.com/npm/npm-registry-couchapp` 이곳에 가서 하나하나 해보자

curl -X PUT http://localhost:5984/registry

sudo vi /etc/couchdb/local.ini
```
[couch_httpd_auth]
public_fields = appdotnet, avatar, avatarMedium, avatarLarge, date, email, fields, freenode, fullname, github, homepage, name, roles, twitter, type, _id, _rev
users_db_public = true

[httpd]
secure_rewrites = false

[couchdb]
delayed_commits = false
```
```
git clone git://github.com/npm/npm-registry-couchapp
cd npm-registry-couchapp
npm install
```
```
npm start \
  --npm-registry-couchapp:couch=http://admin:password@localhost:5984/registry
```

에러가 날 것이다.
`/etc/couchdb/local.ini` 요기에서 admin = password 설정을 해주고 in [admins] 재시작
`sudo stop couchdb`
`sudo start couchdb`


```
npm run load \
  --npm-registry-couchapp:couch=http://admin:password@localhost:5984/registry
```

```
npm run copy \
  --npm-registry-couchapp:couch=http://admin:password@localhost:5984/registry
```



여기까지 했으면
```
npm config set \
  registry=http://localhost:5984/registry/_design/app/_rewrite
```
위 명령어로 registry 주소를 방금만든 local private registry 를 바라보게해서 테스트를 해보자

```
npm i underscore
```
`404 Not Found: underscore` 이런 메시지가 나와야 정상이다. 내 사설 registry 에는 아직 아무 패키지도 없으니까.
아래의 명령으로 공식 npm registry 와 replication 을 맺을수 있다고 한다. ([요 블로그 참고](http://www.clock.co.uk/blog/how-to-create-a-private-npmjs-repository))

당연히 모든 패키지 파일을 받는건 아닐테고...
(에이 설마 천문학적 디스크공간이 필요할것이다) 200,000 모듈 * 각 릴리스버전 10개씩 * 0.5MB 라고만해도 100,000 MB => 100기가
음... 생각보다 그렇게 크지 않네 모두 끌어당겨올수도 있겠다싶다.



아무튼 네트웤속도가 느린 필자의 환경에선 한 100메가 정도까지 가져오다 아래 3번째 명령어로 cancel 하였다.

curl -X POST http://127.0.0.1:5984/_replicate -d '{"source":"http://isaacs.iriscouch.com/registry/", "target":"registry", "create_target":true}' -H "Content-Type: application/json" 

curl -X POST http://127.0.0.1:5984/_replicate -d '{"source":"http://isaacs.iriscouch.com/registry/", "target":"registry", "continuous":true, "create_target":true}' -H "Content-Type: application/json" 

curl -X POST http://127.0.0.1:5984/_replicate -d '{"source":"http://isaacs.iriscouch.com/registry/", "target":"registry", "continuous":true, "create_target":true, "cancel":true}' -H "Content-Type: application/json"

하지만 내 기억에 어디선가 다 끌어올려면 8기가 정도라고 들은것 같다. 몇년 전 글인것 같긴 했지만
아무래도 meta정보만을 가져오고 실제 바이너리 파일들은 cdn을 당연히 태우겠네싶다.
테스트를 해봤다.
npm search promise
결과가 제법 나온다. 결과중 하나를 골라 `npm i ya-promise` 설치 성공.
인터넷을 끄고 해본다. (물론 npm un ya-promise, npm cache clean 후 )
설치가 안된다. 실제 파일은 원격으로 불러오는 것이 확인됐다

또 결과중에 npm i zed 를 인스톨하니 promise 레지스트리에서 모듈을 찾지 못했다는 에러가 뜬다.
public npm으로 확인하니 
zed@0.1.0 node_modules/zed
└── lazypromise@0.1.0 (promise@2.0.0)

디펜던시 모듈의 디펜던시 모듈중에 promise 모듈이 있다. 중간에 replication 을 취소했기 때문에 
모든 메타정보를 저장하고 있진 않아서 생기는 문제라고 볼 수 있다.

npm adduser test01
아무렇게나 user 를 만들어 publish , install 을 해보았다. 잘되는 것을 확인.
차이점은 default registry 에서 adduser 를 하면 새로운 유저일 경우 npmjs.com 에 아카운트가 자동으로 추가되는데
private registry에선 당연히 이 webpage 띄우는 것도 모르겠고 couchdb 에 추가가되나보다.

좋아 이제 
어떻게 사용할 것인가 몇가지 옵션이 있다.

1. 그냥 충분한 하드디스크 용량을 보유한 다음 메타데이터 모두 레플리케이션 한다음 모두 받기 (좋은 경험이 될 것같다ㅎㅎ)
2. User 들이 잘 사용하면된다. official 레지스트리의 모듈을 받을때와 private registry 에서 받을때 각각 `npm i underscore --registry http://~` 넣어주면된다. npm i -g express-generator --registry https://registry.npmjs.org
2. sinopia - npm

1번은 먼가 이런 npm 같은 것을 직접 만들어볼 사람이라면 규모를 가늠해볼수도 있고
경험해본다면 여러가지 도움은 될듯하다.
하지만 npm 구축이 목적이 아닌 나와같이 npm을 단순 업무협업의 도구로 사용할 목적이라면
너무 많이간샘. 한번 받으면 되는게 아니라 추가되는 세상의 모든 module을 팔로업하려면 항상 리슨을 하고 있어야하고
프로세서나 네트워크 자원도 관리해줘야한다.

2번.. 사실 나정도 node와 npm에 익숙한 사람이라면 2번을 해도 무리가 없다.
하지만 private registry 를 구축하여 팀원들 및 타부서와 협업을 목적으로 하는 사람이 2번을 생각한다면
그사람은 매우 많이 같이일하기 싫은 사람이다.
수많은 휴먼오류와 안해도 되는 설정들 모듈을 새로 추가할때마다 모든 팀원이 내용을 익히거나해야하고
자동스크립트가 제공된다해도 그것은 별로이다. npm 에 익숙해지는건 좋지만 지생각을 담아 만든 허접한 자동스크립트를 익히는건 큰 시간 낭비이기 때문. 많은 npm에 익숙하지 않은 팀원들은 익숙해질때까지 수많은 휴먼오류를 낼 것이고 자동 스크립트있다해도 그 스크립트를 만드는 수고, 무수한 스크립트 에러, 가장 별로인건 common 하지 않고 딱 그 환경에서만 필요한 다른곳에서 쓸모없는 것들을 열심히 시간을 들여 익혀야한다는 것이다.

3번. 좋아 이걸로가보자.
couchdb 까지 안쓰고 파일로 module 을 관리해주며 없는 모듈은 official registry것을 자동으로 땡겨준다고한다.
npm 을 훅 해서 동작하는 원리인가.
모든 npm 명령어가 다 지원되는건 아니라고 하니 npm 을 수정하여 만든 또다른 npm인가
이런경우 npm 기존 높은 버전과의 차이가 많이 날텐데.. 걱정스럽기도 하지만 그래도 쉽게 설치할수 있다니 한번 ㄱ ㄱ

