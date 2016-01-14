### partitioning
sudo parted



### format

parted print all 등으로 /dev/sdb1 이걸 알아낸후
sudo mkfs.ext4 /dev/sdb1

mkfs.ext4 /dev/sdb
또는
mkfs.ext4 /dev/sdb1
