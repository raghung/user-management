package com.security

class UserType {

	String name
	String description
	
    static constraints = {
		name blank: false, unique: true
		description blank: false
    }
	
	String toString() {
		return "${name}"
	}
}
