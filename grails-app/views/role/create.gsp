<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>

<div class="body">

	<s2ui:form width='100%' height='240' elementId='formContainer'
	           titleCode='default.create.label' titleCodeArgs='[entityName]'>

	<g:form action="save" name='roleCreateForm'>
		<div class="dialog">

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
                  								params: '\'name=\' + this.value')}"/>
                  		</td>
                  	</tr>
                  	<tr>
                  		<td><g:message code='user.organization.group.label' default='Group'/></td>
                  		<td colspan="3">
                  			<span id="group-names">
								<select name="groupName" id="groupName">
									<option value="null">-- Select --</option>
						 		</select>
						 	</span>
						</td>
					</tr>
					<tr>
						<td><g:message code='role.authority.label' default='Authority'/></td>
						<td colspan='3'><g:textField name='authority' size='50' value="${role?.authority}"/></td>
					</tr>

					<tr><td>&nbsp;</td></tr>

					<tr class="prop">
						<td valign="top">
							<s2ui:submitButton elementId='create' form='roleCreateForm' messageCode='default.button.create.label'/>
						</td>
					</tr>

				</tbody>
			</table>
		</div>

	</g:form>

	</s2ui:form>

</div>

<script>
$(document).ready(function() {
	$('#authority').focus();
});
</script>

</body>
</html>
