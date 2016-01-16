/*jshint devel:true, node:true, undef:true, unused:strict*/
// 위를 지우고 에러 찾아봥

var express = require('express');
var issueRoom = require('../myModule/issueRoom');
var router = express.Router();
var _ = require('underscore');
var logger = require('tracer').colorConsole();
var count = 0;

function sendFirstPage( res, options ) {

	options = options || {};

	//logger.debug( issueRoom.commentColl.length );

	logger.info( count++ );
	logger.debug('send firstPage');

	//res.append("X-UA-Compatible", "IE=edge");
	res.setHeader('X-UA-Compatible', 'IE=edge');

	var data = options.room.getData();

	var now = Date.now();

	if( options.useCache && room.renderedView ) {
		logger.info('res.send( html ); from cache');
		res.send( room.renderedView );
	} else {
		logger.info('res.render( html ); by new rendering');
		res.render('index', {
			title: options.room.title,
			commentList: data.commentColl.toJSON(),
			contents: data.contents
		}, function( err, renderedView ) {
			room.renderedView = renderedView;
			setTimeout( function() {
				delete room.renderedView;
			}, 30 * 1000 );
		});
	}

	logger.info( '걸린시간: ' +  (Date.now() - now) );
}

router.get('/:seqIdOrTitle', function(req, res, next) {

	logger.info( 'Server received "' + req.params.seqIdOrTitle + "'");
	//logger.debug( issueRoom.syncPromise );

	var seqIdOrTitle = req.params.seqIdOrTitle;
	var seq, title;

	if( _.isNaN( Number(seqIdOrTitle) )) {
		title = seqIdOrTitle;
		seqId = issueRoom.getSeqIdByTitle( title );
		if( ! seqId ) {
			logger.info( 'no seqId' );
			return res.send('hello babo');
		}
	} else {
		seqId = seqId;
	}

	var room = issueRoom.getRoom( seqId );
	logger.info( 'OK! valid request. The room has seqId: ' + seqId, ', title: ' + title );

	if( room.isPending() ) {

		logger.debug( 'on Pending.. waiting fullfilled' );
		room.syncPromise.then( function( room ) {
			logger.debug( arguments );
			sendFirstPage( res, { room: room, useCache: false });
		})
		.catch( function() {
			logger.error( arguments );
			res.send('Error! - 2341');
		});

	} else {

		room.checkNeedSync('commentSyncInfo')
		.then( function( needSync ) {

			if( needSync ) {
				room.sync().then( function() {
					sendFirstPage( res, { room: room, useCache: false });
				});
			} else {
				sendFirstPage( res, { room: room, useCache: true });
			}
		});
	}
});

module.exports = router;
