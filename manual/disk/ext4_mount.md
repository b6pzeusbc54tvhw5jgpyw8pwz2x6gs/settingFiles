

#1. mount, chown

ext[234] 들은 -o uid=ssohjiro 등이 먹지 않는다, 
그냥 mount 한 후 chown 을 돌리거나 /etc/fstab 을 해줘야한다.

예는 ext4 파티션 1개로 이루어진 disk 를 마운트 하는 방법이다.
파티션이 1개 이상일 경우 /dev/sde1 /dev/sde2 이런 식으로 되지 않을까?


```
sudo mkdir /media/diskE
sudo mount /dev/sde /media/diskE
```

partition 라벨 이름으로 하고 싶다면
```
sudo e2label /dev/sde 로 label 을 알아낸 후 ( ex: NonRaid02 )
sudo mkdir /media/NonRaid02
sudo mount /dev/sde /media/NonRaid02
```

또는
```
sudo mkdir /media/`sudo e2label /dev/sde` -p
sudo mount /dev/sde /media/`sudo e2label /dev/sde`
```

디스크 쓰기 권한등을 가져오기 위해 chown 명령어가 필요하면 해준다
```
sudo chown -R ssohjiro:ssohjiro /media/NonRaid02
```
위 명령어는 영구적으로 디스크에 있는 모든 파일 및 디렉토리 소유자와 그룹을 변경한다


#2. /etc/fstab
아래를 추가한다
`UUID=disk_uuid  /media/NonRaid02       ext4    defaults        0       2`

Note!
물리 키보드를 조작할 수 없는 원격 서버의 경우 `nobootwait` 옵션을 추가하는 것이 좋다.
타이핑 실수 등으로 위의 코드가 잘못 될 경우 skip 할꺼냐 recover manually 할꺼냐 고르는 메뉴가 나오면서
부팅을 hold 시킨다. ssh 접속이 되지 않기 때문에 원격으론 아무것도 할 수 없는 상태!! 
실수를 대비해 아래와 같이 해주는 것이 좋다.
`UUID=disk_uuid  /media/NonRaid02       ext4    nobootwait        0       2`

/media/NonRaid02 디렉토리는 존재해야함
disk uuid 는 `ls -l /dev/disk/by-uuid/` 명령어로확인


#3. 결론
1회성으로 할땐 #1번 사용 및 sudo 명령어로 파일 편집 및 사용
매번 해줘야 하는 경우 #1번을 startup.sh 스크립트에 넣어서 서버가 리부트 할 때마다 매번 실행해주곤 했었는데
생각해보면 2번의 방법이 더 괜찮은것 같다.

Refer to
[askubuntu](http://askubuntu.com/questions/232790/automount-ext4-partition-with-user-permission-ownership-fstab)
[/etc/fstab/](https://en.wikipedia.org/wiki/Fstab)
