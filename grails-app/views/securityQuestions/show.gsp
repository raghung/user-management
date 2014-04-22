
<%@ page import="com.security.SecurityQuestions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'securityQuestions.label', default: 'SecurityQuestions')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-securityQuestions" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-securityQuestions" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list securityQuestions">
			
				<g:if test="${securityQuestionsInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="securityQuestions.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:fieldValue bean="${securityQuestionsInstance}" field="question"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${securityQuestionsInstance?.priority}">
				<li class="fieldcontain">
					<span id="priority-label" class="property-label"><g:message code="securityQuestions.priority.label" default="Priority" /></span>
					
						<span class="property-value" aria-labelledby="priority-label"><g:fieldValue bean="${securityQuestionsInstance}" field="priority"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${securityQuestionsInstance?.id}" />
					<g:link class="edit" action="edit" id="${securityQuestionsInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
