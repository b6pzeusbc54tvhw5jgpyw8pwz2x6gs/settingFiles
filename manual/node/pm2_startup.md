
```
ssohjiro@ubuntuParallels:~$ pm2 startup
[PM2] You have to run this command as root. Execute the following command:
      sudo su -c "env PATH=$PATH:/usr/local/bin pm2 startup linux -u ssohjiro --hp /home/ssohjiro"
```

`sudo su -c "env PATH=$PATH:/usr/local/bin pm2 startup linux -u ssohjiro --hp /home/ssohjiro"` 
이부분을 복붙으로 실행

`pm2 start process.json` 명령어로 리부트 후에 자동으로 실행될 프로세스들을 실행시킴.
`pm2 list` 명령어로 프로세스들이 잘 떠있나 확인
`pm2 save` 명령어로 프로세스들을 실행 시켰을시 당시 실행 환경 등을 dump! ~/.pm2/dump.pm2 파일로 저장

### reboot!

이제 dump.pm2 파일에 있는대로 재부팅 후 프로세서들을 다시 실행함.

실행 스크립트인 process.json 파일이 변경되었다면 다시 `pm2 save` 필요.


### 80번 포트는 아마 권한문제로 실행이 안될꺼임. manual 따로 있음.
