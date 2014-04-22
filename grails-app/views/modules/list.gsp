
<%@ page import="com.security.Modules" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modules.label', default: 'Modules')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-modules" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-modules" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'modules.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="url" title="${message(code: 'modules.url.label', default: 'Url')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'modules.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${modulesInstanceList}" status="i" var="modulesInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${modulesInstance.id}">${fieldValue(bean: modulesInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: modulesInstance, field: "url")}</td>
					
						<td>${fieldValue(bean: modulesInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${modulesInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
