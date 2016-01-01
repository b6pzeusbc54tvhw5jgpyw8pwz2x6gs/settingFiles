[Refer to that blog](http://www.rackspace.com/knowledge_center/article/multiple-repositories-and-subversion)

mkdir repositories
svnadmin create repositories/repo1
vi repositories/repo1/conf/svnserve.conf
remove comment
anon-access = read
auth-access = write
password-db = passwd

vi repositories/repo1/conf/svnserve.conf (for passwd)

cd ~/projects/
mkdir project1
touch project1/initFile.txt
svn import project1 file:///home/ssohjiro/repositories/... -m “import project1”
또는
svn import project1 file:///home/ssohjiro/repositories/... -m “import project1”

(svnserve -d -r /home/ssohjiro/repositores)

rm -rf proejct1
svn co file:///home/ssohjiro/repositories/... project1


.svnignore 파일에 svn 예외파일들을 넣어놓고,
svn propset svn:ignore -F .svnignore .
