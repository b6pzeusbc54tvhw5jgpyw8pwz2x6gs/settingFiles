## ext4 파티션 1개로 이루어진 disk 를 마운트 하는 방법

sudo mkdir /media/diskE
sudo mount /dev/sde /media/diskE

partition 라벨 이름으로 하고 싶다면

sudo e2label /dev/sde 로 label 을 알아낸 후 ( ex: NonRaid02 )
sudo mkdir /media/NonRaid02
sudo mount /dev/sde /media/NonRaid02

또는
sudo mkdir /media/`sudo e2label /dev/sde` -p
sudo mount /dev/sde /media/`sudo e2label /dev/sde`
