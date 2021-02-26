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
	<!-- ControllerPath = "platform6/db/dbtablecol/dbTableColController/toDbTableColManage" -->
	<title>管理</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<style>
		.searchBox {
			padding: 5px;
			left: 0;
			top: 90px;
			width: 199px;
			background: #fff
		}

		.searchBox input {
			color: #888888;
			font-size: 12px;
			padding-left: 14px;
			border-radius: 14px;
			background: #f3f4f9;
			border: 1px solid #EAECF2;
			height: 28px;
			line-height: 32px;
			width: 100%;
			padding: 0 46px 0 14px;
			outline: medium;
		}

		.searchBox i.clear {
			position: absolute;
			left: auto;
			right: 38px;
			font-size: 14px;
			width: 28px;
			height: 28px;
			text-align: center;
			line-height: 28px;
			cursor: pointer;
			color: #888888;
			display: none;
		}

		.searchBox i.query {
			position: absolute;
			left: auto;
			right: 20px;
			font-size: 14px;
			width: 28px;
			height: 28px;
			text-align: center;
			line-height: 28px;
			cursor: pointer;
			color: #888888;
		}

		.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td {
			padding-right: 2px;
			overflow: hidden;
			white-space: nowrap;
			text-overflow: ellipsis;
			word-break: break-all;
			vertical-align: middle;
			padding-top: 4px;
			padding-bottom: 4px;
		}
	</style>
</head>
<body>
	
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#home" data-toggle="tab">
				结构
			</a>
		</li>
		<li><a href="#index" data-toggle="tab">索引</a></li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="home">
			<div id="tableToolbar" class="toolbar">
				<div class="toolbar-left"> 
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_dbTableCol_button_add" permissionDes="添加">
						<a id="dbTableCol_insert" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
							title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
										   domainObject="formdialog_dbTableCol_button_copytable" permissionDes="复制表">
						<a id="dbTableCol_copytable" href="javascript:void(0)"
						   class="btn btn-default form-tool-btn btn-sm" role="button"
						   title="复制表"><i class="fa fa-copy"></i> 复制表</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
										   domainObject="formdialog_dbTableCol_button_copyrow" permissionDes="复制行">
						<a id="dbTableCol_copyrow" href="javascript:void(0)"
						   class="btn btn-default form-tool-btn btn-sm" role="button"
						   title="复制行"><i class="fa fa-copy"></i> 复制行</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
										   domainObject="formdialog_dbTableCol_button_commoncol" permissionDes="常用字段">
						<a id="dbTableCol_commoncol" href="javascript:void(0)"
						   class="btn btn-default form-tool-btn btn-sm" role="button"
						   title="常用字段"><i class="icon icon-cont"></i> 常用字段</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_dbTableCol_button_del" permissionDes="删除">
						<a id="dbTableCol_del" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
										   domainObject="formdialog_dbTableCol_button_save" permissionDes="保存">
						<a id="dbTableCol_save" href="javascript:void(0)"
						   class="btn btn-primary form-tool-btn btn-sm" role="button"
						   title="保存"><i class="fa fa-save"></i> 保存</a>
					</sec:accesscontrollist>
				</div>
				<div class="toolbar-right">
					<div class="searchBox">
						<input type="text" id="search" placeholder="请输入字段名称"> <i class="icon icon-guanbi1 clear" id="searchClear"></i><i class="icon icon-search_ query" id="searchQuery"></i>
					</div>
				</div>
			</div>
			<table id="dbTableColjqGrid"></table>
			<div id="jqGridPager"></div>
		</div>
		<div class="tab-pane fade" id="index">
			<div id="tableToolbarIndex" class="toolbar">
				<div class="toolbar-left">
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_dbTableIndex_button_add" permissionDes="添加">
						<a id="dbTableIndex_insert" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm btn-point" role="button"
							title="添加"><i class="fa fa-plus"></i> 添加</a>
					</sec:accesscontrollist>
					<%-- <sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_dbTableIndex_button_del" permissionDes="删除">
						<a id="dbTableIndex_del" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="删除"><i class="fa fa-trash-o"></i> 删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_dbTableIndex_button_save"
						permissionDes="保存">
						<a id="dbTableIndex_save" href="javascript:void(0)"
							class="btn btn-primary form-tool-btn btn-sm" role="button"
							title="保存"><i class="fa fa-save"></i> 保存</a>
					</sec:accesscontrollist> --%>
				</div>

			</div>
			<table id="dbTableIndexjqGrid"></table>
			<div id="jqGridPagerIndex"></div>
		</div>
	</div>
</body>
<!-- 高级查询 -->
<div id="searchDialog" style="overflow: auto; display: none">
	<form id="form" style="padding: 10px;">
		<table class="form_commonTable">
			<tr>
				<th width="10%">表外键:</th>
				<td width="39%"><input title="表外键"
					class="form-control input-sm" type="text" name="tableId"
					id="tableId" /></td>
				<th width="10%">列英文名称:</th>
				<td width="39%"><input title="列英文名称"
					class="form-control input-sm" type="text" name="colName"
					id="colName" /></td>
			</tr>
			<tr>
				<th width="10%">列类型:</th>
				<td width="39%"><pt6:h5select css_class="form-control input-sm"
						name="colType" id="colType" title="列类型" isNull="true"
						lookupCode="DB_COL_TYPE" /></td>
				<th width="10%">列长度:</th>
				<td width="39%"><input title="列长度"
					class="form-control input-sm" type="text" name="colLength"
					id="colLength" /></td>
			</tr>
			<tr>
				<%--<th width="10%">是否允许为空:</th>
				<td width="39%"><input title="是否允许为空"
					class="form-control input-sm" type="text" name="colNullable"
					id="colNullable" /></td>--%>
				<th width="10%">默认值:</th>
				<td width="39%"><input title="默认值"
					class="form-control input-sm" type="text" name="colDefault"
					id="colDefault" /></td>
			</tr>
			<tr>
				<th width="10%">备注:</th>
				<td width="39%"><input title="备注" class="form-control input-sm"
					type="text" name="colComments" id="colComments" /></td>
				<th width="10%">是否主键:</th>
				<td width="39%"><input title="是否主键"
					class="form-control input-sm" type="text" name="colIsPk"
					id="colIsPk" /></td>
			</tr>
			<tr>
				<th width="10%">是否唯一值:</th>
				<td width="39%"><input title="是否唯一值"
					class="form-control input-sm" type="text" name="colIsUnique"
					id="colIsUnique" /></td>
				<th width="10%">应用ID:</th>
				<td width="39%"><input title="应用ID"
					class="form-control input-sm" type="text" name="sysApplicationId"
					id="sysApplicationId" /></td>
			</tr>
			<tr>
			</tr>
		</table>
	</form>
</div>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="avicit/platform6/db/dbtablecol/js/DbTableCol.js"
	type="text/javascript"></script>
<script src="avicit/platform6/db/dbtableindex/js/DbTableIndex.js"
	type="text/javascript"></script>
<script type="text/javascript">
	//后台获取的通用代码数据
	var iscreated = "${iscreated}";
	var dataSourceName = "${dataSourceName}";
	var dbtype = "${dbtype}";
	var dbTableCol;
	var dbTableIndex;
    function formatColNull(cellvalue, options, rowObject){
        if(cellvalue && cellvalue != ''){
            return cellvalue;
        }else{
            var rowId = options.rowId;
            var datas = options.colModel.editoptions.value;
            var forId = options.colModel.editoptions.forId;
            var code = rowObject[forId];
            return datas[code] ? datas[code] : '否';
        }
    }
	$(document).ready(
			function() {
				var disabled = false;
				if (iscreated == "Y"){
					disabled = true;
				}
				var dataGridColModel = [ /*{
					label: "移动",
					name: "columnOrderNo",
					width: 50,
					frozen: true,
					align: "center",
					editable: false,
					edittype: "text",
					formatter:function( b, c, a) {
						return '<i class="fa fa-arrows" style="color:#aaa;cursor:move"></i>'
					},
					editoptions: {
						maxlength: "8",

					}
				},*/{
					label : 'id',
					name : 'id',
					key : true,
					width : 75,
					hidden : true
				}, {
					label : '表外键',
					name : 'tableId',
					width : 150,
					hidden : true
				}, {
					label : '列英文名称',
					name : 'colName',
					width : 150,
					editable : true,
                    editoptions : {
                        dataEvents: [{
                            type: 'change', fn: function (e) {
                                var rowid = $(e.currentTarget).parent().parent().attr("id");
                                $("#"+rowid).addClass("edited");
                            }
                        }]
                    }
				},{
					label : '列中文名称',
					name : 'colComments',
					width : 150,
					editable : true,
                    editoptions : {
                        dataEvents: [{
                            type: 'change', fn: function (e) {
                                var rowid = $(e.currentTarget).parent().parent().attr("id");
                                $("#"+rowid).addClass("edited");
                            }
                        }]
                    }
				}, {
					label : '列类型',
					name : 'colType',
					width : 150,
					editable : true,
					edittype : "select",
					editoptions : {
						value : {"VARCHAR2":"VARCHAR2","DATE":"DATE","NUMBER":"NUMBER","BLOB":"BLOB","CLOB":"CLOB"},
						dataEvents:[{type:'change',fn:function(e){
								var rowid=$(e.target).closest("tr").attr("id");//通过事件获得行ID
                                $("#"+rowid).addClass("edited");
								var value = $(e.target).val();
								if(value == "VARCHAR2"){                             //新建字段控件改变字段类型
									$("#"+rowid+"_colLength").val("50");
									$("#"+rowid+"_colLength").removeAttr("disabled");
									$("#"+rowid+"_attribute02").val("");
									$("#"+rowid+"_attribute02").attr("disabled","disabled");
								}else if(value == "DATE" || value == "CLOB" || value == "BLOB"){
									$("#"+rowid+"_colLength").val("");
									$("#"+rowid+"_colLength").attr("disabled","disabled");
									$("#"+rowid+"_attribute02").val("");
									$("#"+rowid+"_attribute02").attr("disabled","disabled");
								}else if(value == "NUMBER"){
									$("#"+rowid+"_colLength").val("5");
									$("#"+rowid+"_colLength").removeAttr("disabled","disabled");
									$("#"+rowid+"_attribute02").val("0");
									$("#"+rowid+"_attribute02").removeAttr("disabled","disabled");
								}

							}}]
					}
				}, {
					label : '列长度',
					name : 'colLength',
					width : 150,
					editable : true,
					align: "right",
                    editoptions : {
                        dataEvents: [{
                            type: 'change', fn: function (e) {
                                var rowid = $(e.currentTarget).parent().parent().attr("id");
                                $("#"+rowid).addClass("edited");
                            }
                        }]
                    }
				},  {
					label : '列小数位',
					name : 'attribute02',
					width : 150,
					editable : true,
					align: "right",
					editoptions : {
						dataEvents:[{type:'change',fn:function(e){
								var rowid = $(e.currentTarget).parent().parent().attr("id");
                                $("#"+rowid).addClass("edited");
								for(var i = 0; i < dbTableCol.initData.length; i++){
									var rowData = dbTableCol.initData[i];
									if(rowid == rowData.id){
										var oldValue = rowData.data.attribute02;
                                        var colLength = rowData.data.colLength;
	                                    var oldIntValue = oldValue;
	                                    if(oldIntValue == null || oldIntValue == undefined){
                                            oldIntValue = 0;
                                        }
										var newValue = $(e.currentTarget).val();

										var regex = /^\d+$/;
										if (!regex.test(newValue)){
											layer.alert("列小数位只能是自然数！", {
												icon : 7,
												area : [ '400px', '' ], //宽高
												closeBtn : 0
											});
											$(e.currentTarget).val(oldValue)
											return false;
										}

										if(oldIntValue > newValue){
											$(e.currentTarget).val(oldValue)

										}

										if (oldIntValue>newValue&&rowid.indexOf("new_row")!=0){
											layer.alert("列小数位只能增大不能减小！", {
												icon : 7,
												area : [ '400px', '' ], //宽高
												closeBtn : 0
											});
											$(e.currentTarget).val(oldValue)
										}else if(regex.test(newValue)){
											$("#"+rowid+"_colLength").val(parseInt(colLength)+(newValue-oldIntValue));
										}
									}

								}

							}}]
					}
				}/*,{ label:'colNullableId', name:'colNullable', width:75, hidden:true},

					{
					label : '是否允许为空',
					name : 'colNullableName',
					width : 150,
					editable : true,
                        edittype:"custom",
					align: "center",
					formatter:formatColNull,
                        editoptions: {custom_element:selectElem,
                                        custom_value:selectValue,
                                        require:true,
                                        forId:'colNullable',
                                        value:{"N":"否","Y":"是"},
                                        dataEvents: [{
                                            type: 'change', fn: function (e) {
                                                var rowid = $(e.currentTarget).parent().parent().attr("id");
                                                $("#"+rowid).addClass("edited");
                                            }
                                        }]
					}
				}*/, {
					label : '默认值',
					name : 'colDefault',
					width : 150,
					editable : true,
					hidden:true
				},  { label:'colIsPkId', name:'colIsPk', width:75, hidden:true},{
					label : '是否主键',
					name : 'colIsPkName',
					width : 150,
					editable : false,
					align: "center",
                        edittype:"custom",
                        align: "center", formatter:formatColNull, editoptions: {custom_element:selectElem, custom_value:selectValue, require:true,forId:'colIsPk',value:{"N":"否","Y":"是"}}
				},  {
					label : '应用ID',
					name : 'sysApplicationId',
					width : 150,
					editable : true,
					hidden:true
				} ,  {
					label : '是否系统字段',
					name : 'colIsSys',
					width : 150,
					editable : true,
					hidden:true
				}];
				var searchNames = new Array();
				var searchTips = new Array();
				searchNames.push("colName");
				searchTips.push("列英文名称");
				$('#dbTableCol_keyWord').attr('placeholder',
						'请输入' + searchTips[0] );
				dbTableCol = new DbTableCol('dbTableColjqGrid', '${url}',
						'searchDialog', 'form', 'dbTableCol_keyWord',
						searchNames, dataGridColModel,'${tableId}');
				if(dataSourceName == "local" && dbtype != "3"){
					//添加按钮绑定事件
					$('#dbTableCol_insert').bind('click', function() {
						dbTableCol.insert();
					});
					//删除按钮绑定事件
					$('#dbTableCol_create').bind('click', function() {
						dbTableCol.create();
					});
					//创建表按钮绑定事件
					$('#dbTableCol_del').bind('click', function() {
						dbTableCol.del();
					});
					//保存按钮绑定事件
					$('#dbTableCol_save').bind('click', function() {
						dbTableCol.save('${tableId}');
					});

					//复制表按钮绑定事件
					$('#dbTableCol_copytable').bind('click', function() {
						dbTableCol.copytable();
					});

					//复制行按钮绑定事件
					$('#dbTableCol_copyrow').bind('click', function() {
						dbTableCol.copyrow();
					});

					//复制行按钮绑定事件
					$('#dbTableCol_commoncol').bind('click', function() {
						dbTableCol.commoncol();
					});
				}else{
					$(".toolbar").hide();
				}
				//查询按钮绑定事件
				$('#dbTableCol_searchPart').bind('click', function() {
					dbTableCol.searchByKeyWord();
				});
				//打开高级查询框
				$('#dbTableCol_searchAll').bind('click', function() {
					dbTableCol.openSearchForm(this);
				});
				//回车键查询
				$('#dbTableCol_keyWord').on('keydown', function(e) {
					if (e.keyCode == 13) {
						dbTableCol.searchByKeyWord();
					}
				});
				$("#dbTableColjqGrid").setGridWidth($(window).width()*0.99);
				
				function getSelectCols(){
					var colJson;
					avicAjax.ajax({
						 async :false,
						 url:'${url}'+"getCol"+"/"+'${tableId}',
						 type : 'post',
						 dataType : 'json',
						 success : function(backData){
							 if(backData!=null){
								 colJson = eval(backData);
							 }
						 }
					 });
					return colJson;
				}
					
				var dataGridIndexModel = [ {
					label : 'id',
					name : 'id',
					key : true,
					width : 750,
					hidden : true
				}, {
					label : '表外键ID',
					name : 'tableId',
					width : 1500,
					editable : true,
					hidden : true
				}, {
					label : '索引英文名称',
					name : 'indexName',
					width : 1500,
					editable : true
				}, {
					label : '索引类型id',
					name : 'indexType',
					width : 750,
					hidden : true
				},{
					label : '索引类型',
					name : 'indexTypeName',
					width : 1500,
					editable : true,
					edittype : "custom",
					editoptions : {
						custom_element : selectElem,
						custom_value : selectValue,
						forId : 'indexType',
						value : {"Normal":"Normal","Unique":"Unique"}
					}
				},{
					label : '索引列id',
					name : 'indexColId',
					width : 750,
					hidden : true
				},{
					label : '索引列',
					name : 'indexCol',
					width : 1500,
					editable : true,
					edittype : "custom",
					editoptions : {
						custom_element : selectElem,
						custom_value : selectValue,
						forId : 'indexColId',
						value : getSelectCols()
					}
				}, {
					label : '应用ID',
					name : 'sysApplicationId',
					width : 1500,
					editable : true,
					hidden : true
				} ];
				var searchNamesIndex = new Array();
				var searchTipsIndex = new Array();
				searchNamesIndex.push("indexName");
				searchTipsIndex.push("索引英文名称");
				$('#dbTableIndex_keyWord').attr('placeholder',
						'请输入' + searchTipsIndex[0] );
				dbTableIndex = new DbTableIndex('dbTableIndexjqGrid', 'platform/platform6/db/dbtableindex/dbTableIndexController/operation/',
						'searchDialogIndex', 'form', 'dbTableIndex_keyWord',
						searchNamesIndex, dataGridIndexModel,'${tableId}');
				
				if(dataSourceName == "local"&&iscreated == "Y"){
					//添加按钮绑定事件
					$('#dbTableIndex_insert').bind('click', function() {
						//dbTableIndex.insert();
						dbTableIndex.add('${tableName}');	
					});
					//删除按钮绑定事件
					/* $('#dbTableIndex_del').bind('click', function() {
						dbTableIndex.del();
					});
					//保存按钮绑定事件
					$('#dbTableIndex_save').bind('click', function() {
						dbTableIndex.save('${tableId}');
					}); */
				}else{
					var msg="";
					if(iscreated == "N"){
						msg = "未创建实体表的表模型不能执行该操作！";
					}else{
						msg = "非本地数据模型不能执行该操作！";
					}
					$("#dbTableIndex_insert,#dbTableIndex_del,#dbTableIndex_save")
						.removeClass("btn-primary btn-sm").addClass("btn-grey")
						.attr('style','background:grey!important')
						.bind('click', function() {
							layer.msg(msg);
						});
				}
				//查询按钮绑定事件
				$('#dbTableIndex_searchPart').bind('click', function() {
					dbTableIndex.searchByKeyWord();
				});
				//打开高级查询框
				$('#dbTableIndex_searchAll').bind('click', function() {
					dbTableIndex.openSearchForm(this);
				});
				//回车键查询
				$('#dbTableIndex_keyWord').on('keydown', function(e) {
					if (e.keyCode == 13) {
						dbTableIndex.searchByKeyWord();
					}
				});
				
				//tab页切换补完事件
				$("#myTab li").on('click',function(){
					$("#dbTableIndexjqGrid").setGridWidth($(window).width()*0.99);
				});

				if (dbtype != "1"){
				    $("#tableToolbar").hide();
				    $("#index").hide();
				    $("a[href='#index']").hide();
                }

				//处理谷歌中文输入法不触发keyup的问题
				var bind_name = 'input';
				if (navigator.userAgent.indexOf("MSIE") != -1){
					bind_name = 'propertychange';
				}

				//查询
				$('#search').bind(bind_name,function(e){
					var search = $("#search").val();
					if (search!='') {
						$("#searchClear").show();
					} else {
						$("#searchClear").hide();
					}
					dbTableCol.searchWord($(e.target).val());
				});


				$('#searchClear').bind('click',function(event){
					$("#searchClear").hide();
					$("#search").val(null);
					dbTableCol.searchWord("");
				});

			});


</script>
</html>