
//加载
function loadUserDefined(index){
	asynGetUserDefinedPortlet(index);
}

function asynGetUserDefinedPortlet(index){
	if(typeof(index) == 'undefined'){
		index = 0;
	}
	$.ajax({
		type: 'GET',  
		url: 'platform/portal/userDefinedPortlet/toGetUserDefinedPortletJsonData',
		dataType : 'json',
        cache:false,
		success: function(datas) {
			var contentHtml = "";
			var indexDefaultDisplay = "";
			for(var i = 0 ; i < datas.length ; i++){
				var checked = datas[i].isDefault == "1" ? "checked" : "";
				if(checked){
					indexDefaultDisplay = datas[i].id;
				}
				var url = "portal/userDefinedPortlet/toGetPortalConfigContent?id=" + datas[i].id;
				contentHtml += "<li class=\"changeUrl " + checked + "\" rel=\"" + url + "\"><div><i></i><span class=\"cn\">" + datas[i].portletName + "</span><span class=\"setting\" data-for=\"" + datas[i].id + "\"></span></div></li>";
			}
			$("#indexMenu .indexMenuContent").html(contentHtml);
			addSubMenu(index, 'index');
			initIndexDefaultDisplay(indexDefaultDisplay);
			setting();
//			setDispalySetting();
		},
		error :function(data){
			top.layer.alert('加载失败！',{
				  icon: 7,
				  area: ['400px', ''],
				  closeBtn: 0
			    }
	         );
		}
	});
}
function initIndexDefaultDisplay(id){
	var tagName = $('.tabsSubMenu').data('for');
    var tab = $('#tabs-panel').tabs('getTab', tagName);
    var url = "portal/userDefinedPortlet/toGetPortalConfigContent?id=" + id;
    $('#tabs-panel')
    .tabs('select', tagName)
    .tabs('update', {
        tab: tab,
        options: {
            title: tagName,
            content: '<iframe scrolling="auto" id="mainFrame" name="mainFrame" frameborder="0"  src="' + url + '" style="width:100%;height:100%;"></iframe>'
        }
    });
    
//    $("#mainFrame").attr("src",url);
}
//
/**
 * 新增自定栏目(portlet)
 * @returns
 */
function userDefinedPortlet_add(){
//	layer.prompt({
//	  formType: 0,
//	  title: '请输入首页名称',
//	  area: ['200px', '155px'] //自定义文本域宽高
//	}, function(value, index, elem){
//	   
//	});
	layer.open({
        type : 1,
        area: ['400px', '155px'],
        title : '提示',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, // 开启最大化最小化按钮
        content : "<table style='margin-top: 20px;margin-left: 50px;'><tr><td nowrap><label style='font-weight:600;font-size:14px;'>首页名称：</label></td><td><input type='text' size='30px' id='userDefinedName' class='form-control input-sm'></td></tr></table>",
        btn: ['确定','取消'],
        yes: function(index, layero){
        	var value = $('#userDefinedName').val();
           if(value){
        	   save(value);
           } else {
        	   layer.alert('请选择或输入【首页名称】,该值不允许为空！', {
					  title : '提示',
					  icon : 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
        	   return;
           }
           layer.close(index);
        }
    });
	return false;
}

/**
 * 保存名称
 */
function save(name){
    var _top = top;
	$.ajax({  
		type: 'POST',  
		url: 'platform/portal/userDefinedPortlet/toSavePortletConfig',  
		data: { 
			portletName: name
		},  
		success: function(data) {
			top.layer.msg('保存成功！');
            var indexPortSave = _top.layer.open({
		     	 type : 2,
		         title: false,
		         skin: 'index-model-noborder',
		         move :'.simple-movetab',
		         shade: false,
                 closeBtn : 0,
                area: ['100%', '100%'],
		         content : 'portal/portlet/toGetPortalConfigDesign?id=' + data + '&isPortal=true'
		     });
		},
		error :function(data){
			top.layer.alert('保存失败！',{
				  icon: 7,
				  area: ['400px', ''],
				  closeBtn: 0
			    }
	         );
		}
	});
}
/**
 * 设置portlet
 */
function setting(){
    var _top = top;
	$(".setting").click(function(){
		var id = $(this).data('for');
		var name = $(this).prev().text();
		var indexPortSet = _top.layer.open({
	    	type : 2,
	        title: false,
	        skin: 'index-model-noborder',
	        move :'.simple-movetab',
	        shade: false,
            closeBtn : 0,
            area: ['100%', '100%'],
	        content : 'portal/portlet/toGetPortalConfigDesign?id=' + id + '&isPortal=true'
	    });
	});
	 return false;
}
/**
 * 鼠标经过时显示setting
 */
function setDispalySetting(){
	$(".changeUrl").mouseover(function(){
		$(this).find("span:last").css("display","block");
	}).mouseout(function(){
		$(this).find("span:last").css("display","none");
	});
}
