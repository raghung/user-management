<%@ page import="com.security.UserType" %>



<div class="fieldcontain ${hasErrors(bean: userTypeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="userType.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${userTypeInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userTypeInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="userType.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${userTypeInstance?.description}"/>
</div>

