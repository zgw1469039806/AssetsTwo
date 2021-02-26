<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8">
	 $.extend($.fn.datagrid.methods, {
	
	    autoMergeCells: function (jq, fields) {
	
	        return jq.each(function () {
	
	            var target = $(this);
	
	            if (!fields) {
	
	                fields = target.datagrid("getColumnFields");
	            }
	
	            var rows = target.datagrid("getRows");
	
	            var i = 0,
	            j = 0,
	
	            temp = {};
	
	            for (i; i < rows.length; i++) {
	
	                var row = rows[i];
	
	                j = 0;
	
	                for (j; j < fields.length; j++) {
	
	                    var field = fields[j];
	
	                    var tf = temp[field];
	
	                    if (!tf) {
	
	                        tf = temp[field] = {};
	
	                        tf[row[field]] = [i];
	
	                    } else {
	
	                        var tfv = tf[row[field]];
	
	                        if (tfv) {
	
	                            tfv.push(i);
	
	                        } else {
	
	                            tfv = tf[row[field]] = [i];
	
	                        }
	
	                    }                }
	
	            }
	
	            $.each(temp, function (field, colunm) {
	
	                $.each(colunm, function () {
	
	                    var group = this;
	
	 
	
	                    if (group.length > 1) {
	
	                        var before,
	
	                        after,
	
	                        megerIndex = group[0];
	
	                        for (var i = 0; i < group.length; i++) {
	
	                            before = group[i];
	
	                            after = group[i + 1];
	
	                            if (after && (after - before) == 1) {
	
	                                continue;
	
	                            }
	
	                            var rowspan = before - megerIndex + 1;
	
	                            if (rowspan > 1) {
	
	                                target.datagrid('mergeCells', {
	
	                                    index: megerIndex,
	
	                                    field: field,
	
	                                    rowspan: rowspan
	
	                                });
	
	                            }
	
	                            if (after && (after - before) != 1) {
	
	                                megerIndex = after;
	
	                            }
	
	                        }
	
	                    }
	
	                });
	
	            });
	
	        });
	
	    }
	
	});
	
	
	function mergesRow(data){
		var sysmenurows = data.rows;
		
		for(var i=0; i<sysmenurows.length; i++){
		
			
			$('#showPermisstionDataGrid').datagrid('autoMergeCells',['name', 'sencondName','thirdName']); 
		}

		   
	} 
</script>

</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;">


<table id="showPermisstionDataGrid" class="easyui-datagrid" datapermission='showpermisstion'
							data-options=" 
								fit: true,
								border: false,
								animate: true,
								rownumbers: true,
								collapsible: false,
								fitColumns: true,
								autoRowHeight: false,
								onLoadSuccess: mergesRow,
								singleSelect: true,
								selectOnCheck: false,
								striped:true,
								url:'platform/ShowPermissController/findUserResources.json?userId=${userId}'
								">
							<thead>
								<tr>
									<th data-options="field:'name',required:true,align:'center'" editor="{type:'text'}" width="220">一级级菜单</th>
									
									<th data-options="field:'sencondName',required:true,align:'center'" editor="{type:'text'}" width="220">二级菜单</th>
									
									<th data-options="field:'thirdName',required:true,align:'center'" editor="{type:'text'}" width="200">三级菜单</th>
									
									<th data-options="field:'fourthName',align:'center',align:'center'" editor="{type:'text'}"  width="100">四级菜单</th>
									
								</tr>
							</thead>
					</table>
</div>

</body>
</html>