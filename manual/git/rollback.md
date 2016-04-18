# 롤백

롤백은 이전 형상으로 되돌아가는 것을 말한다.
[stackoverflow](http://stackoverflow.com/questions/1463340/revert-multiple-git-commits)

```
A -> B -> C -> D -> HEAD
```
이런 히스토리가 있다고 가정하자. A로 되돌리고 싶다. 두가지 방법이 있다.
기본적으로 `$ git revert SHA` 명령어는 SHA 커밋을 취소하는 새로운 커밋을 생성한다.

여러개의 커밋이 있다면 귀찮은 방법이다.

```
$ git revert --no-commit D
$ git revert --no-commit C
$ git revert --no-commit B
$ git commit -m'the commit message'
```

그럴땐 [checkout](https://git-scm.com/docs/git-checkout) 을 이용하자
```
$ git checkout -f A -- .
$ git commit -a
```
