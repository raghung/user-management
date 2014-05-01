<html>
<%@ page import="org.codehaus.groovy.grails.plugins.PluginManagerHolder" %>
<%@ page import="com.security.User" %>

<sec:ifNotSwitched>
	<sec:ifAllGranted roles='ROLE_SWITCH_USER'>
	<g:if test='${user.username}'>
	<g:set var='canRunAs' value='${true}'/>
	</g:if>
	</sec:ifAllGranted>
</sec:ifNotSwitched>

<head>
	<meta name='layout' content='springSecurityUI'/>
	<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
	<title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<h3><g:message code="default.edit.label" args="[entityName]"/></h3>

<g:form action="update" name='userEditForm' class="button-style">
<g:hiddenField name="id" value="${user?.id}"/>
<g:hiddenField name="version" value="${user?.version}"/>

<%
def tabData = []
tabData << [name: 'userinfo', icon: 'icon_user', messageCode: 'spring.security.ui.user.info']
tabData << [name: 'organization', icon: 'icon_organization', messageCode: 'spring.security.ui.user.organization']
tabData << [name: 'roles',    icon: 'icon_role', messageCode: 'spring.security.ui.user.roles']
tabData << [name: 'contactinfo',    icon: 'icon_information', messageCode: 'spring.security.ui.user.contactinfo']

boolean isOpenId = PluginManagerHolder.pluginManager.hasGrailsPlugin('springSecurityOpenid')
if (isOpenId) {
	tabData << [name: 'openIds', icon: 'icon_role', messageCode: 'spring.security.ui.user.openIds']
}
%>

<s2ui:tabs elementId='tabs' height='575' data="${tabData}">

	<s2ui:tab name='userinfo' height='475'>
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
				<td colspan='3'><g:select name="type" from="${userType}" value="Admin" noSelection="${['null':'Select Type']}"/></td>
			</tr>
			
			<s2ui:textFieldRow name='identification' labelCode='user.identification.label' bean="${user}"
                            labelCodeDefault='Identification' value="${user?.identification}"/>
            
            <tr>
				<td><g:message code='user.birthdate.label' default='Birth date'/>:</td>
				<td colspan='3'><g:textField name='birthDate' size='12' value="${formatDate(date: user?.birthDate, format: 'MM/dd/yyyy')}" placeholder="mm/dd/yyyy"/></td>
			</tr>
			
			<s2ui:checkboxRow name='enabled' labelCode='user.enabled.label' bean="${user}"
                           labelCodeDefault='Enabled' value="${user?.enabled}"/>

			<s2ui:checkboxRow name='accountExpired' labelCode='user.accountExpired.label' bean="${user}"
                           labelCodeDefault='Account Expired' value="${user?.accountExpired}"/>

			<s2ui:checkboxRow name='accountLocked' labelCode='user.accountLocked.label' bean="${user}"
                           labelCodeDefault='Account Locked' value="${user?.accountLocked}"/>

			<s2ui:checkboxRow name='passwordExpired' labelCode='user.passwordExpired.label' bean="${user}"
                           labelCodeDefault='Password Expired' value="${user?.passwordExpired}"/>

			<tr>
				<td><g:message code='user.createTime.label' default='Create Time'/>:</td>
				<td colspan='3'><g:formatDate date="${user?.createTime}" format="MM/dd/yyyy HH:mm:ss"/></td>
			</tr>
			<tr>
				<td><g:message code='user.createUser.label' default='Create User'/>:</td>
				<td colspan='3'>${User.get(user.createUser).username}</td>
			</tr>
			<tr>
				<td><g:message code='user.lastUpdtTime.label' default='Last Updt Time'/>:</td>
				<td colspan='3'><g:formatDate date="${user?.lastUpdtTime}" format="MM/dd/yyyy HH:mm:ss"/></td>
			</tr>
			<tr>
				<td><g:message code='user.lastUpdtUser.label' default='Last Updt User'/>:</td>
				<td colspan='3'>${User.get(user.lastUpdtUser).username}</td>
			</tr>                           
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
			&nbsp;Group: <span id="group-names"><select name="groupName" id="groupName">
								<option value="null">-- Select --</option>
						 </select></span>
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
				<g:each in="${user.organization}" status="i" var="org">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
					<td>${org.description}<g:hiddenField name="orgId" value="${org.id}"/></td>
					<td>${org.groupDescription}</td>
					<td>
						<g:if test="${org.name != 'Default'}">
						<img src="${fam.icon(name: 'delete')}" onclick="delOrg(this)"/>
						</g:if>
					</td>
				</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</s2ui:tab>
	
	<s2ui:tab name='roles' height='275'>
		<div id="authList">
			<g:render template="authList" model="[roleMap: roleMap, userRoles: userRoles]" />
		</div>
	</s2ui:tab>
	
	<s2ui:tab name='contactinfo' height='275'>
		Contact Information
	</s2ui:tab>

	<g:if test='${isOpenId}'>
	<s2ui:tab name='openIds' height='275'>
	<g:if test='${user?.openIds}'>
		<ul>
		<g:each var="openId" in="${user.openIds}">
		<li>${openId.url}</li>
		</g:each>
		</ul>
	</g:if>
	<g:else>
	No OpenIDs registered
	</g:else>
	</s2ui:tab>
	</g:if>

</s2ui:tabs>

<div style='float:left; margin-top: 10px;'>
<s2ui:submitButton elementId='update' form='userEditForm' messageCode='default.button.update.label'/>

<g:if test='${user}'>
<s2ui:deleteButton />
</g:if>

<g:if test='${canRunAs}'>
<a id="runAsButton">${message(code:'spring.security.ui.runas.submit')}</a>
</g:if>

</div>

</g:form>

<g:if test='${user}'>
<s2ui:deleteButtonForm instanceId='${user.id}'/>
</g:if>

<g:if test='${canRunAs}'>
	<form name='runAsForm' action='${request.contextPath}/j_spring_security_switch_user' method='POST'>
		<g:hiddenField name='j_username' value="${user.username}"/>
		<input type='submit' class='s2ui_hidden_button' />
	</form>
</g:if>

<script>
$(document).ready(function() {
	$('#username').focus();

	<s2ui:initCheckboxes/>

	$("#runAsButton").button();
	$('#runAsButton').bind('click', function() {
	   document.forms.runAsForm.submit();
	});

	$("#birthDate").datepicker();
	$("#type").val("${user?.type}")

	 /*$("#vehicleManufacturerDropDown").change(function() {
       		$.ajax({
               url: "/ChainDropDown/vehicle/manufacturerSelected",
               data: "id=" + this.value,
               cache: false,
               success: function(html) {
               		$("#models").html(html);
               }
             });
          });*/
		 	
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
		data: {
			"id": ${user?.id},
			"orgId": JSON.stringify(arrOrgId)
			},
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
