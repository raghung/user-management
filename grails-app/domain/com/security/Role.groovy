package com.security

import java.util.Date;

import org.apache.commons.lang.builder.HashCodeBuilder;

class Role {

	String authority
	
	static belongsTo = [organization: Organization]

	static mapping = {
		cache true
	}

	boolean equals(other) {
		if (!(other instanceof Role)) {
			return false
		}

		other.authority == authority && other.organization.id == organization.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append authority
		builder.append organization
		builder.toHashCode()
	}
	
	static constraints = {
		id composite: ['authority', 'organization']
	}
}
