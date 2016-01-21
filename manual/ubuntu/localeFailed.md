```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LC_PAPER = "ko_KR.UTF-8",
	LC_ADDRESS = "ko_KR.UTF-8",
	LC_MONETARY = "ko_KR.UTF-8",
	LC_NUMERIC = "ko_KR.UTF-8",
	LC_TELEPHONE = "ko_KR.UTF-8",
	LC_IDENTIFICATION = "ko_KR.UTF-8",
	LC_MEASUREMENT = "ko_KR.UTF-8",
	LC_TIME = "ko_KR.UTF-8",
	LC_NAME = "ko_KR.UTF-8",
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
locale: Cannot set LC_ALL to default locale: No such file or directory
```
이런에러 날 시 

`sudo vi /etc/environment`

아래 추가
```
LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LC_TYPE=en_US.UTF-8
```


