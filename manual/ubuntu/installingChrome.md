
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# or

wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb

sudo dpkg i https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```

```
$ sudo dpkg -i google-chrome-stable_current_amd64.deb 
Selecting previously unselected package google-chrome-stable.
(Reading database ... 170280 files and directories currently installed.)
Preparing to unpack google-chrome-stable_current_amd64.deb ...
Unpacking google-chrome-stable (47.0.2526.111-1) ...
dpkg: dependency problems prevent configuration of google-chrome-stable:
 google-chrome-stable depends on libappindicator1; however:
  Package libappindicator1 is not installed.

dpkg: error processing package google-chrome-stable (--install):
 dependency problems - leaving unconfigured
Processing triggers for gnome-menus (3.10.1-0ubuntu2) ...
Processing triggers for desktop-file-utils (0.22-1ubuntu1) ...
Processing triggers for bamfdaemon (0.5.1+14.04.20140409-0ubuntu1) ...
Rebuilding /usr/share/applications/bamf-2.index...
Processing triggers for mime-support (3.54ubuntu1.1) ...
Processing triggers for man-db (2.6.7.1-1ubuntu1) ...
Errors were encountered while processing:
 google-chrome-stable
 
 
 
 
 
$ sudo apt-get install libappindicator1
Reading package lists... Done
Building dependency tree       
Reading state information... Done
You might want to run 'apt-get -f install' to correct these:
The following packages have unmet dependencies:
 libappindicator1 : Depends: libindicator7 (>= 0.4.90) but it is not going to be installed
E: Unmet dependencies. Try 'apt-get -f install' with no packages (or specify a solution).





$ sudo apt-get -f install 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Correcting dependencies... Done
The following extra packages will be installed:
  libappindicator1 libindicator7
The following NEW packages will be installed:
  libappindicator1 libindicator7
0 upgraded, 2 newly installed, 0 to remove and 248 not upgraded.
1 not fully installed or removed.
Need to get 39.9 kB of archives.
After this operation, 201 kB of additional disk space will be used.
Do you want to continue? [Y/n] 
```
