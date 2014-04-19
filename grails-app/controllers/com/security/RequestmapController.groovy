package com.security

import grails.plugin.springsecurity.SpringSecurityUtils

class RequestmapController extends grails.plugin.springsecurity.ui.RequestmapController {

/*	def requestmapSearch() {

		boolean useOffset = params.containsKey('offset')
		setIfMissing 'max', 10, 100
		setIfMissing 'offset', 0

		def hql = new StringBuilder('FROM ').append(lookupRequestmapClassName()).append(' r WHERE 1=1 ')
		def queryParams = [:]

		String urlField = SpringSecurityUtils.securityConfig.requestMap.urlField
		String configAttributeField = SpringSecurityUtils.securityConfig.requestMap.configAttributeField

		for (name in [name: 'name', url: urlField, configAttribute: configAttributeField]) {
			if (params[name.key]) {
				hql.append " AND LOWER(r.${name.value}) LIKE :$name.key"
				queryParams[name.key] = '%' + params[name.key].toLowerCase() + '%'
			}
		}

		int totalCount = lookupUserClass().executeQuery("SELECT COUNT(DISTINCT r) $hql", queryParams)[0]

		Integer max = params.int('max')
		Integer offset = params.int('offset')

		String orderBy = ''
		if (params.sort) {
			orderBy = " ORDER BY r.$params.sort ${params.order ?: 'ASC'}"
		}

		def results = lookupRequestmapClass().executeQuery(
				"SELECT DISTINCT r $hql $orderBy",
				queryParams, [max: max, offset: offset])
		def model = [results: results, totalCount: totalCount, searched: true]

		// add query params to model for paging
		for (name in [
			'name',
			'url',
			'configAttribute',
			'sort',
			'order'
		]) {
			model[name] = params[name]
		}

		render view: 'search', model: model
	}*/
}
