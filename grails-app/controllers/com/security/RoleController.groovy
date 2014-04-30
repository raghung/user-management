package com.security

import grails.converters.JSON;
import grails.plugin.springsecurity.SpringSecurityUtils;
import grails.util.GrailsNameUtils;

class RoleController extends grails.plugin.springsecurity.ui.RoleController {

	def create() {
		[role: lookupRoleClass().newInstance(params), orgList: UserController.getOrganizations()]
	}

	def save() {
		def role = lookupRoleClass().newInstance(params)
		role.organization = Organization.findById(params.long('groupName'))

		role.clearErrors()
		if (!role.save(flush: true)) {
			render view: 'create', model: [role: role]
			return
		}

		flash.message = "${message(code: 'default.created.message', args: [message(code: 'role.label', default: 'Role'), role.id])}"
		redirect action: 'edit', id: role.id
	}

	def edit() {

		String upperAuthorityFieldName = GrailsNameUtils.getClassName(
				SpringSecurityUtils.securityConfig.authority.nameField, null)

		def role = params.name ? lookupRoleClass()."findBy$upperAuthorityFieldName"(params.name) : null
		if (!role) role = findById()
		if (!role) return

			setIfMissing 'max', 10, 100

		def roleClassName = GrailsNameUtils.getShortName(lookupRoleClassName())
		def userField = GrailsNameUtils.getPropertyName(GrailsNameUtils.getShortName(lookupUserClassName()))

		def users = lookupUserRoleClass()."findAllBy$roleClassName"(role, params)*."$userField"
		int userCount = lookupUserRoleClass()."countBy$roleClassName"(role)

		def grpList = Organization.findAllByName(role.organization.name, [sort: "groupName", order: "asc"])

		[role: role, users: users, userCount: userCount, orgList: UserController.getOrganizations(), grpList: grpList]
	}

	def update() {
		def role = findById()
		if (!role) return
			if (!versionCheck('role.label', 'Role', role, [role: role])) {
				return
			}

		// Add organization
		role.organization = Organization.findById(params.long('groupName'))

		if (!springSecurityService.updateRole(role, params)) {
			render view: 'edit', model: [role: role]
			return
		}

		flash.message = "${message(code: 'default.updated.message', args: [message(code: 'role.label', default: 'Role'), role.id])}"
		redirect action: 'edit', id: role.id
	}

	def search() {
		def searched = params.searched
		if (params.searched == null) {
			render view: 'search', model:[orgList: UserController.getOrganizations(), grpList: [:], searched: false]
		} else {

			String authorityField = SpringSecurityUtils.securityConfig.authority.nameField

			boolean useOffset = params.containsKey('offset')
			setIfMissing 'max', 10, 100
			setIfMissing 'offset', 0

			Integer max = params.int('max')
			Integer offset = params.int('offset')
			def org = params.org
			def orgId = params.long('groupName')
			def authority = params.authority
			def results = Role.createCriteria().list(max: max, offset: offset) {
				if (authority) {
					ilike("authority", "${authority}%")
				}

				if (orgId && orgId != 'null') {
					organization {
						eq("id", orgId)
						order("name", "asc")
						order("groupName", "asc")
					}
				} else if (org && org != 'null') {
					organization {
						eq("name", "${org}")
						order("name", "asc")
						order("groupName", "asc")
					}
				} else {
					organization {
						order("name", "asc")
						order("groupName", "asc")
					}
				}
			}

			def grpList = Organization.findAllByName(params.org, [sort: "groupName", order: "asc"])

			render view: 'search', model: [results: results,
				totalCount: results.totalCount,
				authority: params.authority,
				org: params.org,
				groupId: params.groupName,
				orgList: UserController.getOrganizations(),
				grpList: grpList,
				searched: true]
		}
	}

	def ajaxRoleSearch() {

		def jsonData = []

		if (params.term?.length() > 1) {
			setIfMissing 'max', 10, 100
			setIfMissing 'offset', 0
			def org = params.org
			def orgId = params.long('groupName')
			
			def results = Role.createCriteria().list(max: params.max) {
				ilike ("authority", "%${params.term}%")
				
				if (orgId && orgId != 'null') {
					organization {
						eq("id", orgId)
					}
				} else if (org && org != 'null') {
					organization {
						eq("name", "${org}")
					}
				}
				order("authority", "asc")
			}
			def lst = []
			for (result in results) {
				lst += result["authority"]
			}
			def setAuthority = lst as Set
			for (authority in setAuthority) {
				jsonData << [value: authority]
			}
		}

		render text: jsonData as JSON, contentType: 'text/plain'
	}
}
