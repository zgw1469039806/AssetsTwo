/**
 * 绘制idea Toolbar
 */
function drawIdeasToolbar(){
	$('#toolbar').toolbar({
		items:[{
			id : 'selectCommonIdearToolbar',
			iconCls : 'icon-ideas',
			disabled : false,
			text : '常用意见'
		},{
			id : 'saveCommonIdear',
			text : '保存到常用意见',
			iconCls : 'icon-save',
			handler : function(){
				var ideasValue = $("#textAreaIdeas").val();
				var ideasLength = ideasValue.length;
				if(ideasValue != ''){
					if(ideasLength > 30){
						$.messager.alert('提示','常用意见最多包含30个字符，当前长度为'+ideasLength+',请缩减后再保存!','error');	
					}else
						saveIdeas(ideasValue);		
				} else {
					$.messager.alert('提示','意见为空!','error');
				}
			}
		},{
			id : 'ideaCompelMannerToolbar',
			iconCls : 'icon-ideas-lock',
			disabled : false,
			text : '    '
		}]
	});
}
/**
 * 绘制强制表态
 * @param branchNo
 */
function drawIdeaCompelManner(branchNo){
	if(dataJson.nextTask[branchNo].currentActivityAttr && dataJson.nextTask[branchNo].currentActivityAttr.userSelectType && dataJson.nextTask[branchNo].currentActivityAttr.ideaCompelManner == 'yes'){
		$('#ideaCompelMannerRadioGroup').appendTo($('#toolbar'));//动态追加"是否强制表态" radio group 
	}
}

/**
 * 保存意见
 */
function saveIdeas(ideasValue){
	$.ajax({
		   type: "POST",
		   url: getPath2() + '/platform/user/bpmSelectUserAction/savePersonCommonIdear',
		   async: false,
		   data: encodeURI('idears=' + ideasValue),
		   dataType: 'text',
		   success: function(msg){
			   $.messager.show({
					title:'提示',
					msg:'保存成功!',
					timeout:1000,
					showType:'slide'
				}); 
		   },
		   error : function(msg){
			   $.messager.alert('错误',msg,'error');
		   }
	});
}
var conditions = {
		//分支
		isBranch : function(){
			
			if(dataJson.nextTask != null && dataJson.nextTask.length > 1){//分支
				return true;
			}else {//非分支
				return false;
			}
		},
		//选人方式
		isUserSelectTypeAuto : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.userSelectType){
				if(dataJson.nextTask[branchNo].currentActivityAttr.userSelectType == 'auto'){
					return true;//自动选人方式
				} else {
					return false;
				}
			} else {
				return false;//手动选人方式
			}
		},
		//是否启用工作移交
		isWorkHandUser : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isWorkHandUser){
				if(dataJson.nextTask[branchNo].currentActivityAttr.isWorkHandUser == 'no'){
					return false;//启用
				} else {
					return true;//不启用
				}
			} else {//默认
				return true;//不启用
			}
		},
		//处理方式
		getDealType : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.dealType){
				return dataJson.nextTask[branchNo].currentActivityAttr.dealType;
			}
			return "2";
		},
		//处理方式
		getSingle : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.single){
				return dataJson.nextTask[branchNo].currentActivityAttr.single;
			}
			return "no";
		},
		//是否必须选人
		isMustUser : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isMustUser){
				if(dataJson.nextTask[branchNo].currentActivityAttr.isMustUser == 'no'){//必须选人
					return false;
				} else {
					return true;//必须选人
				}
			} else {
				return true;//默认值
			}
		},
		//是否启用密级
		isSecret : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isSecret){
				if(dataJson.nextTask[branchNo].currentActivityAttr.isMustUser == 'yes'){//启用
					return true;
				} else {
					return false;//不启用
				}
			} else {
				return false;//不启用
			}
		}, 
		//意见添写方式
		getIdeaType : function(){
			if(dataJson.currentActivityAttr.ideaType){
				return dataJson.currentActivityAttr.ideaType;
			}
			return "";
		},
		//是否强制表态
		isIdeaCompelManner : function(){
			if(dataJson.currentActivityAttr.ideaCompelManner){
				if(dataJson.currentActivityAttr.ideaCompelManner == 'yes'){//强制
					return true;
				} else {
					return false;//不强制
				}
			} else {
				return false;//不强制
			}
		},
		//退回意见是否必填
		isNeedIdea : function(){
			if(dataJson.currentActivityAttr.isNeedIdea){
				if(dataJson.currentActivityAttr.isNeedIdea == 'no'){//强制
					return false;
				} else {
					return true;//不强制
				}
			} else {
				return true;//不强制
			}
		},
		//是否显示选人框
		isSelectUser : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isSelectUser){
				if(dataJson.nextTask[branchNo].currentActivityAttr.isSelectUser == 'no'){//不显示
					return false;
				} else {
					return true;//显示
				}
			} else {
				return true;//显示
			}
		},
		/**
		 * 是否自动获取用户
		 */
		isAutoGetUser : function(branchNo){
			if(typeof(branchNo) == 'undefined'){
				branchNo = 0;
			}
			if(dataJson.nextTask != null && dataJson.nextTask[branchNo].currentActivityAttr.isAutoGetUser){
				if(dataJson.nextTask[branchNo].currentActivityAttr.isAutoGetUser == 'no'){//不显示
					return false;
				} else {
					return true;//是
				}
			} else {
				return false;
			}
		},
		//获取下节点类型
		getNextActivityType : function(){
			return dataJson.activityType;
		}
};
var eventToolbar = {
		getBranchLength : function(){
			if(dataJson.nextTask == null){
				return 0;
			}
			return dataJson.nextTask.length;
		},
		//为toolbar添加强制表态radio
		eventOfToolbarAppendIdeaCompelMannerRadio : function(){
		
			if(conditions.isIdeaCompelManner() && type == 'dosubmit'){
				$("#toolbar").toolbar('enable','强制表态');
				$("#ideaCompelMannerToolbar").css("display",'');
				$('#ideaCompelMannerToolbar .icon-ideas-lock').html('<div style="float:left;">强制表态</div><div style=\"display:block;float:left;border:0px solid red;\"><label><input type=\"radio\" name=\"ideaCompelMannerRadioGroup\" value=\"yes\" >同意</label> <label><input type=\"radio\" name=\"ideaCompelMannerRadioGroup\" value=\"no\">不同意</label></div>');
			} else {
				$("#toolbar").toolbar('disabled','强制表态');
				$("#ideaCompelMannerToolbar").css("display",'none');
			}
		}
};

$(function(){
	drawIdeasToolbar();
//	从cookie中获取数据到指定的component中
	setTimeout(function(){
		//加载历史意见记录

		try{
			var idearHistoryKey = settings.saveToCookieKey;
			var idearHistoryVal = $.cookie(idearHistoryKey);
			$('#textAreaIdeas').val(idearHistoryVal);
		}catch(e){
			
		}
		// 为常用意见button绑定menu
		$('#selectCommonIdearToolbar .l-btn-left').attr('class','easyui-splitbutton').menubutton({});
		$('#selectCommonIdearToolbar .l-btn-left').click(function(){
			getCommonIdear();
			var height = $(this).height();
			var top = $(this).offset().top;
			var left = $(this).offset().left + ($(this).width() /2) - ($('#shareit-box').width() / 2);		
			$('#shareit-header').height('1');
			$('#shareit-box').show();
			$('#shareit-box').css({'top':top, 'left':'13'});
		});
	}, 300);
	
	eventToolbar.eventOfToolbarAppendIdeaCompelMannerRadio();
	
	$('#shareit-box').mouseleave(function(){
		$(this).hide();
	});
	
	$("input[name='ideaCompelMannerRadioGroup']").click(function(){
		$("#ideaCompelManner").val(this.value);
	});
});
function setTextareaVal(value){
	//定义常用意见menu
	$("#textAreaIdeas").val(value);
	$('#shareit-box').hide();
}
//从服务端获取常用意见
function getCommonIdear(){
	$.ajax({
		   type: "GET",
		   url: getPath2() + '/platform/user/bpmSelectUserAction/getPersonCommonIdear?j=' + Math.random(),
		   async: false,
		   dataType: 'json',
		   success: function(msg){
			   $("#shareit-url").html('');
			   var commonIdearList = msg.customedImplList;
			   if(typeof(commonIdearList) != 'undefined' && commonIdearList.length > 0){
				   for(var i = 0 ; i < commonIdearList.length ; i++){
//					   $('#commonIdearsMenus').menu('appendItem', {
//							text: commonIdearList[i].value
//					   });
					   if(commonIdearList[i].value != null){
						   $("#shareit-url").append("<li onclick=\"setTextareaVal('" + commonIdearList[i].value + "')\">" + commonIdearList[i].value + "</li>");
					   }
				   }
			   } else {
				   $('#commonIdearsMenus').menu('appendItem', {
						text: '空'
					});
			   } 
		   },
		   error : function(msg){
//			   $.messager.alert('错误','获取常用意见列表失败!','error');
		   }
	});
}
function saveToCookieTip(){
	$.messager.show({
		title:'提示',
		msg:'保存成功!',
		timeout:1000,
		showType:'slide'
	});
}



