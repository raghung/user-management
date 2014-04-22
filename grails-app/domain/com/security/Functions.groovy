package com.security

class Functions {

	String name
	String description
	String url
	
	static belongsTo = [module: Modules]
	
    static constraints = {
    	name blank:false
		url blank:false, unique:true
		description nullable:true
	}
	
	String toString() {
		return "${name}"
	}
}
