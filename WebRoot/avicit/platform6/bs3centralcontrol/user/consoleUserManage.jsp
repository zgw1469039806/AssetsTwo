<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.session.SessionHelper" %>
<%
	String importlibs = "common,tree,form";
	String currentOrgId = SessionHelper.getCurrentOrgIdentity(request);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ztree/3.5.12/css/treeViewStyle/treeview.css"/>
<script type="text/javascript">
    var curOrgId = '<%= currentOrgId%>';

	document.body.onload = function(){
	 	if (navigator.userAgent.indexOf('MSIE') >= 0) {
            if (CollectGarbage) {
                CollectGarbage(); //IE 特有 释放内存
            }
        }

	}
	if (!Array.prototype.indexOf) {
	    Array.prototype.indexOf = function(elt /*, from*/ ) {
	        var len = this.length >>> 0;
	        var from = Number(arguments[1]) || 0;
	        from = (from < 0) ?
	            Math.ceil(from) :
	            Math.floor(from);
	        if (from < 0)
	            from += len;
	        for (; from < len; from++) {
	            if (from in this &&
	                this[from] === elt)
	                return from;
	        }
	        return -1;
	    };
	}
</script>
</head>
<body>
<div class="easyui-layout" fit="true" >
		<div data-options="region:'west',split:true" style="width:300px;padding:0px;overflow:auto;">
			<div class="row" style="margin: 5px;">
				<div class="input-group  input-group-sm">
			      <input  class="form-control" placeholder="输入名称查询" type="text" id="txt" name="txt">
			      <span class="input-group-btn">
			        <button id="searchbtn" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
			      </span>
			    </div>
				<div>
					<ul id="treeDemo" class="ztree"></ul>
				</div>
			</div>
		</div>
		<div data-options="region:'center'" >
			<div id="userlist">
			</div>
		</div>
	</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<!-- 模块js -->
<script type="text/javascript" src="avicit/platform6/bs3centralcontrol/user/js/OrgTree.js" ></script>
<script type="text/javascript">

	var isNotSafeManager = '${isNotSaveManager}';
	$(function(){
		$('#userlist').css("height",document.documentElement.clientHeight-20);
		
		setTimeout(function(){
			$('<iframe id="iframeUserList" src="avicit/platform6/bs3centralcontrol/user/consoleUserList.jsp" scrolling="no" frameborder="0" style="width:100%;height:100%;"></iframe>').appendTo($('#userlist'));
		},10);
	})
	$(window).resize(function(){
		$('#userlist').css("height",document.documentElement.clientHeight-20);
	});
	
	
	
	function test(treeId, treeNode){
		if(treeNode){
			var frmWindow =  document.getElementById("iframeUserList").contentWindow;
			frmWindow.loadUserData(treeId, treeNode);
		}
	}	
	var orgtree;
	
	$(document).ready(function(){
		orgtree = new OrgTree('treeDemo','${'console/dept'}','form','txt','searchbtn');
	    orgtree.init();
		$('.date-picker').datepicker();
		$('.time-picker').datetimepicker({
			closeText:'确定',//关闭按钮文案
			oneLine:true,//单行显示时分秒
			showButtonPanel:true,//是否展示功能按钮面板
			showSecond:false,//是否可以选择秒，默认否
			beforeShow: function(selectedDate) {
				if($('#'+selectedDate.id).val()==""){
					$(this).datetimepicker("setDate", new Date());
					$('#'+selectedDate.id).val('');
				}
			}
		});
		//禁止用户手动输入时间绑定事件
		$('.date-picker').on('keydown',nullInput);
		$('.time-picker').on('keydown',nullInput);
		//选人、选部门控件绑定事件
		$('#attribute03Alias').on('keydown',function(e){
			if(e.keyCode != '13'){
				e.returnValue=false;
				return false;
			}
			new H5CommonSelect({type:'userSelect', idFiled:'attribute03',textFiled:'attribute03Alias'});
		}); 
		$('#userbtn').on('click',function(){
			new H5CommonSelect({type:'userSelect', idFiled:'attribute03',textFiled:'attribute03Alias'});
		});
		$('#attribute04Alias').on('keydown',function(e){
			if(e.keyCode != '13'){
				e.returnValue=false;
				return false;
			}
			new H5CommonSelect({type:'deptSelect', idFiled:'attribute04',textFiled:'attribute04Alias'});
		});
        $('#deptbtn').on('click',function(){
        	new H5CommonSelect({type:'deptSelect', idFiled:'attribute04',textFiled:'attribute04Alias'});
		});
		//按钮绑定事件
        $('#orgtree_save').bind('click', function(){
        	OrgTree.save();
        });
	    $('#orgtree_insert').bind('click',function(){
	    	OrgTree.insert();
	    });
	    $('#orgtree_insertSub').bind('click',function(){
	    	OrgTree.insertSub();
	    });
	    $('#orgtree_del').bind('click',function(){
	    	OrgTree.del();
	    });

		orgtree.formvaliad(); //form表单校验
	});
</script>

</body>
</html>