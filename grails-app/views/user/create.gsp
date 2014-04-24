<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<h3><g:message code="default.create.label" args="[entityName]"/></h3>

<g:form action="save" name='userCreateForm'>

<%
def tabData = []
tabData << [name: 'userinfo', icon: 'icon_user', messageCode: 'spring.security.ui.user.info']
tabData << [name: 'roles',    icon: 'icon_role', messageCode: 'spring.security.ui.user.roles']
%>

<s2ui:tabs elementId='tabs' height='375' data="${tabData}">

	<s2ui:tab name='userinfo' height='280'>
		<table>
		<tbody>

			<s2ui:textFieldRow name='username' labelCode='user.username.label' bean="${user}"
                            labelCodeDefault='Username' value="${user?.username}"/>

			<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${user}"
                                labelCodeDefault='Password' value="${user?.password}"/>
			<s2ui:textFieldRow name='firstname' labelCode='user.firstname.label' bean="${user}"
                            labelCodeDefault='First name' value="${user?.firstname}"/>
            <s2ui:textFieldRow name='lastname' labelCode='user.lastname.label' bean="${user}"
                            labelCodeDefault='Last name' value="${user?.lastname}"/>
			<tr>
				<td><g:message code='user.type.label' default='Type'/>:</td>
				<td colspan='3'><g:select name="type" from="${userType}" value="${type}" noSelection="${['null':'Select Type']}"/></td>
			</tr>
			<s2ui:textFieldRow name='identification' labelCode='user.identification.label' bean="${user}"
                            labelCodeDefault='Identification' value="${user?.identification}"/>
            <tr>
				<td><g:message code='user.birthdate.label' default='Birth date'/>:</td>
				<td colspan='3'><g:textField name='birthDate' size='12' value='${birthDate}' placeholder="mm/dd/yyyy"/></td>
			</tr>
			<s2ui:checkboxRow name='enabled' labelCode='user.enabled.label' bean="${user}"
                           labelCodeDefault='Enabled' value="${user?.enabled}"/>

			<s2ui:checkboxRow name='accountExpired' labelCode='user.accountExpired.label' bean="${user}"
                           labelCodeDefault='Account Expired' value="${user?.accountExpired}"/>

			<s2ui:checkboxRow name='accountLocked' labelCode='user.accountLocked.label' bean="${user}"
                           labelCodeDefault='Account Locked' value="${user?.accountLocked}"/>

			<s2ui:checkboxRow name='passwordExpired' labelCode='user.passwordExpired.label' bean="${user}"
                           labelCodeDefault='Password Expired' value="${user?.passwordExpired}"/>
		</tbody>
		</table>
	</s2ui:tab>

	<s2ui:tab name='roles' height='280'>
		<g:each var="auth" in="${authorityList}">
		<div>
			<g:checkBox name="${auth.authority}" />
			<g:link controller='role' action='edit' id='${auth.id}'>${auth.authority.encodeAsHTML()}</g:link>
		</div>
		</g:each>
	</s2ui:tab>

</s2ui:tabs>

<div style='float:left; margin-top: 10px; '>
<s2ui:submitButton elementId='create' form='userCreateForm' messageCode='default.button.create.label'/>
</div>

</g:form>

<script>
$(document).ready(function() {
	$('#username').focus();
	$("#birthDate").datepicker();
	<s2ui:initCheckboxes/>
});
</script>

</body>
</html>
