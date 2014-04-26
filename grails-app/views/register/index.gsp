<html>

<head>
	<meta name='layout' content='register'/>
	<title><g:message code='spring.security.ui.register.title'/></title>
</head>

<body>

<p/>

<s2ui:form width='650' height='715' elementId='loginFormContainer'
           titleCode='spring.security.ui.register.description' center='true'>

<g:form action='register' name='registerForm'>

	<g:if test='${emailSent}'>
	<br/>
	<g:message code='spring.security.ui.register.sent'/>
	</g:if>
	<g:else>

	<br/>

	<table>
	<tbody>
<%
	def lstQuestion = [0: 'What was your childhood nickname?', 
					   1: 'In what city did you meet your spouse/significant other?',
						2: 'What is the name of your favorite childhood friend?', 
						3: 'What street did you live on in third grade?',
						4: 'What is your oldest sibling’s birthday month and year? (e.g., January 1900)', 
						5: 'What is the middle name of your oldest child?',
						6: 'What is your oldest sibling\'s middle name?',
						7: 'What school did you attend for sixth grade?']
	def pwdCriteria = '''
						Minimum 8 characters, Maximum 64 charaters<br>
						Atleast one Capital letter (A-Z)<br>
						Atleast one Small letter (a-z)<br>
						Atleast one Number (0-9)<br>
						Atleast one Special character (!@#$%^&)
					  '''
%>
		<s2ui:textFieldRow name='username' labelCode='user.username-email.label' bean="${command}"
                         size='40' labelCodeDefault='Username (e-mail)' value="${command.username}"/>
	
		<%--<s2ui:textFieldRow name='email' bean="${command}" value="${command.email}"
		                   size='40' labelCode='user.email.label' labelCodeDefault='E-mail'/>--%>

		<s2ui:passwordFieldRow name='password' labelCode='user.password.label' bean="${command}"
                             size='40' labelCodeDefault='Password' value="${command.password}"/>

		<s2ui:passwordFieldRow name='password2' labelCode='user.confirmPassword.label' bean="${command}"
                             size='40' labelCodeDefault='Confirm Password' value="${command.password2}"/>
        <tr class="prop">
			<td colspan=2 valign="top" class="name">
			<label for="">${pwdCriteria}</label>
			</td>
		</tr>
		<tr><td colspan="2"><hr></td></tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Register As</label>
			</td>
			<td valign="top" class="value false">
				<g:select name="role" from="[0:'Patient', 1:'Doctor', 2:'Staff']" 
        									optionKey="key" optionValue="value"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Name</label>
			</td>
			<td valign="top" class="value false">
				<%--<g:select name="role" from="[0:'Mr.', 1:'Mrs.', 2:'Ms.', 3:'Dr.']" 
        									optionKey="key" optionValue="value"/>&nbsp;--%>
        		<g:textField name="firstname" placeholder="First name"/>&nbsp;<g:textField name="lastname" placeholder="Last name"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Address</label>
			</td>
			<td valign="top" class="value false">
        		<g:textField name="streetaddress" placeholder="Street address" size="60"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			&nbsp;
			</td>
			<td valign="top" class="value false">
			    <g:textField name="city" placeholder="City" size="25"/>&nbsp;
				<g:select name="role" from="[0:'AZ', 1:'CA', 2:'NM', 3:'PO']" 
        									optionKey="key" optionValue="value"/>&nbsp;
        		<g:textField name="zip" placeholder="Zip" size="5"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Phone no</label>
			</td>
			<td valign="top" class="value false">
        		<g:textField name="phoneno" placeholder="(xxx)xxx-xxxx" size="14"/>
        		<g:textField name="extn" placeholder="Extn" size="5"/>
			</td>
		</tr>
		<tr><td colspan="2"><hr></td></tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Secret Question 1</label>
			</td>
			<td valign="top" class="value false">
				<g:select name="question1" from="${lstQuestion}" optionKey="key" optionValue="value" value="0"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Answer 1</label>
			</td>
			<td valign="top" class="value false">
				<g:textField name="secretAns1"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Secret Question 2</label>
			</td>
			<td valign="top" class="value false">
				<g:select name="question2" from="${lstQuestion}" optionKey="key" optionValue="value" value="1"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Answer 2</label>
			</td>
			<td valign="top" class="value false">
				<g:textField name="secretAns1"/>
			</td>
		</tr>
				<tr class="prop">
			<td valign="top" class="name">
			<label for="">Secret Question 3</label>
			</td>
			<td valign="top" class="value false">
				<g:select name="question3" from="${lstQuestion}" optionKey="key" optionValue="value" value="2"/>
			</td>
		</tr>
		<tr class="prop">
			<td valign="top" class="name">
			<label for="">Answer 3</label>
			</td>
			<td valign="top" class="value false">
				<g:textField name="secretAns3"/>
			</td>
		</tr>
	</tbody>
	</table>

	<s2ui:submitButton elementId='create' form='registerForm' messageCode='spring.security.ui.register.submit'/>

	</g:else>

</g:form>

</s2ui:form>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

</body>
</html>
