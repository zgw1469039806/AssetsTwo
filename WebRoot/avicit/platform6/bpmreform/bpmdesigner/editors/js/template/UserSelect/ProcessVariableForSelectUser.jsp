<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

</head>
<body class=" easyui-layout" fit="true">
	<table id="jqGrid"></table>
	<%--<div class="pull-right">
     	 <button name="chooseVarButtion" type="button" class="btn btn-default form-tool-btn btn-sm " disabled="disabled">确定</button>
     </div>--%>
	<br>
	<form>
		<fieldset>
			<div class="form-group">
				<label for="dataType" style="font-size: 14px;color:#525252;">&nbsp;&nbsp;&nbsp;&nbsp;数据维度</label>
				<select class="form-control" id="dataType" deptPositionId="" deptPositionName="" onchange="changeDataType(this)">
					<option value="user">用户</option>
					<option value="dept">部门</option>
					<option value="role">角色</option>
					<option value="position">岗位</option>
					<option value="group">群组</option>
				</select>
			</div>
		</fieldset>
	</form>
</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
<script>
    var jq;
	$(function() {
		$("#dataType").attr("deptPositionId","");
		$("#dataType").attr("deptPositionName","");
		/*var index = parent.layer.getFrameIndex(window.name); //获取窗口索引*/
		var processId = flowUtils.getUrlQuery("processId");
		/*var pid = flowUtils.getUrlQuery("pid");
		var pname = flowUtils.getUrlQuery("pname");*/
		var dataGridColModel = [ {
			label : '变量名称',
			name : 'alias',
			key :true,
			width : 150
		}, {
			label : '变量',
			name : 'name',
			width : 150
		},
		 {
			label : '初始值',
			name : 'initExpr',
			width : 150
		},
		 {
			label : '变量类型',
			name : 'type',
			width : 150
		},
		 {
			label : '描述',
			name : 'desc',
			width : 150
		}
		];

		jq = $('#jqGrid').jqGrid({
			//url : url,
			//mtype : 'POST',
			datatype : "local",
			colModel : dataGridColModel,
			height : $(window).height() - 120,
			scrollOffset : 20, //设置垂直滚动条宽度
			altRows : true,
			userDataOnFooter : true,
			loadonce : true,
			viewrecords : true,
			styleUI : 'Bootstrap',
			viewrecords : true,
			autowidth : true,
			responsive : true,//开启自适应
			multiboxonly : false,
			multiselect : false,
			onSelectAll : false,
			onSelectRow:function(id){
				$("button[name='chooseVarButtion']").removeAttr("disabled");
			},
			gridComplete : function() {
				/*  if (dataVal) {
					var pos = dataVal.split(';');
					for ( var o = 0; o < pos.length; o++) {
						var id = pos[o];
						$(this).jqGrid("setSelection", id);
					}
				}  */
			}
		});
		if(processId) {
		/* 	{"alias":"123","name":"123","initExpr":"1432","type":"string","desc":"4324"} */
			var i = 1;
			 parent.parent.$("#"+processId +" table[name='table-flow-variable']").find("input[name='dataValue']").each(function(){
				 jq.addRowData(i,JSON.parse($(this).val()));
				 i++;
			});

			 var globalformid = parent.parent.$('#' + processId).find('#guan_lian_biao_dan').val();
			 getFormFields(globalformid,jq,i);
		}

		/*$("button[name='chooseVarButtion']").on('click',function(){
			var name = getJqGridRowValue(jq, "name");
	    	var alias = getJqGridRowValue(jq, "alias");
			parent.addVariableNodeInfoUserSelectView(pid,pname,alias,alias);
			parent.layer.close(index);
		});*/
	});

	function setPosition(deptPositionId,deptPositionName){
		$("#dataType").attr("deptPositionId",deptPositionId);
		$("#dataType").attr("deptPositionName",deptPositionName);
	}

	function changeDataType(obj){
		if($(obj).val()=='dept'){
			layer.open({
				type:  2,
				area: [ "400px",  "300px"],
				title: "请选择岗位",
				skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
				shade:   0.3,
				maxmin: false, //开启最大化最小化按钮
				content: "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect/deptSelectTreeForVariable.jsp",
				btn: ['确定', '关闭'],
				yes: function(index, layero){
					var iframeWin = layero.find('iframe')[0].contentWindow;
					iframeWin.getSelectNode();
				},
				cancel: function(index){
				},
				success: function(layero, index){
				}
			});
		}
	}

	function getJqGridRowValue(code) {
	    var jqgrid = jq;
		var KeyValue = "";
		var selectedRowIds = jqgrid.getGridParam("selarrrow");
		if (selectedRowIds != "") {
			var len = selectedRowIds.length;
			for ( var i = 0; i < len; i++) {
				var rowData = jqgrid.getRowData(selectedRowIds[i]);
				KeyValue += rowData[code] + ";";
			}
			KeyValue = KeyValue.substr(0, KeyValue.length - 1);
		} else {
			var rowData = jqgrid.getRowData(
					jqgrid.getGridParam("selrow"));
			KeyValue = rowData[code];
		}
		return KeyValue;
	};

	function getFormFields(globalformid,jq,j){

		avicAjax.ajax({
            url: "bpm/designer/getProcessFormFieldsForVar",
            data:{
            	globalformid:globalformid,
            	isVar:'1'
            },
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData.fields == '') {

                } else {
                    var formFields = JSON.parse(backData.fields);
                    for (var i = 0; i < formFields.length; i++) {
                        var varType = "";
                        if('VARCHAR2'==formFields[i].colType || 'VARCHAR'==formFields[i].colType
                                || 'LVARCHAR'==formFields[i].colType
                                || 'CLOB'==formFields[i].colType || 'LONGTEXT'==formFields[i].colType
                                || 'TEXT'==formFields[i].colType){
                        	varType = "string";
                        }else if('NUMBER'==formFields[i].colType || 'DECIMAL'==formFields[i].colType){
                        	varType = "double";
                        }else if('DATE'==formFields[i].colType || 'TIMESTAMP'==formFields[i].colType
                                || 'DATETIME'==formFields[i].colType || 'DATETIME2'==formFields[i].colType){
                        	varType = "date";
                        }else if('BLOB'==formFields[i].colType || 'BYTE'==formFields[i].colType
                                || 'LONGBLOB'==formFields[i].colType){
                        	varType = "byte[]";
                        }
                    	var dataRow = {
                    			alias:formFields[i].colLabel,
            					name:formFields[i].colName,
            					type: varType,
            					initExpr:formFields[i].defaultValue,
            					desc:formFields[i].remark};
                    	jq.addRowData(j,dataRow);
                    	j++;
                    }
                }
            }
		});
	}

</script>
</body>
</html>
