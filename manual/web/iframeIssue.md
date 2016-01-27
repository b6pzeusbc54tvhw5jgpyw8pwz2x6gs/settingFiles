
###재현경로

1. hash change
2. iframe 에서 url 이동 후 iframe 을 제거
3. HW_BACK 버튼
4. hash change 로 뒤로 가야할 main frame 이 page reload를 한다(서버요청)

###재현환경
1. Linux Chrome 47, OSX Chrome 47

###솔루션
1. iframe 에 load 이벤트 걸고 url 움직임을 감시하자
2. iframe 을 열때와 닫을때의 history.length 를 비교하자

```
// html
<iframe id="sub" name="sub"></iframe>

// js
var frame = window.frames["sub"];

		var h = [];
		$('iframe').on('load', function() {
			//h.push( iframe.location.href );
			console.log( 'hfffi' );
			console.log( frame.window.location.href );
			console.log( frame.window.history.length );
		});
```
