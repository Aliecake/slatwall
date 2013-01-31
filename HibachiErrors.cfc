component output="false" accessors="true" extends="HibachiObject" {

	// @hint stores any validation errors for the entity
	property name="errors" type="struct";

	// @hint Constructor for error bean. Initializes the error bean.
	public function init() {
		variables.errors = structNew();
		
		return this;
	}
	
	// @hint Adds a new error to the error structure.
	public void function addError(required string errorName, required string errorMessage) {
		if(!structKeyExists(variables.errors, arguments.errorName)) {
			variables.errors[arguments.errorName] = [];
		}
		arrayAppend(variables.errors[arguments.errorName], arguments.errorMessage);
	}
	
	// @hint Returns an array of error messages from the error structure.
	public array function getError(required string errorName) {
		if(hasError(errorName=arguments.errorName)){
			return variables.errors[arguments.name];
		}
		
		throw("The Error #arguments.errorName# doesn't Exist");
	}
	
	// @hint Returns true if the error exists within the error structure.
	public string function hasError(required string errorName) {
		return structKeyExists(variables.errors, arguments.errorName) ;
	}
	
	// @hint Returns true if there is at least one error.
	public boolean function hasErrors() {
		return !structIsEmpty(variables.errors) ;
	}
}