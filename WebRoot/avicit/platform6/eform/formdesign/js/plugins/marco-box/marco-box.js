var MyElement = {
    elecode: "marco-box",
    colType:"VARCHAR2",
    dragElement: function () {
    	var dragelement = {};
    	dragelement.name = "宏控件";
    	dragelement.icon = "fa fa-file-code-o";
    	return dragelement;
    },
    dropElement: function () {
        return '<input type="text" value="宏控件">';
    },
    update: function (form, ui) {
        var attrJson = form.serializeObject();
    },
    initAttrForm:function(form,attrJson){
    	$.ajax({
    		url: 'platform/eform/plugin/getAllMarcos.json',
    		type :'get',
    		dataType :'json',
    		success : function(r){
    			if (!r){
    				return;
    			}
    			if (r.length < 1){
    				return;
    			}
    			$("#selecttext").empty();
    			$("#singletext").empty();
    				for (var i = 0 ; i < r.length ; i++){
    					var json = r[i];
    					var marcoName = json.marcoName;
    					var marcoImpl = json.marcoImpl;
    					var marcoType = json.marcoType;
    					var marcoExp = json.marcoExp;
    					if (attrJson){//如果是回带数据
    						var attr = $.parseJSON(attrJson);
    						$("#marcoType").val(attr.marcoType);
    						var isSelected = "";
    						if (attr.marco == marcoExp){
    							isSelected = "selected";
    						}
    						appendComboxData(marcoExp,marcoType,marcoName,isSelected);
    					}else if(i == 0){//如果是第一条数据，设置选中信息
    						$("#marcoType").val(marcoType);
    						// $("#marcoType").trigger('keyup');
    						appendComboxData(marcoExp,marcoType,marcoName,"");
    					}else{
    						appendComboxData(marcoExp,marcoType,marcoName,"");
    					}
    					
    				}
                $("#marcoType").trigger('keyup');
    		}
    	});
    	$("#marco").on("change",function(){
    		var type = $('#marco option:selected').attr("colType");
    		$("#marcoType").val(type);
    	});
    	function appendComboxData(marcoExp,marcoType,marcoName,isSelected){
    		if (marcoType == "日期时间"){
    			$("#date_time").append('<option value="' + marcoExp + '" colType="' + marcoType + '" ' + isSelected + '>' + marcoName + '</option>');
    		} else if(marcoType == "用户组织"){
    			$("#org_user").append('<option value="' + marcoExp + '" colType="' + marcoType + '" ' + isSelected + '>' + marcoName + '</option>');
    		} else if(marcoType == "流程"){
    			$("#workflow").append('<option value="' + marcoExp + '" colType="'+marcoType+'" ' + isSelected + '>' + marcoName + '</option>');
    		} else {
    			$("#other").append('<option value="' + marcoExp + '" colType="' + marcoType + '" ' + isSelected + '>' + marcoName + '</option>');
    		}
    	}
    }
};