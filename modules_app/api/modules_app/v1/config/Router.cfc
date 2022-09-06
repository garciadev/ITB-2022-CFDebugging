component {

	function configure() {
		// API Echo
		get( "/", "Echo.index" );

		// API Authentication Routes
		post( "/login", "Auth.login" );
		post( "/logout", "Auth.logout" );
		post( "/register", "Auth.register" );
		get( "/verify", "Auth.verify" );

		// API Secured Routes
		get( "/whoami", "Echo.whoami" );

		apiResources( resource="questions", parameterName="questionID" );

		route( "/:handler/:action" ).end();
	}

}
