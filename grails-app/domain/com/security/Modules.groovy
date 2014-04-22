package com.security

class Modules {

	String name
	String description
	String url
	
	static hasMany = [functions: Functions]
	
    static constraints = {
		name blank:false, unique:true
		url blank:false, unique:true
		description nullable:true
    }
	
	String toString() {
		return "${name}"
	}
}
