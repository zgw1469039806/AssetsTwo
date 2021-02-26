<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form,tree";
%>
<!DOCTYPE html>
<HTML>
<head>
<title>${diggername}-设计</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
<style type="text/css">
    a{
        color : #555;
    }

    .img-delete {
         position: absolute;
         top: 0px;
         right: 0px;
         dispaly: inline-block;
         z-index: 2;
         font-size: 15px;
         width: 20px;
         height: 20px;
         background-color: #ffffff;
         text-align: center;
         opacity:0.7
     }
    .img-delete:hover{
        cursor: pointer;
        opacity:0.9;
    }
    .nav>li>a {
        position: relative;
        display: block;
        padding: 5px 5px;
    }
    .navbar {
        position: relative;
        min-height: 50px;
        margin-bottom: 1px;
        border: 1px solid transparent;
    }
</style>
<script type="text/javascript">
	var uid='${uid}';
</script>
</head>
<body class="easyui-layout" fit="true">
    <div id="navbar" class="navbar ace-save-state" style="background-color:#FFF;">
    		<div class="navbar-header pull-left" style="padding-top:10px;padding-left:10px;">
                    <h4 id="formName">报表模型库/${diggerType}${diggerComponentName}/${diggername}</h4>
            </div>
            <div class="navbar-buttons navbar-header pull-right" style="padding-top:5px;">
                <div class="navbar-form navbar-left">
                    <span style="color: #2fae95;">
						<i class="icon iconfont icon-Preservation" style="font-size:23px;cursor: pointer;" id="saveBut" title="保存"></i>
					</span>
					<span style="border-left: 1px solid #B5B5B5;padding-bottom: 0px;padding-top: 7px;padding-left:5px;"></span>
					<span style="color: #B5B5B5;">
                   		 <i class="icon iconfont icon-preview" style="font-size:23px;cursor: pointer;"  id="preview" title="预览" ></i>
                	</span>

                </div>
            </div>
    </div>
	<div style="margin:1px 10px">
		<ul class="nav nav-tabs" role="tablist" id="nav-tabs" >
			<li role="presentation" class="active"><a href="#diggerBaseInfo" aria-controls="diggerBaseInfo" role="tab" data-toggle="tab" style="font-size: 12px">基本信息</a></li>
			<li role="presentation"><a href="#diggerDatasource" onclick="datasource_refresh()" aria-controls="diggerDatasource" role="tab" data-toggle="tab" style="font-size: 12px">数据源</a></li>
			<li role="presentation"><a href="#diggerToolbar"   aria-controls="diggerToolbar" role="tab" data-toggle="tab" style="font-size: 12px; display: none;">工具条</a></li>
			<li role="presentation"><a href="#mutilTableHeader" onclick="mutilTableHeader_refresh()"  aria-controls="diggerToolbar" role="tab" data-toggle="tab" style="font-size: 12px;">多级表头</a></li>
			<li role="presentation"><a href="#diggerQuery" onclick="queryConfig_refresh()" aria-controls="diggerQuery" role="tab" data-toggle="tab" style="font-size: 12px">查询器</a></li>
			<li role="presentation"><a href="#diggerJavaEvent" aria-controls="diggerJavaEvent" role="tab" data-toggle="tab" style="font-size: 12px;display: none;">java程序</a></li>
		</ul>
		<div class="tab-content">
			<%--基本信息 --%>
			<div role="tabpanel" class="tab-pane active" id="diggerBaseInfo">
				<div data-options="region:'center',split:true,border:false">
					<form id='baseinfoForm' enctype="multipart/form-data" style="margin-top: 20px">
					    <input type='hidden' name='id' id='id' value='${id}' />
                        <input type='hidden' name='diggerType' id='diggerType' value='${diggerType}'/>
						<table class="form_commonTable">
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="diggername">名称:</label></th>
								<td width="39%">
									<input title="" class="form-control input-sm" type="text" name="diggername" id="diggername" value='<c:out  value='${diggerInfo.diggername}'/>'/>
								</td>
                                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="diggercode">编码:</label></th>
                                <td width="39%">
                                    <input title="" class="form-control input-sm" type="text" name="diggercode" id="diggercode" value='<c:out  value='${diggerInfo.diggercode}'/>'/>
                                </td>
							</tr>
							<tr style="height:48px;display:none;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="componentType">模型分类:</label></th>
								<td width="39%" >
									<input title="" class="form-control input-sm" type="text" name="componentType" id="componentType" value=''/>
								</td>
								<th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="master">模型管理员:</label></th>
								<td width="38%">
									<input title="" class="form-control input-sm" type="text" name="master" id="master" value='<c:out  value='${diggerInfo.master}'/>'/>
								</td>
							</tr>
							<tr style="height:48px;">
                               <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="conditionCol">条件区每行列数:</label></th>
                               <td width="39%" >
                                   <select id='conditionCol' name='conditionCol' class='form-control input-sm'>
                                       <option value='2' select>2列</option>
                                       <option value='3'>3列</option>
                                       <option value='4'>4列</option>
                                   </select>
                               </td>
                               <th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="autoExec">是否自动执行结果:</label></th>
                               <td width="38%" colspan="3">
                                  <input type='radio' name='autoExec' value='1'>是</input>&nbsp;
                                  <input type='radio' name='autoExec' value='0' checked>否</input>
                               </td>
                            </tr>

                            <tr style="height:48px;">
                                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="diggerDesc">描述:</label></th>
                                <td width="39%" colspan='3'>
                                    <textarea style='width:100%;' id='diggerDesc' name='diggerDesc'><c:out  value='${diggerInfo.diggerDesc}'/></textarea>
                                </td>
                            </tr>
						</table>
					</form>
				</div>
			</div>
			<%--基本信息 end--%>
			<%--数据源--%>
			<div role="tabpanel" class="tab-pane" id="diggerDatasource">
				<div data-options="region:'center',split:true,border:false;">
                    <iframe id="diggerDatasourceConfigFrame" name="diggerDatasourceConfigFrame" frameborder="0" src="" style="width: 100%; overflow: hidden;"></iframe>
				</div>
			</div>
            <%--数据源 end--%>
			<%--多级表头--%>
			<div role="tabpanel" class="tab-pane" id="mutilTableHeader">
				<div data-options="region:'center',split:true,border:false">
					<iframe id="mutilTableHeaderConfigFrame" name="mutilTableHeaderConfigFrame" frameborder="0" src="" style="width: 100%;overflow: hidden;"></iframe>
				</div>
			</div>
				<%--数据源 end--%>
			<%--工具条--%>

			<%--工具条 end--%>
			<%--查询器--%>
            <div role="tabpanel" class="tab-pane" id="diggerQuery">
                <iframe id="diggerQueryConfigFrame" name="diggerQueryConfigFrame" frameborder="0" src="" style="width: 100%;overflow: hidden;"></iframe>
            </div>
            <%--查询器 end--%>
            <%--java程序 --%>

            <%--java程序 end--%>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
	<script src="avicit/platform6/digger/design/js/DiggerFormInfo.js"></script>
	<script type="text/javascript">
		var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	    var diggerFormInfo = new DiggerFormInfo("formArea", "formInfoDiv");
		var isAdmin ='${isAdmin}';
        var maxSize = '${maxSize}';
		var viewScopeType='';
		if(isAdmin=="true"){
			viewScopeType = '';
		}else{
			viewScopeType = 'allowAcross';
		}
		var graphictype = '<c:out  value='${diggerInfo.graphictype}'/>'//图形类型
		var conditionCol = '<c:out  value='${diggerInfo.conditionCol}'/>'//图形类型
		var autoExec = '<c:out  value='${diggerInfo.autoExec}'/>'//是否自动执行结果
		var isdiycond = '<c:out  value='${diggerInfo.isdiycond}'/>'//提供用户自定义查询
		$(function() {
            $("#conditionCol ").get(0).value = conditionCol;
            $(":radio[name='autoExec'][value='" + autoExec + "']").prop("checked", "checked");
            $(":radio[name='isdiycond'][value='" + isdiycond + "']").prop("checked", "checked");
           //保存事件
            diggerFormInfo.formValidate($('#baseinfoForm'));//添加较验

            $('#saveBut').click(function(){//保存按钮事件
			   var tabLength = $('#nav-tabs').children("li").length;
			   var tabName;
			   for(var i = 0 ; i < tabLength ; i++){
				   if ($("#nav-tabs").children('li')[i].className == "active") {
					   tabName = $("#nav-tabs").children('li')[i].innerText
					   break;
				   }
			   }
			   if(tabName == '基本信息'){
				   diggerFormInfo.baseInfoSave($("#baseinfoForm"));//保存基本信息
			   } else if(tabName == '数据源'){
				   //保存数据源配置
				   document.getElementById('diggerDatasourceConfigFrame').contentWindow.datasourceSave();
			   } else if(tabName == '查询器'){
				   //保存查询器配置
				   document.getElementById('diggerQueryConfigFrame').contentWindow.saveQuery();
			   } else if(tabName == '多级表头'){
				   //保存查询器配置
				   document.getElementById('mutilTableHeaderConfigFrame').contentWindow.saveMutilTableHeader();
			   } else if(tabName == ''){

			   }
           });

			$('#preview').click(function() {//预览按钮事件
				var diggerId = $("#baseinfoForm").find("#id").val();
				window.open(baseUrl + "platform/digger/diggerExecuteController/preview/" + diggerId, "_blank");
			});
			setHeight();//设置iframe主度
		});

		function setValue(e){
            var v = $(e.target).val();
            var rowid = $("#diggerColumnGrid").jqGrid("getGridParam","selrow");
            $("#diggerColumnGrid").jqGrid('setCell',rowid , 'roleCode' ,v + '-a');
         }


          function getFormId(){
               return $('#datasourceFormId').val();
          }
          // 重新加载diggerDatasourceConfigFrame
        function datasource_refresh(){
            document.getElementById('diggerDatasourceConfigFrame').src = 'digger/diggerManageController/getDatasourceConfig?diggerId=<c:out value="${diggerInfo.id}" />';
        }
        // 重新加载diggerQueryConfigFrame
        function queryConfig_refresh(){
            document.getElementById('diggerQueryConfigFrame').src = 'digger/diggerManageController/getQueryConfig?diggerId=<c:out value="${diggerInfo.id}" />';
        }
        function mutilTableHeader_refresh(){
            document.getElementById('mutilTableHeaderConfigFrame').src = 'digger/diggerManageController/getMutilTableHeaderConfig?diggerId=<c:out value="${diggerInfo.id}" />';
        }
	</script>
</body>
</html>