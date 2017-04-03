<<<<<<< HEAD
=======
/*
    Hibachi
    Copyright (C) ten24, LLC

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

    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.

    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms
    of your choice, provided that you follow these specific guidelines:
	- You also meet the terms and conditions of the license of each
	  independent module
	- You must not alter the default display of the Hibachi name or logo from
	  any part of the application
	- Your custom code must not alter or create any files inside Hibachi,
	  except in the following directories:
		/integrationServices/
	You may copy and distribute the modified version of this program that meets
	the above guidelines as a combined work under the terms of GPL for this program,
	provided that you include the source code of that other code when and as the
	GNU GPL requires distribution of source code.

    If you modify this program, you may extend this exception to your version
    of the program, but you are not obligated to do so.
Notes:
*/
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
component output="false" accessors="true" extends="HibachiService"  {

	property name="accountService" type="any";
	property name="orderService" type="any";
	property name="hibachiAuditService" type="any";
	property name="hibachiTagService" type="any";
	property name="hibachiUtilityService" type="any";

	// ===================== START: Logical Methods ===========================
<<<<<<< HEAD
	public struct function getConfig(){
		var config = {};
		config[ 'applicationKey' ] = getApplicationValue('applicationKey');
		config[ 'baseURL' ] = getApplicationValue('baseURL');
		config[ 'action' ] = getApplicationValue('action');
		config[ 'dateFormat' ] = 'mmm dd, yyyy';
		config[ 'timeFormat' ] = 'hh:mm tt';
		var rbLocale = 'en_us';
		if(!isNull(getHibachiScope().getSession().getRBLocale())){
			rbLocale = '#getHibachiScope().getSession().getRBLocale()#';
		}
		config[ 'rbLocale' ] = rbLocale;
		config[ 'debugFlag' ] = getApplicationValue('debugFlag');
		config[ 'instantiationKey' ] = '#getApplicationValue('instantiationKey')#';
		return config;
	}
	
	public void function setProperSession() {
		var requestHeaders = getHTTPRequestData();
		
		// Check to see if a session value doesn't exist, then we can check for a cookie... or just set it to blank
		if(!getHibachiScope().hasSessionValue("sessionID")) {
			getHibachiScope().setSessionValue('sessionID', '');
		}
		
		
		var foundWithNPSID = false;
		var foundWithPSID = false;
		var foundWithExtendedPSID = false;
		
		// Check for non-persistent cookie.
		if( len(getHibachiScope().getSessionValue('sessionID')) ) {
			var sessionEntity = this.getSession( getHibachiScope().getSessionValue('sessionID'), true);
		} else if( (StructKeyExists(request,'context') && StructKeyExists(request.context, "jsonRequest") && request.context.jsonRequest && StructKeyExists(request.context.deserializedJsonData, "request_token") ) || StructKeyExists(requestHeaders.headers, "request_token") ){
=======

	public void function setPropperSession() {
		var requestHeaders = getHTTPRequestData();

		// Check to see if a session value doesn't exist, then we can check for a cookie... or just set it to blank
		if(!hasSessionValue("sessionID")) {
			setSessionValue('sessionID', '');
		}

		var foundWithNPSID = false;
		var foundWithPSID = false;

		// Check for non-persistent cookie.

		if( len(getSessionValue('sessionID')) ) {
			var sessionEntity = this.getSession( getSessionValue('sessionID'), true);

		} else if( (StructKeyExists(request.context, "jsonRequest") && request.context.jsonRequest && StructKeyExists(request.context.deserializedJsonData, "request_token") ) || StructKeyExists(requestHeaders.headers, "request_token") ){
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
				//If the API 'cookie' and deviceID were passed directly to the API, we can use that for setting the session if the request token matches
				//the token we already have.
				
				//Find the request token in the json or in the headers if it exists.
				var rt = "";
				if (StructKeyExists(request.context, "jsonRequest") && request.context.jsonRequest){
					rt = request.context.deserializedJsonData["request_token"];
				}
				if (StructKeyExists(requestHeaders.headers, "request_token")){
					rt = requestHeaders.headers["request_token"];
				}
<<<<<<< HEAD

=======
								
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
				//set the session
				var NPSID = rt;
				var sessionEntity = this.getSessionBySessionCookieNPSID( NPSID, true );
				foundWithNPSID = true;
<<<<<<< HEAD
				getHibachiScope().setSessionValue('sessionID', sessionEntity.getSessionID());
=======
				setSessionValue('sessionID', sessionEntity.getSessionID());
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
				request.context["foundWithRequestToken"] = true;
				
				/*
				if ( StructKeyExists(request.context, "deviceID") && !Len(sessionEntity.getDeviceID())){
					//If the device doesn't yet exist, add it.'
					sessionEntity.setDeviceID("#request.context.deviceID#");
					foundWithNPSID = true;
<<<<<<< HEAD
					getHibachiScope().setSessionValue('sessionID', sessionEntity.getSessionID());
=======
					setSessionValue('sessionID', sessionEntity.getSessionID());
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
				}else if (( StructKeyExists(requestHeaders.headers, "deviceID") && Len(sessionEntity.getDeviceID()) )){
					//If the device already exists, check against that device to the new device id.
					if (requestHeaders.headers.deviceID == sessionEntity.getDeviceID()){
						foundWithNPSID = true;
<<<<<<< HEAD
						getHibachiScope().setSessionValue('sessionID', sessionEntity.getSessionID()); //We have the correct device for this session.
=======
						setSessionValue('sessionID', sessionEntity.getSessionID()); //We have the correct device for this session.
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
					}else{
						//we don't have the correct device for this session so dont set the session
						foundWithNPSID = false;
					}
				}
				*/
<<<<<<< HEAD
		
		} else if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-ExtendedPSID")) {
			var sessionEntity = this.getSessionBySessionCookieExtendedPSID( cookie["#getApplicationValue('applicationKey')#-ExtendedPSID"], true);
		
			if(sessionEntity.getNewFlag()) {
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-ExtendedPSID", value='', expires="#getHibachiScope().setting('globalExtendedSessionAutoLogoutInDays')#");
			} else {
		
				foundWithExtendedPSID = true;
				getHibachiScope().setSessionValue('sessionID', sessionEntity.getSessionID());
		
			}
			
		} else if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-NPSID")) {
			var sessionEntity = this.getSessionBySessionCookieNPSID( cookie["#getApplicationValue('applicationKey')#-NPSID"], true);
		
			if(sessionEntity.getNewFlag()) {
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-NPSID", value='', expires="#now()#");
			} else {
		
				foundWithNPSID = true;
				getHibachiScope().setSessionValue('sessionID', sessionEntity.getSessionID());
		
			}
		
		} else if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-PSID")) {
			var sessionEntity = this.getSessionBySessionCookiePSID( cookie["#getApplicationValue('applicationKey')#-PSID"], true);
		
			if(sessionEntity.getNewFlag()) {
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-PSID", value='', expires="#now()#");
			} else {
				foundWithPSID = true;
				getHibachiScope().setSessionValue('sessionID', sessionEntity.getSessionID());
			}
		
		
		} else {
			var sessionEntity = this.newSession();
		
		}
		
		// Populate the hibachi scope with the session
		getHibachiScope().setSession( sessionEntity );
		
		// Let the hibachiScope know how we found the proper sessionID
		getHibachiScope().setSessionFoundNPSIDCookieFlag( foundWithNPSID );
		getHibachiScope().setSessionFoundPSIDCookieFlag( foundWithPSID );
		getHibachiScope().setSessionFoundExtendedPSIDCookieFlag( foundWithExtendedPSID );
		
		// Variable to store the last request dateTime of a session
		var previousRequestDateTime = getHibachiScope().getSession().getLastRequestDateTime();
		
		//set a value if previous request dateTime is null.
		if (isNull(previousRequestDateTime)){
			previousRequestDateTime = now();
		}
		
		// update the sessionScope with the ID for the next request
		getHibachiScope().setSessionValue('sessionID', getHibachiScope().getSession().getSessionID());
		
		if(!isNull(getHibachiScope().getSession().getRBLocale())) {
			getHibachiScope().setRBLocale( getHibachiScope().getSession().getRBLocale() );
		
		}
		
		//If the user has never loggedIn via the loggedInDateTime
		
		// If we are an admin and we are not using an extended session. and one of the following, then logout. . .
		
		// If the session has an account but no authentication, then remove the account
		
		// Check to see if this session has an accountAuthentication, if it does then we need to verify that the authentication shouldn't be auto logged out
		
		// If there was an integration, then check the verify method for any custom auto-logout logic
		
		// If the sessions account is an admin and last request by the session was 15 min or longer ago. 
		if(
			(
				(
					getHibachiScope().getSessionFoundPSIDCookieFlag() 
					|| getHibachiScope().getSessionFoundExtendedPSIDCookieFlag() 
					|| getHibachiScope().getSessionFoundNPSIDCookieFlag()
				) 
				&& !getHibachiScope().getLoggedInFlag()
			)
		
			|| (!isNull(getHibachiScope().getSession().getAccountAuthentication()) && getHibachiScope().getSession().getAccountAuthentication().getForceLogoutFlag()) 
		
			|| (isNull( getHibachiScope().getSession().getAccountAuthentication()) && getHibachiScope().getLoggedInFlag())
		
			|| (
				!isNull(getHibachiScope().getSession().getAccountAuthentication()) 
				&& getHibachiScope().getSession().getAccount().getAdminAccountFlag() == true 
				&& !isNull(previousRequestDateTime) 
				&& DateDiff('n', previousRequestDateTime, Now()) >= getHibachiScope().setting('globalAdminAutoLogoutMinutes') 
			)
			|| (
				!isNull(getHibachiScope().getSession().getAccountAuthentication()) 
				&& getHibachiScope().getSession().getAccount().getAdminAccountFlag() == true 
				&& getHibachiScope().getSessionFoundPSIDCookieFlag() 
			)
		
			|| (
				!isNull(getHibachiScope().getSession().getAccountAuthentication()) 
				&& getHibachiScope().getSession().getAccount().getAdminAccountFlag() != true 
				&& !isNull(previousRequestDateTime) 
				&& DateDiff('n', previousRequestDateTime, Now()) >= getHibachiScope().setting('globalPublicAutoLogoutMinutes') 
			)
		
		) 	{
			//check fo soft logout. 
			//has the extended cookie and if not an admin and we are using those extended cookies via the setting then soft logout instead of hard. . .
			if ( structKeyExists(cookie, "#getApplicationValue('applicationKey')#-ExtendedPSID") &&
				!getHibachiScope().getSession().getAccount().getAdminAccountFlag() && 
				 getHibachiScope().setting('globalUseExtendedSession')==1){
				//go into extended session mode.
				logoutAccount(softLogout=true);	
				
			} else {
				logoutAccount(softLogout=false);
			}
		}
		
		// Update the last request datetime, and IP Address now that all other checks have completed.
		getHibachiScope().getSession().setLastRequestDateTime( now() );
		getHibachiScope().getSession().setLastRequestIPAddress( CGI.REMOTE_ADDR );
		
	}
	
	public void function persistSession(boolean updateLoginCookies=false) {
	
		// Save the session
		getHibachiDAO().save( getHibachiScope().getSession() );
		
		// Save session ID in the session Scope & cookie scope for next request
		getHibachiScope().setSessionValue('sessionID', getHibachiScope().getSession().getSessionID());
		
		if (arguments.updateLoginCookies == true){
			
			//Generate new session cookies for every time the session is persisted (on every login);
			//This cookie is removed on browser close
			var npCookieValue = getValueForCookie();
				getHibachiScope().getSession().setSessionCookieNPSID(npCookieValue);
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-NPSID", value=getHibachiScope().getSession().getSessionCookieNPSID());
		    
		    //This cookie never expires.
		    var cookieValue = getValueForCookie();
				getHibachiScope().getSession().setSessionCookiePSID(cookieValue);
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-PSID", value=getHibachiScope().getSession().getSessionCookiePSID(), expires="never");
			
			//only set this if the use is not an admin user and we are using extended sessions.
			if (!getHibachiScope().getAccount().getAdminAccountFlag() && getHibachiScope().setting('globalExtendedSessionAutoLogoutInDays') && getHibachiScope().setting('globalUseExtendedSession')){
				var cookieValue = getValueForCookie();
				getHibachiScope().getSession().setSessionCookieExtendedPSID(cookieValue);
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-ExtendedPSID", value=getHibachiScope().getSession().getSessionCookieExtendedPSID(), expires="#getHibachiScope().setting('globalExtendedSessionAutoLogoutInDays')#");
			}
			
			getHibachiScope().flushORMSession();
			
		}
	}
	
	public string function loginAccount(required any account, required any accountAuthentication) {
	
		var currentSession = getHibachiScope().getSession();
		currentSession.setAccount( arguments.account );
		currentSession.setAccountAuthentication( arguments.accountAuthentication );
	    currentSession.setLoggedInDateTime(DateTimeFormat(now()));
		
		// Make sure that we persist the session
		persistSession(updateLoginCookies=true);
	
		var auditLogData = {
	
			account = arguments.account
	
		};
		
		getHibachiAuditService().logAccountActivity( "login", auditLogData );
		getHibachiEventService().announceEvent("onSessionAccountLogin");
		
	}
	
	/** Logs out the user completely. */
	public void function logoutAccount(boolean softLogout=false) {
		var currentSession = getHibachiScope().getSession();
		var auditLogData = {};
	
		if(!isNull(currentSession.getAccount())) {
			auditLogData.account = currentSession.getAccount();
		}
		
		//No need to remove the account or authentication. We just set the state to being logged out.
		currentSession.setLoggedOutDateTime(DateTimeFormat(now()));
		
		// Update the last request datetime, and IP Address now that all other checks have completed.
		currentSession.setLastRequestDateTime( now() );
		currentSession.setLastRequestIPAddress( CGI.REMOTE_ADDR );
		
		if (arguments.softLogout == false){
			
			var oldSession = currentSession;
			
			var newSession = this.newSession();
			
			//if the settings are set for copying the cart over, then copy it.
			if (getHibachiScope().setting('globalCopyCartToNewSessionOnLogout') && !isNull(oldSession.getOrder())){
				getHibachiDAO().save( oldSession.getOrder() );
				if (!oldSession.getOrder().hasErrors()){
					newSession.setOrder(oldSession.getOrder());
				}
			}
			getHibachiScope().setSession(newSession);
			getHibachiDAO().save( newSession );
			getHibachiDAO().flushORMSession();
			
		}
		
		//Remove the cookies. Forgets the user if they intentionally click logout (on public computer for example)
		if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-NPSID")){
			getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-NPSID", value='', expires="#now()#");
			structDelete(cookie,"#getApplicationValue('applicationKey')#-NPSID", true);
		}
		
		if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-PSID")){
			getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-PSID", value='', expires="#now()#");
			structDelete(cookie,"#getApplicationValue('applicationKey')#-PSID", true);
		}
		
		//only delete this extended session cookie if this is a hard logout instead of soft.
		if((structKeyExists(cookie, "#getApplicationValue('applicationKey')#-ExtendedPSID") && arguments.softLogout == false) || (structKeyExists(cookie, "#getApplicationValue('applicationKey')#-ExtendedPSID") && currentSession.getAccount().getAdminAccountFlag())){
			getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-ExtendedPSID", value='', expires="#now()#");
			structDelete(cookie,"#getApplicationValue('applicationKey')#-ExtendedPSID", true);
		}

		// Make sure that we persist the session
		persistSession(updateLoginCookies=false);
		
		// Make sure that this logout is persisted
		getHibachiDAO().flushORMSession();
		getHibachiAuditService().logAccountActivity("logout", auditLogData);
		if (softLogout == false){
			getHibachiEventService().announceEvent("onSessionAccountLogout");
		}
	}
	
	// =====================  END: Logical Methods ============================
	
	// ===================== START: DAO Passthrough ===========================
	
	// ===================== START: DAO Passthrough ===========================
	
	// ===================== START: Process Methods ===========================
	
	public any function processSession_authorizeAccount(required any session, required any processObject) {
		
		// Take the email address and get all of the user accounts by primary e-mail address
		var accountAuthentications = getAccountService().getInternalAccountAuthenticationsByEmailAddress(emailAddress=arguments.processObject.getEmailAddress());
	
		if(arrayLen(accountAuthentications)) {
			
			for(var i=1; i<=arrayLen(accountAuthentications); i++) {
				// If the password matches what it should be, then set the account in the session and 
		
=======
			
		} else if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-NPSID")) {
			var sessionEntity = this.getSessionBySessionCookieNPSID( cookie["#getApplicationValue('applicationKey')#-NPSID"], true);

			if(sessionEntity.getNewFlag()) {
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-NPSID", value='', expires="now");
			} else {

				foundWithNPSID = true;
				setSessionValue('sessionID', sessionEntity.getSessionID());

			}

		// Check for a persistent cookie.
		} else if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#-PSID")) {

			var sessionEntity = this.getSessionBySessionCookiePSID( cookie["#getApplicationValue('applicationKey')#-PSID"], true);

			if(sessionEntity.getNewFlag()) {
				getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-PSID", value='', expires="now");
			} else {
				foundWithPSID = true;
				setSessionValue('sessionID', sessionEntity.getSessionID());
			}

		// Last option is to just create a new session record
		} else {
			var sessionEntity = this.newSession();
		}

		// Populate the hibachi scope with the session
		getHibachiScope().setSession( sessionEntity );

		// Let the hibachiScope know how we found the proper sessionID
		getHibachiScope().setSessionFoundNPSIDCookieFlag( foundWithNPSID );
		getHibachiScope().setSessionFoundPSIDCookieFlag( foundWithPSID );

		// Variable to store the last request dateTime of a session
		var previousRequestDateTime = getHibachiScope().getSession().getLastRequestDateTime();

		// update the sessionScope with the ID for the next request
		setSessionValue('sessionID', getHibachiScope().getSession().getSessionID());

		// Update the last request datetime, and IP Address
		getHibachiScope().getSession().setLastRequestDateTime( now() );
		getHibachiScope().getSession().setLastRequestIPAddress( CGI.REMOTE_ADDR );

		if(!isNull(getHibachiScope().getSession().getRBLocale())) {
			getHibachiScope().setRBLocale( getHibachiScope().getSession().getRBLocale() );

		}

		// If the session has an account but no authentication, then remove the account

		// Check to see if this session has an accountAuthentication, if it does then we need to verify that the authentication shouldn't be auto logged out

		// If there was an integration, then check the verify method for any custom auto-logout logic

		// If the sessions account is and admin and last request by the session was 15 min or longer ago.

		if((getHibachiScope().getSessionFoundPSIDCookieFlag() && getHibachiScope().getLoggedInFlag())

			|| (!isNull(getHibachiScope().getSession().getAccountAuthentication()) && getHibachiScope().getSession().getAccountAuthentication().getForceLogoutFlag())

			|| (isNull(getHibachiScope().getSession().getAccountAuthentication()) && getHibachiScope().getLoggedInFlag())

			|| (!isNull(getHibachiScope().getSession().getAccountAuthentication()) && getHibachiScope().getSession().getAccount().getAdminAccountFlag() == true && DateDiff('n', previousRequestDateTime, Now()) >= getHibachiScope().setting('globalAdminAutoLogoutMinutes') )

			|| (!isNull(getHibachiScope().getSession().getAccountAuthentication()) && getHibachiScope().getSession().getAccount().getAdminAccountFlag() != true && DateDiff('n', previousRequestDateTime, Now()) >= getHibachiScope().setting('globalPublicAutoLogoutMinutes') )

		) 	{

		logoutAccount();

		}

	}

	public void function persistSession() {

		// Save the session
		getHibachiDAO().save( getHibachiScope().getSession() );

		// Save session ID in the session Scope & cookie scope for next request
		setSessionValue('sessionID', getHibachiScope().getSession().getSessionID());

		//Generate new session cookies for every time the session is persisted (on every login)
		var npCookieValue = getValueForCookie();
			getHibachiScope().getSession().setSessionCookieNPSID(npCookieValue);
			getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-NPSID", value=getHibachiScope().getSession().getSessionCookieNPSID());
	    var cookieValue = getValueForCookie();
			getHibachiScope().getSession().setSessionCookiePSID(cookieValue);
			getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#-PSID", value=getHibachiScope().getSession().getSessionCookiePSID(), expires="never");

	}

	public string function loginAccount(required any account, required any accountAuthentication) {

		var currentSession = getHibachiScope().getSession();
		currentSession.setAccount( arguments.account );
		currentSession.setAccountAuthentication( arguments.accountAuthentication );

		// Make sure that we persist the session
		persistSession();

		// Make sure that this login is persisted
		getHibachiDAO().flushORMSession();

		var auditLogData = {

			account = arguments.account

		};
		
		// Add the CKFinder Permissions
		session["#getApplicationValue('applicationKey')#CKFinderAccess"] = getHibachiScope().authenticateAction("admin:main.ckfinder");

		getHibachiAuditService().logAccountActivity( "login", auditLogData );
		getHibachiEventService().announceEvent("onSessionAccountLogin");

	}

	public void function logoutAccount() {
		var currentSession = getHibachiScope().getSession();
		var auditLogData = {};

		if(!isNull(currentSession.getAccount())) {
			auditLogData.account = currentSession.getAccount();
		}

		currentSession.removeAccount();
		currentSession.removeAccountAuthentication();

		// Make sure that this logout is persisted
		getHibachiDAO().flushORMSession();
		getHibachiAuditService().logAccountActivity("logout", auditLogData);
		getHibachiEventService().announceEvent("onSessionAccountLogout");
	}

	// =====================  END: Logical Methods ============================

	// ===================== START: DAO Passthrough ===========================

	// ===================== START: DAO Passthrough ===========================

	// ===================== START: Process Methods ===========================

	public any function processSession_authorizeAccount(required any session, required any processObject) {

		// Take the email address and get all of the user accounts by primary e-mail address
		var accountAuthentications = getAccountService().getInternalAccountAuthenticationsByEmailAddress(emailAddress=arguments.processObject.getEmailAddress());

		if(arrayLen(accountAuthentications)) {

			for(var i=1; i<=arrayLen(accountAuthentications); i++) {
				// If the password matches what it should be, then set the account in the session and

>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
				if(!isNull(accountAuthentications[i].getPassword()) && len(accountAuthentications[i].getPassword()) && accountAuthentications[i].getPassword() == getAccountService().getHashedAndSaltedPassword(password=arguments.processObject.getPassword(), salt=accountAuthentications[i].getAccountAuthenticationID())) {
					loginAccount( accountAuthentications[i].getAccount(), accountAuthentications[i] );
					return arguments.session;
				}
<<<<<<< HEAD
		
			}
	
			arguments.processObject.addError('password', rbKey('validate.session_authorizeAccount.password.incorrect'));
			
		} else {
			
			arguments.processObject.addError('emailAddress', rbKey('validate.session_authorizeAccount.emailAddress.notfound'));
			
		}
	
		return arguments.session;
	
	}
	
	// =====================  END: Process Methods ============================
	
	// ====================== START: Status Methods ===========================
	
	// ======================  END: Status Methods ============================
	
	// ====================== START: Save Overrides ===========================
	
	// ======================  END: Save Overrides ============================
	
	// ==================== START: Smart List Overrides =======================
	
	// ====================  END: Smart List Overrides ========================
	
	// ====================== START: Get Overrides ============================
	
	// ======================  END: Get Overrides =============================
	
	// ===================== START: Delete Overrides ==========================
	
	// =====================  END: Delete Overrides ===========================
	
	// ================== START: Private Helper Functions =====================
	
=======

			}

			arguments.processObject.addError('password', rbKey('validate.session_authorizeAccount.password.incorrect'));

		} else {

			arguments.processObject.addError('emailAddress', rbKey('validate.session_authorizeAccount.emailAddress.notfound'));

		}

		return arguments.session;

	}

	// =====================  END: Process Methods ============================

	// ====================== START: Status Methods ===========================

	// ======================  END: Status Methods ============================

	// ====================== START: Save Overrides ===========================

	// ======================  END: Save Overrides ============================

	// ==================== START: Smart List Overrides =======================

	// ====================  END: Smart List Overrides ========================

	// ====================== START: Get Overrides ============================

	// ======================  END: Get Overrides =============================

	// ===================== START: Delete Overrides ==========================

	// =====================  END: Delete Overrides ===========================

	// ================== START: Private Helper Functions =====================

>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
	/**
	* @deprecated getSessionIDEncryptedCookie
	*/
	private any function getSessionIDEncryptedCookie( required any sessionID, required string cookieType ) {
		return getHibachiUtilityService().encryptValue(value=arguments.sessionID, salt="valid-#arguments.cookieType#-#getApplicationKey()#SessionIDCookie");
<<<<<<< HEAD
	} 
	
=======
	}

>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
	/*
	* @deprecated getSessionIDFromEncryptedCookie
	*/
	private any function getSessionIDFromEncryptedCookie( required any cookieData, required string cookieType ) {
		return getHibachiUtilityService().decryptValue(value=arguments.cookieData, salt="valid-#arguments.cookieType#-#getApplicationKey()#SessionIDCookie");
	}
<<<<<<< HEAD
	
=======

>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
	/**
	 * Generate new cookie value
	 */
	private any function getValueForCookie(){
		var id = getHibachiScope().getSession().getSessionID();
		var hashedID = hash(id, "md5");
		var uuid = replace(createUUID(),'-','','all');
		var final = hashedID & uuid;
		return final;
	}
	// ==================  END:  Private Helper Functions =====================
<<<<<<< HEAD
	
	// =================== START: Deprecated Functions ========================
	
	// ===================  END: Deprecated Functions =========================

}
=======

	// =================== START: Deprecated Functions ========================

	// ===================  END: Deprecated Functions =========================

}
>>>>>>> 04efc81912db0c0c808e100caa063517245d1476
