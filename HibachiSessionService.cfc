component output="false" accessors="true" extends="HibachiService"  {

	property name="accountService" type="any";
	property name="orderService" type="any";
	property name="hibachiTagService" type="any";
	

	// ===================== START: Logical Methods ===========================
	
	public void function setPropperSession() {
		// Check to see if a session value doesn't exist, then we can check for a cookie... or just set it to blank
		if(!hasSessionValue("sessionID")) {
			if(structKeyExists(cookie, "#getApplicationValue('applicationKey')#SessionID")) {
				setSessionValue('sessionID', cookie["#getApplicationValue('applicationKey')#SessionID"]);
			} else {
				setSessionValue('sessionID', '');
			}
		}
		
		// Load Session
		var session = this.getSession(getSessionValue('sessionID'), true);
		getHibachiScope().setSession( session );
		
		// Check to see if this session has an accountAuthentication, if it does then we need to verify that the authentication shouldn't be auto logged out
		if(!isNull(session.getAccountAuthentication())) {
			// If there was an integration, then check the verify method for any custom auto-logout logic
			if(session.getAccountAuthentication().getForceLogoutFlag()) {
				logoutAccount();
			}
		}
		
		// Update the last request datetime
		session.setLastRequestDateTime( now() );
		
		// Save the session
		getHibachiDAO().save(session);
		
		// Save session ID in the session Scope & cookie scope for next request
		setSessionValue('sessionID', session.getSessionID());
		getHibachiTagService().cfcookie(name="#getApplicationValue('applicationKey')#SessionID", value=session.getSessionID(), expires="never");
	}
	
	public string function loginAccount(required any account, required any accountAuthentication) {
		var currentSession = getHibachiScope().getSession();
		
		currentSession.setAccount( arguments.account );
		currentSession.setAccountAuthentication( arguments.accountAuthentication );
		
		// Make sure that this login is persisted
		getHibachiDAO().flushORMSession();
	}
	
	public void function logoutAccount() {
		var currentSession = getHibachiScope().getSession();
		
		currentSession.removeAccount();
		currentSession.removeAccountAuthentication();
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
				if(!isNull(accountAuthentications[i].getPassword()) && len(accountAuthentications[i].getPassword()) && accountAuthentications[i].getPassword() == getAccountService().getHashedAndSaltedPassword(password=arguments.processObject.getPassword(), salt=accountAuthentications[i].getAccountAuthenticationID())) {
					loginAccount( accountAuthentications[i].getAccount(), accountAuthentications[i] );
					return arguments.session;
				}
			}
			arguments.processObject.addError('password', rbKey('validate.session.authorizeAccount.invalidpassword'), true);
		} else {
			arguments.processObject.addError('email', rbKey('validate.session.authorizeAccount.invalidemail'), true);
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
	
}