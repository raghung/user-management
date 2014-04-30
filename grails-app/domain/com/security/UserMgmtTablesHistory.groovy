package com.security

class UserMgmtTablesHistory {
	
	//static mapWith = "mongo"

	String id
	
	String domainClass
	
	String jsonObject
	
	// Last update Date of domain class - for sorting
	Date lastUpdtDate
	
    static constraints = {
		domainClass blank: false
		jsonObject blank: false
		lastUpdtDate blank: false
    }
}
