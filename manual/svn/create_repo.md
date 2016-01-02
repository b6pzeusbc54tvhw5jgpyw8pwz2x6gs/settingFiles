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
```

import 를 하자
```
// from remote
corcoFile$ ls
//test.corco
corcoFile$ svn import . svn://utopos.me/repo1/trunk -m "import to svn project"
이게 체크아웃 된 것은 아니다. 체크하웃은 따로 해야함.
svn co svn://utopos.me/corcoFiles/trunk corcoFiles

// from local
cd ~/projects/
mkdir project1
touch project1/initFile.txt
svn import project1 file:///home/ssohjiro/svnRepos/... -m “import project1”
또는
svn import project1 file:///home/ssohjiro/svnRepos/... -m “import project1”

(svnserve -d -r /home/ssohjiro/repositores)

rm -rf proejct1
svn co file:///home/ssohjiro/svnRepos/... project1


.svnignore 파일에 svn 예외파일들을 넣어놓고,
svn propset svn:ignore -F .svnignore .
```
