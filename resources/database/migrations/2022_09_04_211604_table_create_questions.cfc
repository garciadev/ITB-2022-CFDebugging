component {

    function up( schema, qb ) {
        schema.create( "questions", function( table ) {
            table.increments( "questionID" );
            table.unicodeText( "question" );
            table.string( "answer1" );
            table.string( "answer2" );
            table.string( "answer3" ).nullable();
            table.string( "answer4" ).nullable();
            table.integer( "correctAnswer" );
            table.timestamp( "createdDate" );
            table.timestamp( "modifiedDate" );
        } );
    }

    function down( schema, qb ) {
        schema.drop( "questions" );
    }

}