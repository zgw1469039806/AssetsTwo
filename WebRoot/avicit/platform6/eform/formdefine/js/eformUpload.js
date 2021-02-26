/**
 * 
 */

function upLoadUserPhoto(colId,id,colName){
	if(document.getElementById("sysUserPhoto").value != ''){
		if(checkfiletype('sysUserPhoto')){
			$.messager.progress();	// 显示进度条
			$('#uploadForm').form('submit', {
				url: 'platform/eform/image/uploaduser/headerphoto?colId='+colId+'&id='+id,
				success: function(){
					$.messager.progress('close');	// 如果提交成功则隐藏进度条
					$.messager.alert('提示','图片文件上传成功!','info',function(r){
						window.parent.document.getElementById(colName).src="platform/eform/image/upload/getphoto?id="+id+"&colId="+colId+"&o=" + Math.random();
						parent.closeDialog("eformupload");
					});
				}
			});
			return;
		} else {
			$.messager.alert('警告','请选择要上传的头像文件!','warning');
			return;
		}
	}
}

//检查上传类型
function checkfiletype(id){
    var fileName = document.getElementById(id).value;
    //设置文件类型数组
    var extArray =[".jpg",".png",".gif",".bmp"];
   	//获取文件名称
   	while (fileName.indexOf("//") != -1)
    	fileName = fileName.slice(fileName.indexOf("//") + 1);
       	//获取文件扩展名
       	var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
   		//遍历文件类型
       	var count = extArray.length;
   		for (;count--;){
     		if (extArray[count] == ext){ 
       			return true;
     		}
   		}  
   		$.messager.alert('错误','只能上传下列类型的文件: '  + extArray.join(" "),'error');
   return false;  
}