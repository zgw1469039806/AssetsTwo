var monitorApiInfo;
var monitorOrganization;
var busnessDomainTree;



function formatValue(cellvalue, options, rowObject) {
	return '<a href="javascript:void(0);"  onclick="APIServicePage(\'' + rowObject.id +'\',\''+"serviceCode"+ '\');">' + cellvalue + '</a>';
}

function formatDateForHref(cellvalue, options, rowObject) {
	var thisDate = format(cellvalue);
	return '<a href="javascript:void(0);" onclick="monitorApiInfo.detail('
			+ rowObject.id + ');">' + thisDate + '</a>';
}

function formatValueAPI(cellvalue, options, rowObject) {
	return '<a href="javascript:void(0);"  onclick="APIServicePage(\'' + rowObject.id+'\',\''+"null" + '\');">' + cellvalue + '</a>';
}

function APIServicePage(id,serviceCode){
	 APIServiceIndex = layer.open({
		type : 2,
		area : [ '100%', '100%' ],
		title : 'API信息',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		maxmin : false, // 开启最大化最小化按钮
		content : 'apicenter/apiInfoManage/apiInfoManageController/operation/toApiService/' + id+'/'+serviceCode
	});
}

$(function() {
	
	monitorOrganization = new MonitorOrganization('_ztree',
			'apicenter/apiInfoManage/apiInfoManageController', 'form', 'txt', 'searchbtn');
	monitorOrganization.init();


	
	var dataGridColModel = [ 
	   {label : 'id',name : 'id',key : true,width : 75,hidden : true
	}, {label : 'API名称',name : 'apiName',width : 150,formatter : formatValueAPI
	}, {label : '服务编码',name : 'serviceCode',width : 150,formatter : formatValue
	}, {label : '业务域编码',name : 'businessDomain',width : 150
	}, {
		label : '责任部门ID',
		name : 'deptName',
		width : 150,
		hidden : true
	},   {
		label : '责任部门',
		name : 'deptNameAlias',
		width : 150
	}, {label : '应用名称',name : 'appName',width : 150
	}, {label : '应用编码',name : 'appCode',width : 150
	}, {label : '应用描述',name : 'appDesc',width : 150,hidden : true
	}, {label : '应用版本',name : 'appVersion',width : 150
	}, {label : '服务描述',name : 'serviceDesc',width : 150,hidden : true
	}, {label : 'API地址',name : 'apiServiceUri',width : 150,hidden : true
	}, {label : 'API描述',name : 'apiDesc',width : 150,hidden : true
	}, {label : 'API版本',name : 'apiVersion',width : 150,hidden : true
	}, {label : 'API请求方法',name : 'apiRequestMethod',width : 150,hidden : true
	}, {label : 'API请求参数',name : 'apiRequestParam',width : 150,hidden : true
	}, {label : 'API请求头',name : 'apiRequestHeader',width : 150,hidden : true
	}, {label : 'API返回格式',name : 'apiReturnFormat',width : 150,hidden : true
	}, {label : 'API返回参数',name : 'apiReturnParam',width : 150,hidden : true
	}, {label : 'API错误码',name : 'apiErrorInfo',width : 150,hidden : true
	}, {label : '技术支持',name : 'techSupport',width : 150,hidden : true
	} ];
	

	$("#monitorApiInfojqGrid").jqGrid({
		url : 'apicenter/apiInfoManage/apiInfoManageController/operation/getApiInfoManagersByPageWithoutPage.json',
		mtype : 'POST',
		datatype : "json",
		async:false,
		toolbar : [ true, 'top'],
		colModel : dataGridColModel,
		height : $(window).height() - 120,
		scrollOffset : 20, // 设置垂直滚动条宽度
		styleUI : 'Bootstrap',
		viewrecords : true,
		multiselect : false,
		autowidth : true,
		rowNum: -1,
		rownumbers:true,
		pagination:false,
		
		altRows : true,
		userDataOnFooter : true,
		
		shrinkToFit : true,
		responsive : true,
		onSelectRow: function(id) { //单击选择行  
         var rowData = $("#monitorApiInfojqGrid").jqGrid('getRowData', id);
         var appCode=rowData.appCode;
         var treeObj = $.fn.zTree.getZTreeObj("_ztree");
  		
         if(treeObj){
        	 //当前选中节点
        	 var nodes = treeObj.getNodesByParam("id", appCode);
        	 if(!nodes || nodes.length == 0){
        		 nodes = treeObj.getNodesByParam("orgIdentity", "other");
        	 }
        	 
        	//获取之前选中的节点
             var nodesBefore = treeObj.getSelectedNodes();
             if(nodesBefore[0].id==nodes[0].id){//如果点击同一个节点，则不执行
            	 
             }else if (nodesBefore.length>0&&nodesBefore[0].id!="1") { //关闭之前节点及父节点
            	 //关
               	treeObj.cancelSelectedNode(nodesBefore[0]);
              	var parentNode = nodesBefore[0].getParentNode();
              	var rootCode="root";
              	var codeArray=[];
              	while(parentNode){
              		codeArray.push(parentNode.attributes.organizationCode);
              		parentNode = parentNode.getParentNode();
              	}
              	parentNode = nodes[0].getParentNode();
              	while(parentNode){
              		var index = $.inArray(parentNode.attributes.organizationCode,codeArray);
              		if(index > -1){
              			rootCode = parentNode.attributes.organizationCode;
              			break;
              		}
              		parentNode = parentNode.getParentNode();
              	}
              	parentNode = nodesBefore[0].getParentNode();
              	while(parentNode&&parentNode.attributes.organizationCode!=rootCode){
              		treeObj.expandNode(parentNode, false, true, false);
          			parentNode = parentNode.getParentNode();
          		}
              	//开
              	treeObj.selectNode(nodes[0]);
          		var parentNodeCurrent = nodes[0].getParentNode();
          		while(parentNodeCurrent&&parentNodeCurrent.attributes.organizationCode!=rootCode){
          			treeObj.expandNode(parentNodeCurrent, true, false, false);
          			parentNodeCurrent =  parentNodeCurrent.getParentNode();
          		}
              }else if(nodes!=null && nodes.length>0){ //打开相关节点及父节点
              		var selectNode = nodes[0];
              		treeObj.selectNode(selectNode);
              		var parentNode = selectNode.getParentNode();
              		while(parentNode){
              			treeObj.expandNode(parentNode, true, false, false);
              			parentNode =  parentNode.getParentNode();
              		}
              	}
             
            
         	
         } else {
        	 layer.msg("业务域树ID设置不正确！");
         }
		}
	});

	$("#t_monitorApiInfojqGrid").append($("#tableToolbar"));
	
	var searchNames = new Array();
	var searchTips = new Array();
	searchNames.push("apiName");
	searchTips.push("API名称");
	
	var searchC = searchTips.length == 2 ? '或' + searchTips[1]
			: "";
	// $('#monitorApiInfo_keyWord').attr('placeholder','请输入' +
	// searchTips[0] + searchC);

	// 添加按钮绑定事件
	/*monitorApiInfo = new MonitorApiInfo('monitorApiInfojqGrid',
			'${url}', 'searchDialog', 'form',
			'monitorApiInfo_keyWord', searchNames,
			dataGridColModel);*/
	// 查询按钮绑定事件
	$('#monitorApiInfo_searchPart').bind('click', function() {
		searchByKeyWord();
	});
	// 打开高级查询框
	$('#monitorApiInfo_searchAll').bind('click', function() {
		openSearchForm(this);
	});
	
	// 回车查询
	$("#monitorApiInfo_keyWord").on('keydown', function(e) {
		if (e.keyCode == '13') {
			searchByKeyWord();
		}
	});
	
	//搜索全部
	$('#ApiInfo_searchAll').bind('click', function() {
		$('#ApiInfo_searchAll').css("color","blue");
		$('#ApiInfo_searchlatest').css("color","black");
		$("#monitorApiInfojqGrid").jqGrid('clearGridData');//清空表格
		$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
			postData : {
				"latest": ""
			}
		}).trigger("reloadGrid");
		
	});
	//搜索最新
	$('#ApiInfo_searchlatest').bind('click', function() {
		$('#ApiInfo_searchAll').css("color","black");
		$('#ApiInfo_searchlatest').css("color","blue");
		$("#monitorApiInfojqGrid").jqGrid('clearGridData');//清空表格
		$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
			postData : {
				"latest": "new"
			}
		}).trigger("reloadGrid");
	});
	//责任部门
	$('#deptNameAlias').on('focus', function(e) {
		new H5CommonSelect({
			type : 'deptSelect',
			idFiled : 'deptName',
			textFiled : 'deptNameAlias'
		});
		this.blur();
		nullInput(e);
	});
	
	//yewuyu
	$('.businessDomainValue').on('click', function(e) {
		layer.open({
				type : 2,
				area : [ '300px', '450px' ],
				title : '请选择业务域',
				btn: ['确定', '取消'],
				maxmin : false, // 开启最大化最小化按钮
				content : 'apicenter/apiorganization/apiOrganizationController/toApiOrganizationManage/businessDomain/businessDomainValue',
				yes: function(index){//layer.msg('yes');    //点击确定回调
			        layer.close(index);
			    },
			    btn2: function(){//layer.alert('aaa',{title:'msg title'});  ////点击取消回调
			    	//layer.close(index);
			    	$("#businessDomainValue").val("");
					$("#businessDomain").val("");
			    },
			    cancel: function(){
			    	$("#businessDomainValue").val("");
					$("#businessDomain").val("");
			      }
			});
	});
	
});
//关键字查询
searchByKeyWord = function() {
	var keyWord = $("#monitorApiInfo_keyWord").val() == $("#monitorApiInfo_keyWord").attr(
			"placeholder") ? "" : $("#monitorApiInfo_keyWord").val();
	var treeObj = $.fn.zTree.getZTreeObj("_ztree");
	var nodes = treeObj.getSelectedNodes();
	
	if(nodes[0].attributes.applicationCode){
		var param = {};
		param["apiName"] = keyWord;
		var  parentBusNode=nodes[0].getParentNode();
		param["businessDomain"]=parentBusNode.attributes.organizationCode;
		param["appCode"]=nodes[0].attributes.applicationCode;
		
		var searchdata = {
			keyWord : JSON.stringify(param),
			param : null
		}
		 $("#monitorApiInfojqGrid").jqGrid('setGridParam', {
			datatype : 'json',
			postData : searchdata
		}).trigger("reloadGrid");
	}else if(nodes[0].attributes.organizationCode=="root"){
		var param = {};
		param["apiName"] = keyWord;
		param["businessDomain"]="";
		param["appCode"]="";
		
		var searchdata = {
			keyWord : JSON.stringify(param),
			param : null
		}
		 $("#monitorApiInfojqGrid").jqGrid('setGridParam', {
			datatype : 'json',
			postData : searchdata
		}).trigger("reloadGrid");
	}else{
		var param = {};
		param["apiName"] = keyWord;
		param["businessDomain"]=nodes[0].attributes.organizationCode;
		param["appCode"]="";
		
		var searchdata = {
			keyWord : JSON.stringify(param),
			param : null
		}
		 $("#monitorApiInfojqGrid").jqGrid('setGridParam', {
			datatype : 'json',
			postData : searchdata
		}).trigger("reloadGrid");
	}
	
}

openSearchForm = function(searchDiv) {
	var _self = this;
	var contentWidth = 600;
	var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left;
	var text = $(searchDiv).text();
	var width = $(searchDiv).innerWidth();

	layer.config({
		extend : 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});

	layer.open({
		type : 1,
		shift : 5,
		title : false,
		scrollbar : false,
		move : false,
		area : [ contentWidth + 'px', '230px' ],
		offset : [ top + 'px', left + 'px' ],
		closeBtn : 0,
		
		shadeClose : true,
		btn : [ '查询', '清空', '取消' ],
		content : $("#searchDialog"),
		success : function(layero, index) {
			var serachLabel = $(
					'<div class="serachLabel"><span>' + text
							+ '</span><span class="caret"></span></div>')
					.appendTo(layero);
			serachLabel.bind('click', function() {
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
			
			 this.enterConfirm = function(event){
	                if(event.keyCode === 13){
	                    _self.searchData();
	                    layer.close(index);
	                }
	            };
	            $(document).on('keydown', this.enterConfirm);
		},
		yes : function(index, layero) {
			searchData();
			layer.close(index);// 查询框关闭
		},
		btn2 : function(index, layero) {
			clearData();
			return false;
		},
		btn3 : function(index, layero) {

		},
        end:function(){
            $(document).off('keydown', this.enterConfirm); //解除键盘事件
        }
	});
};
// 关闭对话框
closeDialog = function(id) {
	if (id == "insert") {
		layer.close(this.insertIndex);
	} else {
		layer.close(this.eidtIndex);
	}
};
// 高级查询
searchData = function() {
	var treeObj = $.fn.zTree.getZTreeObj("_ztree");
	var nodes = treeObj.getSelectedNodes();
	
//	if(nodes[0].attributes.applicationCode){
//		$("#appCode").val(nodes[0].attributes.applicationCode);
//	}
	var searchdata = {
		keyWord : null,
		param : JSON.stringify(serializeObject($("#form")))
	}
	
	$("#monitorApiInfojqGrid").jqGrid('setGridParam', {
		datatype : 'json',
		postData : searchdata
	}).trigger("reloadGrid");
};
// 隐藏查询框
hideSearchForm = function() {
	layer.close("#searchDialog");
};
/* 清空查询条件 */
clearData = function() {
	var appCode = $("#appCode").val();
	var appName = $("#appName").val();
	clearFormData("#form");
	if($("#appCode").attr("readOnly")){
		$("#appCode").val(appCode);
		$("#appName").val(appName);
	}
	this.searchData();
};