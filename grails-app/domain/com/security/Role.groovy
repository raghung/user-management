package com.security

import java.util.Date;

import org.apache.commons.lang.builder.HashCodeBuilder;

class Role {

	String authority
	
	static belongsTo = [organization: Organization]

	static mapping = {
		cache true
	}
	
	static constraints = {
		authority blank: false, unique: true
		organization blank: false
	}
}
