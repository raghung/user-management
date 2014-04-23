package com.security

class Role {

	String authority
	
	static belongsTo = [organization: Organization]

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
		organization nullable: true
	}
}
