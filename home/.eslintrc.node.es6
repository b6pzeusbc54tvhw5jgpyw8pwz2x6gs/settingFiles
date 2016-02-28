{
	"parser": "babel-eslint",
	"env": {
		"es6": true,
		"node": true
	},
	"ecmaFeatures": {
		"modules": true,
		"templateStrings": true,
        	"modules": true,
		"classes": true,
		"arrowFunctions": true,
        	"jsx": true,
		"blockBindings": true
	},
	"rules": {
		"semi": 1,
		"no-unused-vars": [1, {"vars": "all", "args": "after-used"}],
		"no-undef": 2,
		"no-redeclare": 2,
		"no-cond-assign": 1,
		"no-unreachable": 1,
		"block-scoped-var": 2,
		"no-shadow": [2, {"hoist": "functions", "allow": ["e"] }],
		"no-use-before-define": [2, "nofunc"]
	},
	"globals": {
	
	}
}
