
### 먼저 읽어야 할것

1. [보안용어개념을 잡게 해주는 만화. 4편정도는 필독!](http://minix.tistory.com/395)

2. [간단한 openssl 따라하기 및 아파치에서 SSL 디테일한 적용방법](https://opentutorials.org/course/228/4894)

3. [using-self-signed-ssl-certificates](https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/)
3. [using-self-signed-ssl-certificates(clone)](https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/blob/master/manual/security/using-self-signed-ssl-certificates.md)

### expressjs (v4.13.1)

위 3번에서 만든 rootCA.crt, host.crt, host.key 를 사용.


- 노드 공식 문서
```javascript
const options = {
  // These are necessary only if using the client certificate authentication
  key: fs.readFileSync('client-key.pem'),
  cert: fs.readFileSync('client-cert.pem'),

  // This is necessary only if the server uses the self-signed certificate
  ca: [ fs.readFileSync('server-cert.pem') ]
};

```

bin/www 파일

```javascript
#!/usr/bin/env node

/**
 * Module dependencies.
 */

var app = require('../app');
var debug = require('debug')('server:server');
var http = require('http');
var https = require('https');
var fs = require('fs');

var privateKey = fs.readFileSync('ssl/host.key');
var certificate = fs.readFileSync('ssl/host.crt');
var caCertificate = fs.readFileSync('ssl/rootCA.crt');

/**
 * Get port from environment and store in Express.
 */

var port = normalizePort(process.env.PORT || '3000');
app.set('port', port);

/**
 * Create HTTP server.
 */

var server = http.createServer( app);
var httpsServer = https.createServer({
  key: privateKey,
  cert: certificate,
  ca: caCertificate
//  requestCert: true,
//  rejectUnauthorized: true
}, app);

/**
 * Listen on provided port, on all network interfaces.
 */

server.listen(port);
httpsServer.listen(443);

// skip rest
```

`rejectUnauthorized`, `requestCert` 이 두 값을 모두 true로 주면 서버도 클라이언트의 비밀키에 대한 공개키를 요구하고
이 공개키를 인증하는 인증기관의 인증서가 있어야 접속이 되는 것 같다.
어느 상황에 쓰는건지 잘 모르겠다.

### in Client Side
브라우저 에서 접속하면 경고가 뜨면서 https 부분을 클릭하면 rootCA.crt 를 export 할수 있다.
저장시키고 브라우저 셋팅에서 import시켜서 trust 체크해주면된다.
맥에선 keychain 에 드래그해서 추가 할수 있다.

### 참고
[80, 443 포트를 sudo 없이 쓰려면 참고](https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/blob/master/manual/node/howToUsePort80.md)
