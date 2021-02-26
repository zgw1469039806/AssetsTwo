 //加载初始化
function openTreeOrg(isUserNumber,success,error){
	$.ajax({
		url : './im/ImOrgController/getOrgDataLazy?pid=-1&isUserNumber='+isUserNumber,
		type : 'post',
		data : {},
		dataType : 'json',
		success : function(data) {
			if(success){
				success(data);
			}
		},error : function(err, msg) {
			if(error){
				error(err, msg);
			}
		}
	});
}
