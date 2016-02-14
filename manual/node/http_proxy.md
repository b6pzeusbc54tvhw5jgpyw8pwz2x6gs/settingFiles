## http_proxy.md

### 서론
회사에 들어와서 proxy 라는 것을 알았다. 사내에서 인터넷에 접속하기 위해 거쳐서 나가는 관문 같은것.

최근에 node 웹서버를 6개씩 띄우며 작업을 하고 있다. 뒤에 포트만 다르게 해서...
접속하여 사용할땐 https://my.ip.address:3003, https://my.ip.address:3010, https://my.ip.address:3015 등으로
포트를 다르게해가며 사용하고 있어서 다 외울수도 없고 매번 헷갈린다.

vhost를 사용하여, 하나의 프로세스를 띄운 후 직접 각 6개 각 express 서버의 app 을 가져와
들어온 요청들을 보내주는 방법도 있지만, vhost 서버와 디펜던시가 걸리는 것도 그렇고 6개중 어느 한 서버가 수정되었을때
vhost 서버를 껏다켜야 하는 것이나(모든 서버가 껏다켜지겠지) 싱글스레드인 자바스크립트의 성능문제로 아무 상관없는 다른 서버에 영향을 받을 수 있는 문제등으로

http-proxy 를 사용하여 해결하고자 한다.
간단하게 아파치웹서버를 사용한다면 설정파일을 수정하여 구현이 가능한거지만
잘 모르는 아파치보다 그래도 조금은 더 잘 아는 또 더 잘 알고 싶은 node서버로 모두 구현해보고 싶은 마음.

아파치 서버로 구현하는 방법은 좋은 참고가 많다
http://blog.naver.com/zsgth/140207650018

아무튼,
프록시가 사내에서 나가는 인터넷에만 쓰이는 용어가 아닌 들어오는 트래픽을 한곳으로 모을때도 쓰인다는 것을 알았다.


### 해보자

https://www.npmjs.com/package/http-proxy

역시 100마디 설명보단 코드 몇줄이 보기 좋을 것 이다.

```
var http = require('http');
var httpProxy = require('http-proxy');

var proxy = httpProxy.createProxyServer({});
var server = http.createServer( function( req, res ) {

  if( req.headers.host === 'static.localhost' ) {
    proxy.web( req, res, { target:'http://localhost:3081' });
  } else if( req.headers.host === 'localhost' ) {
    proxy.web( req, res, { target:'http://localhost:3015' });
  }
});

server.listen( 3080 );
console.log('start proxy');
```

예를들어 naver.com 이라는 dns 를 사용할땐
m.naver.com
music.naver.com
movie.naver.com 등의 서브 도매인들을 구분하여 분배시켜주게된다.


조금 개선한 버전

```
var _ = require('underscore');
var http = require('http');
var httpProxy = require('http-proxy');

var proxy = httpProxy.createProxyServer({});
var port = process.env.PORT;

var mapInfoList = [
  { host: 'localhost', target: 'http://localhost:3081' },
  { host: 'pc.localhost', target: 'http://localhost:3015' }
];

var server = http.createServer( function( req, res ) {

  var mapInfo = _.findWhere( mapInfoList, { host: req.headers.host });

  if( ! mapInfo ) {
    return;
  }

  proxy.web( req, res, { target: mapInfo.target });
});

server.listen( port );

console.log('mapInfoList: ')
console.log( JSON.stringify( mapInfoList, null, 2) );
console.log('proxy-server now listen to port: ' + port );
```


예제에선 localhost, pc.localhost 등 localhost 앞에 sub domain 을 붙여서
전부 127.0.0.1 로 돌려야 하기 때문에 /etc/hosts 에 `127.0.0.1  *.localhost` 를 추가하였다.

클론하여 실행 할 수 있는 예제 github 참고
https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/node-proxy-server
