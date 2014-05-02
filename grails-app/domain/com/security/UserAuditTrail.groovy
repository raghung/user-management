package com.security

class UserAuditTrail {

	static mapWith = "mongo"
	
	String id
	
	Long userId
	
	String visitedUrl
	
	String jsonParams
	
	String device
	
	String ipAddress
	
	String dateCreated = new Date()
	
	static constraints = {
		userId blank: false
		visitedUrl blank: false
		jsonParams blank: false
		device blank: false
		ipAddress blank: false 
    }
}
