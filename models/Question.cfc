/**
 * I am a new Model Object
 */
component extends="quick.models.BaseEntity" table="questions" accessors="true" {

	// Properties
	property name="questionID" column="questionID" setter="false";
	property name="question";
	property name="answer1";
	property name="answer2";
	property name="answer3";
	property name="answer4";
	property name="correctAnswer";

	variables._key = "questionID";

	this.constraints = {
        "question": {
            required: true,
            size: "1..255"
        },
		"answer1": {
            required: true,
            size: "1..255"
        },
		"answer2": {
            required: true,
            size: "1..255"
        },
		"answer3": {
            required: false,
            size: "0..255"
        },
		"answer4": {
            required: false,
            size: "0..255"
        },
		"correctAnswer": {
            required: true,
			type: "numeric",
            size: "1..1"
        }
    }

	/**
	 * Constructor
	 */
	Question function init(){
		super.init();
		return this;
	}

	
    

	/**
     * Helper function to retrieve Constraints 
     *
     * @constraintsKeyName The name of the variable to pull the constraints out of
     * 
     * @return struct of Constraints
     */
    struct function getConstraints( constraintsKeyName="constraints" ){
        if( len( arguments.constraintsKeyName ) != 0 && structKeyExists( this, constraintsKeyName ) ){
            return this[ constraintsKeyName ];
        } else {
            return {};
        }        
    }

	function vof() {
		return validateOrFail(argumentCollection = arguments);
	}


	/**
	* Validate an object or structure according to the constraints rules.
	* @fields The fields to validate on the target. By default, it validates on all fields
	* @constraints A structure of constraint rules or the name of the shared constraint rules to use for validation
	* @locale The i18n locale to use for validation messages
	* @excludeFields The fields to exclude from the validation
	* @includeFields The fields to include in the validation
	*
	* @return cbvalidation.model.result.IValidationResult
	* @throws ValidationException error
	*/
	public struct function validateOrFail(
		any constraints = this.getConstraints(),
		string fields = "*",
		string locale = "",
		string excludeFields = "",
		string includeFields = ""
	) {
		var result = _wirebox
			.getInstance( "ValidationManager@cbvalidation" )
			.validateOrFail(
				target = this,
				fields = arguments.fields,
				constraints = arguments.constraints,
				locale = arguments.locale,
				excludeFields = arguments.excludeFields,
				includeFields = arguments.includeFields
			);
		return this;
	}
}