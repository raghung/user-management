package com.security

import java.text.SimpleDateFormat;
import java.util.Map;

import grails.converters.JSON;
import grails.plugin.springsecurity.SpringSecurityUtils;
import grails.plugin.springsecurity.authentication.dao.NullSaltSource;
import grails.util.GrailsNameUtils;

class UserController extends grails.plugin.springsecurity.ui.UserController {
	def springSecurityService
	def scopesInfoService
	
	def create() {
		def user = lookupUserClass().newInstance(params)
		[user: user, userType: UserType.findAll(), orgList: getOrganizations(), roleMap: sortedRoles(user), userRoles: []]
	}

	def save() {
		def currentUser = springSecurityService.currentUser
		
		def user = new User(params) // parameters are automatically mapped
		user.birthDate = params.date('birthDate', 'MM/dd/yyyy')
		user.createUser = currentUser.id
		user.lastUpdtUser = currentUser.id

		if (params.password) {
			String salt = saltSource instanceof NullSaltSource ? null : params.username
			user.password = springSecurityUiService.encodePassword(params.password, salt)
		}
		
		// Organization
		user.organization = populateOrganization(user)
		
		// Clear any pre-validated errors (sometime grails persists String errors on Date field)
		user.clearErrors()
		if (!user.save(flush: true)) {
			render view: 'create', model: [user: user, userType: UserType.findAll(), orgList: getOrganizations(), roleMap: sortedRoles(user), userRoles: []]
			return
		}

		addRoles(user)
		flash.message = "${message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])}"
		redirect action: 'edit', id: user.id
	}

	protected void addRoles(user) {
		String upperAuthorityFieldName = GrailsNameUtils.getClassName(
			SpringSecurityUtils.securityConfig.authority.nameField, null)

		// Default organization
		def orgDefault = Organization.findByName("Default")
		if (user.organization.contains(orgDefault)) {
			def role = 'ROLE_PATIENT'
			if (user.type == 'Patient') {
				role = 'ROLE_PATIENT'
			} else if (user.type == 'Doctor') {
				role = 'ROLE_DOCTOR'
			} else if (user.type == 'Staff') {
				role = 'ROLE_STAFF'
			} else if (user.type == 'Admin') {
				role = 'ROLE_ADMIN'
			}
			lookupUserRoleClass().create user, lookupRoleClass().findByAuthorityAndOrganization(role, orgDefault), true
			return
		}
		
		def lstRoles = params.list('userRole')
		for (roleId in lstRoles) {
			lookupUserRoleClass().create user, lookupRoleClass().findById(Long.parseLong(roleId)), true
		}
		/*for (String key in params.keySet()) {
			if (key.contains('ROLE') && 'on' == params.get(key)) {
				lookupUserRoleClass().create user, lookupRoleClass()."findBy$upperAuthorityFieldName"(key), true
			}
		}*/
	}
	
	def update() {
		
		def currentUser = springSecurityService.currentUser
		String passwordFieldName = SpringSecurityUtils.securityConfig.userLookup.passwordPropertyName

		def user = findById()
		if (!user) return
			if (!versionCheck('user.label', 'User', user, [user: user])) {
				return
		}
		
		// Map the parameters to user properties	
		user.properties = params

		user.birthDate = params.date('birthDate', 'MM/dd/yyyy')
		user.lastUpdtTime = new Date()
		user.lastUpdtUser = currentUser.id

		def oldPassword = user."$passwordFieldName"
		user.properties = params
		if (params.password && !params.password.equals(oldPassword)) {
			String salt = saltSource instanceof NullSaltSource ? null : params.username
			user."$passwordFieldName" = springSecurityUiService.encodePassword(params.password, salt)
		}
		
		// Organization
		user.organization = populateOrganization(user)
		
		// Clear any pre-validated errors (sometime grails persists String errors on Date field)
		user.clearErrors()
		
		if (!user.save(flush: true)) {
			render view: 'edit', model: buildUserModel(user)
			return
		}

		String usernameFieldName = SpringSecurityUtils.securityConfig.userLookup.usernamePropertyName

		lookupUserRoleClass().removeAll user
		addRoles user
		userCache.removeUserFromCache user[usernameFieldName]
		flash.message = "${message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])}"
		redirect action: 'edit', id: user.id
	}

	protected List populateOrganization(User user) {
		
		def lst = params.list('orgId')
		
		// Patient is default organization
		if (user && user.type == 'Patient') {
			lst = []
		}
		
		def lstOrgIds = []
		for (orgId in lst) {
			lstOrgIds += Long.parseLong(orgId)
		}
		
		def orgDefault = Organization.findByName('Default')
		def lstOrg = Organization.findAllByIdInList(lstOrgIds)
		
		// Actual organization is selected
		if (lstOrg.size() > 1 && lstOrg.contains(orgDefault)) {
			lstOrg -= orgDefault
		}
		
		// No organization is selected
		if (lstOrg.size() == 0) {
			lstOrg += orgDefault
		}
		
		return lstOrg
	}
	
	def search() {
		def lst = scopesInfoService.getSessionsInfo()
		
		for (obj in lst) {
			def objSession = obj.session
			def attr = objSession.getAttributeNames()
			def spring = objSession.getAttribute("SPRING_SECURITY_CONTEXT")
			println attr
		}
		def searched = params.searched
		if (params.searched == null) {
			render view: 'search', model:[userType: UserType.findAll(), enabled: 0, accountExpired: 0, accountLocked: 0, passwordExpired: 0, searched: false]
		} else {
			boolean useOffset = params.containsKey('offset')
			setIfMissing 'max', 10, 100
			setIfMissing 'offset', 0

			String orderBy = params.order ?: 'asc'
			Integer max = params.int('max')
			Integer offset = params.int('offset')
			String username = params.username
			String firstname = params.firstname
			String lastname = params.lastname
			String type = params.type
			String identification = params.identification
			Boolean enabled
			if (params.int('enabled') != 0) {
				enabled = params.int('enabled') == 1 ? true : false
			}
			def accountExpired
			if (params.int('accountExpired') != 0) {
				accountExpired = params.int('accountExpired') == 1 ? true : false
			}
			def accountLocked
			if (params.int('accountLocked') != 0) {
				accountLocked = params.int('accountLocked') == 1 ? true : false
			}
			def passwordExpired
			if (params.int('passwordExpired') != 0) {
				passwordExpired = params.int('passwordExpired') == 1 ? true : false
			}

			def birthDate
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			if (params.birthDate) {
				birthDate = sdf.parse(params.birthDate)
			}
			def results = User.createCriteria().list(max: max, offset: offset) {
				if (username) {
					ilike("username", "${username}%")
				}
				if (firstname) {
					ilike("firstname", "${firstname}%")
				}
				if (lastname) {
					ilike("lastname", "${lastname}%")
				}
				if (type && type != 'null') {
					eq("type", "${type}")
				}
				if (identification) {
					eq("identification", "${identification}")
				}
				if (birthDate) {
					eq("birthDate", "${birthDate}")
				}
				if (enabled) {
					eq("enabled", enabled)
				}
				if (accountExpired) {
					eq("accountExpired", accountExpired)
				}
				if (accountLocked) {
					eq("accountLocked", accountLocked)
				}
				if (passwordExpired) {
					eq("passwordExpired", passwordExpired)
				}
				if (params.sort) {
					order("${params.sort}", orderBy)
				}
			}

			def model = [results: results, totalCount: results.totalCount, searched: true]

			// add query params to model for paging
			for (name in [
				'username',
				'firstname',
				'lastname',
				'type',
				'identification',
				'birthDate',
				'enabled',
				'accountExpired',
				'accountLocked',
				'passwordExpired',
				'sort',
				'order'
			]) {
				model[name] = params[name]
			}

			// User type values for select box
			model['userType'] = UserType.findAll()

			render view: 'search', model: model
		}
	}

	def ajaxUserSearch() {

		def jsonData = []

		if (params.term?.length() > 1) {
			String term = params.term
			String field = params.field
			setIfMissing 'max', 10, 100

			def results = User.createCriteria().list(max: params.max) {
				ilike ("${field}", "${term}%")
				order("${field}", "asc")
			}

			for (result in results) {
				jsonData << [value: result["${field}"]]
			}
		}

		render text: jsonData as JSON, contentType: 'text/plain'
	}

	def ajaxGroupNames() {
		def lstOrg = Organization.findAllByName(params.name, [sort: "groupName", order: "asc"])
		render template: 'groupNames', model: [orgList: lstOrg]
	}
	
	def ajaxAuthList() {
		def orgIds = JSON.parse(params.orgId)
		params['orgId'] = orgIds 
		def user
		def userRoles = []
		// Editing User
		if (params.id) {
			user = User.findById(params.id)
			user.organization = populateOrganization(user)
			userRoles = user.getAuthorities()
		}
		
		def roleMap = sortedRoles(user)
		render template: 'authList', model: [roleMap: roleMap, userRoles: userRoles]
	}
	
	protected Map buildUserModel(User user) {

		Map roleMap = sortedRoles(user)
		Set userRoles = user.getAuthorities()
		
		return [user: user, roleMap: roleMap, userRoles: userRoles, userType: UserType.findAll(), orgList: getOrganizations()]
	}
	
	static List getOrganizations() {
		def lstNames = Organization.createCriteria().list {
			projections {
				distinct("name")
			}
		}
		
		def lstOrg = []
		for (name in lstNames) {
			lstOrg += Organization.findByName(name)
		}
		
		return lstOrg
	}
	
	protected Map sortedRoles(User user) {
		def lstOrgs = []
		def userOrgs = []
		
		// Organizations already exists
		if (user && user.organization) {
			userOrgs = user.organization
		} else {
			userOrgs = populateOrganization(user)
		}
		
		for (org in userOrgs) {
			lstOrgs += org.description + "|" + org.groupDescription
		}

		def setOrgs = lstOrgs as Set
		def mapRoles = [:]
		def lstRoles = []
		for (org in setOrgs) {
			def split = org.tokenize("|")
			lstRoles = lookupRoleClass().createCriteria().list() {
				organization {
					and {
						eq("description", "${split[0]}")
						eq("groupDescription", "${split[1]}" )
					}
				}
				order("authority", "asc")
			}
			def key = split[0] + " - " + split[1]
			mapRoles[key] = lstRoles
		}
		return mapRoles
	}
	 
}
