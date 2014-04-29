package com.security

import java.util.Date;

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
