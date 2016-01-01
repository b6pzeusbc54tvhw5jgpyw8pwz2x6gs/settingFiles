우분우 14.04 에서는 preload 되어있는 vim 이 7.4 버전이라 따로 최신버전을 깔아줄 필요가 없다.
하지만 아래처러 Small version 이라 몇몇 플러그인들이 동작을 안한다.

```
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Jan  2 2014 19:39:02)
Included patches: 1-52
Modified by pkg-vim-maintainers@lists.alioth.debian.org
Compiled by buildd@
Small version without GUI.  Features included (+) or not (-):
+acl             -farsi           -mouse_sgr       -tag_old_static
-arabic          -file_in_path    -mouse_sysmouse  -tag_any_white
-autocmd         -find_in_path    -mouse_urxvt     -tcl
-balloon_eval    -float           -mouse_xterm     +terminfo
-browse          -folding         +multi_byte      -termresponse
+builtin_terms   -footer          -multi_lang      -textobjects
-byte_offset     +fork()          -mzscheme        -title
-cindent         -gettext         -netbeans_intg   -toolbar
-clientserver    -hangul_input    -path_extra      -user_commands
-clipboard       +iconv           -perl            -vertsplit
-cmdline_compl   -insert_expand   -persistent_undo -virtualedit
+cmdline_hist    +jumplist        -printer         +visual
-cmdline_info    -keymap          -profile         -visualextra
-comments        -langmap         -python          -viminfo
-conceal         -libcall         -python3         -vreplace
-cryptv          -linebreak       -quickfix        +wildignore
-cscope          -lispindent      -reltime         -wildmenu
-cursorbind      -listcmds        -rightleft       +windows
-cursorshape     -localmap        -ruby            +writebackup
-dialog          -lua             -scrollbind      -X11
-diff            -menu            -signs           +xfontset
-digraphs        -mksession       -smartindent     -xim
-dnd             -modify_fname    -sniff           -xsmp
-ebcdic          -mouse           -startuptime     -xterm_clipboard
-emacs_tags      -mouse_dec       -statusline      -xterm_save
-eval            -mouse_gpm       -sun_workshop    -xpm
-ex_extra        -mouse_jsbterm   -syntax
-extra_search    -mouse_netterm   -tag_binary
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
  fall-back for $VIM: "/usr/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -DTINY_VIMRC -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
Linking: gcc   -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed -o vim    -lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM -lICE  -lm -ltinfo  -lselinux -lacl -lattr -ldl
```

`sudo apt-get install vim` 으로 설치한번 해주면,
Small version 에서 아래처럼 Huge version으로 업그레이드 되는 것을 볼 수 있다.
+python 기능도 enable 되어있다.
패치 버전이 좀 낮지만 따로 소스다운-컴파일 없이 충분히 쓸수 있는 버전이라 굳.

```
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Jan  2 2014 19:39:32)
Included patches: 1-52
Modified by pkg-vim-maintainers@lists.alioth.debian.org
Compiled by buildd@
Huge version without GUI.  Features included (+) or not (-):
+acl             +farsi           +mouse_netterm   +syntax
+arabic          +file_in_path    +mouse_sgr       +tag_binary
+autocmd         +find_in_path    -mouse_sysmouse  +tag_old_static
-balloon_eval    +float           +mouse_urxvt     -tag_any_white
-browse          +folding         +mouse_xterm     -tcl
++builtin_terms  -footer          +multi_byte      +terminfo
+byte_offset     +fork()          +multi_lang      +termresponse
+cindent         +gettext         -mzscheme        +textobjects
-clientserver    -hangul_input    +netbeans_intg   +title
-clipboard       +iconv           +path_extra      -toolbar
+cmdline_compl   +insert_expand   -perl            +user_commands
+cmdline_hist    +jumplist        +persistent_undo +vertsplit
+cmdline_info    +keymap          +postscript      +virtualedit
+comments        +langmap         +printer         +visual
+conceal         +libcall         +profile         +visualextra
+cryptv          +linebreak       +python          +viminfo
+cscope          +lispindent      -python3         +vreplace
+cursorbind      +listcmds        +quickfix        +wildignore
+cursorshape     +localmap        +reltime         +wildmenu
+dialog_con      -lua             +rightleft       +windows
+diff            +menu            -ruby            +writebackup
+digraphs        +mksession       +scrollbind      -X11
-dnd             +modify_fname    +signs           -xfontset
-ebcdic          +mouse           +smartindent     -xim
+emacs_tags      -mouseshape      -sniff           -xsmp
+eval            +mouse_dec       +startuptime     -xterm_clipboard
+ex_extra        +mouse_gpm       +statusline      -xterm_save
+extra_search    -mouse_jsbterm   -sun_workshop    -xpm
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
  fall-back for $VIM: "/usr/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -fstack-protector --param=ssp-buffer-size=4 -Wformat -Werror=format-security -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
Linking: gcc   -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,--as-needed -o vim        -lm -ltinfo -lnsl  -lselinux  -lacl -lattr -lgpm -ldl    -L/usr/lib/python2.7/config-x86_64-linux-gnu -lpython2.7 -lpthread -ldl -lutil -lm -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions
```

