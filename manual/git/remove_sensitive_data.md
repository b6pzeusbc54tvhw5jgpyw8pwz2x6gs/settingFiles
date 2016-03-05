# Remove sensitive data

## 공식페이지
https://help.github.com/articles/remove-sensitive-data/

## 공식페이지에서 추천해주는 BFG Repo-Cleaner 
https://rtyley.github.io/bfg-repo-cleaner/


.passwd 라는 민감한 파일을 실수로 commit 후 원격저장소에 push 해버렸다고 가정하자.
그냥 삭제하고 commit 을 다시하여도 history에 남아 누구라도 해당 리비전에 접근할 수 있다.

.passwd 는 물론 이 파일의 history까지 전부 지워보자.

```
$ git clone --mirror https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles.git

Cloning into bare repository 'settingFiles.git'...
remote: Counting objects: 546, done.
remote: Compressing objects: 100% (179/179), done.
remote: Total 546 (delta 83), reused 0 (delta 0), pack-reused 367
Receiving objects: 100% (546/546), 90.23 KiB | 84.00 KiB/s, done.
Resolving deltas: 100% (254/254), done.
Checking connectivity... done.

$ java -jar bfg-1.12.8.jar --delete-files .passwd settingFiles.git

SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.

Using repo : /Users/ssohjiro/settingFiles.git

Found 50 objects to protect
Found 6 commit-pointing refs : HEAD, refs/heads/b6pzeusbc54tvhw5jgpyw8pwz2x6gs-patch-1, refs/heads/master, ...

Protected commits
-----------------

These are your protected commits, and so their contents will NOT be altered:

 * commit 379d148f (protected by 'HEAD')

Cleaning
--------

Found 144 commits
Cleaning commits:       100% (144/144)
Cleaning commits completed in 112 ms.

Updating 4 Refs
---------------

	Ref                 Before     After
	---------------------------------------
	refs/heads/master | 379d148f | 3d48eb08
	refs/pull/1/head  | 8fd7b606 | b603aaa4
	refs/pull/2/head  | d4102c1d | 2e1cf802
	refs/pull/3/head  | 4e3b3a70 | 2654e0e6

Updating references:    100% (4/4)
...Ref update completed in 25 ms.

Commit Tree-Dirt History
------------------------

	Earliest                                              Latest
	|                                                          |
	.DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD........Dm

	D = dirty commits (file tree fixed)
	m = modified commits (commit message or parents changed)
	. = clean commits (no changes to file tree)

	                        Before     After
	-------------------------------------------
	First modified commit | 6b41677c | ff0c494c
	Last dirty commit     | dc619226 | b7284df0

Deleted files
-------------

	Filename   Git id
	---------------------------
	.passwd   | 707487b4 (197 B)


In total, 125 object ids were changed. Full details are logged here:

	/Users/ssohjiro/settingFiles.git.bfg-report/2016-02-08/03-31-02

BFG run is complete! When ready, run: git reflog expire --expire=now --all && git gc --prune=now --aggressive


Has the BFG saved you time?  Support the BFG on BountySource:  https://j.mp/fund-bfg
```
이후 하단에서 실행하라는 명령어를 한번 실행시켜주고 push 하면 끝
```
cd settingFiles.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push
```

push 후 이런 에러 메시지가 떴는데,

```
Counting objects: 424, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (186/186), done.
Writing objects: 100% (424/424), 71.58 KiB | 0 bytes/s, done.
Total 424 (delta 208), reused 424 (delta 208)
To https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles.git
 * [new branch]      b6pzeusbc54tvhw5jgpyw8pwz2x6gs-patch-1 -> b6pzeusbc54tvhw5jgpyw8pwz2x6gs-patch-1
 * [new branch]      master -> master
 ! [remote rejected] refs/pull/1/head -> refs/pull/1/head (deny updating a hidden ref)
 ! [remote rejected] refs/pull/2/head -> refs/pull/2/head (deny updating a hidden ref)
 ! [remote rejected] refs/pull/3/head -> refs/pull/3/head (deny updating a hidden ref)
error: failed to push some refs to 'https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles.git'
```
pull request 용으로 잠깐 만들었다 지운 branch를 참조할 수 없어서 나는 에러같음.
현재 존재하는 브랜치인 b6pzeusbc54tvhw5jgpyw8pwz2x6gs-patch-1, master 브랜치는 잘 적용됨


## 참고

--mirror 로 클론 받았다는 것은 repo 정보 전체를 받은것이다.
모든 커밋 히스토리에서 .passwd 파일관련 정보를 찾아지운것이고,
이걸 통째로 다시 push 하는것 같다.

테스트로 config 파일의 아래 url정보를 바꾸고, github 에서 바꾼이름으로 새 repo 를 받을고 `git push` 해보니
모든 히스토리가 ( .passwd 파일은 지워진채로 ) 잘 push 되었다.
```
[remote "origin"]
	url = https://github.com/b6pzeusbc54tvhw5jgpyw8pwz2x6gs/settingFiles_new.git
```


## 결론
이런 실수를 하게되면 저장소를 깨끗하게 삭제하고 지금 형상을 복사하여 새로운 저장소로 이주해야하나
그렇게 하면 history 가 다 날라갈텐데... 이런 고민을 했었는데 역시 누군가는 먼저 고민하여
정말로 편리한 솔루션을 무료로 제공해주고 있다.

Has the BFG saved you time?  Support the BFG on BountySource:  https://j.mp/fund-bfg

bfg 실행 결과의 마지막 문구이다.

시간은 돈으로 살 수 없다. 하지만 누군가는 한푼도 받지 않고 자신의 소중한 시간을 타인에게 배푼다.
이름도 모르는 누군가에게.

감사하며 Flattr! 오랜만에 기분좋은 기부~




### 20160305 추가

bfs 로 파일을 삭제한 후 어떤 변경하지 않는 커밋들이 생길 수 있다.
`git rebase` 를 이용하여 이런 커밋들을 다른 커밋과 합쳐서 클린하게 만들수 있다.
```
$ git rebase -i HEAD~1
```
--interactive 옵션을 붙이면 에디터등이 열리며 앞의 명령어를 수정하며 작업을 할 수 있다.
```
pick fb40f4a Separate only the server from the unified project

# Rebase 938dc9c..fb40f4a onto 938dc9c
#
# Commands:
#  p, pick = use commit
#  r, reword = use commit, but edit the commit message
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#  f, fixup = like "squash", but discard this commit's log message
#  x, exec = run command (the rest of the line) using shell
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

HEAD~1 로 하여 1개만 뜬것이구 이런 아무것도 변경하지 않는 커밋들이 여러개라면
HEAD~3, HEAD~4 처럼 원하는 만큼 합쳐버릴수 있다.



