[Refer to that blog](http://www.rackspace.com/knowledge_center/article/multiple-repositories-and-subversion)
```
mkdir svnRepos

cd svnRepos
svnadmin create --compatible-version 1.7 repo1

cd repo1
vi conf/svnserve.conf
remove "#"
anon-access = read
auth-access = write
password-db = passwd

vi conf/passwd (for passwd)

//절대경로로 서버 실행
svnserve -d -r /home/ssohjiro/svnRepos

```

import 를 하자
```
// from remote
corcoFiles$ ls
//test.corco
corcoFiles$ svn import . svn://utopos.me/repo1/trunk -m "import to svn project"
이게 체크아웃 된 것은 아니다. 체크하웃은 따로 해야함.
cd ..
rm -rf corcoFiles
svn co svn://utopos.me/corcoFiles/trunk corcoFiles

// from local

corcoFiles$ svn import . file:///home/ssohjiro/svnRepos/repo1/trunk -m “import to svn project"
cd ..
rm -rf corcoFiles
svn co file:///home/ssohjiro/svnRepos/repo1/trunk corcoFiles

로컬에서도 svn:// 잘 되는듯?
(svn co svn://utopos.me/corcoFiles/trunk corcoFiles)
```
