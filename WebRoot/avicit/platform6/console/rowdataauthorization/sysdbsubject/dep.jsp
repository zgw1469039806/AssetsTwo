<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,tree,form,table";
%>
<!DOCTYPE html>
<html>
<head>
<title>部门选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css-fixie8-fonticon.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css"
	href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeviewmin-fixie8.css" />
<style>
.ztree a {
	color: black
}
</style>
</head>
<body class=" easyui-layout" fit="true">
    <div data-options="region:'north'" style="height:40px;margin-right: 5px;">
		<div class="toolbar-right">
			<div  class="col-xs-6">
				<div class="input-group  input-group-sm" style="width:230px;padding-top:2px;margin-right:0px;">
			      <input  class="form-control" placeholder="输入部门名称查询" type="text" id="search_text" name="search_text"  onkeyup="orgtree.onSeach(event.keyCode, this.value)">
			      <span class="input-group-btn">
			        <button class="btn btn-default" type="button" onclick="orgtree.onSeach(13, $('#search_text').val())"><span class="glyphicon glyphicon-search"></span></button>
			      </span>
			    </div>
			</div>
		</div>
	</div>
	<div data-options="region:'center',split:false,collapsible:false" >
		<div class="row" style="margin: 5px;">
			<div id='mdiv' style="overflow:auto;">
				<ul id="treeDemo" class="ztree" style="height: 100%;overflow-x: hidden;"></ul>
			</div>
		</div>
	</div>
	<!--<div>
		<ul id="treeDemo" class="ztree" style="overflow-y: auto;"></ul>
	</div>-->
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script>
var orgtree;
var type_id;

$(document).ready(function(){
	orgtree = new OrgTree('treeDemo','${"console/dept"}','form','txt','searchbtn');
    orgtree.init();
});
/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */

function OrgTree(ztreeId, url, form, searchD, searchbtn){
	if(!ztreeId || typeof(ztreeId)!=='string'&&ztreeId.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url = url;
    this.getUrl = function(){
    	return _url;
    }
    
    var _selectNode = {};
    
    var _onSelect=function(){};//单击node事件
    
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
		return this;
	};
    
    this.addRetIdFlag = null; //初始化添加节点标记
    this.firstAsyncSuccessFlag = 0; //第一次加载
    this.tree = null;
    this.ztreeId  = ztreeId;
	this._ztreeId="#"+ztreeId;
	this.setting = {};
	this._doc = document;
	this._formId="#"+form; //formId
	this._searchId ="#"+searchD;
	this._searchbtnId ="#"+searchbtn;
};



 function getFont(treeId, node) {  
 	if(node.fontCss=="Y"){
 		// return {color:'#BA55D3'};
 	}
     
  } 
  
//初始化树节点
OrgTree.prototype.init=function(){
	var _self = this;	
	_self.setting = {
			view: {
				selectedMulti: true,
				fontCss: getFont
			},
			data: {
				key: {
					id: "id",
					name: "text",
					children: "children"
				},
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: -1
				}
			},
			async: {
				enable: true,
				url:"h5/view/common/select/SelectController/getDeptSelectList",
				autoParam:["id","nodeType","orgId"],
				otherParam: {
					"viewScope" : "currentOrg"
				},
				dataFilter: function(treeId, parentNode, childNodes){
					if (!childNodes)
			            return null;
			        childNodes = eval(childNodes);
			        return childNodes;
				}
			},
			callback: {
				onClick :  function(event, treeId, treeNode){ //绑定左右联动事件
					 _self._selectNode = treeNode;
					 _self.loadUserData(event, treeId, treeNode);
					
					 type_id = treeNode.id;
						var choseType=$("#myTabContent .active",parent.document).children().attr("val");
						var pid=parent.pId;
						parent.sysDbEntity.reLoad(pid,choseType,type_id);
			    },
			    beforeClick: zTreeBeforeClick,
			   
				onAsyncError:  function(){alert("加载失败！");},
				onAsyncSuccess:  function(event, treeId, msg){
					 if (_self.firstAsyncSuccessFlag == 0) {
		                 var nodes = _self.tree.getNodes();  
		                 _self.tree.expandNode(nodes[0], true);  
		                 $("#"+nodes[0].tId+"_span").click();
		                 _self.firstAsyncSuccessFlag = 1;   
					 } 
					var node = _self.tree.getNodeByParam("id", $('#id').val());
					_self.tree.selectNode(node);
					_self.addRetIdFlag = null;  //初始化添加节点标记
				}
		    }
		};
	    _self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
}
OrgTree.prototype.onSeach = function(ecode, value){
        var _self = this;
		if(ecode == 13){
			if(value==null || value==""){
				firstAsyncSuccessFlag2 = 0;
				$.fn.zTree.init($("#treeDemo"),_self.setting, []);
        		return;
        	}
        	$.ajax({
                cache: true,
                type: "post",
                url: "h5/view/common/select/SelectController/searchDept",
                dataType:"json",
                data:{
                	"search_text":value,
					"viewScope" : "currentOrg"
                },
                async: false,
                error: function(request) {
                	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
                	$.fn.zTree.init($("#treeDemo"), {
            			view: {
            				selectedMulti: false
            			},
            			data: {
            				key: {
            					id: "id",
            					name: "text",
            					children: "children"
            				},
            				simpleData: {
            					enable: false,
            					idKey: "id",
            					pIdKey: "parentId",
            					rootPId: -1
            				}
            			},callback: {
            				onClick: function (event, treeId, treeNode){
        						 _self._selectNode = treeNode;
					             _self.loadUserData(event, treeId, treeNode);
					
					              type_id = treeNode.id;
						          var choseType=$("#myTabContent .active",parent.document).children().attr("val");
						          var pid=parent.pId;
						          parent.sysDbEntity.reLoad(pid,choseType,type_id);
        					},
        					beforeClick: zTreeBeforeClick,
			   
				            onAsyncError:  function(){alert("加载失败！");},
				            onAsyncSuccess:  function(event, treeId, msg){
					                              if (_self.firstAsyncSuccessFlag == 0) {
		                                               var nodes = _self.tree.getNodes();  
		                                               _self.tree.expandNode(nodes[0], true);  
		                                               $("#"+nodes[0].tId+"_span").click();
		                                               _self.firstAsyncSuccessFlag = 1;   
					                               } 
					                               var node = _self.tree.getNodeByParam("id", $('#id').val());
					                               _self.tree.selectNode(node);
					                               _self.addRetIdFlag = null;  //初始化添加节点标记
				            }
        					
        				}
            			
            		}, data);
                }
            });
		}
	};

//表单加载json对象数据
OrgTree.prototype.loadUserData = function (event, treeId, treeNode) {
		try{
			var frmWindow =  document.getElementById("iframeUserList").contentWindow;
			frmWindow.loadUserData(treeNode);
		
		}catch(e){
		
		}
}

OrgTree.prototype.loadUserDataRoot = function () {
		var frmWindow =  document.getElementById("iframeUserList").contentWindow;
		try{
			frmWindow.loadUserDataRoot();
		}catch(e){
		
		}
}

function onSelectRow() {
	var type_id = $("#jqGrid").jqGrid('getGridParam','selarrrow');
	var rowData = $("#jqGrid").jqGrid('getRowData',type_id[0]);
	var choseType=$("#myTabContent .active",parent.document).children().attr("val");
	parent.dbAuthEntity.reLoad(choseType,type_id[0]);
	
};  
function zTreeBeforeClick(treeId, treeNode, clickFlag) {
	return treeNode.nodeType == 'dept';//只有当节点类型为dept时,可以选取
};

</script>

</body>
</html>
