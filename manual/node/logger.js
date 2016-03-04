
const log4js = require("log4js");
const my_log4js_configuration = {
	appenders: [{

		type: "console",
		layout: {
			type    : "pattern",
			pattern : "%r %[%1.1p %x{desc} %]\t%m",
			tokens: {
				desc: function() {

					var stack = new Error().stack.split('\n');
					var desc = stack.pop();

					// parse following
					// at Query._callback (/home/ssohjiro/Galaxyapps/nodemysql/refund.js:162:10)
					var reg = new RegExp(''+
						'\\('+							// match an opening parentheses
							'('+							// begin capturing group
								'[^)]+'+				// match one or more non ) characters
							')'+							// end capturing group
						'\\)$'							// match closing parentheses
					);

					var matched = desc.match( reg );
					var filePath_line_col;
					if( ! (matched && matched[1]) ) {
						// parse following
						// at /home/ssohjiro/Galaxyapps/nodemysql/refund.js:162:10
						reg = new RegExp(''+
							'at '+							// match an opening parentheses
								'('+				// begin capturing group
									'\/.*[0-9]'+				// match one or more non ) characters
								')'+							// end capturing group
							'$'							// match closing parentheses
						);

						matched = desc.match( reg );
					}

					filePath_line_col = matched[1];
					return filePath_line_col.replace( new RegExp('^'+process.cwd()), '' );
				}
			}
		}
	}]
};

log4js.configure( my_log4js_configuration );
module.exports = log4js;
