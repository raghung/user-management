package com.security

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
		
		description nullable: true
		groupDescription nullable: true
    }
}
