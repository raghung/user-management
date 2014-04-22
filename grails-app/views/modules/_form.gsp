<%@ page import="com.security.Modules" %>



<div class="fieldcontain ${hasErrors(bean: modulesInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="modules.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${modulesInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: modulesInstance, field: 'url', 'error')} required">
	<label for="url">
		<g:message code="modules.url.label" default="Url" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="url" required="" value="${modulesInstance?.url}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: modulesInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="modules.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${modulesInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: modulesInstance, field: 'functions', 'error')} ">
	<label for="functions">
		<g:message code="modules.functions.label" default="Functions" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${modulesInstance?.functions?}" var="f">
    <li><g:link controller="functions" action="show" id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="functions" action="create" params="['modules.id': modulesInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'functions.label', default: 'Functions')])}</g:link>
</li>
</ul>

</div>

