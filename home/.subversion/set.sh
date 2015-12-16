sudo cp vimdiffForSvn /usr/bin/
sudo cp vimMergeForSvn /usr/bin/
sudo chmod a+x /usr/bin/vimdiffForSvn
echo "export SVN_MERGE=/usr/bin/vimMergeForSvn" >> ~/.bashrc
