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
	 * First name
	 */
	String firstname
	
	/**
	 * Last name
	 */
	String lastname
	
	/**
	 * User type from UserType table
	 */
	String type
	
	/**
	 * Identification for user like NPI number
	 */
	String identification
	
	/**
	 * Birth date
	 */
	Date birthDate
	
	/**
	 * Secret questions SecurityQuestions table and answers
	 */
	String question1
	String question2
	String question3
	String answer1
	String answer2
	String answer3
	
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static hasMany = [organization: Organization]
	
	static transients = ['springSecurityService']

	static constraints = {
		username email: true, blank: false, unique: true
		password blank: false
		firstname blank: false
		lastname blank: false
		type blank: false
		identification blank: false
		birthDate blank: false, max: new Date()
		
		question1 nullable: true
		question2 nullable: true
		question3 nullable: true
		answer1 nullable: true
		answer2 nullable: true
		answer3 nullable: true
		organization nullable: true
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
	
	String toString() {
		return "${firstname} ${lastname}"
	}
}
