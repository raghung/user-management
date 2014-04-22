
<%@ page import="com.security.SecurityQuestions" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'securityQuestions.label', default: 'SecurityQuestions')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-securityQuestions" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-securityQuestions" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="question" title="${message(code: 'securityQuestions.question.label', default: 'Question')}" />
					
						<g:sortableColumn property="priority" title="${message(code: 'securityQuestions.priority.label', default: 'Priority')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${securityQuestionsInstanceList}" status="i" var="securityQuestionsInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${securityQuestionsInstance.id}">${fieldValue(bean: securityQuestionsInstance, field: "question")}</g:link></td>
					
						<td>${fieldValue(bean: securityQuestionsInstance, field: "priority")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${securityQuestionsInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
