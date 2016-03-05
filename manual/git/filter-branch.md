# filter-branch

## when?

server, client, deploy code, misc_tools 프로젝트와 관련된 코드를 모두 한 project 로 두었는데, (old_project 라 하자)
서로 직접적인 디펜던시가 없는 프로젝트들이라 각각 프로젝트를 따서 관리하려고 한다.

[remove_sensitive_data.md](https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles/blob/master/manual/git/remove_sensitive_data.md) 를 참고하여 

```
java -jar bfg-1.12.8.jar --delete-folders client old_project.git
java -jar bfg-1.12.8.jar --delete-folders deploy old_project.git
java -jar bfg-1.12.8.jar --delete-folders misc_tools old_project.git
```

먼저 server 디렉토리만을 관리하는 project_server 라는 프로젝트 만드려고 나머지 폴더를 위 명령어로 지웠다. 그러자 
```
$ java -jar bfg-1.12.8.jar --delete-folders client old_project.git

SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.

Using repo : /Projects/old_project.git

Found 104 objects to protect
Found 3 commit-pointing refs : HEAD, refs/heads/master, refs/heads/prd

Protected commits
-----------------

These are your protected commits, and so their contents will NOT be altered:

 * commit 9af90085 (protected by 'HEAD')

Cleaning
--------

Found 68 commits
Cleaning commits:       100% (68/68)
Cleaning commits completed in 148 ms.

Updating 2 Refs
---------------

	Ref                 Before     After
	---------------------------------------
	refs/heads/master | 9af90085 | fb40f4a4
	refs/heads/prd    | 1faa1a9e | 4018717e

Updating references:    100% (2/2)
...Ref update completed in 24 ms.

Commit Tree-Dirt History
------------------------

	Earliest                                              Latest
	|                                                          |
	DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDm

	D = dirty commits (file tree fixed)
	m = modified commits (commit message or parents changed)
	. = clean commits (no changes to file tree)

	                        Before     After
	-------------------------------------------
	First modified commit | 3d67eca7 | fea6a8d1
	Last dirty commit     | c5bc99a0 | 938dc9cd


In total, 135 object ids were changed. Full details are logged here:
  /Projects/old_project.git.bfg-report/2016-03-05/04-10-06

BFG run is complete! When ready, run: git reflog expire --expire=now --all && git gc --prune=now --aggressive


Has the BFG saved you time?  Support the BFG on BountySource:  https://j.mp/fund-bfg
```

dirty commits 들이 많이 생긴다.
`git log --stat` 하면 파일 변경내용이 없는 그냥 빈 커밋들이 있는데 바로 dirty commit 들이다.
이 더티 커밋들을 없애려고 git rebase -i --root 를 한 후 삭제를 하고 그러느라
rebase 명령어를 열심히 배웠다.

결국 git-scm.com 공식 사이트의 e-book 에 있는 더 좋은 솔루션으로 해결함. [Git-도구-히스토리-단장하기](https://git-scm.com/book/ko/v2/Git-%EB%8F%84%EA%B5%AC-%ED%9E%88%EC%8A%A4%ED%86%A0%EB%A6%AC-%EB%8B%A8%EC%9E%A5%ED%95%98%EA%B8%B0)
참고로 나는 bare 저장소에서 하였다.
```
$ git filter-branch --subdirectory-filter server HEAD
```
추가로 email 변경도 하였다.
```
git filter-branch --commit-filter '
        if [ "$GIT_AUTHOR_EMAIL" = "schacon@localhost" ];
        then
                GIT_AUTHOR_NAME="Scott Chacon";
                GIT_AUTHOR_EMAIL="schacon@example.com";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
```

filter-branch 를 한번 하면 refs/original 폴더에 백업파일이 생기나보다.
두번째 명령어를 날린땐 이 백업 파일을 덮어쓴다는 -f 옵션을 붙여야한다.
전전 형상으로 돌아가지 못할것 같으니 주의하자.

## 결론
Git은 사실 많이 정리할게 없다. 공식 사이트의 가이드 문서와 e-book 에 너무 잘 정리되어 있다.
물론 더 깊게 공부해야하거나 대규모 프로젝트의 관리자라 수많은 예측 불가능한 문제를 해결해야하는 고수가 되려면 이 문서와 이북이 부족할수도 있겠지만 우선 내가 쓰는 범위안에선 거의 다른 참고가 필요 없을 정도였다.
