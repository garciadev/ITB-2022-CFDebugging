component{
	/**
	 * Configure the ColdBox App For Production
	 */
	function configure() {
		/**
		 * --------------------------------------------------------------------------
		 * ColdBox Directives
		 * --------------------------------------------------------------------------
		 * Here you can configure ColdBox for operation. Remember tha these directives below
		 * are for PRODUCTION. If you want different settings for other environments make sure
		 * you create the appropriate functions and define the environment in your .env or
		 * in the `environments` struct.
		 */
		coldbox = {
			// Application Setup
			appName                  : getSystemSetting( "APPNAME", "Your app name here" ),
			eventName                : "event",
			// Development Settings
			reinitPassword           : "",
			reinitKey                : "fwreinit",
			handlersIndexAutoReload  : true,
			// Implicit Events
			defaultEvent             : "v1:Echo.index",
			requestStartHandler      : "",
			requestEndHandler        : "",
			applicationStartHandler  : "",
			applicationEndHandler    : "",
			sessionStartHandler      : "",
			sessionEndHandler        : "",
			missingTemplateHandler   : "",
			// Extension Points
			applicationHelper        : "",
			viewsHelper              : "",
			modulesExternalLocation  : [],
			viewsExternalLocation    : "",
			layoutsExternalLocation  : "",
			handlersExternalLocation : "",
			requestContextDecorator  : "",
			controllerDecorator      : "",
			// Error/Exception Handling
			invalidHTTPMethodHandler : "",
			exceptionHandler         : "v1:Echo.onError",
			invalidEventHandler      : "",
			customErrorTemplate      : "",
			// Application Aspects
			handlerCaching           : false,
			eventCaching             : false,
			viewCaching              : false,
			// Will automatically do a mapDirectory() on your `models` for you.
			autoMapModels            : true,
			// Auto converts a json body payload into the RC
			jsonPayloadToRC          : true
		};

		/**
		 * --------------------------------------------------------------------------
		 * Custom Settings
		 * --------------------------------------------------------------------------
		 */
		settings = {};

		/**
		 * --------------------------------------------------------------------------
		 * Environment Detection
		 * --------------------------------------------------------------------------
		 * By default we look in your `.env` file for an `environment` key, if not,
		 * then we look into this structure or if you have a function called `detectEnvironment()`
		 * If you use this setting, then each key is the name of the environment and the value is
		 * the regex patterns to match against cgi.http_host.
		 *
		 * Uncomment to use, but make sure your .env ENVIRONMENT key is also removed.
		 */
		// environments = { development : "localhost,^127\.0\.0\.1" };

		/**
		 * --------------------------------------------------------------------------
		 * Module Loading Directives
		 * --------------------------------------------------------------------------
		 */
		modules = {
			// An array of modules names to load, empty means all of them
			include : [],
			// An array of modules names to NOT load, empty means none
			exclude : []
		};

		/**
		 * --------------------------------------------------------------------------
		 * Application Logging (https://logbox.ortusbooks.com)
		 * --------------------------------------------------------------------------
		 * By Default we log to the console, but you can add many appenders or destinations to log to.
		 * You can also choose the logging level of the root logger, or even the actual appender.
		 */
		logBox = {
			// Define Appenders
			appenders : {
				coldboxTracer : { class : "coldbox.system.logging.appenders.ConsoleAppender" },
				dbLogger      : {
					class      : "DBAppender",
					levelMin   : getSystemSetting( "LOG_ERROR_LEVEL_MIN", 0 ),
					levelMax   : getSystemSetting( "LOG_ERROR_LEVEL_MAX", 4 ),
					properties : {
						dsn        : getSystemSetting( "DB_DATABASE", "" ),
						table      : "logging",
						autocreate : true,
						async      : true,
						rotate     : false
					}
			} },
			// Root Logger
			root      : { levelmax : "INFO", appenders : "*" },
			// Implicit Level Categories
			info      : [ "coldbox.system" ]
		};

		/**
		 * --------------------------------------------------------------------------
		 * Layout Settings
		 * --------------------------------------------------------------------------
		 */
		layoutSettings = { defaultLayout : "", defaultView : "" };

		/**
		 * --------------------------------------------------------------------------
		 * Custom Interception Points
		 * --------------------------------------------------------------------------
		 */
		interceptorSettings = { customInterceptionPoints : [] };

		/**
		 * --------------------------------------------------------------------------
		 * Application Interceptors
		 * --------------------------------------------------------------------------
		 * Remember that the order of declaration is the order they will be registered and fired
		 */
		interceptors = [];

		/**
		 * --------------------------------------------------------------------------
		 * Module Settings
		 * --------------------------------------------------------------------------
		 * Each module has it's own configuration structures, so make sure you follow
		 * the module's instructions on settings.
		 *
		 * Each key is the name of the module:
		 *
		 * myModule = {
		 *
		 * }
		 */
		moduleSettings = {
			/**
			 * --------------------------------------------------------------------------
			 * cbSwagger Settings
			 * --------------------------------------------------------------------------
			 */
			cbswagger : {
				// The route prefix to search.  Routes beginning with this prefix will be determined to be api routes
				"routes"        : [ "api" ],
				// Any routes to exclude
				"excludeRoutes" : [],
				// The default output format: json or yml
				"defaultFormat" : "json",
				// A convention route, relative to your app root, where request/response samples are stored ( e.g. resources/apidocs/responses/[module].[handler].[action].[HTTP Status Code].json )
				"samplesPath"   : "resources/apidocs",
				// Information about your API
				"info"          : {
					// A title for your API
					"title"          : "ColdBox REST-HMVC Template",
					// A description of your API
					"description"    : "This API produces amazing results and data.",
					// A terms of service URL for your API
					"termsOfService" : "",
					// The contact email address
					"contact"        : {
						"name"  : "API Support",
						"url"   : "https://www.swagger.io/support",
						"email" : "info@ortussolutions.com"
					},
					// A url to the License of your API
					"license" : {
						"name" : "Apache 2.0",
						"url"  : "https://www.apache.org/licenses/LICENSE-2.0.html"
					},
					// The version of your API
					"version" : "1.0.0"
				},
				// Tags
				"tags"         : [],
				// https://swagger.io/specification/#externalDocumentationObject
				"externalDocs" : {
					"description" : "Find more info here",
					"url"         : "https://blog.readme.io/an-example-filled-guide-to-swagger-3-2/"
				},
				// https://swagger.io/specification/#serverObject
				"servers" : [
					{
						"url"         : "https://mysite.com/v1",
						"description" : "The main production server"
					},
					{
						"url"         : "http://127.0.0.1:60299",
						"description" : "The dev server"
					}
				],
				// An element to hold various schemas for the specification.
				// https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#componentsObject
				"components" : {
					// Define your security schemes here
					// https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#securitySchemeObject
					"securitySchemes" : {
						"ApiKeyAuth" : {
							"type"        : "apiKey",
							"description" : "User your JWT as an Api Key for security",
							"name"        : "x-api-key",
							"in"          : "header"
						},
						"bearerAuth" : {
							"type"         : "http",
							"scheme"       : "bearer",
							"bearerFormat" : "JWT"
						}
					}
				}

				// A default declaration of Security Requirement Objects to be used across the API.
				// https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#securityRequirementObject
				// Only one of these requirements needs to be satisfied to authorize a request.
				// Individual operations may set their own requirements with `@security`
				// "security" : [
				//	{ "APIKey" : [] },
				//	{ "UserSecurity" : [] }
				// ]
			},
			/**
			 * --------------------------------------------------------------------------
			 * cbSecurity Settings
			 * --------------------------------------------------------------------------
			 * We have pre-configured cbSecurity to secure the API using JWT Tokens
			 */
			cbAuth     : { "userServiceClass" : "UserService" },
			cbsecurity : {
				// The global invalid authentication event or URI or URL to go if an invalid authentication occurs
				"invalidAuthenticationEvent"  : "v1:Echo.onAuthenticationFailure",
				// Default Auhtentication Action: override or redirect when a user has not logged in
				"defaultAuthenticationAction" : "override",
				// The global invalid authorization event or URI or URL to go if an invalid authorization occurs
				"invalidAuthorizationEvent"   : "v1:Echo.onAuthorizationFailure",
				// Default Authorization Action: override or redirect when a user does not have enough permissions to access something
				"defaultAuthorizationAction"  : "override",
				// You can define global security rules here
				"rules"                       : [],
				// Use JWT For validation of incoming requests
				"validator"                   : "JWTService@cbsecurity",
				// We will use cbAuth for authentication by default
				"authenticationService"       : "authenticationService@cbauth",
				// WireBox ID of the user service to use
				"userService"                 : "UserService",
				// The name of the variable to use to store an authenticated user in prc scope if using a validator that supports it.
				"prcUserVariable"             : "oCurrentUser",
				// Use regular expression matching on the rule match types
				"useRegex"                    : true,
				// Force SSL for all relocations
				"useSSL"                      : false,
				// Auto load the global security firewall
				"autoLoadFirewall"            : true,
				// Activate handler/action based annotation security
				"handlerAnnotationSecurity"   : true,
				// Activate security rule visualizer, defaults to false by default
				"enableSecurityVisualizer"    : false,
				// JWT Settings
				"jwt"                         : {
					// The issuer authority for the tokens, placed in the `iss` claim
					"issuer"           : "",
					// The jwt secret encoding key, defaults to getSystemEnv( "JWT_SECRET", "" )
					"secretKey"        : getSystemSetting( "JWT_SECRET", "" ),
					// by default it uses the authorization bearer header, but you can also pass a custom one as well.
					"customAuthHeader" : "x-auth-token",
					// The expiration in minutes for the jwt tokens
					"expiration"       : 60,
					// encryption algorithm to use, valid algorithms are: HS256, HS384, and HS512
					"algorithm"        : "HS512",
					// Which claims neds to be present on the jwt token or `TokenInvalidException` upon verification and decoding
					"requiredClaims"             : [],
					// If true, enables refresh tokens, token creation methods will return a struct instead of just an access token string
					// e.g. { access_token: "", refresh_token : "" }
					"enableRefreshTokens"        : true,
					// The default expiration for refresh tokens in minutes, defaults to 7 days
					"refreshExpiration"          : 10080,
					// The custom header to inspect for refresh tokens
					"customRefreshHeader"        : "x-refresh-token",
					// If enabled, the JWT validator will inspect the request for refresh tokens and expired access tokens
					// It will then automatically refresh them for you and return them back as
					// response headers in the same request according to the `customRefreshHeader` and `customAuthHeader`
					"enableAutoRefreshValidator" : false, // TODO: Do we want to set this to true?
					// Enable the POST > /cbsecurity/refreshtoken API endpoint
					"enableRefreshEndpoint"      : true,
					// The token storage settings
					"tokenStorage"     : {
						// enable or not, default is true
						"enabled"    : true,
						// A cache key prefix to use when storing the tokens
						"keyPrefix"  : "cbjwt_",
						// The driver to use: db, cachebox or a WireBox ID
						"driver"     : "cachebox",
						// Driver specific properties
						"properties" : { "cacheName" : "default" }
					}
				}
			},
			// Debugger Settings
			cbDebugger : {
				// Master switch to enable/disable request tracking into storage facilities.
				enabled        : getSystemSetting( "CBDEBUGGER_ENABLED", true ),
				// Turn the debugger UI on/off by default. You can always enable it via the URL using your debug password
				// Please note that this is not the same as the master switch above
				// The debug mode can be false and the debugger will still collect request tracking
				debugMode      : getSystemSetting( "CBDEBUGGER_DEBUG_MODE", true ),
				// The URL password to use to activate it on demand
				debugPassword  : getSystemSetting( "CBDEBUGGER_DEBUG_PASSWORD", "cb:null" ),
				// Request Tracker Options
				requestTracker : {
					// Track all cbdebugger events, by default this is off, turn on, when actually profiling yourself :) How Meta!
					trackDebuggerEvents          : false,
					// Store the request profilers in heap memory or in cachebox, default is cachebox
					storage                      : "cachebox",
					// Which cache region to store the profilers in
					cacheName                    : "template",
					// Expand by default the tracker panel or not
					expanded                     : true,
					// Slow request threshold in milliseconds, if execution time is above it, we mark those transactions as red
					slowExecutionThreshold       : 1000,
					// How many tracking profilers to keep in stack: Default is to monitor the last 20 requests
					maxProfilers                 : 50,
					// If enabled, the debugger will monitor the creation time of CFC objects via WireBox
					profileWireBoxObjectCreation : false,
					// Profile model objects annotated with the `profile` annotation
					profileObjects               : false,
					// If enabled, will trace the results of any methods that are being profiled
					traceObjectResults           : false,
					// Profile Custom or Core interception points
					profileInterceptions         : false,
					// By default all interception events are excluded, you must include what you want to profile
					includedInterceptions        : [],
					// Control the execution timers
					executionTimers              : {
						expanded           : true,
						// Slow transaction timers in milliseconds, if execution time of the timer is above it, we mark it
						slowTimerThreshold : 250
					},
					// Control the coldbox info reporting
					coldboxInfo : { expanded : false },
					// Control the http request reporting
					httpRequest : {
						expanded        : false,
						// If enabled, we will profile HTTP Body content, disabled by default as it contains lots of data
						profileHTTPBody : false
					}
				},
				// ColdBox Tracer Appender Messages
				tracers     : { enabled : true, expanded : false },
				// Request Collections Reporting
				collections : {
					// Enable tracking
					enabled      : false,
					// Expanded panel or not
					expanded     : false,
					// How many rows to dump for object collections
					maxQueryRows : 50,
					// Max number to use when dumping objects via the top argument
					maxDumpTop   : 5
				},
				// CacheBox Reporting
				cachebox : { enabled : true, expanded : false },
				// Modules Reporting
				modules  : { enabled : false, expanded : false },
				// Quick and QB Reporting
				qb       : {
					enabled   : true,
					expanded  : false,
					// Log the binding parameters
					logParams : true
				},
				// cborm Reporting
				cborm : {
					enabled   : false,
					expanded  : false,
					// Log the binding parameters (requires CBORM 3.2.0+)
					logParams : false
				},
				// Adobe ColdFusion SQL Collector
				acfSql : { enabled : false, expanded : false, logParams : false },
				// Async Manager Reporting
				async  : { enabled : true, expanded : false }
			}
		};

		/**
		 * --------------------------------------------------------------------------
		 * Flash Scope Settings
		 * --------------------------------------------------------------------------
		 * The available scopes are : session, client, cluster, ColdBoxCache, or a full instantiation CFC path
		 */
		flash = {
			scope        : "session",
			properties   : {}, // constructor properties for the flash scope implementation
			inflateToRC  : true, // automatically inflate flash data into the RC scope
			inflateToPRC : false, // automatically inflate flash data into the PRC scope
			autoPurge    : true, // automatically purge flash data for you
			autoSave     : true // automatically save flash scopes at end of a request and on relocations.
		};

		/**
		 * --------------------------------------------------------------------------
		 * App Conventions
		 * --------------------------------------------------------------------------
		 */
		conventions = {
			handlersLocation : "handlers",
			viewsLocation    : "views",
			layoutsLocation  : "layouts",
			modelsLocation   : "models",
			eventAction      : "index"
		};
	}

	/**
	 * Development environment
	 */
	function development() {
		// coldbox.customErrorTemplate = "/coldbox/system/exceptions/BugReport.cfm"; // static bug reports
		coldbox.customErrorTemplate = "/coldbox/system/exceptions/Whoops.cfm"; // interactive bug report
	}
}
