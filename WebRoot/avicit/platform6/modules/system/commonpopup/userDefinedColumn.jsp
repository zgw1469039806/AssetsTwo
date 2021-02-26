<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自定义显示列</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>

<script type="text/javascript">
	var tableId = '${param.tableId}';
	
	//页面加载完成的标志位
    var initFlag = false;
    
	//页面变化的列的数组
    var arrayColumnChangeIndexArray = new Array();
	
	//实现编辑事件
	$.extend($.fn.datagrid.methods, {
		editCell : function(jq, param) {
			return jq.each(function() {
				var fields = $(this).datagrid('getColumnFields', true).concat(
						$(this).datagrid('getColumnFields'));
				for ( var i = 0; i < fields.length; i++) {
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor1 = col.editor;
					if (fields[i] != param.field) {
						col.editor = null;
					}
				}
				$(this).datagrid('beginEdit', param.index);
				for ( var i = 0; i < fields.length; i++) {
					var col = $(this).datagrid('getColumnOption', fields[i]);
					col.editor = col.editor1;
				}
			});
		}
	});

	//结束编辑
	var editIndex = undefined;
	function endEditing() {
		if (editIndex == undefined) {
			return true;
		}
		if ($('#dg').datagrid('validateRow', editIndex)) {
			$('#dg').datagrid('endEdit', editIndex);
			editIndex = undefined;
			return true;
		} else {
			return false;
		}
	}
	
	//编辑单元格
	function onClickCell(index, field, value) {
		if (endEditing()) {
			$('#dg').datagrid('selectRow', index).datagrid('editCell', {
				index : index,
				field : field
			});
			editIndex = index;
			arrayColumnChangeIndexArray.myDistinct(index);
		}
	}
	
	// 取消选中事件
	function onUncheck(rowIndex,rowData){
		if(initFlag){
			arrayColumnChangeIndexArray.myDistinct(rowIndex);
		}
	}
	
	// 选中事件
	function onCheck(rowIndex,rowData){
		if(initFlag){
			arrayColumnChangeIndexArray.myDistinct(rowIndex);
		}
	}
	
	/**
	 * 数组去重
	 */
	Array.prototype.myDistinct = function(value) {
		var count = 0;
		for ( var i = 0; i < this.length; i++) {
			if (value == this[i]) {
				count++;
				break;
			}
		}
		if (count == 0 || this.length == 0) {
			this.push(value);
		}
	}

	/**
	 * 确定操作
	 */
	function saveVisableColumn() {
		endEditing();
		var rows = $('#dg').datagrid('getRows');
		var columnArray = new Array();
		//for (var i = 0; i < arrayColumnChangeIndexArray.length; i++) {
		for ( var i = 0; i < rows.length; i++) {

			var row=rows[i];
			var id = row.ID;
			var columnShow = true;
			if (isUnChecked(id)) {
				columnShow = false;
			}

			var rowIndex = $("#dg").datagrid('getRowIndex', row);
			var column = {
				columnField : id,
				columnShow : columnShow,
				columnWidth : row.COLUMNWIDTH,
				innerOrder : rowIndex//rows[i].attribute01
			};
			columnArray[i] = column;
		}
		parent.editTable(columnArray, tableId);
		closeDiag();
	}

	/**
	 * 列是否选中
	 */
	function isUnChecked(ID) {
		var isUnChecked = true;
		var checkeds = $('#dg').datagrid('getChecked');
		for ( var i = 0; i < checkeds.length; i++) {
			if (ID == checkeds[i].ID) {
				isUnChecked = false;
				break;
			}
		}
		return isUnChecked;
	}

	/**
	 * 关闭页面
	 */
	function closeDiag() {
		parent.$("#userDefineColumnDialog").dialog('close');
	}
	
	/**
	 * 删除当前表格配置
	 */
	function deleteColumnProfile() {
		parent.deleteUserdefinedColumnInfo(tableId);
	}
	
	//页面加载数据前
	function onBeforeLoad(param){
		var userDefineColumnFieldsOptions = parent.userDefineColumnFieldsOptions;
		if (null != userDefineColumnFieldsOptions && userDefineColumnFieldsOptions.length > 0) {
			for (var i = 0; i < userDefineColumnFieldsOptions.length ; i++) {
				var columnOptions = userDefineColumnFieldsOptions[i];
				if (columnOptions.field != 'ID' && columnOptions.field != 'id' && columnOptions.field != 'VERSION' && columnOptions.field != 'version') {
					var field = columnOptions.field;
					var title = columnOptions.title;
					var width = columnOptions.width;
					var innerOrder = columnOptions.innerOrder || i;

					var hidden = false;
					if (columnOptions.hidden) {
						hidden = columnOptions.hidden;
					}

					if (title && field) {
						try{
							$('#dg').datagrid('appendRow', {
								ID : field,
								COLUMNNAME : title,
								COLUMNWIDTH : width,
								attribute01 : i
							});
						}catch(err) {
							
						}
						if (hidden == false) {
							var index = $('#dg').datagrid('getRowIndex', field);
							$('#dg').datagrid('checkRow', index);
						}
					}
				}
			}
			unSelectAll();
		}
		$(".datagrid-header-row .datagrid-header-check").html('<span style="color:#494949;font-weight: bold;font-size:12px;">可见</span>');
		initFlag = true;
		$("#dg").datagrid("options").fitColumns = true;
		$('#dg').datagrid('fitColumns');
	}
	//移动

	function formateRemove(value, row, index) {
		return '<a href="javascript:void(0);" onclick="removeUp(\'' + index + '\');">向上</a> | ' + '<a href="javascript:void(0);" onclick="removeDown(\'' + index + '\');">向下</a>';
	}
	//向上移动
	function removeUp(index) {
		if (!isMoveRow(index, -1)) {
			return false;
		}
		unSelectAll();
		$("#dg").datagrid('selectRow', index);
		var row = $("#dg").datagrid('getSelected');
		var indexUp = $("#dg").datagrid('getRowIndex', row);
		mysort(indexUp, 'up', 'dg');
	};
	//向下移动
	function removeDown(index) {
		if (!isMoveRow(index, 1)) {
			return false;
		}
		unSelectAll();
		$("#dg").datagrid('selectRow', index);
		var row = $("#dg").datagrid('getSelected');
		var indexDown = $("#dg").datagrid('getRowIndex', row);
		mysort(indexDown, 'down', 'dg');
	};
	//判断是否能移动
	function isMoveRow(index, isMoveRow) {
		var i = parseInt(index) + parseInt(isMoveRow);
		var rows = $('#dg').datagrid("getRows");
		var row = rows[index];
		if (i < 0) {
			$.messager.alert("提示", "不能向上移动！", "warning");
			return false;
		}
		if (i >= rows.length) {
			$.messager.alert("提示", "不能向下移动！", "warning");
			return false;
		}

		return true;
	}
	//移动数据,刷新index
	function mysort(index, type, gridname) {
		if ("up" == type) {
			if (index != 0) {
				var toup = $('#' + gridname).datagrid('getData').rows[index];
				var toupIsChecked= isChecked(toup);
				var todown = $('#' + gridname).datagrid('getData').rows[index - 1];

				var todownIsChecked= isChecked(todown);

				$('#' + gridname).datagrid('getData').rows[index] = todown;
				$('#' + gridname).datagrid('getData').rows[index - 1] = toup;

				if (todownIsChecked=="Y"){

					$('#dg').datagrid('checkRow', index);
				}else {

					$('#dg').datagrid('uncheckRow', index);
				}

				if (toupIsChecked=="Y"){

					$('#dg').datagrid('checkRow', index-1);
				}else {

					$('#dg').datagrid('uncheckRow', index-1);
				}

				$('#' + gridname).datagrid('refreshRow', index);
				$('#' + gridname).datagrid('refreshRow', index - 1);
				$('#' + gridname).datagrid('selectRow', index - 1);
			}
		} else if ("down" == type) {
			var rows = $('#' + gridname).datagrid('getRows').length;
			if (index != rows - 1) {
				var todown = $('#' + gridname).datagrid('getData').rows[index];
				var todownIsChecked= isChecked(todown);
				var toup = $('#' + gridname).datagrid('getData').rows[index + 1];
				var toupIsChecked= isChecked(toup);

				$('#' + gridname).datagrid('getData').rows[index + 1] = todown;
				$('#' + gridname).datagrid('getData').rows[index] = toup;

				if (todownIsChecked=="Y"){

					$('#dg').datagrid('checkRow', index+ 1);
				}else {

					$('#dg').datagrid('uncheckRow', index+ 1);
				}

				if (toupIsChecked=="Y"){

					$('#dg').datagrid('checkRow', index);
				}else {

					$('#dg').datagrid('uncheckRow', index);
				}
				$('#' + gridname).datagrid('refreshRow', index);
				$('#' + gridname).datagrid('refreshRow', index + 1);
				$('#' + gridname).datagrid('selectRow', index + 1);
			}
		}

		unSelectAll();
	}
	//取消选中状态
	function unSelectAll() {
		$("#dg").datagrid('unselectAll').datagrid('clearSelections');
	}


	function isChecked(row) { //参数为你要判断的行
		var result = "N";
		var allRows = $("#dg").datagrid('getChecked'); //获取所有被选中的行
		$.each(allRows, function(i, n) {

			if (row.ID == n.ID) { //id为一个列的属性，任意列都可以
				result="Y";
				return false;
			}
		});
		return result;
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" border="false">
		<table id="dg" class="easyui-datagrid"
			data-options="rownumbers: true,
						  animate: true,
						  collapsible: false,
						  fitColumns: false,
						  autoRowHeight: false,
						  fit : false,
						  striped:true,
						  scrollbarSize: 0 ,
						  idField:'ID',
						  url:'',
						  onClickCell:onClickCell,
						  checkOnSelect:false,
						  onUncheck:onUncheck,
						  onCheck:onCheck,
						  onBeforeLoad:onBeforeLoad">
			<thead>
				<tr>
					<th data-options="field:'COLUMNNAME', align:'center'" width="100px">列名</th>
					<th data-options="field:'ID', align:'center',checkbox:true">可见</th>
					<th data-options="field:'COLUMNWIDTH', align:'center'" width="100px"
						editor="{type:'numberbox',options:{required:true }}">宽度</th>
					<th
						data-options="field:'btnCellRemove', align:'center',formatter:formateRemove"
						width="80">移动</th>
				</tr>
			</thead>
		</table>
	</div>
	<div region="south" border="false" style="height:40px;">
		<div class="datagrid-toolbar datagrid-toolbar-extend foot-formopera" style="height: auto; display: block;">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
						<a id="deleteProfileBtn" class="easyui-linkbutton" onclick="deleteColumnProfile();" href="javascript:void(0);">删除当前表格的配置</a>
						<a id="saveVisableColumnBtn" class="easyui-linkbutton primary-btn" onclick="saveVisableColumn();" href="javascript:void(0);">确定</a>
						<a class="easyui-linkbutton" onclick="closeDiag();" href="javascript:void(0);">返回</a>
                    </td>
                </tr>
			</table>
		</div>
	</div>

</body>
</html>