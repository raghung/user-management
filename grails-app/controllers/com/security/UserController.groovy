package com.security

import java.text.SimpleDateFormat;

import grails.converters.JSON;
import grails.plugin.springsecurity.SpringSecurityUtils;

class UserController extends grails.plugin.springsecurity.ui.UserController {

	def search() {
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
}
