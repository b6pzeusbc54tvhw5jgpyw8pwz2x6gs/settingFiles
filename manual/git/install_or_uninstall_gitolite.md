# gitolite 설치

https://git-scm.com/book/ko/v1/Git-%EC%84%9C%EB%B2%84-Gitolite

요거 따라하면됨.

공개키만드는 과정은 요 링크.

https://git-scm.com/book/ko/v2/Git-%EC%84%9C%EB%B2%84-SSH-%EA%B3%B5%EA%B0%9C%ED%82%A4-%EB%A7%8C%EB%93%A4%EA%B8%B0


비밀키-공개키 개념을 확실히 모른다면 그냥 하지 말것.


# uninstall

더 나은 개발자 환경을 위해 gitlab 을 사용하기 시작했다.
gitlab 도 처음엔 gitolite 디펜던시가 있었다고한다.
gitolite 는 process가 항상 떠있지 않고 git hook 을 이용하여 구동되기 때문에
[공식 가이드](http://gitolite.googlecode.com/git-history/f023591183365980d11c1ba352461bea9863746f/doc/uninstall.html)대로 git 유저 홈 디렉토리로 가서 관련 데이터를 삭제하는 것으로 간단하게 gitolite 를 삭제할 수 있다.

gitlab 도 똑같이 git 이라는 user 명을 사용하므로 gitlab을 설치하면 git 계정의 홈 디렉토리등이 변경되는 이유로
gitlite 로 운영되던 remote git 저장소는 더이상 접근 할 수 없게된다.
홈 디렉토리를 다시 셋팅해주거나 하는 몇가지 작업을 거치면 동시에 쓰는것도 가능할 듯 보이나
굳이 gitolite와 gitlab을 동시에 사용하며 삶의 질을 떨어뜨리고 싶지 않다.




