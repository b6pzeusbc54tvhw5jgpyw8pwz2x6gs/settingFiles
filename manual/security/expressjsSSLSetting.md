
### 먼저 읽어야 할것

1. [보안용어개념을 잡게 해주는 만화. 4편정도는 필독!](http://minix.tistory.com/395)

2. [간단한 openssl 따라하기 및 아파치에서 SSL 디테일한 적용방법](https://opentutorials.org/course/228/4894)

3. [using-self-signed-ssl-certificates](https://help.github.com/enterprise/11.10.340/admin/articles/using-self-signed-ssl-certificates/)

### expressjs (v4.13.1)

위 3번에서 만든 rootCA.crt, host.crt, host.key 를 사용.

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

/**
 * Get port from environment and store in Express.
 */

var port = normalizePort(process.env.PORT || '3000');
app.set('port', port);

/**
 * Create HTTP server.
 */

var server = http.createServer( app);
var httpsServer = https.createServer({ key: privateKey, cert: certificate }, app);

/**
 * Listen on provided port, on all network interfaces.
 */

server.listen(port);
httpsServer.listen(443);

server.on('error', onError);
server.on('listening', onListening);

/**
 * Normalize a port into a number, string, or false.
 */

function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}

/**
 * Event listener for HTTP server "error" event.
 */

function onError(error) {
  if (error.syscall !== 'listen') {
    throw error;
  }

  var bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
      break;
    case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
      break;
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */

function onListening() {
  var addr = server.address();
  var bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port;
  debug('Listening on ' + bind);
}
```
