echo 'im server/svnIgnore'
svn propset svn:ignore "node_modules
public
logs
dbFile
release
build" ./

#svn propset svn:ignore "bower_components" ./public
#svn propset svn:ignore "0.1.1.zip" ./release
