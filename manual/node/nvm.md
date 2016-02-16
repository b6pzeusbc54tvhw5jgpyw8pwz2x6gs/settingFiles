# nvm

## 1. install for Ubuntu

[Refer to official github](https://github.com/creationix/nvm)

## 2. postinstall
replace to system node
```
nvm install 4.2.3
nvm list
nvm use 4.2.3
```

A. then, change your .bashrc or .profile. 
```
nvm use 4.2.3
```

B. If needed, copy to system node (Notice! it overide system node)
```
n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
```

I think A is better than B! ( for Linux, osX. )



A 선택시 sudo node, sudo npm 등이 안된다.
https://github.com/creationix/nvm/issues/43



Setting this in ~/.profile worked for me:
```
alias sudo='sudo env PATH=$PATH:$NVM_BIN'
```

It's part of the nvm installation in vagrant:

Vagrantfile
```
config.vm.provision :shell, path: "vagrant/nodejs.sh", privileged: false
```

vagrant/nodejs.sh
```
sudo su vagrant -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.26.1/install.sh | bash"

echo "
source /home/vagrant/.nvm/nvm.sh
alias sudo='sudo env PATH=\$PATH:\$NVM_BIN'
" >> /home/vagrant/.profile

export NVM_DIR="/home/vagrant/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install stable
nvm alias default stable
```
Now I can do sudo node|npm|pm2|whatever.
참고하여, `alias sudo='sudo env PATH=$PATH:$NVM_BIN'` 등록











## install for window

download and install from setup file in [https://github.com/coreybutler/nvm-windows/releases](https://github.com/coreybutler/nvm-windows/releases)
`https://github.com/coreybutler/nvm-windows/releases/download/1.1.0/nvm-setup.zip`
```
nvm proxy http://company.proxy.address:port/
nvm install 4.2.3
nvm list
nvm use 4.2.3
```

open new cmd
```
node --version
```
