<html>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
	<title><g:message code="default.create.label" args="[entityName]"/></title>
	<style>
	.error-field {
		border: 2px solid red;
	}
	</style>
</head>

<body>

<h3><g:message code="default.create.label" args="[entityName]"/></h3>

<g:form action="save" name='userCreateForm'>

<%
def tabData = []
tabData << [name: 'userinfo', icon: 'icon_user', messageCode: 'spring.security.ui.user.info']
tabData << [name: 'organization', icon: 'icon_organization', messageCode: 'spring.security.ui.user.organization']
tabData << [name: 'roles',    icon: 'icon_role', messageCode: 'spring.security.ui.user.roles']
tabData << [name: 'contactinfo',    icon: 'icon_information', messageCode: 'spring.security.ui.user.contactinfo']	
%>

<s2ui:tabs elementId='tabs' height='575' data="${tabData}">

	<s2ui:tab name='userinfo' height='380'>
		<table>
		<tbody>
			<tr><td colspan="4"><g:hasErrors bean="${user}"><span style="color:red">* Invalid Input</span></g:hasErrors></td></tr>
			<tr>
				<td><g:message code='user.username.label' default='Username'/></td>
				<td colspan='3'><g:textField name='username' value='${user?.username}' placeholder="E-Mail" 
					class="${hasErrors(bean:user,field:'username','error-field')}"/></td>
			</tr>
			<tr>
				<td><g:message code='user.password.label' default='Password'/></td>
				<td colspan='3'><g:passwordField name='password' value='${user?.password}' 
					class="${hasErrors(bean:user,field:'password','error-field')}"/> 8-64 Characters (A-Z, a-z, 0-9, !@#$%^&)</td>
			</tr>
			<tr>
				<td><g:message code='user.firstname.label' default='First Name'/></td>
				<td colspan='3'><g:textField name='firstname' value='${user?.firstname}' 
					class="${hasErrors(bean:user,field:'firstname','error-field')}"/></td>
			</tr>
			<tr>
				<td><g:message code='user.lastname.label' default='Last Name'/></td>
				<td colspan='3'><g:textField name='lastname' value='${user?.lastname}' 
					class="${hasErrors(bean:user,field:'lastname','error-field')}"/></td>
			</tr>                                
			<tr>
				<td><g:message code='user.type.label' default='Type'/>:</td>
				<td colspan='3'><g:select name="type" from="${userType}" value="${user?.type}" noSelection="${['':'Select Type']}"
					class="${hasErrors(bean:user,field:'type','error-field')}"/></td>
			</tr>
			<tr>
				<td><g:message code='user.identification.label' default='Identification'/></td>
				<td colspan='3'><g:textField name='identification' value='${user?.identification}' 
					class="${hasErrors(bean:user,field:'identification','error-field')}"/></td>
			</tr>
            <tr>
				<td><g:message code='user.birthdate.label' default='Birth date'/>:</td>
				<td colspan='3'><g:textField name='birthDate' size='12' value="${formatDate(date: user?.birthDate, format: 'MM/dd/yyyy')}" placeholder="mm/dd/yyyy"
					class="${hasErrors(bean:user,field:'birthDate','error-field')}"/></td>
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

	<s2ui:tab name='organization' height='275'>
		<div>
			Organization: <g:select name="org" from="${orgList}" noSelection="${['null':'-- Select --']}"
									optionKey="name" optionValue="description"
									onchange="${remoteFunction(controller: 'user',
												action: 'ajaxGroupNames',
                  								update: [success: 'group-names'],
                  								params: '\'name=\' + this.value')}"/>
			&nbsp;Group: <span id="group-names">
							<select name="groupName" id="groupName">
								<option value="null">-- Select --</option>
						 	</select>
						 </span>
			&nbsp;<input type="button" value="Add" onclick="addOrg()">
		</div>
		<hr>
		<div>
			<table id="tblOrg">
				<thead>
				<tr>
					<th>Organization</th>
					<th>Group</th>
					<th>&nbsp;</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
			</table>
		</div>
	</s2ui:tab>
	
	<s2ui:tab name='roles' height='280'>
		<div id="authList">
			<g:render template="authList" model="[roleMap: roleMap, userRoles: userRoles]" />
		</div>
	</s2ui:tab>

	<s2ui:tab name='contactinfo' height='275'>
		contact information
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

function addOrg() {
	var org = $("#org").val();
	var orgId = $("#groupName").val();
	var grp = $("#groupName option:selected").html();

	if (orgId == 'null') return;

	var arrId = document.getElementsByName('orgId');
	for(i=0; i<arrId.length; i++) {
		if (arrId[i].value == orgId) {
			alert("Group already added");
			return;
		}
	}
	
	// Adding to table
	var len = $("#tblOrg tbody tr").length;
	var trClass = "even";
	if (len % 2 == 0)
		trClass = "odd"
	var appendStr = '<tr class="'+ trClass +'">' +
					'<td>'+org+'<input type="hidden" name="orgId" id="orgId" value="'+orgId+'"/></td>' +
					'<td>'+grp+'</td>';
	if (org == 'Default') 
		appendStr = appendStr + '<td>&nbsp;</td></tr>';
	else 				
		appendStr = appendStr + '<td><img src="${fam.icon(name: 'delete')}" onclick="delOrg(this)"/></td></tr>';

	$("#tblOrg tbody").append(appendStr);
	
	populateAuthList();
}

function delOrg(ele) {
	$(ele).closest('tr').remove();
	// reset the row class
	$("#tblOrg tbody tr").each(function() {
			trClass = "even";
			if ($(this).index() % 2 == 0)
				trClass = "odd"
			$(this).removeClass();
			
			$(this).addClass(trClass);	
		});

	populateAuthList();
}

function populateAuthList() {
	var arrObj = document.getElementsByName("orgId");
	var arrOrgId = new Array()
	for (i=0; i<arrObj.length; i++)
		arrOrgId[i] = arrObj[i].value
	$.ajax({
		type: 'POST',
		url: "${createLink(controller: 'user', action: 'ajaxAuthList')}",
		data: {"orgId": JSON.stringify(arrOrgId)},
		success:function(result){
	    	$("#authList").html(result);
	  	},
	  	error:function(result) {
			alert("Error!!")
		}
  	});
}
</script>

</body>
</html>
