
#How to mount backup disk img file

```
seoul:/media/UbuntuRaid01/151228_ubuntu_ssd$ parted Disk\ Image\ of\ sdb\ \(2015-12-29\ 0235\).img
WARNING: You are not superuser.  Watch out for permissions.
GNU Parted 2.3
Using /media/UbuntuRaid01/151228_ubuntu_ssd/Disk Image of sdb (2015-12-29 0235).img
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) u
Unit?  [compact]? B
(parted) print
Model:  (file)
Disk /media/UbuntuRaid01/151228_ubuntu_ssd/Disk Image of sdb (2015-12-29 0235).img: 120034123776B
Sector size (logical/physical): 512B/512B
Partition Table: msdos

Number  Start     End            Size           Type     File system  Flags
 1      1048576B  120033640447B  120032591872B  primary  ext4         boot

(parted) ^C
(parted) q

seoul:/media/UbuntuRaid01/151228_ubuntu_ssd$ sudo mkdir /media/backupDisk
seoul:/media/UbuntuRaid01/151228_ubuntu_ssd$ sudo mount -o loop,offset=1048576 Disk\ Image\ of\ sdb\ \(2015-12-29\ 0235\).img /media/backupDisk/
```



## Note!
ssh 로 열었는데 파일탐색기(nautilus)가 열린다.
문제가 될수 있으므로 꺼야함
gsettings set org.gnome.desktop.media-handling automount-open false
