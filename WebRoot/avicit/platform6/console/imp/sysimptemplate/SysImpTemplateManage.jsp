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
<!-- ControllerPath = "platform6/msystem/imp/sysimptemplate/sysImpTemplateController/toSysImpTemplateManage" -->
<title>管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div class="easyui-layout" data-options="region:'center'">
		<div  id="centerDiv1" data-options="region:'center',onResize:function(a){$('#sysImpTemplatejqGrid').setGridWidth(a);$(window).trigger('resize');}">
			<div id="tableToolbar" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysImpTemplate_button_add"
						permissionDes="添加">
						<a id="sysImpTemplate_insert" href="javascript:;"
							class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
							title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysImpTemplate_button_edit"
						permissionDes="编辑">
						<a id="sysImpTemplate_modify" href="javascript:;"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="编辑"><i class="fa fa-file-text-o"></i> 编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysImpTemplate_button_delete"
						permissionDes="删除">
						<a id="sysImpTemplate_del" href="javascript:;"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
				</div>
				<div class="toolbar-right">
					<div class="input-group form-tool-search">
						<input type="text" name="sysImpTemplate_keyWord"
							id="sysImpTemplate_keyWord" style="width: 240px;"
							class="form-control input-sm" placeholder="请输入查询条件"> <label
							id="sysImpTemplate_searchPart"
							class="icon icon-search form-tool-searchicon"></label>
					</div>
				</div>
			</div>
			<table id="sysImpTemplatejqGrid"></table>
			<div id="jqGridPager"></div>
		</div>
		<div id="centerDiv2" data-options="region:'east',split:true,width:fixwidth(.3),onResize:function(a,b){$('#sysImpSheetTableResjqGrid').setGridWidth(a);$(window).trigger('resize');}" >
			<div id="sysImpSheetToolbar" class="toolbar" style="height: 43px;">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysImpSheetTableRes_button_add"
						permissionDes="初始化sheet页">
						<a id="sysImpTemplate_start" href="javascript:	;"
							class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
							title="初始化sheet页"><i class="fa fa-cogs"></i> 初始化sheet页</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysImpSheetTableRes_button_delete"
						permissionDes="删除">
						<a id="sysImpSheetTableRes_del" href="javascript:;"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_sysImpSheetTableRes_button_save"
						permissionDes="保存">
						<a id="sysImpSheetTableRessave" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="保存"><i class="fa fa-floppy-o"></i> 保存</a>
					</sec:accesscontrollist>
				</div>
			</div>
			<table id="sysImpSheetTableResjqGrid"></table>
			<div id="jqGridPager1"></div>
		</div>
	</div>
	<div data-options="region:'south',split:true,onResize:function(a,b){resizeSouth(a,b);}" style="height: 300px">
		<div id="sysImpColumnFiledToolbar" class="toolbar" style="height: 43px;">
			<div class="toolbar-left">
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysImpColumnFiledRes_button_init"
					permissionDes="初始化列">
					<a id="sysImpTemplatecolum_start" href="javascript:;"
						class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
						title="初始化列"><i class="fa fa-cogs"></i> 初始化列</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysImpColumnFiledRes_matching"
					permissionDes="自动匹配">
					<a id="sysImpcolumnAutoFind" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="自动匹配"><i class="fa fa-compress"></i> 自动匹配</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysImpColumnFiledRes_button_delete"
					permissionDes="删除">
					<a id="sysImpColumnFiledRes_del" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="删除"><i class="fa fa-trash-o"></i> 删除</a>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3"
					domainObject="formdialog_sysImpColumnFiledRes_save"
					permissionDes="保存">
					<a id="sysImpcolumnSave" href="javascript:void(0)"
						class="btn btn-primary form-tool-btn btn-sm" role="button"
						title="保存"><i class="fa fa-floppy-o"></i> 保存</a>
				</sec:accesscontrollist>
			</div>
		</div>
		<table id="sysImpColumnFiledResjqGrid"></table>
		<div id="jqGridPager2"></div>
	</div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">编码:</th>
				<td width="39%"><input title="编码" class="form-control input-sm"
					type="text" name="code" id="code" /></td>
				<th width="10%">名称:</th>
				<td width="39%"><input title="名称" class="form-control input-sm"
					type="text" name="name" id="name" /></td>
			</tr>
			<tr>
				<th width="10%">事务控制方式:</th>
				<td width="39%"><input
					title="事务控制方式"
					class="form-control input-sm" type="text" name="swfl" id="swfl" />
				</td>
				<th width="10%">描述:</th>
				<td width="39%"><input title="描述" class="form-control input-sm"
					type="text" name="bz" id="bz" /></td>
			</tr>
			<tr>
				<th width="10%">用户自定义处理类:</th>
				<td width="39%"><input title="用户自定义处理类"
					class="form-control input-sm" type="text" name="userClass"
					id="userClass" /></td>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script
	src="avicit/platform6/console/imp/sysimptemplate/js/SysImpTemplate.js"
	type="text/javascript"></script>
<script type="text/javascript">
	var sysImpTemplate = new Array();
	var mapListTableName = null;
	var checkTypeData = ${checkTypeData};
	var onlyOrNot = ${onlyOrNot};
	var selectData={};
	function formatValue(cellvalue, options, rowObject) {
		return '<a href="javascript:void(0);" onclick="sysImpTemplate.detail(\''
				+ rowObject.id + '\');">' + cellvalue + '</a>';
	}
	function formatDateForHref(cellvalue, options, rowObject) {
		var thisDate = format(cellvalue);
		return '<a href="javascript:void(0);" onclick="sysImpTemplate.detail(\''
				+ rowObject.id + '\');">' + thisDate + '</a>';
	}
	//根据之前选择显示
	function formatchoose(cellvalue, options, rowObject) {
		if (cellvalue == "1") {
			return "允许单条成功"
		} else if (cellvalue == "2") {
			return "允许单sheet页成功"
		} else {
			return "允许全部成功"
		}

	}
	//判断是否为空
	function formatterValueYN(cellvalue, options, rowObject) {
		if (cellvalue == "Y") {
			return "是"
		} else if (cellvalue == "N") {
			return "否"
		}else{
			return "";
		}
	}
	function unformatterValueYN(cellvalue, options, rowObject) {
		if (cellvalue == "是") {
			return "Y"
		} else if (cellvalue == "否") {
			return "N"
		}else{
			return "";
		}
	}
	
	//实现字段属性下拉菜单
	/*function customFmatter(cellvalue, options, rowObject) {
		var String1 = '<select class="'
				+ rowObject.id
				+ '" style="width:100%;border: solid 1px lightgray;border-radius:2px;"   onchange="getName(this)"><option value="请选择">请选择</option>';
		var str = "";
		var selectOption = " ";
		//保证有值
		if (null != mapListTableName && mapListTableName.length > 0) {
			for (i = 0; i < mapListTableName.length; i++) {
				//如果filed有值，则默认选中
				if (null != rowObject.field) {
					if (rowObject.field == mapListTableName[i].COLUMN_NAME) {
						selectOption = '<option value=' + mapListTableName[i].COLUMN_NAME +' '+ 'selected ="selected">'
								+ mapListTableName[i].COLUMN_NAME + '</option>';
					} else {
						str += '<option value='+mapListTableName[i].COLUMN_NAME+'>'
								+ mapListTableName[i].COLUMN_NAME + '</option>';
					}
				} else {
					str += '<option value='+mapListTableName[i].COLUMN_NAME+'>'
							+ mapListTableName[i].COLUMN_NAME + '</option>';
				};
			}
			var getName = [];
			for (i = 0; i < mapListTableName.length; i++) {
				getName.push(mapListTableName[i].COLUMN_NAME);
			}
			return String1 + str + selectOption + "</select>";
		}
	}
	*/
	
	//点击字段属性，实现其他字段联动输入
	function getName(rowId,getSlectedName) {
		for (i = 0; i < mapListTableName.length; i++) {
			if (mapListTableName[i].COLUMN_NAME == getSlectedName) {
				if(mapListTableName[i].DATA_TYPE=="NUMBER"){
					$("#sysImpColumnFiledResjqGrid").jqGrid('setRowData', rowId,
						{
							field : mapListTableName[i].COLUMN_NAME,
							fieldDesc : mapListTableName[i].COMMENTS,
							required : mapListTableName[i].NULLABLE=="Y"?"N":"Y",
							fieldtype:mapListTableName[i].DATA_TYPE,
							vcharlength :  mapListTableName[i].DATA_PRECISION,
							datascale : mapListTableName[i].DATA_SCALE
						});
				}else{
					$("#sysImpColumnFiledResjqGrid").jqGrid('setRowData',rowId, 
						{
							field : mapListTableName[i].COLUMN_NAME,
							fieldDesc : mapListTableName[i].COMMENTS,
							required : mapListTableName[i].NULLABLE=="Y"?"N":"Y",
							fieldtype:mapListTableName[i].DATA_TYPE,
							vcharlength : mapListTableName[i].DATA_LENGTH
						});
				}
			}
		}
	}

	function currencyElem(value, options) {
		var rowId = options.rowId;
		var rowData = $(this).jqGrid('getRowData', rowId);

		var $elem = $('<div class="input-group input-group-sm" style="margin:2px">'
				+ '<input type="hidden" id="cellRowId" value="'+ rowId +'">'
				+ '<input class="form-control" placeholder="请选择" type="text" id="cellCurrency" name="cellCurrency" readonly value="'+ value +'">'
				+ '<span class="input-group-addon">'
				+ '<i class="fa fa-search-plus"></i>' + '</span>' + '</div>');
		
		$elem.find('#cellCurrency, .input-group-addon').on('click',function() {
			layer.open({
				type : 2,
				area : [ '800px', '540px' ],
				title : '请选择数据表',
				skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
				shade : 0.3,
				maxmin : false, //开启最大化最小化按钮
				content : 'avicit/platform6/console/imp/sysimptemplate/SelectDataTable.jsp',
				btn : [ '确定', '关闭' ],
				yes : function(index, layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
					var $childrenBody = layer.getChildFrame('body',index);//子页面的body元素
					var $jqGridTable = $childrenBody.find("#testCurrencyjqGrid");

					//从子页面向主页面传递参数
					var id = $jqGridTable.jqGrid('getGridParam', 'selrow');
					if (id) {
						var data = $jqGridTable.jqGrid("getRowData", id);
						$elem.find("#cellCurrency").val(data['TABLE_NAME']);
						//$elem.parent().parent().parent().parent().parent().jqGrid('endEditCell');
						
					}
					layer.close(index);
				},
				cancel : function(index, layero) {
					layer.close(index);
				},
				success : function(layero, index) {
					var iframeWin = layero.find('iframe')[0].contentWindow;
					iframeWin.init({
						callbcak : function (data){
							$elem.find("#cellCurrency").val(data['TABLE_NAME']);
							layer.close(index);
						}
					});
				}
			});
		});

		return $elem;
	}

	function currencyValue(elem, operation, value) {
		if (operation === 'get') {
			return $(elem).find('#cellCurrency').val();
		} else if (operation === 'set') {
			$(elem).find('#cellCurrency').val(value);
		}
	}
	
	function saveSheet(){
		$("#sysImpSheetTableResjqGrid").jqGrid('endEditCell'); //关闭单元格编辑
		var ids = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
		var rowData = $("#sysImpSheetTableResjqGrid").jqGrid('getRowData',ids[0]);
		var obj = $("#sysImpSheetTableResjqGrid").jqGrid("getRowData");
		for(var i = 0; i< obj.length; i++){
		    if(obj[i].tableName == ""){
                layer.alert('表名称不能为空，请为Sheet页指定对应表！', {
                        icon: 0,
                        title :'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
                return;
			}
		}
		$.ajax({
			url : 'platform6/msystem/imp/sysimpsheettableres/sysImpSheetTableResController/operation/save',
			data : {
				data : JSON.stringify(obj)
			},
			type : 'POST',
			dataType : 'JSON',
			async : false,
			success : function(result) {
				if (result.flag == "success") {
					layer.msg('保存成功！');
				} else {
					layer.msg('数据保存失败！');
				}
			}
		});
	}
	
	function saveColumn(){
		$("#sysImpColumnFiledResjqGrid").jqGrid('endEditCell'); //关闭单元格编辑
		var ids = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
		var obj = $("#sysImpColumnFiledResjqGrid").jqGrid("getRowData");
        for (var i = 0; i < obj.length; i++) {
            var errorMsg = "";
            if(obj[i].field == ''){
                layer.alert("字段英文名不能为空，请选择对应字段！" , {
                        icon: 0,
                        title :'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
                return;
            }else if(obj[i].fieldtype == ''){
                layer.alert("字段类型不能为空，请选择对应类型！" , {
                        icon: 0,
                        title :'提示',
                        area: ['400px', ''], //宽高
                        closeBtn: 0
                    }
                );
                return;
            }

        }
		/*for (var i = 0; i < obj.length; i++) {
			if(obj[i].fieldtype.toUpperCase()=="NUMBER"&&obj[i].checkTypeName!=""){
				layer.alert('字段类型为NUMBER时，不需要配置校验格式！请检查第' + (i+1) + "行", {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				return false;
			}
		}*/

		$.ajax({
			url : 'platform6/msystem/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/operation/save',
			data : {
				data : JSON.stringify(obj)
			},
			type : 'POST',
			dataType : 'JSON',
			async : false,
			success : function(result) {
				if (result.flag == "success") {
					layer.msg('保存成功！');
					$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam',{
						datatype : 'json',
						postData : {
							'excelId' : ids[0]
						}
					}).trigger("reloadGrid");
				} else {
					layer.msg('数据保存失败！');
				}
			}
		});
	};
	
	function onSelectRowSheet() {
		$("#sysImpSheetTableResjqGrid").jqGrid('endEditCell');
		var type_id = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
		var rowData = $("#sysImpSheetTableResjqGrid").jqGrid('getRowData',type_id[0]);
		var tableName = rowData.tableName;
		if (tableName != undefined && tableName.length < 50) {
			$.ajax({
				type : 'POST',
				dataType : 'JSON',
				url : 'platform6/msystem/imp/sysimptemplate/sysImpTemplateController/operation/getchooseTableColumns',
				data : {
					'tableName' : tableName
				},
				success : function(r) {
					mapListTableName = r.mapList;
					selectData={};
					for(var i=0;i<mapListTableName.length;i++){
						var nameValue=mapListTableName[i].COLUMN_NAME;
						selectData[nameValue]=nameValue;
					}
					if(type_id.length>1){
						$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam', {datatype : 'json',postData : {'excelId' : "null"}}).trigger("reloadGrid");
					}else{
						$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam', {datatype : 'json',postData : {'excelId' : type_id[0]}}).trigger("reloadGrid");
					}
					
				}
			});
		} else {
			$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam', {datatype : 'json',postData : {'excelId' : "null"}}).trigger("reloadGrid");
		}
	};
	
	function selectElemName(value, options) {
		var rowId = options.rowId;
		var datas = selectData;
		var forId = options.forId;
		var rowData = $(this).jqGrid('getRowData', rowId);
		var gid = $(this).jqGrid("getGridParam","id");
		var elemHtml = [];
		elemHtml.push('<select onchange="$(\'#'+gid+'\').jqGrid(\'endEditCell\')" class="form-control">');
		elemHtml.push('<option value="">请选择</option>');
		for ( var code in datas) {
			if(options.dataModel && options.dataModel.model=="array_object"){
				elemHtml.push('<option value="'+ datas [code][options.dataModel.key] +'">' + datas[code] [options.dataModel.value] + '</option>');
			}else{
				elemHtml.push('<option value="'+ code +'">' + datas[code] + '</option>');
			}
		}
		elemHtml.push('</select>');

		var elem = $(elemHtml.join(''));
		elem.val(rowData[forId]);
		elem.attr('data-rowid', rowId);
		elem.attr('data-forid', forId);
		return elem[0];
	};

	function selectValueName(elem, operation, value) {
		if (operation === 'get') {
			var rowId = $(elem).attr('data-rowid');
			var forId = $(elem).attr('data-forid');
			var selectText = $(elem).find('option:selected').text();
			var rowData = {};
			rowData[forId] = $(elem).val();
			$(this).jqGrid('setRowData', rowId, rowData);
			if(selectText != "请选择"){
				getName(rowId,selectText);
				return selectText;
			}else{
				return "";
			}
		} else if (operation === 'set') {
			$(elem).find('option[text="' + value + '"]').attr("selected", true);
		}
	};
	
	$(document).ready(function(){
		//template页面
		var dataGridColModel = [
			{label : 'id',name : 'id',key : true,width : 75,hidden : true}, 
			{label : '编码',name : 'code',width : 150,formatter : formatValue},
			{label : '名称',name : 'name',width : 150},
			{label : '事务控制方式',name : 'swfl',width : 150,formatter : formatchoose},
			{label : '描述',name : 'bz',width : 150}, 
			{label : '用户自定义处理类',name : 'userClass',width : 150}
		];
		//sheet关联页 页面
		var dataGridColModel1 = [
	        {label : 'id',name : 'id',key : true,width : 75,hidden : true}, 
	        {label : '导入模板id',name : 'templateId',width : 150,editable : false,hidden : true},
	        {label : 'sheet页名称',name : 'sheetName',width : 150}, 
	        {label : '<font color="red">*</font>表名称',name : 'tableName',width : 150, editable : true, edittype : "custom",editoptions : {custom_element : currencyElem, custom_value : currencyValue }}, 
	        {label : '表描述',name : 'tableDesc',width : 150, editable : true, hidden : true}
		];
		//column配置关系页页面
		var dataGridColModel2 = [ 
			{label : 'id',name : 'id',key : true,width : 75,hidden : true}, 
			{label : 'sheetId',name : 'sheetid',width : 150, sortable:false,formatter : formatValue,hidden : true},
			{label : '列标题',name : 'columnTitle', sortable:false, width : 150},
			{label : '列序号',name : 'columnIndex', sortable:false, width : 150},
			{label : '<font color="red">*</font>字段英文名',name : 'field',editable : true,edittype : "custom",editoptions : {custom_element : selectElemName,custom_value : selectValueName,forId : 'field' ,value : selectData }},
			{label : '字段名称',name : 'fieldDesc',sortable:false, width : 150,editable : true}, 
			{label : '是否必填',name : 'required', sortable:false, width : 150,formatter : formatterValueYN,unformat : unformatterValueYN},
			{label : '<font color="red">*</font>字段类型',name : 'fieldtype', sortable:false, width : 150},
			{label : '文本长度',name : 'vcharlength',sortable:false, width : 150},
			{label : '小数位',name : 'datascale',sortable:false, width : 150}, 
			{label : '备注',name : 'remark', sortable:false, width : 150,hidden : true},
			{label : '格式校验 ',name : 'checkType', sortable:false, width : 75,hidden : true},
			{label : '格式校验 ',name : 'checkTypeName', sortable:false, width : 150,editable : true,edittype : "custom",editoptions : {custom_element : selectElem,custom_value : selectValue,forId : 'checkType',value : checkTypeData}},
			{label : '是否唯一性列 ',name : 'keyunique',sortable:false, width : 75,hidden : true},
			{label : '是否唯一性列 ',name : 'keyuniqueName',sortable:false, width : 150,editable : true,edittype : "custom",editoptions : {custom_element : selectElem,custom_value : selectValue,forId : 'keyunique',value : onlyOrNot}}
		];
		var searchNames = new Array();
		var searchTips = new Array();
		searchNames.push("code");
		searchTips.push("编码");
		searchNames.push("name");
		searchTips.push("名称");
		var searchC = searchTips.length == 2 ? '或'+ searchTips[1] : "";
		$('#sysImpTemplate_keyWord').attr('placeholder','请输入' + searchTips[0] + searchC);
		sysImpTemplate = new SysImpTemplate(
				'sysImpTemplatejqGrid', '${url}',
				'searchDialog', 'form',
				'sysImpTemplate_keyWord', searchNames,
				dataGridColModel);
		//添加按钮绑定事件
		$('#sysImpTemplate_insert').bind('click', function() {
			sysImpTemplate.insert();
		});
		//编辑按钮绑定事件
		$('#sysImpTemplate_modify').bind('click', function() {
			sysImpTemplate.modify();
		});
		//删除按钮绑定事件
		$('#sysImpTemplate_del').bind('click', function() {
			sysImpTemplate.del();
		});
		//查询按钮绑定事件
		$('#sysImpTemplate_searchPart').bind('click',function() {
					sysImpTemplate.searchByKeyWord();
		});
		//查询框回车事件
		$('#sysImpTemplate_keyWord').bind('keyup', function(e) {
			if (e.keyCode == 13) {
				sysImpTemplate.searchByKeyWord();
			}
		});
		//打开高级查询框
		$('#sysImpTemplate_searchAll').bind('click',function() {
			sysImpTemplate.openSearchForm(this);
		});
		//sheet页保存
		$("#sysImpSheetTableRessave").bind('click',function() {
			saveSheet();
		});
		//column详细信息保存
		$("#sysImpcolumnSave").bind('click',function() {
			saveColumn();
		});
		//sheet页设置
		$("#sysImpSheetTableResjqGrid").jqGrid({
			url : 'platform6/msystem/imp/sysimpsheettableres/sysImpSheetTableResController/operation/getSysImpSheetTableRessByPage.json',
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridColModel1,//表格列的属性
			height : $(window).height() - 430,//初始化表格高度
			scrollOffset : 20, //设置垂直滚动条宽度
			rowNum : 100,//每页条数
			rowList : [ 200, 100, 50, 30, 20,
					10 ],//每页条数可选列表
			altRows : true,//斑马线
			userDataOnFooter : true,
			pagerpos : 'left',//分页栏位置
			loadonce : false,
			viewrecords : true, //是否要显示总记录数
			styleUI : 'Bootstrap', //Bootstrap风格
			multiselect : true,//可多选
			autowidth : true,//列宽度自适应
			//rownumbers : true,
			responsive : true,//开启自适应
			hasTabExport:false,
			multiselect : true,
			hasColSet:false,
			pager : "#jqGridPager1",
			cellEdit : true,
			cellsubmit : 'clientArray',
			autowidth : true,
			responsive : true,
			multiboxonly : true,
			onSelectRow : onSelectRowSheet//,js方法
		});
		 
		//自动匹配
		$("#sysImpcolumnAutoFind").bind('click',function(){
			var rows = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
			if(rows.length > 1 || rows.length == 0){
				layer.alert('请勾选一个sheet页再进行配置', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
					  title:"提示"
					}
				);
				return false;
			}
			var rowData = $('#sysImpSheetTableResjqGrid').jqGrid('getRowData',rows[0]);
			var tableName = rowData.tableName;
			if (tableName != undefined&& tableName.length < 50) {
				$.ajax({
						type : 'POST',
						dataType : 'JSON',
						async : false,
						url : 'platform6/msystem/imp/sysimptemplate/sysImpTemplateController/operation/getchooseTableColumns',
						data : {
							'tableName' : tableName
						},
						success : function(r) {
							mapListTableName = r.mapList;
							selectData={};
							for(var i=0;i<mapListTableName.length;i++){
								var nameValue=mapListTableName[i].COLUMN_NAME;
								selectData[nameValue]=nameValue;
							}
						}
					});
			}
			
			var obj = $("#sysImpColumnFiledResjqGrid").jqGrid("getRowData");
			for (var i = 0; i < obj.length; i++) {
				for (var j = 0; j < mapListTableName.length; j++) {
					if (obj[i].columnTitle == mapListTableName[j].COMMENTS) {
						if(mapListTableName[j].DATA_TYPE=="NUMBER" || mapListTableName[j].DATA_TYPE=="decimal"){
								$("#sysImpColumnFiledResjqGrid").jqGrid('setRowData',obj[i].id,{
									field : mapListTableName[j].COLUMN_NAME,
									fieldDesc : mapListTableName[j].COMMENTS,
									required : mapListTableName[j].NULLABLE=="Y"?"N":"Y",
									vcharlength :  mapListTableName[j].DATA_PRECISION,
									fieldtype : mapListTableName[j].DATA_TYPE,
									datascale : mapListTableName[j].DATA_SCALE
									
								});
						}else{
							$("#sysImpColumnFiledResjqGrid").jqGrid('setRowData',obj[i].id,{
								field : mapListTableName[j].COLUMN_NAME,
								fieldDesc : mapListTableName[j].COMMENTS,
								required : mapListTableName[j].NULLABLE=="Y"?"N":"Y",
								vcharlength : mapListTableName[j].DATA_LENGTH,
								fieldtype:mapListTableName[j].DATA_TYPE
							});
						}
					}
				}

			}
			
			
		 	$("#sysImpColumnFiledResjqGrid").jqGrid('endEditCell'); //关闭单元格编辑
			var ids = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
			var obj1 = $("#sysImpColumnFiledResjqGrid").jqGrid("getRowData");
			$.ajax({
				url : 'platform6/msystem/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/operation/save',
				data : {
					data : JSON.stringify(obj1)
				},
				type : 'POST',
				dataType : 'JSON',
				async : false,
				success : function(result) {
					if (result.flag == "success") {
						$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam',{
							datatype : 'json',
							postData : {
								'excelId' : ids[0]
							}
						}).trigger("reloadGrid");
					} else {
						layer.msg('数据匹配失败！');
					}
				}
			}); 
		})
		//column页设置
		$("#sysImpColumnFiledResjqGrid").jqGrid({
			url : 'platform6/msystem/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/operation/getSysImpColumnFiledRessByPage.json',
			mtype : 'POST',
			datatype : "json",
			colModel : dataGridColModel2,
			height : 180,
			scrollOffset : 20, //设置垂直滚动条宽度
			rowNum : 20,
			rowList : [ 200, 100, 50, 30, 20,10 ],
			altRows : true,
			pagerpos : 'left',
			styleUI : 'Bootstrap',
			viewrecords : true,
			multiselect : true,
			afterSaveCell:function(rowid, cellname, value, iRow, iCol){
				if(iCol == 13){
					var rowData = $('#sysImpColumnFiledResjqGrid').jqGrid('getRowData',rowid);
					if(rowData.fieldtype == "VARCHAR2" || rowData.fieldtype == "varchar"){
						if(!(value == "" || value == "请选择" || value == "邮箱" || value == "手机")){
							layer.alert('不能选择该值！', {
								icon : 7,
								area : [ '400px', '' ], // 宽高
								closeBtn : 0,
								btn : [ '关闭' ],
								title : "提示"
							});
							$('#sysImpColumnFiledResjqGrid').jqGrid('setRowData',rowid, {checkType: "", checkTypeName: ""});
							return false;
						}
					} else if(rowData.fieldtype == "DATE" || rowData.fieldtype == "date"){
						if(!(value == "" || value == "请选择" || value == "日期")){
							layer.alert('不能选择该值！', {
								icon : 7,
								area : [ '400px', '' ], // 宽高
								closeBtn : 0,
								btn : [ '关闭' ],
								title : "提示"
							});
							$('#sysImpColumnFiledResjqGrid').jqGrid('setRowData',rowid, {checkType: "", checkTypeName: ""});
							return false;
						}
					} else if(rowData.fieldtype == "NUMBER" || rowData.fieldtype == "decimal"){
						if(!(value == "" || value == "请选择" || value == "数值")){
							layer.alert('不能选择该值！', {
								icon : 7,
								area : [ '400px', '' ], // 宽高
								closeBtn : 0,
								btn : [ '关闭' ],
								title : "提示"
							});
							$('#sysImpColumnFiledResjqGrid').jqGrid('setRowData',rowid, {checkType: "", checkTypeName: ""});
							return false;
						}
					}
				}else if(iCol == 15){
					var rowData = $('#sysImpColumnFiledResjqGrid').jqGrid('getRowData',rowid);
					if(!(rowData.fieldtype == "VARCHAR2" || rowData.fieldtype == "varchar")){
						if(!(value == "" || value == "请选择")){
							layer.alert('不能选择该值！', {
								icon : 7,
								area : [ '400px', '' ], // 宽高
								closeBtn : 0,
								btn : [ '关闭' ],
								title : "提示"
							});
							$('#sysImpColumnFiledResjqGrid').jqGrid('setRowData',rowid, {keyunique: "", keyuniqueName: ""});
							return false;
						}
					}
				}
			},
			shrinkToFit : true,
			hasTabExport:false,
			hasColSet:false,
			responsive : true,//开启自适应
			pager : "#jqGridPager2",
			cellEdit : true,
			cellsubmit : 'clientArray'
		});

		//初始化sheet页
		$("#sysImpTemplate_start").bind('click',function() {
			var ids = $('#sysImpTemplatejqGrid').jqGrid('getGridParam','selarrrow');
			var rowData = $('#sysImpTemplatejqGrid').jqGrid('getRowData',ids[0]);
			if (ids.length < 1) {
				layer.alert('请选择一条数据！', {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				return false;
			} else if (ids.length > 1) {
				layer.alert('只允许选择一条数据！', {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				return false;
			}
			$.ajax({
				url : 'platform6/msystem/imp/sysimptemplate/sysImpTemplateController/operation/getExcelInfo',
				data : {
					templateId : ids[0]
				},
				type : 'POST',
				dataType : 'JSON',
				async : false,
				success : function(r) {
					//sheet页name刷新
					$("#sysImpSheetTableResjqGrid").jqGrid('setGridParam',{
						datatype : 'json',
						postData : {
							'templateId' : ids[0]
						}
					}).trigger("reloadGrid");
				}
			});
			
		});
		
		$("#sysImpSheetTableRes_del").bind('click',function(){
			var rows = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
			var _self = this;
			var ids = [];
			var l =rows.length;
			if(l > 0){
				layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
					for(;l--;){
						 ids.push(rows[l]);
					 }
					 avicAjax.ajax({
						 url:'platform6/msystem/imp/sysimptemplate/sysImpTemplateController/operation/deleteSheetIds',
						 data:	JSON.stringify(ids),
						 contentType : 'application/json',
						 type : 'post',
						 dataType : 'json',
						 success : function(r){
							 if (r.flag == "success") {
								 var ids = $('#sysImpTemplatejqGrid').jqGrid('getGridParam','selarrrow');
								 $("#sysImpSheetTableResjqGrid").jqGrid('setGridParam',{
										datatype : 'json',
										postData : {
											'templateId' : ids[0]
										}
									}).trigger("reloadGrid");
								 $("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam',{
										datatype : 'json',
										postData : {
											'excelId' : ""
										}
									}).trigger("reloadGrid");
							}else{
								layer.alert('删除失败！' + r.error, {
									  icon: 7,
									  area: ['400px', ''],
									  closeBtn: 0,
									  btn: ['关闭'],
				                      title:"提示"
									}
								);
							}
						 }
					 });
					 layer.close(index);
				});   
			}else{
			    layer.alert('请选择要删除的数据！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
					  title:"提示"
					}
				);
			}
		});
		
		$("#sysImpColumnFiledRes_del").bind('click',function(){
			var rows = $("#sysImpColumnFiledResjqGrid").jqGrid('getGridParam','selarrrow');
			var _self = this;
			var ids = [];
			var l =rows.length;
			if(l > 0){
				layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
					for(;l--;){
						 ids.push(rows[l]);
					 }
					 avicAjax.ajax({
						 url:'platform6/msystem/imp/sysimpcolumnfiledres/sysImpColumnFiledResController/operation/delete',
						 data:	JSON.stringify(ids),
						 contentType : 'application/json',
						 type : 'post',
						 dataType : 'json',
						 success : function(r){
							 if (r.flag == "success") {
								var rowid = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
								if(rowid.length > 0){
									$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam',{
										datatype : 'json',
										postData : {
											'excelId' : rowid[0]
										}
									}).trigger("reloadGrid");
								}
							}else{
								layer.alert('删除失败！' + r.error, {
									  icon: 7,
									  area: ['400px', ''],
									  closeBtn: 0,
									  btn: ['关闭'],
				                      title:"提示"
									}
								);
							}
						 }
					 });
					 layer.close(index);
				});   
			}else{
			    layer.alert('请选择要删除的数据！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
					  title:"提示"
					}
				);
			}
		});

		//初始化column详细信息页
		$("#sysImpTemplatecolum_start").bind('click',function(){
			var rows = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
			if(rows.length > 1 || rows.length == 0){
				layer.alert('请勾选一个sheet页再进行配置', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
					  title:"提示"
					}
				);
				return false;
			}
			var rowData = $('#sysImpSheetTableResjqGrid').jqGrid('getRowData',rows[0]);
			if(typeof(rowData.templateId)!="undefined"){
				var templateId = rowData.templateId;
				var sheetId = rowData.id;
				var transferName = rowData.sheetName;
				var tableName = rowData.tableName;
				if (tableName != ""&& tableName.length < 50) {
					$.ajax({
						type : 'POST',
						dataType : 'JSON',
						//async: false, 
						url : 'platform6/msystem/imp/sysimptemplate/sysImpTemplateController/operation/getExcelInfoAndSave',
						data : {
							'templateId' : templateId,
							'sheetId' : sheetId,
							'transferName' : transferName,
							'tableName' : tableName
						},
						success : function(r){
							mapListTableName = r.mapList;
							selectData={};
							for(var i=0;i<mapListTableName.length;i++){
								var nameValue=mapListTableName[i].COLUMN_NAME;
								selectData[nameValue]=nameValue;
							}
							var rowid = $("#sysImpSheetTableResjqGrid").jqGrid('getGridParam','selarrrow');
							if(rowid.length > 0){
								//sheet页详细信息刷新
								$("#sysImpColumnFiledResjqGrid").jqGrid('setGridParam',{
									datatype : 'json',
									postData : {
										'excelId' : rowid[0]
									}
								}).trigger("reloadGrid");
							}
						}
					});
	
				} else {
					layer.alert('所选数据表名称为空！', {
						icon : 7,
						area : [ '400px', '' ], // 宽高
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}
			}else{
				layer.alert('请选择一条sheet页数据！', {
					icon : 7,
					area : [ '400px', '' ], // 宽高
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
				return false;
			}
		});
		//sheet区域太小隐藏文字显示
		$("#jqGridPager1_right").css("display","none");
	});
	//南侧拖拽修改改变时修改表格自适应
	function resizeSouth(width,height){
		var windowHeight = $(window).height();
		var topTableHeight = windowHeight - height
		$("#centerDiv1").height(topTableHeight);
		$("#centerDiv2").height(topTableHeight);
		$('#sysImpColumnFiledResjqGrid').setGridHeight(height-120);
		$('#sysImpSheetTableResjqGrid').setGridHeight(topTableHeight-120);
		$('#sysImpTemplatejqGrid').setGridHeight(topTableHeight-120);
	}
</script>
</html>