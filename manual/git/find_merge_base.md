[from stackoverflow](http://stackoverflow.com/questions/1549146/find-common-ancestor-of-two-branches)


```
$ git merge-base A B
```

You may also be interested in the shorthand:
```
$ git log master...HEAD
```

```
$ git log -1 $(git merge-base branchA branchB) 
```
