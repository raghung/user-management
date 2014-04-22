package com.security

class SecurityQuestions {

	Integer priority
	String question
	
    static constraints = {
		question blank: false, unique: true
		priority blank: false
    }
}
