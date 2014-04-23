package com.security

import java.text.SimpleDateFormat;

import grails.plugin.springsecurity.SpringSecurityUtils;

class UserController extends grails.plugin.springsecurity.ui.UserController {
	
	def search() {
		[userType: UserType.findAll(), enabled: 0, accountExpired: 0, accountLocked: 0, passwordExpired: 0]
	}
	
	def userSearch() {

		boolean useOffset = params.containsKey('offset')
		setIfMissing 'max', 10, 100
		setIfMissing 'offset', 0

		def hql = new StringBuilder('FROM ').append(lookupUserClassName()).append(' u WHERE 1=1 ')
		def queryParams = [:]

		def userLookup = SpringSecurityUtils.securityConfig.userLookup
		String usernameFieldName = userLookup.usernamePropertyName

		for (name in [username: usernameFieldName]) {
			if (params[name.key]) {
				hql.append " AND LOWER(u.${name.value}) LIKE :${name.key}"
				queryParams[name.key] = params[name.key].toLowerCase() + '%'
			}
		}
		if (params['firstname']) {
			hql.append " AND LOWER(firstname) LIKE :${'firstname'}"
			queryParams['firstname'] = params['firstname'].toLowerCase() + '%'
		}
		if (params['lastname']) {
			hql.append " AND LOWER(lastname) LIKE :${'lastname'}"
			queryParams['lastname'] = params['lastname'].toLowerCase() + '%'
		}
		if (params['type'] && params['type'] != 'null') {
			hql.append " AND LOWER(type) LIKE :${'type'}"
			queryParams['type'] = params['type'].toLowerCase() + '%'
		}
		if (params['identification']) {
			hql.append " AND LOWER(identification) = :${'identification'}"
			queryParams['identification'] = params['identification']
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		if (params['birthDate']) {
			hql.append " AND birthDate = :${'birthDate'}"
			queryParams['birthDate'] = sdf.parse(params['birthDate'])
		}
		
		String enabledPropertyName = userLookup.enabledPropertyName
		String accountExpiredPropertyName = userLookup.accountExpiredPropertyName
		String accountLockedPropertyName = userLookup.accountLockedPropertyName
		String passwordExpiredPropertyName = userLookup.passwordExpiredPropertyName

		for (name in [enabled: enabledPropertyName,
			accountExpired: accountExpiredPropertyName,
			accountLocked: accountLockedPropertyName,
			passwordExpired: passwordExpiredPropertyName]) {
			Integer value = params.int(name.key)
			if (value) {
				hql.append " AND u.${name.value}=:${name.key}"
				queryParams[name.key] = value == 1
			}
		}

		int totalCount = lookupUserClass().executeQuery("SELECT COUNT(DISTINCT u) $hql", queryParams)[0]

		Integer max = params.int('max')
		Integer offset = params.int('offset')

		String orderBy = ''
		if (params.sort) {
			orderBy = " ORDER BY u.$params.sort ${params.order ?: 'ASC'}"
		}

		def results = lookupUserClass().executeQuery(
				"SELECT DISTINCT u $hql $orderBy",
				queryParams, [max: max, offset: offset])
		def model = [results: results, totalCount: totalCount, searched: true]

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
		
		model['userType'] = UserType.findAll()

		render view: 'search', model: model
	}
}
