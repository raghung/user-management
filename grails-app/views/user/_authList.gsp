<g:each var="entry" in="${roleMap}">
	<div><b>${entry.key}:</b></div>
	<g:each var="userRole" in="${entry.value}">
		<div>
			<g:checkBox name="userRole" value="${userRole.id}" checked="${userRoles.contains(userRole)}"/>
			<g:link controller='role' action='edit' id='${userRole.id}'>${userRole.authority.encodeAsHTML()}</g:link>
		</div>	
	</g:each>
</g:each>