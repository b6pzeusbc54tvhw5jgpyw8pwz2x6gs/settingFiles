

# 1. install

[Refer to official github](https://github.com/creationix/nvm)

# 2. postinstall
replace to system node
```
nvm list
nvm install 4.2.3
nvm list
nvm use 4.2.3
n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; sudo cp -r $n/{bin,lib,share} /usr/local
```
