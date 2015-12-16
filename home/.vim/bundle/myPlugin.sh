#!/bin/bash

#mkdir -p ~/.vim/autoload ~/.vim/bundle; \
#curl -Sso ~/.vim/autoload/pathogen.vim \
#https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/wavded/vim-stylus.git
git clone https://github.com/marijnh/tern_for_vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/Lokaltog/vim-easymotion.git
git clone https://github.com/digitaltoad/vim-jade.git
git clone https://github.com/majutsushi/tagbar.git
git clone https://github.com/vim-scripts/DirDiff.vim.git
git clone https://github.com/bling/vim-airline.git
git clone https://github.com/groenewege/vim-less.git
git clone https://github.com/aaronj1335/underscore-templates.vim.git
git clone https://github.com/chrisbra/SudoEdit.vim.git

git clone https://github.com/Shougo/neosnippet.vim.git
git clone https://github.com/Shougo/neocomplcache.vim.git
git clone https://github.com/Shougo/neosnippet-snippets.git

git clone https://github.com/gregsexton/MatchTag.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/tpope/vim-unimpaired

git clone https://github.com/juneedahamed/vc.vim

#git clone https://github.com/vim-scripts/sql.vim--Stinson.git
#git clone https://github.com/vim-scripts/SQLUtilities.git

#git clone https://github.com/xolox/vim-easytags.git
#git clone https://github.com/xolox/vim-misc.git

#git clone https://github.com/brookhong/cscope.vim.git
#git clone https://github.com/vim-scripts/a.vim.git
#git clone https://github.com/vim-scripts/edc-support.git
#git clone https://github.com/hallettj/jslint.vim.git
#git clone https://github.com/nathanaelkane/vim-indent-guides.git
#git clone https://github.com/joeytwiddle/sexy_scroller.vim.git

cp -iv javascript.snip neosnippet-snippets/neosnippets/
