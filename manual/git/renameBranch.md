```
git branch -m old_branch_name new_branch_name
```

### delete push
```
git push origin :old_branch_name
```
만약 github 에 old_branch_name 이 default branch 이었다면 delete 푸시가 안된다
default branch 를 아무걸로 살짝 바꿔주고 ( github setting ) 다시 명령어 ㄱ

### create push
git push --set-upstream origin new_branch_name
