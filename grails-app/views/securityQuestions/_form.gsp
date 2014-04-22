<%@ page import="com.security.SecurityQuestions" %>



<div class="fieldcontain ${hasErrors(bean: securityQuestionsInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="securityQuestions.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="question" required="" value="${securityQuestionsInstance?.question}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: securityQuestionsInstance, field: 'priority', 'error')} required">
	<label for="priority">
		<g:message code="securityQuestions.priority.label" default="Priority" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="priority" type="number" value="${securityQuestionsInstance.priority}" required=""/>
</div>

