
<%@ page import="com.security.Modules" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'modules.label', default: 'Modules')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-modules" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-modules" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list modules">
			
				<g:if test="${modulesInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="modules.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${modulesInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${modulesInstance?.url}">
				<li class="fieldcontain">
					<span id="url-label" class="property-label"><g:message code="modules.url.label" default="Url" /></span>
					
						<span class="property-value" aria-labelledby="url-label"><g:fieldValue bean="${modulesInstance}" field="url"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${modulesInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="modules.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${modulesInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${modulesInstance?.functions}">
				<li class="fieldcontain">
					<span id="functions-label" class="property-label"><g:message code="modules.functions.label" default="Functions" /></span>
					
						<g:each in="${modulesInstance.functions}" var="f">
						<span class="property-value" aria-labelledby="functions-label"><g:link controller="functions" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${modulesInstance?.id}" />
					<g:link class="edit" action="edit" id="${modulesInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
