component extends="coldbox.system.testing.BaseTestCase" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll() {
		structDelete( application, "cbController" );
		structDelete( application, "wirebox" );
		super.beforeAll();
	}

	function afterAll() {
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run() {
		describe( "Question", function() {
			beforeEach( function( currentSpec ) {
				setup();
				model = getInstance( "Question" );
			} );

			it( "can be created", function() {
				expect( model ).toBeComponent();

			} );

			it("can list all the questions", function () {
				var aResults = model.all();
                expect(aResults).toBeArray();
			});
		} );
	}

}