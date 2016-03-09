

```
sudo vi /etc/ssh/sshd_config
sudo restart ssh

sudo vi /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure
```

repo address 가 아래와 같이 바뀔것임.
```
ssh://git@123.123.123.123:23/userid/my_project.git
```
