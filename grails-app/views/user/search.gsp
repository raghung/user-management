<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<title><g:message code='spring.security.ui.user.search'/></title>
</head>

<body>

<div>

	<s2ui:form width='100%' height='450' elementId='formContainer'
	           titleCode='spring.security.ui.user.search'>

	<g:form action='userSearch' name='userSearchForm'>

		<br/>

		<table>
			<tbody>

			<tr>
				<td><g:message code='user.username.label' default='Username'/>:</td>
				<td colspan='3'><g:textField name='username' size='50' maxlength='255' autocomplete='off' value='${username}'/></td>
			</tr>
			<tr>
				<td><g:message code='user.firstname.label' default='First name'/>:</td>
				<td colspan='3'><g:textField name='firstname' size='50' maxlength='255' autocomplete='off' value='${firstname}'/></td>
			</tr>
			<tr>
				<td><g:message code='user.lastname.label' default='Last name'/>:</td>
				<td colspan='3'><g:textField name='lastname' size='50' maxlength='255' autocomplete='off' value='${lastname}'/></td>
			</tr>
			<tr>
				<td><g:message code='user.type.label' default='Type'/>:</td>
				<td colspan='3'><g:select name="type" from="${userType}" value="${type}" noSelection="${['null':'Select Type']}"/></td>
			</tr>
			<tr>
				<td><g:message code='user.identification.label' default='Identification'/>:</td>
				<td colspan='3'><g:textField name='identification' size='20' maxlength='255' autocomplete='off' value='${Identification}'/></td>
			</tr>
			<tr>
				<td><g:message code='user.birthdate.label' default='Birth date'/>:</td>
				<td colspan='3'><g:textField name='birthDate' size='12' value='${birthDate}' placeholder="mm/dd/yyyy"/></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><g:message code='spring.security.ui.search.true'/></td>
				<td><g:message code='spring.security.ui.search.false'/></td>
				<td><g:message code='spring.security.ui.search.either'/></td>
			</tr>
			<tr>
				<td><g:message code='user.enabled.label' default='Enabled'/>:</td>
				<g:radioGroup name='enabled' labels="['','','']" values="[1,-1,0]" value='${enabled}'>
				<td><%=it.radio%></td>
				</g:radioGroup>
			</tr>
			<tr>
				<td><g:message code='user.accountExpired.label' default='Account Expired'/>:</td>
				<g:radioGroup name='accountExpired' labels="['','','']" values="[1,-1,0]" value='${accountExpired}'>
				<td><%=it.radio%></td>
				</g:radioGroup>
			</tr>
			<tr>
				<td><g:message code='user.accountLocked.label' default='Account Locked'/>:</td>
				<g:radioGroup name='accountLocked' labels="['','','']" values="[1,-1,0]" value='${accountLocked}'>
				<td><%=it.radio%></td>
				</g:radioGroup>
			</tr>
			<tr>
				<td><g:message code='user.passwordExpired.label' default='Password Expired'/>:</td>
				<g:radioGroup name='passwordExpired' labels="['','','']" values="[1,-1,0]" value='${passwordExpired}'>
				<td><%=it.radio%></td>
				</g:radioGroup>
			</tr>
			<tr><td colspan='4'>&nbsp;</td></tr>
			<tr>
				<td colspan='4'><s2ui:submitButton elementId='search' form='userSearchForm' messageCode='spring.security.ui.search'/></td>
			</tr>
			</tbody>
		</table>
	</g:form>

	</s2ui:form>

	<g:if test='${searched}'>

<%
def queryParams = [username: username, firstname: firstname, lastname: lastname, type: type, identification: identification, birthDate: birthDate,
					enabled: enabled, accountExpired: accountExpired, accountLocked: accountLocked, passwordExpired: passwordExpired]
%>

	<div class="list">
	<table>
		<thead>
		<tr>
			<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" params="${queryParams}"/>
			<g:sortableColumn property="firstname" title="${message(code: 'user.firstname.label', default: 'Firstname')}" params="${queryParams}"/>
			<g:sortableColumn property="lastname" title="${message(code: 'user.lastname.label', default: 'Lastname')}" params="${queryParams}"/>
			<g:sortableColumn property="type" title="${message(code: 'user.type.label', default: 'Type')}" params="${queryParams}"/>
			<g:sortableColumn property="identification" title="${message(code: 'user.identification.label', default: 'Identification')}" params="${queryParams}"/>
			<g:sortableColumn property="birthDate" title="${message(code: 'user.birthdate.label', default: 'Birthdate')}" params="${queryParams}"/>
			<g:sortableColumn property="enabled" title="${message(code: 'user.enabled.label', default: 'Enabled')}" params="${queryParams}"/>
			<g:sortableColumn property="accountExpired" title="${message(code: 'user.accountExpired.label', default: 'Account Expired')}" params="${queryParams}"/>
			<g:sortableColumn property="accountLocked" title="${message(code: 'user.accountLocked.label', default: 'Account Locked')}" params="${queryParams}"/>
			<g:sortableColumn property="passwordExpired" title="${message(code: 'user.passwordExpired.label', default: 'Password Expired')}" params="${queryParams}"/>
		</tr>
		</thead>

		<tbody>
		<g:each in="${results}" status="i" var="user">
		<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			<sec:access controller='user' action='edit'>
			<td><g:link action="edit" id="${user.id}">${fieldValue(bean: user, field: "username")}</g:link></td>
			</sec:access>
			<sec:noAccess controller='user' action='edit'>
			<td>${fieldValue(bean: user, field: "username")}</td>
			</sec:noAccess>
			<td>${fieldValue(bean: user, field: "firstname")}</td>
			<td>${fieldValue(bean: user, field: "lastname")}</td>
			<td>${fieldValue(bean: user, field: "type")}</td>
			<td>${fieldValue(bean: user, field: "identification")}</td>
			<td><g:formatDate date="${user.birthDate}" format="MM/dd/yyyy"/></td>
			<td><g:formatBoolean boolean="${user.enabled}"/></td>
			<td><g:formatBoolean boolean="${user.accountExpired}"/></td>
			<td><g:formatBoolean boolean="${user.accountLocked}"/></td>
			<td><g:formatBoolean boolean="${user.passwordExpired}"/></td>
		</tr>
		</g:each>
		</tbody>
	</table>
	</div>

	<div class="paginateButtons">
		<g:paginate total="${totalCount}" params="${queryParams}" />
	</div>

	<div style="text-align:center">
		<s2ui:paginationSummary total="${totalCount}"/>
	</div>

	</g:if>

</div>

<script>
$(document).ready(function() {
	$("#username").focus().autocomplete({
		minLength: 3,
		cache: false,
		source: "${createLink(action: 'ajaxUserSearch')}"
	});

	$("#birthDate").datepicker();
});

<s2ui:initCheckboxes/>

</script>

</body>
</html>
