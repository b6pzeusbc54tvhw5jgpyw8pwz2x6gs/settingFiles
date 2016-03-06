# 설치

## 중복 가이드는 싫으니 여기보고 알아서~
https://about.gitlab.com/downloads/#ubuntu1404

## 그후
```
$ sudo gitlab-ctl tail
```
```
2016-03-05_22:43:08.25646 2016/03/06 07:43:07 [emerg] 7830#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:08.75666 2016/03/06 07:43:07 [emerg] 7830#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:09.25682 2016/03/06 07:43:07 [emerg] 7830#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:09.75701 2016/03/06 07:43:07 [emerg] 7830#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:10.25715 2016/03/06 07:43:07 [emerg] 7830#0: still could not bind()
2016-03-05_22:43:10.26949 2016/03/06 07:43:10 [emerg] 7851#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:10.76967 2016/03/06 07:43:10 [emerg] 7851#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:11.26986 2016/03/06 07:43:10 [emerg] 7851#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:11.77004 2016/03/06 07:43:10 [emerg] 7851#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:12.27022 2016/03/06 07:43:10 [emerg] 7851#0: bind() to 0.0.0.0:80 failed (98: Address already in use)
2016-03-05_22:43:12.77037 2016/03/06 07:43:10 [emerg] 7851#0: still could not bind()
```
80포트를 이미 다른 웹서버나 프로세스가 사용하고 있을때 이런 warning 로그가 계속 올라오는것이 보인다.

포트를 돌려보자. [stackoverflow](http://stackoverflow.com/questions/25393370/gitlab-nginx-problems-nginx-emerg-bind-to-0-0-0-080-failed-98-address)
```
$ sudo vi /etc/gitlab/gitlab.rb
modify external_url "http://domain:NewPort"
$ sudo gitlab-ctl reconfigure
```
또는 external_url 에 domain 까지만 쓰고
```
modify external_url "http://domain"
```
아래 주석을 해제하고 포트를 쓰는게 좋다. http, 그 아래 https 포트까지 원하는 포트로 설정할수 있다.
```
nginx['listen_port'] = 8070
```
