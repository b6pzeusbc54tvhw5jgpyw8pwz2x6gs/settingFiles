# about sinopia

## Install
```
sudo npm i -g sinopia
```
test script 에서 에러가 어느 디렉토리에 접근 권한이 없어서 나나보다.
```
sudo npm i -g sinopia --unsafe-perm
```
으로 시도했으나 이번엔 다른 에러. 검색해보니 node v4, v5 는 지원을 안하는갑다

```
nvm install 0.12.9  
nvm use 0.12.9
node --version
```
잘 되는 듯 하나 여기서 쫌 어렵다
0.12.9 라고 잘 찍힌다 하지만 `sudo node --version` 은 여전히 4.2.3 이 찍힌다.
바꿀려고 sudo nvm use 0.12.9 를 실행하지만 nvm 이 없다고 실행이 안된다.
`which nvm` 역시 실행이 안된다.

```
# sudo passwd root <- 이게 전에 필요한가?
sudo -i
cp -r /home/myid/.nvm ./
```
`~/.bashrc` 파일에 아래 추가
```
export NVM_DIR="/home/ssohjiro/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
```

그러면 nvm 이 실행된다. 안되면 exit, sudo -i 다시해서 들어오자.
```
nvm use 0.12.9
```
이렇게 하고 
`npm install -g sinopia` 또는 `npm install -g sinopia --unsafe-perm` 명령어로 설치가 된다.
root 상태이기 때문에 그냥 sudo도 필요없고 --unsafe-perm 도 없이 경고가 하나 뜨지만 잘 되는것 같다.


위 install 문제를 해결하는 2시간이 걸렸다.
이제 설치가 되었으니 실행을 하자
sudo -i 로 들어간 root login 상태에서 `sinopia` 를 실행하니 root 권한으로 실행하지 말라고 경고한다.
exit 로 빠져나와서
```
nvm use 0.12.9
sinopia
```
이래야지 0.12.9 버전 노드 아래에서 sinopia가 드디어 실행된다.
`npm set registry http://localhost:4873/`
셋팅하고 `npm i underscore`
잘 깔린다!

아까 promise 디펜던시가 없어서 안깔리 zed 등또 잘 깔린다.
이제 publish 테스트를 해보자

npm adduser
testuser01
testuser01
testuser01@yopmail.com

아무 모듈이나 만들고 (ex: myabcmodule) `npm publish`
다른 폴더에 가서 `npm i myabcmodule`
잘된다. 원격에서 sinopia를 접근해보자.

sinopia를 종료시킨후 `sinopia --listen http://10.211.55.7:4873` 이렇게 다시 실행시켜야 원격접속이 된다.
`npm set registry http://10.211.55.7:4873/` 으로 다시 셋팅한다.

원격에서도 underscore, myabcmodule 이 잘받아 지는 것을 확인!


통해 myabcmodule을 

## Use SSL Protocol
Private NPM을 사용하는 목적은 대부분 '보안' 에 있을 것이다.
공개해선 안되는 자료를 내부 사람들끼리 쉽게 npm publish, npm install 로 각 모듈화된 부분을 버전관리하는 것.
그렇다면 그 외부에 공개되선 안되는 소중한 자료를 암호화해서 주고 받아야
행여나 중간에 누가 데이터를 들여다보게되도 안심할 수 있다.

https 사용을 해보자. `sinopia --listen https://192.168.0.201:3003` https 프로토콜로 명시하니 아래와 같은 메시지가 뜬다.
```
 warn  --- config file  - /home/ssohjiro/.config/sinopia/config.yaml
 fatal --- You need to specify "https.key" and "https.cert" to run https server

To quickly create self-signed certificate, use:
 $ openssl genrsa -out /home/ssohjiro/.config/sinopia/sinopia-key.pem 2048
 $ openssl req -new -sha256 -key /home/ssohjiro/.config/sinopia/sinopia-key.pem -out /home/ssohjiro/.config/sinopia/sinopia-csr.pem
 $ openssl x509 -req -in /home/ssohjiro/.config/sinopia/sinopia-csr.pem -signkey /home/ssohjiro/.config/sinopia/sinopia-key.pem -out /home/ssohjiro/.config/sinopia/sinopia-cert.pem

And then add to config file (/home/ssohjiro/.config/sinopia/config.yaml):
  https:
    key: sinopia-key.pem
    cert: sinopia-cert.pem
```

위에 가이드를 따라하자. 또한 회사 또는 한 그룹에서 npm private registry 를 관리하게될 담당자라면,
적어도 아래의 내용 정도는 알고 있어야 한다.

1. [보안용어개념을 잡게 해주는 만화. 4편정도는 필독!](http://minix.tistory.com/395)
2. [간단한 openssl 따라하기 및 아파치에서 SSL 디테일한 적용방법](https://opentutorials.org/course/228/4894)
3. [using-self-signed-ssl-certificates](https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/)
3. [using-self-signed-ssl-certificates(clone)](https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/blob/master/manual/security/using-self-signed-ssl-certificates.md)

sinopia 에서 안내하는 내용도 3번 self-signed 내용과 동일하다고 보면된다. 해보자.
먼저 private key 를 생성하자. 필자는 이 private 키들을 관리상의 이유로 한 곳에 보관하여 관리하고 싶다.
한폴더에 넣어놓고 ls -l 하였을때 가지고 있는 key들과 권한, 소유자정보를 한눈에 볼수있도록 경로는 내 맘대로한다.

먼저 private key 를 만든다
```
openssl genrsa -out sinopia-private-key.pem 2048
```
인증서 사인 요청서를 만들자
```
openssl req -new -sha256 -key sinopia-private-key.pem -out sinopia-csr.pem
```
사인받은 인증서를 발급받자
```
openssl x509 -req -in sinopia-csr.pem -signkey sinopia-private-key.pem -out sinopia-cert.pem
```
생성된 파일 3개를 확인하자
```
sinopia-private-key.pem   // 엄청중요한 절대 외부로 나가서는 안되는 비밀키
sinopia-csr.pem           // 걍 인증서정보를 암호화한것 별로 중요하진 않을듯?
sinopia-cert.pem          // 공개키. 뿌리고 다니는거.
```

중요한 파일은 private key 파일의 권한정보를 변경하자. 
```
ssohjiro@ssohjiroSeoul:~/runningServer/lmM35CSUruaxlflq$ chmod 700 .
ssohjiro@ssohjiroSeoul:~/runningServer/lmM35CSUruaxlflq$ chmod 400 sinopia-private-key.pem
ssohjiro@ssohjiroSeoul:~/runningServer/lmM35CSUruaxlflq$ ls -l
total 20
drwx------ 2 ssohjiro ssohjiro 4096 Jan 19 02:16 ./
drwxrwxr-x 6 ssohjiro ssohjiro 4096 Jan 19 02:10 ../
-rw-rw-r-- 1 ssohjiro ssohjiro 1168 Jan 19 02:16 sinopia-cert.pem
-rw-rw-r-- 1 ssohjiro ssohjiro  989 Jan 19 02:15 sinopia-csr.pem
-r-------- 1 ssohjiro ssohjiro 1675 Jan 19 02:10 sinopia-private-key.pem
```
여러가지 휴먼오류를 막기위해 여러 조치들이 들어갔다. 자 그럼 경로를 config 파일에 써주자.
~/.config/sinopia/config.yaml 파일에 아래를 추가하고,
```
# ssl settings
https:
    key: /home/ssohjiro/runningServer/lmM35CSUruaxlflq/sinopia-private-key.pem
    cert: /home/ssohjiro/runningServer/lmM35CSUruaxlflq/sinopia-cert.pem
```

다시 `sinopia --listen https://192.168.0.201:3003` 성공!
그럼 이제 원격으로부터 접속해보자.

기존의 npm config set registry http://utopos.me:3003 으로 되어있는것을 https 로 변경해야한다.
utopos.me 는 서버를 실행시킨 공유기 퍼블리 ip주소에 연결되어있는 도매인이다.
안된다. DEPTH_ZERO_SELF_SIGNED_CERT 이란 에러가 난다.

sinopia-cert.pem 파일을 원격지에서 다운받아 신뢰할수 있는 인증서로 추가시키자.
맥에선 아래와 같이 나온다. `Add` 누르자.
그리고 Keychain Access 를 실행시켜 utopos.me 를 검색한 후 (csr 를 만들때 FQDN 으로 입력한 domain)
더블클릭을 한후 Trust 트리를 열면 아래와 같이 보인다.

When using this certificate: Always trust 로 바꾸자.
cmd+w 로 닫으면서 변경을 하기위해 패스워드를 물어본다.

안된다....
`npm set strict-ssl false` 을 적용하니 되긴 한다. 하지만 중간자 공격에 insecure 한 셋팅이다.
`npm set ca null` <- 이게 시스템 ca list 를 가져온다고 되어있으나 잘 안된다. ca 인증서가 아닌 단순 사이트의 인증서이기때문인가? 

여러 시도 끝에 아래 방법이 성공!

```
npm set cafile /Users/ssohjiro/Downloads/sinopia-cert.pem
```

사실 협업해야 할 팀원들은 윈도우 사용자가 더 많다..... 갈길이 멀다 ㅎㅎ 


## Note!
공유기 환경에선 publicip 나 도매인이아니 내부 아이피로 Listen 해야한다.
서울데이터센터에는 공유기를 사용해서 원하는 포트만 포트포워딩해서 쓰고있다.
이때 public ip 나 public ip에 연결된 도매인으로 --listen 을 하면 아래와 같은 에러를 볼 수 있다.
```
fatal --- cannot create server: listen EADDRNOTAVAIL utopos.me:3003
```


## 프록시 환경 참고:
- 쉽지않다
- 프록시 환경에서 unable to verify first certicifate 에러가 자꾸뜸. 0.12.7로 성공함.
- 회사같은 proxy 환경에선 https 요청을 하면 rootCA를 회사인증서로 바꿔서 주는것 같다.
- 이런경우 회사 인증서는 걍 믿으면 되니까 아래 환경을 추가하자.
```다
process.https_proxy = "http://company.proxy.address:port";
process.http_proxy = "http://company.proxy.address:port";
process.NODE_TLS_REJECT_UNAUTHORIZED = 0;
```

