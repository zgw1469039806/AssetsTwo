<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>导出</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='exportForm'>
        <input title="模块Id" class="form-control input-sm" type="hidden" style="width: 99%;"
               name="componentId" id="componentId" value="${componentId}"/>
        <table class="form_commonTable">
            <tr>

                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentName">模块名称：</label>
                </th>
                <td width="85%" colspan="3">
                    <input title="模块名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="componentName" id="componentName" value=""/>
                </td>
            </tr>
            <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="moduleName">包名称：</label>
                </th>
                <td width="35%">
                    <input title="包名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="moduleName" id="moduleName" value=""/>
                </td>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentName">包路径：</label>
                </th>
                <td width="35%">
                    <input title="包路径" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="packagePath" id="packagePath" value=""/>
                </td>
            </tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm btn-point" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="closeForm">取消</a>
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
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");
        parent.eformComponent.formValidate($('#exportForm'));
        
        $('#saveForm').bind('click', function () {
        	 regEn = /[`~!@#$%^&*()+<>?:{},._\/;'[\]]/im;
        	 regEn1 = /[`~!@#$%^&*()+<>?:{},_\/;'[\]]/im;
        	 regEn2 = /[`~!@#$%^&*()+<>?:{},.\/;'[\]]/im;
             regCn = /[·！#￥（——）：；“”‘、，|《。》？、【】[\]]/im;
             regCh = /[\u4E00-\u9FA5]|[\uFE30-\uFFA0]/gi;
             var componentName = $('#componentName').val();
             var packagePath = $('#packagePath').val();
             var moduleName = $('#moduleName').val();
	         if(regEn2.test(componentName) || regCn.test(componentName)){ //||regCh.test(componentName)
	        	 layer.msg('模块名称不能含有特殊字符', {icon: 7});
	             return false;
	        }	
	         if(regEn.test(moduleName) || regCn.test(moduleName) ||regCh.test(moduleName)) {
	             layer.msg('包名称不能含有特殊字符或中文', {icon: 7});
	             return false;
	        }
	        if(regEn1.test(packagePath) || regCn.test(packagePath) ||regCh.test(packagePath)){
	        	layer.msg('包路径不能含有特殊字符或中文', {icon: 7});
	             return false;
	        }
	        
            parent.eformComponent.subExport($("#exportForm"));
        });
        $('#closeForm').bind('click', function () {
            parent.eformComponent.closeDialog("export");
        }); 
    };
</script>
</body>
</html>
