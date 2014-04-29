<%@ page import="com.security.Organization" %>



<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="organization.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${organizationInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="organization.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${organizationInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'groupName', 'error')} ">
	<label for="groupName">
		<g:message code="organization.groupName.label" default="Group Name" />
		
	</label>
	<g:textField name="groupName" value="${organizationInstance?.groupName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: organizationInstance, field: 'groupDescription', 'error')} ">
	<label for="groupDescription">
		<g:message code="organization.groupDescription.label" default="Group Description" />
		
	</label>
	<g:textField name="groupDescription" value="${organizationInstance?.groupDescription}"/>
</div>

