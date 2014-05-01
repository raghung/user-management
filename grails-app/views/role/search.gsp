<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<title><g:message code='spring.security.ui.role.search'/></title>
</head>

<body>

<div>

	<s2ui:form width='100%' height='230' elementId='formContainer'
	           titleCode='spring.security.ui.role.search'>

	<g:form action='search' name='roleSearchForm'>

		<br/>

		<table>
			<tbody>
			<tr>
				<td><g:message code='user.organization.label' default='Organization'/></td>
				<td colspan="3">
					<g:select name="org" from="${orgList}" noSelection="${['null':'-- Select --']}"
								optionKey="name" optionValue="description"
								onchange="${remoteFunction(controller: 'user',
											action: 'ajaxGroupNames',
               								update: [success: 'group-names'],
               								params: '\'name=\' + this.value')}"
               					value="${org}"/>
               	</td>
           	</tr>
           	<tr>
           		<td><g:message code='user.organization.group.label' default='Group'/></td>
           		<td colspan="3">
          		<span id="group-names">
               		<g:select name="groupName"
         						from="${grpList}"
         						optionKey="id"
         						optionValue="groupDescription"
         						noSelection="${['null': '-- Select --'] }"
         						value="${groupId}"/>
			 	</span>
				</td>
			</tr>
			<tr>
				<td><g:message code='role.authority.label' default='Authority'/>:</td>
				<td><g:textField name='authority' class='textField' size='50' maxlength='255' autocomplete='off' value='${authority}'/></td>
			</tr>
			<tr><td colspan='2'>&nbsp;</td></tr>
			<tr>
				<td colspan='2'><s2ui:submitButton elementId='search' form='roleSearchForm' messageCode='spring.security.ui.search'/></td>
			</tr>
			</tbody>
		</table>
		<g:hiddenField name="searched" value="${searched}"/>
	</g:form>

	</s2ui:form>

	<g:if test='${searched}'>

<%
def queryParams = [org: org, group: groupName, authority: authority]
%>

	<div class="list">
	<table>
		<thead>
		<tr>
			<g:sortableColumn property="org" title="${message(code: 'organization.name.label', default: 'Organization')}" params="${queryParams}"/>
			<g:sortableColumn property="group" title="${message(code: 'organization.group.label', default: 'Group')}" params="${queryParams}"/>
			<g:sortableColumn property="authority" title="${message(code: 'role.authority.label', default: 'Authority')}" params="${queryParams}"/>
		</tr>
		</thead>

		<tbody>
		<g:each in="${results}" status="i" var="role">
		<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
			<td>${fieldValue(bean: role, field: "organization.description")}</td>
			<td>${fieldValue(bean: role, field: "organization.groupDescription")}</td>
			<sec:access controller='role' action='edit'>
			<td><g:link action="edit" id="${role.id}">${fieldValue(bean: role, field: "authority")}</g:link></td>
			</sec:access>
			<sec:noAccess controller='role' action='edit'>
			<td>${fieldValue(bean: role, field: "authority")}</td>
			</sec:noAccess>
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
	$("#authority").focus().autocomplete({
		minLength: 2,
		cache: false,
		source: "${createLink(action: 'ajaxRoleSearch')}"
	});
});
</script>

</body>
</html>
