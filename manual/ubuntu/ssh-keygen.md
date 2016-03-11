### id_rsa , id_rsa.pub 를 만드는 방법이다.

```
ssh-keygen
```

여러개의 키를 관리하는 방법은 .ssh/config 파일로 관리하는 것이다.
```
Host myshortname realname.example.com
    HostName realname.example.com
    IdentityFile ~/.ssh/realname_rsa # private key for realname
    User remoteusername

Host myother realname2.example.org
    HostName realname2.example.org
    IdentityFile ~/.ssh/realname2_rsa
    User remoteusername
```
