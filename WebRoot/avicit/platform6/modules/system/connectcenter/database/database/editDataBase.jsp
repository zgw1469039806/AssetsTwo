<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='editForm'>
        <input type="hidden" id="classId" name="classId" value="${dataBase.classId}">
        <table class="form_commonTable">
        	<fieldset>
        		<legend style="text-align: center;">基本信息</legend>
				<tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="id">标识：</label>
	                </th>
	                <td width="35%">
	                    <input title="标识" class="form-control input-sm" type="text" style="border-style:none;border:0px;width: 99%;font-weight:bold;font-style:italic;" type="text"
	                           name="id" id="id" value="${dataBase.id}" readonly="readonly"/>
	                </td>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
						&nbsp;
					</th>
					<td width="35%">
						&nbsp;
					</td>
	            </tr>
        		<tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="name">名称：</label>
	                </th>
	                <td width="35%">
	                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
	                           name="name" id="name" value="${dataBase.name}"/>
	                </td>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
						&nbsp;
					</th>
					<td width="35%">
						&nbsp;
					</td>
	            </tr>

	            <tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="userName">用户：</label>
	                </th>
	                <td width="35%">
	                    <input title="用户" class="form-control input-sm" type="text" style="width: 99%;" type="text"
	                           name="userName" id="userName" value="${dataBase.userName}"/>
	                </td>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="passWord">口令：</label>
	                </th>
	                <td width="35%">
	                    <input title="口令" class="form-control input-sm" type="password" style="width: 100%;" type="text"
	                           name="passWord" id="passWord" />
	                </td>
	            </tr>
	            <tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="driver">驱动：</label>
	                </th>
	                <td width="85%" colspan="3">
	                    <pt6:h5select css_class="form-control input-sm" name="driver" id="driver" title="" isNull="true" lookupCode="PLATFORM_DATASOURCE_DRIVER" defaultValue="${dataBase.driver}"/>
	                </td>
	            </tr>
	            <tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="urlValue">URL：</label>
	                </th>
	                <td width="85%" colspan="3">
	                    <input title="URL" class="form-control input-sm" type="text" style="width: 100%;" type="text"
	                           name="urlValue" id="urlValue" value="${dataBase.urlValue}"/>
	                </td>
	            </tr>
	            
        	</fieldset>
        </table>
    	<%-- <table class="form_commonTable">
    		<fieldset>
        		<legend style="text-align: center;">运行</legend>
        		<tr>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="initPollConnect">初始池连接：</label>
	                </th>
	                <td width="35%">
	                    <input title="初始池连接" class="form-control input-sm" type="text" style="width: 99%;" type="text"
	                           name="initPollConnect" id="initPollConnect" value="${dataBase.initPollConnect}"/>
	                </td>
	                <th width="15%" style="word-break: break-all; word-warp: break-word;">
	                    <label for="maxPollConnect">最大池连接：</label>
	                </th>
	                <td width="35%">
	                    <input title="最大池连接" class="form-control input-sm" type="text" style="width: 99%;" type="text"
	                           name="maxPollConnect" id="maxPollConnect" value="${dataBase.maxPollConnect}"/>
	                </td>
	            </tr>
        	</fieldset>
    	</table> --%>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="测试连接" id="testConnect">测试连接</a>
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	//驱动和URL联动
    	$('#driver').change(function(e){
    		getURL($('#driver').val());
        });
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");
        parent.dataBase.formValidate($('#editForm'));
        $('#saveForm').bind('click', function () {
            parent.dataBase.subEdit($("#editForm"));
        });
        $('#closeForm').bind('click', function () {
            parent.dataBase.closeDialog("edit");
        });
        $('#testConnect').bind('click', function () {
            parent.dataBase.testConnect($("#editForm"),$("#classId").val());
        });
        $('#passWord').val('${dataBase.passWord}');
        $('#userName').val('${dataBase.userName}');
    };
    function getURL(driver){
    	if(driver=="oracle.jdbc.driver.OracleDriver"){
    		$('#urlValue').val("jdbc:oracle:thin:@127.0.0.1:1521:orcl");
    	}else if(driver=="com.mysql.jdbc.Driver"){
    		$('#urlValue').val("jdbc:mysql://127.0.0.1:3306/dbname");
    	}else if(driver=="com.microsoft.sqlserver.jdbc.SQLServerDriver"){
    		$('#urlValue').val("jdbc:sqlserver://127.0.0.1:1433;DatabaseName=dbname");
    	}else if(driver=="com.ibm.db2.jcc.DB2Driver"){
    		$('#urlValue').val("jdbc:db2://127.0.0.1:50000/dbname:currentSchema=schemaName;");
    	}else if(driver=="dm.jdbc.driver.DmDriver"){
            $('#urlValue').val("jdbc:dm://127.0.0.1:5236");
        }else if(driver=="com.oscar.Driver"){
            $('#urlValue').val("jdbc:oscar://127.0.0.1:2003/OSRDB");
        }else if(driver=="com.kingbase8.Driver"){
            $('#urlValue').val("jdbc:kingbase8://127.0.0.1:54321/PT6");
        }else{
    		$('#urlValue').val("请输入...");
    	}
    }
</script>
</body>
</html>
