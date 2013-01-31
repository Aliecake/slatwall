component output="false" accessors="true" persistent="false" extends="HibachiObject" {

	property name="hibachiErrors" type="any" persistent="false";							// This porpery holds errors that are not part of ValidateThis, for example processing errors.
	property name="hibachiMessages" type="any" persistent="false";
	property name="populatedSubProperties" type="array" persistent="false";
	property name="validations" type="struct" persistent="false";
	
	// ========================= START: ACCESSOR OVERRIDES ==========================================
	
	// @hint Returns the errorBean object, if one hasn't been setup yet it returns a new one
	public any function getHibachiErrors() {
		if(!structKeyExists(variables, "hibachiErrors")) {
			variables.hibachiErrors = getTransient("hibachiErrors");
		}
		return variables.hibachiErrors;
	}
	
	// @hint Returns the messageBean object, if one hasn't been setup yet it returns a new one
	public any function getHibachiMessages() {
		if(!structKeyExists(variables, "hibachiMessages")) {
			variables.hibachiMessages = getTransient("hibachiMessages");; 
		}
		return variables.hibachiMessages;
	}
	
	// @hint Returns the populatedSubProperties array, if one hasn't been setup yet it returns a new one
	public array function getPopulatedSubProperties() {
		if(!structKeyExists(variables, "populatedSubProperties")) {
			variables.populatedSubProperties = [];
		}
		return variables.populatedSubProperties; 
	}
	
	// =========================  END:  ACCESSOR OVERRIDES ==========================================
	// ========================== START: ERRORS / MESSAGES ==========================================
	
	// @hint Returns a struct of all the errors for this entity
	public struct function getErrors() {
		return getHibachiErrors().getErrors();
	}
	
	// @hint Returns the error message of a given error name
	public array function getError( required string errorName ) {
		
		// Check First that the error exists, and if it does return it
		if( hasError(arguments.errorName) ) {
			return getErrors()[ arguments.errorName ];
		}
		
		// Default behavior if the error isn't found is to return an empty array
		return [];
	}
		
	// @hint Returns true if this object has any errors.
	public boolean function hasErrors() {
		if(getHibachiErrors().hasErrors()) {
			return true;
		}
		
		return false;
	}
	
	// @hint Returns true if a specific error key exists
	public boolean function hasError( required string errorName ) {
		return structKeyExists(getErrors(), arguments.errorName);
	}
		
	// @hint helper method to add an error to the error bean	
	public void function addError( required string errorName, required string errorMessage) {
		getHibachiErrors().addError(argumentCollection=arguments);
	}
	
	// @hint helper method that returns all error messages as <p> html tags
	public string function getAllErrorsHTML( ) {
		var returnString = "";
		
		for(var errorName in getErrors()) {
			for(var i=1; i<=arrayLen(getErrors()[errorName]); i++) {
				returnString &= "<p class='error'>" & getErrors()[errorName][i] & "</p>";
			}
		}
		
		return returnString;
	}
	
	// @hint helper method to have these error messages be passed to the current hibachiScope
	public void function showErrors() {
		for(var errorName in getErrors()) {
			for(var i=1; i<=arrayLen(getErrors()[errorName]); i++) {
				getHibachiScope().showMessage(getErrors()[errorName][i], "error");
			}
		}
	}
	
	// @hint Returns a struct of all the messages for this object
	public struct function getMessages() {
		return getHibachiMessages().getMessages();
	}
	
	// @hint Returns true if there are any messages
	public boolean function hasMessages( ) {
		return getHibachiMessages().hasMessages();
	}
	
	// @hint Returns true if a specific message key exists
	public boolean function hasMessage( required string messageName ) {
		return getHibachiMessages().hasMessage( arguments.messageName );
	}
	
	// @hint helper method to add an error to the error bean	
	public void function addMessage( required string messageName, required string message ) {
		getHibachiMessages().addMessage(argumentCollection=arguments);
	}
	
	// @hint helper method that returns all messages as <p> html tags
	public string function getAllMessagesHTML( ) {
		var returnString = "";
		
		for(var messageName in getMessages()) {
			for(var i=1; i<=arrayLen(getMessages()[messageName]); i++) {
				returnString &= "<p class='message #lcase(messageName)#'>" & getMessages()[messageName][i] & "</p>";
			}
		}
		
		return returnString;
	}
	
	// @hint helper method to have these messages be passed to the current hibachiScope
	public void function showMessages() {
		for(var messageName in getMessages()) {
			for(var i=1; i<=arrayLen(getErrors()[errorName]); i++) {
				getHibachiScope().showMessage(getErrors()[errorName][i], "info");
			}
		}
	}
	
	// @hint helper method to have all error messages and regular messages shown
	public void function showErrorsAndMessages() {
		for(var messageName in getMessages()) {
			for(var i=1; i<=arrayLen(getErrors()[errorName]); i++) {
				getHibachiScope().showMessage(getErrors()[errorName][i], "info");
			}
		}
	}
	
	// ==========================  END: ERRORS / MESSAGES ===========================================
	// ======================= START: POPULATION & VALIDATION =======================================
	
	// @hint Public populate method to utilize a struct of data that follows the standard property form format
	public any function populate( required struct data={} ) {
		// Param the ignoreProperties key so that we can count on it later
		param name="arguments.data.ignoreProperties" default="";
		
		// Get an array of All the properties for this object
		var properties = getProperties();
		
		// Loop over properties looking for a value in the incomming data
		for( var p=1; p <= arrayLen(properties); p++ ) {
			
			// Set the current property into variable of meta data
			var currentProperty = properties[p];
			
			// Check to see if this property has a key in the data that was passed in, and also make sure that key isn't in the ignoreProperties list
			if( structKeyExists(arguments.data, currentProperty.name) && !listFindNoCase(arguments.data.ignoreProperties, currentProperty.name) ) {
			
				// (SIMPLE) Do this logic if this property should be a simple value, and the data passed in is a simple value
				if( (!structKeyExists(currentProperty, "fieldType") || currentProperty.fieldType == "column") && isSimpleValue(arguments.data[ currentProperty.name ]) ) {
					
						// If the value is blank, then we check to see if the property can be set to NULL.
						if( trim(arguments.data[ currentProperty.name ]) == "" && ( !structKeyExists(currentProperty, "notNull") || !currentProperty.notNull ) ) {
							_setProperty(currentProperty.name);
						
						// If the value isn't blank, or we can't set to null... then we just set the value.
						} else {
							
							// Before setting the value, we want to check for any confirmXXX keys that may have been passed in
							if(!structKeyExists(arguments.data, "confirm#currentProperty.name#") || (arguments.data[ "confirm#currentProperty.name#" ] == arguments.data[ currentProperty.name ])) {
								_setProperty(currentProperty.name, trim(arguments.data[ currentProperty.name ]));	
							} else {
								addError(currentProperty.name, rbKey('define.notconfirmed'));
							}
							
						}
					
				// (MANY-TO-ONE) Do this logic if this property is a many-to-one relationship, and the data passed in is of type struct
				} else if( structKeyExists(currentProperty, "fieldType") && currentProperty.fieldType == "many-to-one" && isStruct( arguments.data[ currentProperty.name ] ) ) {
					
					// Set the data of this Many-To-One relationship into it's own local struct
					var manyToOneStructData = arguments.data[ currentProperty.name ];
					
					// Find the primaryID column Name
					var primaryIDPropertyName = getService( "hibachiService" ).getPrimaryIDPropertyNameByEntityName( "#getApplicationValue('applicationKey')##listLast(currentProperty.cfc,'.')#" );
					
					// If the primaryID exists then we can set the relationship
					if(structKeyExists(manyToOneStructData, primaryIDPropertyName)) {
						
						// set the service to use to get the specific entity
						var entityService = getService( "hibachiService" ).getServiceByEntityName( "#getApplicationValue('applicationKey')##listLast(currentProperty.cfc,'.')#" );
						
						// If there were additional values in the data, then we will get the entity by the primaryID and populate / validate by calling save in its service.
						if(structCount(manyToOneStructData) gt 1) {
							
							// Load the specifiv entity, if one doesn't exist, this will return a new entity
							var thisEntity = entityService.invokeMethod( "get#listLast(currentProperty.cfc,'.')#", {1=manyToOneStructData[primaryIDPropertyName],2=true});
							
							// Set the value of the property as the loaded entity
							_setProperty(currentProperty.name, thisEntity );
							
							// Call the save method for this sub property entity and pass in the data
							thisEntity = entityService.invokeMethod( "save#listLast(currentProperty.cfc,'.')#", {1=thisEntity, 2=manyToOneStructData});
							
							// Add this property to the array of populatedSubProperties so that when this object is validated, it also validates the sub-properties that were populated
							if( !arrayFind(getPopulatedSubProperties(), currentProperty.name) ) {
								arrayAppend(getPopulatedSubProperties(), currentProperty.name);
							}
							
						// If there were no additional values in the strucuture then we just try to get the entity and set it... in this way a null is a valid option
						} else {
							// If the value passed in for the ID is blank, then set the value of the currentProperty to NULL
							if(manyToOneStructData[primaryIDPropertyName] == "") {
								_setProperty(currentProperty.name);
						
							// If it was an actual ID, then we will try to load that entity
							} else {
							
								// Load the specifiv entity, if one doesn't exist... this will be null
								var thisEntity = entityService.invokeMethod( "get#listLast(currentProperty.cfc,'.')#", {1=manyToOneStructData[primaryIDPropertyName]});
								
								if(!isNull(thisEntity)) {
									// Set the value of the property as the loaded entity
									_setProperty(currentProperty.name, thisEntity );	
								}
								
							}
						}
					}
					
				// (ONE-TO-MANY) Do this logic if this property is a one-to-many or many-to-many relationship, and the data passed in is of type array	
				} else if ( structKeyExists(currentProperty, "fieldType") && (currentProperty.fieldType == "one-to-many" or currentProperty.fieldType == "many-to-many") && isArray( arguments.data[ currentProperty.name ] ) ) {
					
					// Set the data of this One-To-Many relationship into it's own local array
					var oneToManyArrayData = arguments.data[ currentProperty.name ];
					
					// Find the primaryID column Name for the related object
					var primaryIDPropertyName = getService( "hibachiService" ).getPrimaryIDPropertyNameByEntityName( "#getApplicationValue('applicationKey')##listLast(currentProperty.cfc,'.')#" );
					
					// Loop over the array of objects in the data... Then load, populate, and validate each one
					for(var a=1; a<=arrayLen(oneToManyArrayData); a++) {
						
						// Check to make sure that this array has the primary ID property in it, otherwise we can't do a populate.  Also check to make sure populateSubProperties was not set to false in the data (if not defined we asume true).
						if(structKeyExists(oneToManyArrayData[a], primaryIDPropertyName) && (!structKeyExists(arguments.data, "populateSubProperties") || arguments.data.populateSubProperties)) {
							
							// set the service to use to get the specific entity
							var entityService = getService( "hibachiService" ).getServiceByEntityName( "#getApplicationValue('applicationKey')##listLast(currentProperty.cfc,'.')#" );
							
							// Load the specific entity, and if one doesn't exist yet then return a new entity
							var thisEntity = entityService.invokeMethod( "get#listLast(currentProperty.cfc,'.')#", {1=oneToManyArrayData[a][primaryIDPropertyName],2=true});
							
							// Add the entity to the existing objects properties
							this.invokeMethod("add#currentProperty.singularName#", {1=thisEntity});
							
							// If there were additional values in the data array, then we use those values to populate the entity, and validating it aswell.
							if(structCount(oneToManyArrayData[a]) gt 1) {
								
								// Call the save method for this sub property entity and pass in the data
								thisEntity = entityService.invokeMethod( "save#listLast(currentProperty.cfc,'.')#", {1=thisEntity, 2=oneToManyArrayData[a]});
								
								// Add this property to the array of populatedSubProperties so that when this object is validated, it also validates the sub-properties that were populated
								if( !arrayFind(getPopulatedSubProperties(), currentProperty.name) ) {
									arrayAppend(getPopulatedSubProperties(), currentProperty.name);
								}
							}
						}
					}
				// (MANY-TO-MANY) Do this logic if this property is a many-to-many relationship, and the data passed in as a list of ID's
				} else if ( structKeyExists(currentProperty, "fieldType") && currentProperty.fieldType == "many-to-many" && isSimpleValue( arguments.data[ currentProperty.name ] ) ) {
					
					// Set the data of this Many-To-Many relationship into it's own local struct
					var manyToManyIDList = arguments.data[ currentProperty.name ];
					
					// Find the primaryID column Name
					var primaryIDPropertyName = getService( "hibachiService" ).getPrimaryIDPropertyNameByEntityName( "#getApplicationValue('applicationKey')##listLast(currentProperty.cfc,'.')#" );
					
					// Get all of the existing related entities
					var existingRelatedEntities = invokeMethod("get#currentProperty.name#");
					
					if(isNull(existingRelatedEntities)) {
						throw("The Many-To-Many relationship for '#currentProperty.name#' could not be populated because it wasn't setup as an empty array on init.");
					}
					
					// Loop over the existing related entities and check if the primaryID exists in the list of data that was passed in.
					for(var m=arrayLen(existingRelatedEntities); m>=1; m-- ) {
						
						// Get the primary ID of this existing relationship
						var thisPrimrayID = existingRelatedEntities[m].invokeMethod("get#primaryIDPropertyName#");
						
						// Find out if hat ID is in the list
						var listIndex = listFind( manyToManyIDList, thisPrimrayID );
						
						// If the relationship already exist, then remove that id from the list
						if(listIndex) {
							manyToManyIDList = listDeleteAt(manyToManyIDList, listIndex);
						// If the relationship no longer exists in the list, then remove the entity relationship
						} else {
							this.invokeMethod("remove#currentProperty.singularname#", {1=existingRelatedEntities[m]});
						}
					}
					
					// Loop over all of the primaryID's that are still in the list, and add the relationship
					for(var n=1; n<=listLen( manyToManyIDList ); n++) {
						
						// set the service to use to get the specific entity
						var entityService = getService( "hibachiService" ).getServiceByEntityName( "#getApplicationValue('applicationKey')##listLast(currentProperty.cfc,'.')#" );
							
						// set the id of this entity into a local variable
						var thisEntityID = listGetAt(manyToManyIDList, n);
						
						// Load the specific entity, if one doesn't exist... this will be null
						var thisEntity = entityService.invokeMethod( "get#listLast(currentProperty.cfc,'.')#", {1=thisEntityID});
						
						// If the entity exists, then add it to the relationship
						if(!isNull(thisEntity)) {
							this.invokeMethod("add#currentProperty.singularname#", {1=thisEntity});
						}
					}
				}	
			}
		}
		
		// Return this object
		return this;
	}
	
	// @hind public method to see all of the validations for a particular context
	public array function getValidations( string context="" ) {
		return getService("hibachiValidationService").getValidationsByContext( object=this, context=arguments.context);
	}
	
	// @hint pubic method to validate this object
	public any function validate( string context="" ) {
		
		getService("hibachiValidationService").validate(object=this, context=arguments.context);
		
		// Validate each of the objects that are in the populatedSubProperties array, This array has properties added to it during the populate method
		for(var p=1; p<=arrayLen(getPopulatedSubProperties()); p++) {
			
			// Get the values of this sub property
			var subPropertyValue = invokeMethod("get#getPopulatedSubProperties()[p]#");
			
			// If the value is Null then throw an error because the populatedSubProperties array should have never had this propertyName in it
			if(!isNull(subPropertyValue)) {
				// If the results are an array, then loop over them
				if(isArray(subPropertyValue)) {
					
					// Loop over each object in the subProperty array and validate it
					for(var e=1; e<=arrayLen(subPropertyValue); e++ ) {
					
						// If after validation that sub object has errors, add a failure to this object
						if(subPropertyValue[e].hasErrors()) {
							getHibachiErrors().addError(getPopulatedSubProperties()[p], rbKey('validate.#getClassName()#.#getPopulatedSubProperties()[p]#.populate'));
						}
					}
				} else if(isObject(subPropertyValue)) {
					if(subPropertyValue.hasErrors()) {
						getHibachiErrors().addError(getPopulatedSubProperties()[p], rbKey('validate.#getClassName()#.#getPopulatedSubProperties()[p]#.populate'));
					}
				}
			}
		}
		
		return getHibachiErrors();
	}
	
	// =======================  END:  POPULATION & VALIDATION =======================================
	// ======================= START: PROPERTY INTROSPECTION ========================================
	
	// @hint Public method to retrieve a value based on a propertyIdentifier string format
	public any function getValueByPropertyIdentifier(required string propertyIdentifier, boolean formatValue=false) {
		var value = javaCast("null", "");
		var newValue = "";
		var arrayValue = arrayNew(1);
		var pa = listToArray(arguments.propertyIdentifier, "._");
		
		for(var i=1; i<=arrayLen(pa); i++) {
			if(isNull(value)) {
				value = evaluate("this.get#pa[i]#()");
				if(isNull(value)) {
					if(arguments.formatValue) {
						return getFormattedValue(pa[i]);
					}
					return "";
				}
				if(isSimpleValue(value) && arguments.formatValue) {
					value = getFormattedValue(pa[i]);
				}
			} else if(isArray(value)) {
				for(var ii=1; ii<=arrayLen(value); ii++) {
					arrayAppend(arrayValue, value[ii].getValueByPropertyIdentifier(pa[i], arguments.formatValue));
				}
				return arrayValue;
			} else {
				newValue = evaluate("value.get#pa[i]#()");
				if(isNull(newValue)) {
					if(arguments.formatValue) {
						return value.getFormattedValue(pa[i]);
					}
					return "";
				}
				if(isSimpleValue(newValue) && arguments.formatValue) {
					value = value.getFormattedValue(pa[i]);
				} else {
					value = newValue;
				}
			}	
		}
		if(isNull(value)) {
			return "";
		}
		
		return value;
	}

	public any function getFormattedValue(required string propertyName, string formatType ) {
		arguments.value = invokeMethod("get#arguments.propertyName#");
		
		// check if a formatType was passed in, if not then use the getPropertyFormatType() method to figure out what it should be by default
		if(!structKeyExists(arguments, "formatType")) {
			arguments.formatType = getPropertyFormatType( arguments.propertyName );
		}
		
		// If the formatType is custom then deligate back to the property specific getXXXFormatted() method.
		if(arguments.formatType eq "custom") {
			return this.invokeMethod("get#arguments.propertyName#Formatted");	
		} else if(arguments.formatType eq "rbKey") {
			return rbKey('entity.#replace(getEntityName(),getApplicationValue('applicationKey'),"")#.#arguments.propertyName#.#arguments.value#');
		}
		
		// This is the null format option
		if(isNull(arguments.value)) {
			var propertyMeta = getPropertyMetaData( arguments.propertyName );
			if(structKeyExists(propertyMeta, "nullRBKey")) {
				return rbKey(propertyMeta.nullRBKey);
			}
			
			return "";
		// This is a simple value, so now lets try to actually format the value
		} else if (isSimpleValue(arguments.value)) {
			return getService("hibachiUtilityService").formatValue(value=arguments.value, formatType=arguments.formatType);
		}
		
		// If the value has not yet been returned, then it is because the value was complex
		throw("You cannont convert complex values to formatted Values");
	}
	
	// @hint public method for getting the display format for a given property, this is used a lot by the HibachiPropertyDisplay
	public string function getPropertyFormatType(required string propertyName) {
		
		var propertyMeta = getPropertyMetaData( arguments.propertyName );
		
		// First check to see if formatType was explicitly set for this property
		if(structKeyExists(propertyMeta, "formatType")) {
			return propertyMeta.formatType;
			
		// If it wasn't set, but this is a simple value field then inspect the dataTypes and naming convention to try an figure it out
		} else if( !structKeyExists(propertyMeta, "fieldType") || propertyMeta.fieldType == "column" ) {
			
			var dataType = "";
			
			// Check if there is an ormType attribute for this property to use first and asign it to the 'dataType' local var.  Otherwise check if the type attribute was set and use that.
			if( structKeyExists(propertyMeta, "ormType") ) {
				dataType = propertyMeta.ormType;
			} else if ( structKeyExists(propertyMeta, "type") ) {
				dataType = propertyMeta.type;
			}
			
			// Check the dataType against different lists of types for correct formatType
			if( listFindNoCase("boolean,yes_no,true_false", dataType) ) {
				return "yesno";	
			} else if ( listFindNoCase("date,timestamp", dataType) ) {
				return "datetime";
			} else if ( listFindNoCase("big_decimal", dataType) && right(arguments.propertyName, 6) == "weight" ) {
				return "weight";	
			} else if ( listFindNoCase("big_decimal", dataType) ) {
				return "currency";
			}
			
		}
		
		// By default just return non
		return "none";
	}
	
	// @hint public method for returning the validation class of a property
	public string function getPropertyValidationClass( required string propertyName, string context="save" ) {
		
		var validationClass = "";
		
		var validations = getValidations(arguments.context);
		
		if(structKeyExists(validations, arguments.propertyName)) {
			for(var constraint in validations[ arguments.propertyName ]) {
				if(constraint == "required") {
					listAppend(validationClass, "required", " ");
				} else if (constraint == "dataType") {
					if(validations[ arguments.propertyName ][ constraint ] == "numeric") {
						listAppend(validationClass, "number", " ");
					} else {
						listAppend(validationClass, validations[ arguments.propertyName ][ constraint ], " ");
					}
				}
			}
		}
		
		return validationClass;
	}
	
	// @hint public method for getting the title to be used for a property from the rbFactory, this is used a lot by the HibachiPropertyDisplay
	public string function getPropertyTitle(required string propertyName) {
		return rbKey("entity.#getClassName()#.#arguments.propertyName#");
	}
	
	// @hint public method for getting the title hint to be used for a property from the rbFactory, this is used a lot by the HibachiPropertyDisplay
	public string function getPropertyHint(required string propertyName) {
		var exactMatch = rbKey("entity.#getClassName()#.#arguments.propertyName#_hint");
		if(right(exactMatch, 8) != "_missing") {
			return exactMatch;
		}
		return "";
	}
	
	// @hint public method to get the rbKey value for a property in a subentity
	public string function getTitleByPropertyIdentifier( required string propertyIdentifier ) {
		if(find(".", arguments.propertyIdentifier)) {
			var exampleEntity = entityNew("#getApplicationValue('applicationKey')##listLast(getPropertyMetaData( listFirst(arguments.propertyIdentifier, '.') ).cfc,'.')#");
			return exampleEntity.getTitleByPropertyIdentifier( replace(arguments.propertyIdentifier, "#listFirst(arguments.propertyIdentifier, '.')#.", '') );
		}
		return getPropertyTitle( arguments.propertyIdentifier );
	}
	
	// @hint public method to get the rbKey value for a property in a subentity
	public string function getFieldTypeByPropertyIdentifier( required string propertyIdentifier ) {
		if(find(".", arguments.propertyIdentifier)) {
			var exampleEntity = entityNew("#getApplicationValue('applicationKey')##listLast(getPropertyMetaData( listFirst(arguments.propertyIdentifier, '.') ).cfc,'.')#");
			return exampleEntity.getFieldTypeByPropertyIdentifier( replace(arguments.propertyIdentifier, "#listFirst(arguments.propertyIdentifier, '.')#.", '') );
		}
		return getPropertyFieldType( arguments.propertyIdentifier );
	}
	
	// @hint public method for returning the name of the field for this property, this is used a lot by the PropertyDisplay
	public string function getPropertyFieldName(required string propertyName) {
		
		// Get the Meta Data for the property
		var propertyMeta = getPropertyMetaData( arguments.propertyName );
		
		// If this is a relational property, and the relationship is many-to-one, then return the propertyName and propertyName of primaryID
		if( structKeyExists(propertyMeta, "fieldType") && propertyMeta.fieldType == "many-to-one" ) {
			
			var primaryIDPropertyName = getService( "hibachiService" ).getPrimaryIDPropertyNameByEntityName( "#getApplicationValue('applicationKey')##listLast(propertyMeta.cfc,'.')#" );
			return "#arguments.propertyName#.#primaryIDPropertyName#";
		}
		
		// Default case is just to return the property Name
		return arguments.propertyName;
	}
	
	// @hint public method for inspecting the property of a given object and determining the most appropriate field type for that property, this is used a lot by the HibachiPropertyDisplay
	public string function getPropertyFieldType(required string propertyName) {
		
		// Get the Meta Data for the property
		var propertyMeta = getPropertyMetaData( arguments.propertyName );
		
		// Check to see if there is a meta data called 'formFieldType'
		if( structKeyExists(propertyMeta, "formFieldType") ) {
			return propertyMeta.formFieldType;
		}
		
		// If this isn't a Relationship property then run the lookup on ormType then type.
		if( !structKeyExists(propertyMeta, "fieldType") || propertyMeta.fieldType == "column" ) {
			
			var dataType = "";
			
			// Check if there is an ormType attribute for this property to use first and asign it to the 'dataType' local var.  Otherwise check if the type attribute was set and use that.
			if( structKeyExists(propertyMeta, "ormType") ) {
				dataType = propertyMeta.ormType;
			} else if ( structKeyExists(propertyMeta, "type") ) {
				dataType = propertyMeta.type;
			}
			
			// Check the dataType against different lists of types for correct fieldType
			if( listFindNoCase("boolean,yes_no,true_false", dataType) ) {
				return "yesno";	
			} else if ( listFindNoCase("date,timestamp", dataType) ) {
				return "dateTime";
			} else if ( listFindNoCase("array", dataType) ) {
				return "select";
			} else if ( listFindNoCase("struct", dataType) ) {
				return "checkboxgroup";
			}
			
			// If the propertyName has the word 'password' in it... then use a password field
			if(findNoCase("password", arguments.propertyName)) {
				return "password";
			}
			
		// If this is a Relationship property, then determine the relationship type and return the correct fieldType
		} else if( structKeyExists(propertyMeta, "fieldType") && propertyMeta.fieldType == "many-to-one" ) {
			return "select";
		} else if ( structKeyExists(propertyMeta, "fieldType") && propertyMeta.fieldType == "one-to-many" ) {
			throw("There is now property field type for one-to-many relationship properties");
		} else if ( structKeyExists(propertyMeta, "fieldType") && propertyMeta.fieldType == "many-to-many" ) {
			return "listingMultiselect";
		}
		
		// Default case if no matches were found is a text field
		return "text";
	}
	
	// @help Public method to determine if this is a persistent object
	public any function isPersistent() {
		var metaData = getThisMetaData();
		if(structKeyExists(metaData, "persistent") && metaData.persistent) {
			return true;
		}
		return false;
	}
	
	public boolean function hasProperty(required string propertyName) {
		return structKeyExists( getPropertiesStruct(), arguments.propertyName );
	}
	
	// @help public method for getting the meta data of a specific property
	public struct function getPropertyMetaData( required string propertyName ) {
		var propertiesStruct = getPropertiesStruct();
		
		if(structKeyExists(propertiesStruct, arguments.propertyName)) {
			return propertiesStruct[ arguments.propertyName ];
		}
		
		// If no properties found with the name throw error 
		throw("No property found with name #propertyName# in #getClassName()#");
	}
	
	// =======================  END: PROPERTY INTROSPECTION  ========================================
	// ==================== START: APPLICATION CACHED META VALUES ===================================
	
	public array function getProperties() {
		if( !getHibachiScope().hasApplicationValue("classPropertyCache_#getClassFullname()#") ) {
			var metaData = getMetaData(this);
			var metaProperties = metaData.properties;
			
			// Also add any extended data
			if(structKeyExists(metaData, "extends") && structKeyExists(metaData.extends, "properties")) {
				metaProperties = getService("hibachiUtilityService").arrayConcat(metaData.extends.properties, metaProperties);
			}
			
			setApplicationValue("classPropertyCache_#getClassFullname()#", metaProperties);
		}
		
		return getApplicationValue("classPropertyCache_#getClassFullname()#");
	}
	
	public struct function getPropertiesStruct() {
		if( !getHibachiScope().hasApplicationValue("classPropertyStructCache_#getClassFullname()#") ) {
			var propertiesStruct = {};
			var properties = getProperties();
			
			for(var i=1; i<=arrayLen(properties); i++) {
				propertiesStruct[ properties[i].name ] = properties[ i ];
			}
			
			setApplicationValue("classPropertyStructCache_#getClassFullname()#", propertiesStruct);
		}
		
		return getApplicationValue("classPropertyStructCache_#getClassFullname()#");
	}
	
	// @help private method only used by populate
	private void function _setProperty( required any name, any value ) {
		
		// If a value was passed in, set it
		if( structKeyExists(arguments, 'value') ) {
			// Defined the setter method
			var theMethod = this["set" & arguments.name];
			
			// Call Setter
			theMethod(arguments.value);
		} else {
			// Remove the key from variables, represents setting as NULL for persistent entities
			structDelete(variables, arguments.name);
		}
	}
	
	// ====================  END: APPLICATION CACHED META VALUES ====================================
	// ==================== START: INTERNALLY CACHED META VALUES ====================================
	
	// @help Public method that caches locally the meta data of this object
	public any function getThisMetaData(){
		if(!structKeyExists(variables, "thisMetaData")) {
			variables.thisMetaData = getMetaData( this );
		}
		return variables.thisMetaData;
	}
	
	// ====================  END: INTERNALLY CACHED META VALUES =====================================
	// ========================= START: DELIGATION HELPERS ==========================================
	
	// @hint helper function to pass this entity along with a template to the string replace function
	public string function stringReplace( required string templateString, boolean formatValues=false ) {
		return getService("hibachiUtilityService").replaceStringTemplate(arguments.templateString, this, arguments.formatValues);
	}
	
	
}