/*if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}*/

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
	var data = {
			"id": ${user?.id},
			"orgId": JSON.stringify(arrOrgId)
			};
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