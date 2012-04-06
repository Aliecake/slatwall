/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component displayname="Base Object" accessors="true" output="false" {
	
	
	property name="vtResult" type="any";							// This propery holds the ValidateThis result bean once it has been set.
	property name="errorBean" type="any";							// This porpery holds errors that are not part of ValidateThis, for example processing errors.
	property name="messageBean" type="any";
	property name="populatedSubProperties" type="array";
	property name="validations" type="struct";
	
	// Constructor Metod
	public any function init() {
		return this;
	}
	
	// ========================= START: ACCESSOR OVERRIDES ==========================================
	
	// @hint Returns the ValidateThis result object, if one hasn't been setup yet it returns a new one
	public any function getVTResult() {
		if(!structKeyExists(variables, "vtResult")) {
			variables.vtResult = getValidateThis().newResult(); 
		}
		return variables.vtResult;
	}
	
	// @hint Returns the errorBean object, if one hasn't been setup yet it returns a new one
	public any function getErrorBean() {
		if(!structKeyExists(variables, "errorBean")) {
			variables.errorBean = new Slatwall.com.utility.ErrorBean(); 
		}
		return variables.errorBean;
	}
	
	// @hint Returns the messageBean object, if one hasn't been setup yet it returns a new one
	public any function getMessageBean() {
		if(!structKeyExists(variables, "messageBean")) {
			variables.messageBean = new Slatwall.com.utility.MessageBean(); 
		}
		return variables.messageBean;
	}
	
	// @hint Returns the populatedSubProperties array, if one hasn't been setup yet it returns a new one
	public array function getPopulatedSubProperties() {
		if(!structKeyExists(variables, "populatedSubProperties")) {
			variables.populatedSubProperties = [];
		}
		return variables.populatedSubProperties; 
	}
	
	// =========================  END:  ACCESSOR OVERRIDES ==========================================
	
	// =============================== START: ERRORS ================================================
	
	// @hint Returns a struct of all the errors for this entity
	public struct function getErrors() {
		var errorsStruct = {};
		
		// Check the VTResult for any errors
		for(var key in getVTResult().getErrors()) {
			errorsStruct[key] = getVTResult().getErrors()[key];	
		}
		
		// Check the ErrorBean for any errors
		for(var key in getErrorBean().getErrors()) {
			if(structKeyExists(errorsStruct, key)) {
				for(var i=1; i<=arrayLen(getErrorBean().getErrors()[key]); i++) {
					arrayAppend(errorsStruct[key], getErrorBean().getErrors()[key][i]);	
				}
			} else {
				errorsStruct[key] = getErrorBean().getErrors()[key];	
			}
		}
		
		// Default behavior if this object hasn't been validated is to return a blank struct
		return errorsStruct;
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
		if(getVTResult().hasErrors() || getErrorBean().hasErrors()) {
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
		getErrorBean().addError(argumentCollection=arguments);
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
	
	// ===============================  END:  ERRORS ================================================
	
	// ============================== START: MESSAGES ===============================================
	
	// @hint Returns a struct of all the messages for this object
	public struct function getMessages() {
		return getMessageBean().getMessages();
	}
	
	// @hint Returns the error message of a given error name
	public struct function getMessage( required string messageName ) {
		
		// Check First that the error exists, and if it does return it
		if( getMessageBean().hasMessage(arguments.messageName) ) {
			return getMessageBean().getMessage( arguments.messageName );
		}
		
		// Default behavior if the error isn't found is to return an empty array
		return [];
	}
	
	// @hint Returns true if there are any messages
	public boolean function hasMessages( ) {
		return getMessageBean().hasMessages();
	}
	
	// @hint Returns true if a specific message key exists
	public boolean function hasMessage( required string messageName ) {
		return getMessageBean().hasMessage( arguments.messageName );
	}
	
	// @hint helper method to add an error to the error bean	
	public void function addMessage( required string messageName, required string message ) {
		getMessageBean().addMessage(argumentCollection=arguments);
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
	
	// ==============================  END:  MESSAGES ===============================================
	
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
						if( arguments.data[ currentProperty.name ] == "" && ( !structKeyExists(currentProperty, "notNull") || !currentProperty.notNull ) ) {
							_setProperty(currentProperty.name);
						
						// If the value isn't blank, or we can't set to null... then we just set the value.
						} else {
							_setProperty(currentProperty.name, arguments.data[ currentProperty.name ]);
						}
					
				// (MANY-TO-ONE) Do this logic if this property is a many-to-one relationship, and the data passed in is of type struct
				} else if( structKeyExists(currentProperty, "fieldType") && currentProperty.fieldType == "many-to-one" && isStruct( arguments.data[ currentProperty.name ] ) ) {
					
					// Set the data of this Many-To-One relationship into it's own local struct
					var manyToOneStructData = arguments.data[ currentProperty.name ];
					
					// Find the primaryID column Name
					var primaryIDPropertyName = getService( "utilityORMService" ).getPrimaryIDPropertyNameByEntityName( "Slatwall#currentProperty.cfc#" );
					
					// If the primaryID exists then we can set the relationship
					if(structKeyExists(manyToOneStructData, primaryIDPropertyName)) {
						
						// set the service to use to get the specific entity
						var entityService = getService( "utilityORMService" ).getServiceByEntityName( "Slatwall#currentProperty.cfc#" );
						
						// If there were additional values in the data, then we will get the entity by the primaryID and populate / validate by calling save in its service.
						if(structCount(manyToOneStructData) gt 1) {
							
							// Load the specifiv entity, if one doesn't exist, this will return a new entity
							var thisEntity = entityService.invokeMethod( "get#currentProperty.cfc#", {1=manyToOneStructData[primaryIDPropertyName],2=true});
							
							// Set the value of the property as the loaded entity
							_setProperty(currentProperty.name, thisEntity );
							
							// Call the save method for this sub property entity and pass in the data
							thisEntity = entityService.invokeMethod( "save#currentProperty.cfc#", {1=thisEntity, 2=manyToOneStructData});
							
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
								var thisEntity = entityService.invokeMethod( "get#currentProperty.cfc#", {1=manyToOneStructData[primaryIDPropertyName]});
							
								// Set the value of the property as the loaded entity
								_setProperty(currentProperty.name, thisEntity );
							}
						}
					}
					
				// (ONE-TO-MANY) Do this logic if this property is a one-to-many or many-to-many relationship, and the data passed in is of type array	
				} else if ( structKeyExists(currentProperty, "fieldType") && (currentProperty.fieldType == "one-to-many" or currentProperty.fieldType == "many-to-many") && isArray( arguments.data[ currentProperty.name ] ) ) {
					
					// Set the data of this One-To-Many relationship into it's own local array
					var oneToManyArrayData = arguments.data[ currentProperty.name ];
					
					// Find the primaryID column Name for the related object
					var primaryIDPropertyName = getService( "utilityORMService" ).getPrimaryIDPropertyNameByEntityName( "Slatwall#currentProperty.cfc#" );
					
					// Loop over the array of objects in the data... Then load, populate, and validate each one
					for(var a=1; a<=arrayLen(oneToManyArrayData); a++) {
						
						// Check to make sure that this array has the primary ID property in it, otherwise we can't do a populate.  Also check to make sure populateSubProperties was not set to false in the data (if not defined we asume true).
						if(structKeyExists(oneToManyArrayData[a], primaryIDPropertyName) && (!structKeyExists(arguments.data, "populateSubProperties") || arguments.data.populateSubProperties)) {
							
							// set the service to use to get the specific entity
							var entityService = getService( "utilityORMService" ).getServiceByEntityName( "Slatwall#currentProperty.cfc#" );
							
							// Load the specific entity, and if one doesn't exist yet then return a new entity
							var thisEntity = entityService.invokeMethod( "get#currentProperty.cfc#", {1=oneToManyArrayData[a][primaryIDPropertyName],2=true});
							
							// Add the entity to the existing objects properties
							this.invokeMethod("add#currentProperty.singularName#", {1=thisEntity});
							
							// If there were additional values in the data array, then we use those values to populate the entity, and validating it aswell.
							if(structCount(oneToManyArrayData[a]) gt 1) {
								
								// Call the save method for this sub property entity and pass in the data
								thisEntity = entityService.invokeMethod( "save#currentProperty.cfc#", {1=thisEntity, 2=oneToManyArrayData[a]});
								
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
					var primaryIDPropertyName = getService( "utilityORMService" ).getPrimaryIDPropertyNameByEntityName( "Slatwall#currentProperty.cfc#" );
					
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
						var entityService = getService( "utilityORMService" ).getServiceByEntityName( "Slatwall#currentProperty.cfc#" );
							
						// set the id of this entity into a local variable
						var thisEntityID = listGetAt(manyToManyIDList, n);
						
						// Load the specific entity, if one doesn't exist... this will be null
						var thisEntity = entityService.invokeMethod( "get#currentProperty.cfc#", {1=thisEntityID});
						
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
	
	// @hint pubic method to validate this object
	public any function validate( string context="save" ) {
		
		// Set up the validation arguments as a mirror of the arguments struct
		var validationArguments = arguments;
		
		// Add this as "theObject" to the validation arguments
		validationArguments.theObject = this;
		
		// Validate This object
		getValidateThis().validate( argumentCollection=validationArguments );
		
		// Validate each of the objects that are in the populatedSubProperties array, This array has properties added to it during the populate method
		for(var p=1; p<=arrayLen(getPopulatedSubProperties()); p++) {
			
			// Get the values of this sub property
			var subPropertyValue = invokeMethod("get#getPopulatedSubProperties()[p]#");
			
			// If the value is Null then throw an error because the populatedSubProperties array should have never had this propertyName in it
			if(isNull(subPropertyValue)) {
				throw("the property name: #getPopulatedSubProperties()[p]# was in the populatedSubProperties array, however it must not have actually been populated because the value is null.  Or the property was populated, but something later set it back to null.");
			}
			
			// If the results are an array, then loop over them
			if(isArray(subPropertyValue)) {
				
				// Loop over each object in the subProperty array and validate it
				for(var e=1; e<=arrayLen(subPropertyValue); e++ ) {
				
					// If after validation that sub object has errors, add a failure to this object
					if(subPropertyValue[e].hasErrors()) {
						getVTResult().addFailure( failure={message="One or more items had invalid data"},propertyName=getPopulatedSubProperties()[p]);
					}
				}	
			} else if(isObject(subPropertyValue)) {
				if(subPropertyValue.hasErrors()) {
					getVTResult().addFailure( failure={message="The #getPopulatedSubProperties()[p]# property has or more validation errors"},propertyName=getPopulatedSubProperties()[p]);
				}
			}
		}
		
		// Return the VTResult object that was populated by ValidateThis
		return getVTResult();
	}
	
	// =======================  END:  POPULATION & VALIDATION =======================================
	
	// =========================== START: UTILITY METHODS ===========================================
	
	// @hint Public method to retrieve a value based on a propertyIdentifier string format
	public any function getValueByPropertyIdentifier(required string propertyIdentifier, boolean formatValue=false) {
		var value = javaCast("null", "");
		var newValue = "";
		var arrayValue = arrayNew(1);
		var pa = listToArray(arguments.propertyIdentifier, "._");
		
		for(var i=1; i<=arrayLen(pa); i++) {
			try {
				if(isNull(value)) {
					value = evaluate("this.get#pa[i]#()");
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
					if(isSimpleValue(newValue) && arguments.formatValue) {
						value = value.getFormattedValue(pa[i]);
					} else {
						value = newValue;
					}
				}	
			} catch (any e) {
				return "";
			}
		}
		if(isNull(value)) {
			return "";
		}
		
		/*
		if(isSimpleValue(value) && arguments.formatValue) {
			return this.formatValue(value, getPropertyFormatType(pa[1]));
		}
		*/
		
		return value;
	}

	public any function getFormattedValue(required string propertyName, string formatType ) {
			arguments.value = invokeMethod("get#arguments.propertyName#");
		
		// This is the null format option
		if(isNull(arguments.value)) {
			return "";
		// This is not a simple value, throw an exception
		} else if (!isSimpleValue(arguments.value)) {
			throw("You cannont convert complex values to formatted Values");
		}
		
		// check if a formatType was passed in, if not then use the getPropertyFormatType() method to figure out what it should be by default
		if(!structKeyExists(arguments, "formatType")) {
			arguments.formatType = getPropertyFormatType( arguments.propertyName );
		}
		
		return formatValue(value=arguments.value, formatType=arguments.formatType);
	}
	
	// @hint public method for getting the display format for a given property, this is used a lot by the SlatwallPropertyDisplay
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
		
		for(var i=1; i<=arrayLen(validations); i++) {
			if(validations[i].propertyName == arguments.propertyName) {
				var validationType = validations[i].valtype;
				
				if(validationType == "numeric") {
					validationType = "number";
				}
				
				validationClass = listAppend(validationClass, validationType, " ");		
			}
		} 
		
		return validationClass;
	}
	
	// @hind public method to see all of the validations for a particular context
	public array function getValidations( string context="save") {
		if(!structKeyExists(variables, "validations")) {
			variables.validations = {};
		}
		if(!structKeyExists(variables.validations, arguments.context)) {
			variables.validations[ arguments.context ] = getValidateThis().getValidator(theObject=this).getValidations(Context=arguments.context);
		}
		return variables.validations[ arguments.context ];
	}
	
	// @hint public method for getting the title to be used for a property from the rbFactory, this is used a lot by the SlatwallPropertyDisplay
	public string function getPropertyTitle(required string propertyName) {
		var exactMatch = rbKey("entity.#getClassName()#.#arguments.propertyName#");
		if(right(exactMatch, 8) != "_missing") {
			return exactMatch;
		}
		var genericMatch = rbKey("entity.define.#arguments.propertyName#");
		if(right(genericMatch, 8) != "_missing") {
			return genericMatch;
		}
		return exactMatch;
	}
	
	// @hint public method to get the rbKey value for a property in a subentity
	public string function getTitleByPropertyIdentifier( required string propertyIdentifier ) {
		if(find(".", arguments.propertyIdentifier)) {
			var exampleEntity = createObject("component", "Slatwall.com.entity.#getPropertyMetaData( listFirst(arguments.propertyIdentifier, '.') ).cfc#");
			return exampleEntity.getTitleByPropertyIdentifier( replace(arguments.propertyIdentifier, "#listFirst(arguments.propertyIdentifier, '.')#.", '') );
		}
		return getPropertyTitle( arguments.propertyIdentifier );
	}
	
	// @hint public method for returning the name of the field for this property, this is used a lot by the SlatwallPropertyDisplay
	public string function getPropertyFieldName(required string propertyName) {
		
		// Get the Meta Data for the property
		var propertyMeta = getPropertyMetaData( arguments.propertyName );
		
		// If this is a relational property, and the relationship is many-to-one, then return the propertyName and propertyName of primaryID
		if( structKeyExists(propertyMeta, "fieldType") && propertyMeta.fieldType == "many-to-one" ) {
			
			var primaryIDPropertyName = getService( "utilityORMService" ).getPrimaryIDPropertyNameByEntityName( "Slatwall#propertyMeta.cfc#" );
			return "#arguments.propertyName#.#primaryIDPropertyName#";
		}
		
		// Default case is just to return the property Name
		return arguments.propertyName;
	}
	
	// @hint public method for inspecting the property of a given object and determining the most appropriate field type for that property, this is used a lot by the SlatwallPropertyDisplay
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
	
	public boolean function hasProperty(required string propertyName) {
		var properties = getProperties();
		for(var i=1; i<=arrayLen(properties); i++) {
			if(properties[i].name == arguments.propertyName) {
				return true;
			}
		}
		return false;
	}
	
	// @help public method for getting a recursive list of all the meta data of the properties of an object
	public array function getProperties(struct metaData=getMetaData(this)) {
		var properties = arguments.metaData["properties"];
		var parentProperties = "";
		// recursively get properties of any super classes
		if(structKeyExists(arguments.metaData, "extends") && structKeyExists(arguments.metaData.extends,"properties")) {
			parentProperties = getProperties(arguments.metaData["extends"]);
			return getService("utilityService").arrayConcat(parentProperties,properties);
		} else {
			return properties;
		}
	}
	
	// @help public method for getting the meta data of a specific property
	public struct function getPropertyMetaData(string propertyName) {
		var properties = getProperties();
		for(var i=1; i<=arrayLen(properties); i++) {
			if(properties[i].name eq arguments.propertyName) {
				return properties[i];
			}
		}
		// If no properties found with the name throw error 
		throw("No property found with name #propertyName# in #getClassName()#");
	}
	
	// @hint return a simple representation of this entity
	public string function getSimpleRepresentation() {
		
		// Try to get the actual value of that property
		var representation = this.invokeMethod("get#getSimpleRepresentationPropertyName()#");
		
		// If the value isn't null, and it is simple, then return it.
		if(!isNull(representation) && isSimpleValue(representation)) {
			return representation;
		}
		
		// Default case is to return a blank value
		return "";
	}
	
	// @hint returns the propety who's value is a simple representation of this entity.  This can be overridden when necessary
	public string function getSimpleRepresentationPropertyName() {
		
		// Get the meta data for all of the porperties
		var properties = getProperties();
		
		// Look for a property that's last 4 is "name"
		for(var i=1; i<=arrayLen(properties); i++) {
			if(properties[i].name == getClassName() & "name") {
				return properties[i].name;
			}
		}
		
		// If no properties could be identified as a simpleRepresentaition 
		throw("There is no Simple Representation Property Name for #getClassName()#.  You can either override getSimpleRepresentation() or override getSimpleRepresentationPropertyName() in the entity, but be sure to do it at the bottom iside of commented sectin for overrides.");
	}
	
	// @help Public Method that allows you to get a serialized JSON struct of all the simple values in the variables scope.  This is very useful for compairing objects before and after a populate
	public string function getSimpleValuesSerialized() {
		var data = {};
		for(var key in variables) {
			if( isSimpleValue(variables[key]) ) {
				data[key] = variables[key];
			}
		}
		return serializeJSON(data);
	}
		
	// @help Public Method to invoke any method in the object, If the method is not defined it calls onMissingMethod
	public any function invokeMethod(required string methodName, struct methodArguments={}, boolean testing=false) {
		
		if(structKeyExists(this, arguments.methodName)) {
			var theMethod = this[ arguments.methodName ];
			return theMethod(argumentCollection = methodArguments);
		}
		
		return this.onMissingMethod(missingMethodName=arguments.methodName, missingMethodArguments=arguments.methodArguments);
	}
	
	// @help Public method to get everything in the variables scope, good for debugging purposes
	public any function getVariables() {
		return variables;
	}
	
	// @help Public method to get the class name of an object
	public any function getClassName() {
		return listLast(getClassFullname(), "."); 
	}
	
	// @help Public method to get the fully qualified dot notation class name
	public any function getClassFullname() {
		return getMetaData( this ).fullname;
	}
	
	// @help Public method to determine if this is a persistent object
	public any function isPersistent() {
		var metaData = getMetaData( this );
		if(structKeyExists(metaData, "persistent") && metaData.persistent) {
			return true;
		}
		return false;
	}
	
	
	// @hint this method allows you to properly format a value against a formatType
	public any function formatValue( required string value, required string formatType ) {
		
		//	Valid formatType Strings are:	none	yesno	truefalse	currency	datetime	date	time	weight
		
		// Do a switch on the seperate formatTypes and return a formatted value
		switch(arguments.formatType) {
			case "none": {
				return arguments.value;
			}
			case "yesno": {
				if(isBoolean(arguments.value) && arguments.value) {
					return rbKey('define.yes');
				} else {
					return rbKey('define.no');
				}
			}
			case "truefalse": {
				if(isBoolean(arguments.value) && arguments.value) {
					return rbKey('define.true');
				} else {
				return rbKey('define.false');
				}
			}
			case "currency": {
				return LSCurrencyFormat(arguments.value, setting("globalCurrencyType"), setting("globalCurrencyLocale"));
			}
			case "datetime": {
				return dateFormat(arguments.value, setting("globalDateFormat")) & " " & TimeFormat(value, setting("globalTimeFormat"));
			}
			case "date": {
				return dateFormat(arguments.value, setting("globalDateFormat"));
			}
			case "time": {
				return timeFormat(arguments.value, setting("globalTimeFormat"));
			}
			case "weight": {
				return arguments.value & " " & setting("globalWeightUnitCode");
			}
			case "pixels": {
				return arguments.value & "px";
			}
			case "url": {
				return '<a href="#arguments.value#" target="_blank">' & arguments.value & '</a>';
			}
			case "email": {
				return '<a href="mailto:#arguments.value#" target="_blank">' & arguments.value & '</a>';
			}
		}
		
		return arguments.value;
	}
	
	private string function createSlatwallUUID() {
		return replace(lcase(createUUID()), '-', '', 'all');
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
	
	public string function encryptValue(required string value) {
		var encryptedValue = "";
		if(!isNull(arguments.value) && arguments.value != "") {
			if(setting("globalEncryptionService") == "internal"){
				encryptedValue = getService("encryptionService").encryptValue(arguments.value);
			} else {
				encryptedValue = getService("integrationService").getIntegrationByIntegrationPackage( setting("globalEncryptionIntegration") ).getIntegrationCFC().encryptValue(arguments.value);
			}
		}
		return encryptedValue;
	}
	
	public string function decryptValue(required string value) {
		var decryptedValue = "";
		if(!isNull(arguments.value) && arguments.value != "") {
			if(setting("globalEncryptionService") == "internal"){
				decryptedValue = getService("encryptionService").decryptValue(arguments.value);
			} else {
				decryptedValue = getService("integrationService").getIntegrationByIntegrationPackage( setting("globalEncryptionIntegration") ).getIntegrationCFC().decryptValue(arguments.value);
			}
		}
		return decryptedValue;
	}
	
	// ===========================  END:  UTILITY METHODS ===========================================
	
	// ========================= START: DELIGATION HELPERS ==========================================
	
	// @hint  rounding function
	public string function round(required any value, string roundingExpression="0.00", string roundingDirection="Closest") {
		return getService("roundingRuleService").roundValue(argumentcollection=arguments);
	}
	
	// @hint  function for returning the any of the services in the application
	public any function getService(required string serviceName) {
		return getPluginConfig().getApplication().getValue("serviceFactory").getBean(arguments.serviceName);
	}
	
	// @hint  helper function absolute url path from site root
	public string function getSlatwallRootPath() {
		return "#application.configBean.getContext()#/plugins/Slatwall";
	}
	
	// @hint  helper function the file system directory
	public string function getSlatwallRootDirectory() {
		return expandPath("/plugins/Slatwall");
	}
	
	// @hint  helper function to get the database type
	public string function getDBType() {
		return application.configbean.getDBType();
	}
	
	// @hint  helper function to return the Slatwall RB Factory in any component
	public any function getRBFactory() {
		return getPluginConfig().getApplication().getValue("rbFactory");
	}
	
	// @hint  helper function for returning the plugin config inside of any component in the application
	public any function getPluginConfig() {
		return application.slatwall.pluginConfig;
	}
	
	// @hint  helper function for returning the fw
	public any function getFW() {
		return getPluginConfig().getApplication().getValue('fw');
	}
	
	// @hint  helper function for returning the Validate This Facade Object
	public any function getValidateThis() {
		return getPluginConfig().getApplication().getValue('validateThis');
	}
	
	// @hint  helper function for returning the Validate This Facade Object
	public any function getCFStatic() {
		if(!structKeyExists(application.slatwall, "cfstatic")) {
			application.slatwall.cfstatic = createObject("component", "muraWRM.requirements.org.cfstatic.CfStatic").init(
				staticDirectory = expandPath( '/plugins/Slatwall/assets/' ),
				staticUrl = "#application.configBean.getContext()#/plugins/Slatwall/assets/",
				minifyMode = 'package',
				checkforupdates = true
				);
		}
		return application.slatwall.cfstatic;
	}
	
	// @hint  helper function for returning a new API key for a specific resource for this session
	public string function getAPIKey(required string resource, required string verb) {
		return getService("sessionService").getAPIKey(argumentcollection=arguments);
	}
	
	// @hint  helper function to return the RB Key from RB Factory in any component
	public string function rbKey(required string key, string local="us") {
		return getRBFactory().getKeyValue(arguments.local, arguments.key);
	}
	
	// @hint helper function to return a Setting
	public any function setting(required string settingName, array filterEntities=[], formatValue=false) {
		return getService("settingService").getSettingValue(settingName=arguments.settingName, object=this, formatValue=arguments.formatValue);
	}
	
	// @hint helper function to return the details of a setting
	public struct function getSettingDetails(required any settingName, array filterEntities=[]) {
		return getService("settingService").getSettingDetails(settingName=arguments.settingName, object=this);
	}
	
	// @hint  helper function for building URL's
	public string function buildURL() {
		return getFW().buildURL(argumentCollection = arguments);
	}
	
	// @hint  helper function for getting checking security
	public boolean function secureDisplay() {
		return getFW().secureDisplay(argumentCollection = arguments);
	}
	
	// @hint  helper function for using the Slatwall Log service.
	public void function logSlatwall(required string message, boolean generalLog=false){
		getService("utilityLogService").logMessage(message=arguments.message, generalLog=arguments.generalLog);		
	}
	
	// @hint  helper function for using the Slatwall Log Exception service.
	public void function logSlatwallException(required any exception){
		getService("utilityLogService").logException(exception=arguments.exception);		
	}
	
	// @hint  helper function to get a bean for the underlying CMS (mura for now)
	public any function getCMSBean( required any beanName ) {
		return application.serviceFactory.getBean( arguments.beanName );
	} 
	
	// =========================  END:  DELIGATION HELPERS ==========================================
	
}
