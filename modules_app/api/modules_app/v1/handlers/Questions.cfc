component extends=coldbox.system.RestHandler {

    //DI
    property name="questionService" inject="quickService:Question";
    property name="log" inject="logbox:logger:{this}";

    /**
     * Display a paginated list of Questions
     *
     * @x-route (GET) /api/v1/questions
     * @tags Questions
     * @x-parameters /resources/apidocs/api/v1/questions/index/parameters.json##parameters
     * @response-default /resources/apidocs/api/v1/questions/index/responses.json##200
     *
     */
    function index( event, rc, prc ) secured{
        param rc.page = "1";
        param rc.maxrows = "25";
        param rc.includeAnswers = false;
        param rc.sortBy = "question";
        param rc.descending = false;
        param rc.question = "";

        rc.sortDirection = rc.descending == false ? "asc" : "desc";
		if( rc.sortBy == 'null' || rc.sortBy == 'undefined'){
			rc.sortBy = "question";
            rc.sortDirection = "asc";
		}

        prc.cleanedRC = validateOrFail(
            target=rc,
            constraints=getPaginationConstraints()
        );

        prc.questions = questionService
            .when(
                len( rc.question ),
                function( q ){
                    q.whereLike( "question", "%#rc.question#%" );
                }
            )
            .orderBy( rc.sortBy, rc.sortDirection )
            .retrieveQuery()
            .paginate( prc.cleanedRC.page, prc.cleanedRC.maxrows );

// writeDump( prc.questions );abort;
// log.error( "Something happened that we want to log", rc );
// log.debug( "Debugging code...", rc );
// log.info( "Some nice info...", rc );
// log.warn( "Danger Will Robinson!", rc );

        prc.response
            .setDataWithPagination(
                prc.questions
            );
    }

    /**
     *
     * Creating a new Question
     *
     * @x-route (POST) /api/v1/questions
     * @tags Questions
     * @requestBody /resources/apidocs/api/v1/questions/create/requestBody.json
     * @response-200 /resources/apidocs/api/v1/questions/create/responses.json##200
     * @response-401 /resources/apidocs/api/v1/_responses/responses.401.json##401
     * @response-403 /resources/apidocs/api/v1/_responses/responses.403.json##403
     */
    function create( event, rc, prc ) {
        prc.oQuestion = questionService
            .fill( this.vof( target=rc, constraints=questionService.getConstraints() ) )
            .vof()
            .save();
        prc.response
            .addMessage( "Question Created" )
            .setData( prc.oQuestion.getMemento() );
    }

    function show( event, rc, prc ) {
        prc.oQuestion = questionService.findOrFail( rc.questionID );
        prc.response.setData( prc.oQuestion.getMemento() );
    }

    function update(event, rc, prc) {
        prc.oQuestion = questionService
            .findOrFail(rc.questionID)
            .update(
                this.vof(target = rc, constraints = questionService.getConstraints())
            );
        prc.response.addMessage("Question Updated");
    }

    function delete( event, rc, prc ) {
        prc.oQuestion = questionService.findOrFail( rc.questionID );
        prc.oQuestion.delete();
        prc.response
            .addMessage( "Question Deleted" );
    }

    private function getPaginationConstraints(){
        return {
            "page": {
                required: true,
                type: "numeric",
                min: "1",
                max: 1000
            },
            "maxrows": {
                required: true,
                type: "integer",
                min: 1,
                max: 999999
            }
        };
    }

    function vof(){
        return validateOrFail( argumentCollection=arguments );
    }

}