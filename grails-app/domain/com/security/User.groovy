package com.security

class User {

	transient springSecurityService

	/**
	 * User name which is email id
	 */
	String username
	
	/**
	 * Password with validation criteria
	 */
	String password
	
	/**
	 * User type from UserType table
	 */
	String type
	
	/**
	 * Identification 
	 */
	String identification
	
	/**
	 * Secret questions SecurityQuestions table and answers
	 */
	Long question1
	Long question2
	Long question3
	String answer1
	String answer2
	String answer3
	
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		type blank: false
		identification nullable: true
		question1 nullable: true
		question2 nullable: true
		question3 nullable: true
		answer1 nullable: true
		answer2 nullable: true
		answer3 nullable: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
