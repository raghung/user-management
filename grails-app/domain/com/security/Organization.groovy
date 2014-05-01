package com.security

import java.util.Date;

import org.apache.commons.lang.builder.HashCodeBuilder

class Organization implements Serializable {
	
	private static final long serialVersionUID = 1
	
	String name
	String description
	String groupName
	String groupDescription
	
	boolean equals(other) {
		if (!(other instanceof Organization)) {
			return false
		}

		other.name == name && other.groupName == groupName
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		builder.append name
		builder.append groupName
		builder.toHashCode()
	}
	
    static constraints = {
		// Order of display
		name()
		description()
		groupName()
		groupDescription()
		
		// Composite primary key
		id composite: ['name', 'groupName']
		
		description blank: false
		groupDescription blank: false
    }
}
