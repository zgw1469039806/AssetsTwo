<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<% 
String datetime=new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "mdaDatasourceEasyUIController/operation/sub/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<script src="avicit/platform6/mda/mdaclassify/js/MdaClassify.js"
	type="text/javascript">
</script>
</head>
<script type="text/javascript">
	//文档采集时间范围
	function selectDOCTime() {
		var val = $('input:radio[name="radio"]:checked').val();
		if (val == "notime") {
			//alert('===不限制时间==='); 
			$('#docCrawlStartTime').val('')
			$('#docCrawlEndTime').val('');
		} else if (val == "time") {
			//  alert('===限制时间==='); 
		}
	}

	//选择文件系统类型
	function selectFSType() {
		var docType = $('#docType_id').val();
		if (docType == 'ftp') {
			$('.LOCAL_CLASS').hide();
			$('.FTP_CLASS').show();
		}
		if (docType == 'local') {
			$('.FTP_CLASS').hide();
			$('.LOCAL_CLASS').show();
		}
	}

	//选择文档爬取类型
	function selectDocCrawlType() {
		var doctypes = $('.docSaveType_class input:checked');
		var doctypeArr = [];
		doctypes.each(function(i) {
			var doctype = doctypes.eq(i).val();
			doctypeArr.push(doctype);
		});
		$('#docSaveType_id').val(doctypeArr.toString());
	}

	$(function() {
		$(".timeRange").hide();
		$("input[type='radio']").click(function() {
			var _flag = $('#selectedId:checked').val();
			if (_flag) {
				$(".timeRange").show();
			} else {
				$(".timeRange").hide();
			}
		})
		var FS_type = $('#FS_type_id').val();
		if (FS_type == 'ftp'||FS_type=='') {
			$('.LOCAL_CLASS').hide();
		}
		if (FS_type == 'local') {
			$('.FTP_CLASS').hide();
		}
		var saveType = "${mdaDoccrawlconfigDTO.storemethod}";
		var saveTypeArr = saveType.split(",");
		for ( var i = 0; i < saveTypeArr.length; i++) {
			if (saveTypeArr[i] == 'db') {
				$('#saveToDB_id').attr("checked", "checked");
			} else if (saveTypeArr[i] == 'doc') {
				$('#saveToJSON_id').attr("checked", "checked");
			}
		}
	});

	//刷新当前页面
	function refresh() {
		window.location.reload();
	}
	var layerDB, layerDOC, layerSolr;
	//关闭弹窗
	function closeLayer() {
		layerDB.dialog('close', true);
		layerDOC.dialog('close', true);
		layerSolr.dialog('close', true);
	}
	//中间文件存入数据库配置
	function filesToDB() {
		var id = $('#itemId_id').val();
		//弹窗
		layerDB = new CommonDialog("insert", "700", "400", 'platform/mdaDatasourceEasyUIController/toSetFieldSavePath/db/'+ id, "设置", false, true, false);
		layerDB.show();
	}
	//中间文件存为JSON中间文件
	function filesToDOC() {
		var id = $('#itemId_id').val();
		//弹窗
		layerDOC = new CommonDialog("insert", "700", "400", 'platform/mdaDatasourceEasyUIController/toSetFieldSavePath/doc/'+ id, "设置", false, true, false);
		layerDOC.show();
	}

	//中间文件存入数据库配置
	function filesToSolr() {
		var id = $('#itemId_id').val();
		//弹窗
		layerSolr = new CommonDialog("insert", "700", "400", 'platform/mdaDatasourceEasyUIController/toSetFieldSavePath/solr/'+ id, "设置", false, true, false);
		layerSolr.show();
	}
	
	function closWinDOC(){
		layerDOC.close();
	}

	//选择中间文件存储类型
	function selectSaveType() {
		var savetypes = $('.saveType_class input:checked');
		var savetypeArr = [];
		savetypes.each(function(i) {
			var savetype = savetypes.eq(i).val();
			//放进数组里
			savetypeArr.push(savetype);
		});
		$('#saveType_id').val(savetypeArr.toString());
	}
	
	var saveType = "${mdaDatabasecrawlconfigDTO.storemethod}";
	var saveTypeArr = saveType.split(",");
	for ( var i = 0; i < saveTypeArr.length; i++) {
		if (saveTypeArr[i] == 'db') {
			$('#saveToDB_id').attr("checked", "checked");
		} else if (saveTypeArr[i] == 'doc') {
			$('#saveToJSON_id').attr("checked", "checked");
		}
	}
	function closeForm() {
		parent.mdaCrawlitems.closeDialog("insert");
	}

	function openk() {
		var _id = "111";
		this.insertIndex = new CommonDialog("insert", "1200", "600", 'platform/mdaDatasourceEasyUIController/set/Set/'+ _id, "设置", false, true, false);
		this.insertIndex.show();
	}
	function saveForm() {
		selectSaveType();
		selectDOCTime();
		var form = $("#form");
		var _data = serializeObject(form);

		$.ajax({
				url : "platform/mdaDatasourceEasyUIController/operation/saveSet/doc",
				data : _data,
				type : 'post',
				success : function(r) {
					//字符串拆分,获取ID
					var arr = new Array();
					arr = r.split(":");

					if (arr[0] == "success") {
						// parent.openc(2);
						parent.openNext('doc', arr[1]);
						$.messager.alert('提示','保存成功！','info');
					} else {
						$.messager.show({
							title : '提示',
							msg : '保存失败！' + r.error,
							timeout : 3000,
							showType : 'slide'
						});
					}
				}
		});
	}
	$(document).ready(function() {
		//保存按钮绑定事件
		$('#mdaCrawlitems_saveForm').bind('click', function() {
			selectDocCrawlType();
			saveForm(); 
		});
		//返回按钮绑定事件
		$('#mdaCrawlitems_closeForm').bind('click', function() {
			closeForm();
		});

		$('#lastcrawluseridAlias').on('focus', function(e) {
			new H5CommonSelect({
				type : 'userSelect',
				idFiled : 'lastcrawluserid',
				textFiled : 'lastcrawluseridAlias'
			});
			this.blur();
		});
		/* ztree树加载 */
		var setting = {
			data : {
				simpleData : {
					enable : true,
				}
			},
			callback : {
				onClick : zTreeOnClick
			}
		};

		$('#classifyidsAlias').focus(function() {
				$("#crawlitem_classify").css("display", "block");
				$.ajax({
						url : "platform6/mda/mdadatasource/mdaDatasourceEasyUIController/getZtree",
						type : "POST",
						success : function(retVal) {
						$.fn.zTree.init(
							$("#crawlitem_classify"),
							setting,
							retVal);
						}
				});
		});
		function zTreeOnClick(event, treeId, treeNode) {
			var treeObj = $.fn.zTree.getZTreeObj("crawlitem_classify");
			/* 单击展开节点 */
			treeObj.expandNode(treeNode);
			var sNodes = treeObj.getSelectedNodes();
			if (sNodes.length > 0) {
				var isParent = sNodes[0].isParent;
				if (isParent == false) {
					$("#classifyidsAlias").val(treeNode.name)
					$("#crawlitem_classify").css("display",
							"none");
				}
			}
		};
	});
</script>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="sourceId" value="${id}" /> <input
				type="hidden" id="itemId_id" name="itemId" value="${id}" /> <input
				type="hidden" id="FS_type_id" name="FS_type"
				value="${mdaDoccrawlconfigDTO.fstype}" /> <input type="hidden"
				name="type" value="doc" />
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="name">文件系统类型:</label></th>
					<td width="10%" colspan="3"><select onchange="selectFSType();"
						id='docType_id' name="docType" 
						style="width: 80px; height: 35px; min-height: 35px;">
							<option value="ftp" 
								<c:if test="${mdaDoccrawlconfigDTO.fstype == 'ftp' or mdaDoccrawlconfigDTO.fstype == ''}">selected="selected"</c:if>>ftp</option>
							<option value="local"
								<c:if test="${mdaDoccrawlconfigDTO.fstype == 'local' }">selected="selected"</c:if>>local
								file</option>
					</select></td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="13%"><label for="name">用户名:</label></th>
					<td width="36%"><input title="用户名"
						class="inputbox easyui-validatebox" type="text"
						value="${mdaDoccrawlconfigDTO.loginuser}" name="docUserName" /></td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">密码:</label></th>
					<td width="39%"><input title="登录"
						class="inputbox easyui-validatebox" type="text"
						value="${mdaDoccrawlconfigDTO.loginpassword}" name="docUserPWD" />
					</td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">文件系统地址（IP）:</label></th>
					<td width="39%"><input title="文件系统地址（IP）"
						class="inputbox easyui-validatebox" type="text"
						value="${mdaDoccrawlconfigDTO.fsIp}" name="docFSIP" /></td>
				</tr>
				<tr class='FTP_CLASS'>
					<th width="10%"><label for="name">文件系统端口（port）:</label></th>
					<td width="39%"><input title="文件系统端口（port）"
						class="inputbox easyui-validatebox" type="text"
						value="${mdaDoccrawlconfigDTO.docport}" name="docPort" /></td>
				</tr>
				<tr class='LOCAL_CLASS'>
					<th width="10%"><label for="name">本地文件采集路径:</label></th>
					<td colspan="2"><textarea rows="2" name="docAddr" cols="100"
							style="color: #BEBEBE;" id="textarea1" placeholder="请输入本地文件采集路径"><c:if test="${!empty mdaDoccrawlconfigDTO.docaddr }">${mdaDoccrawlconfigDTO.docaddr}</c:if></textarea></td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要采集的关键词:</label></th>
					<td colspan="2"><textarea rows="3" name="docKeyWords"
							cols="100" style="color: #BEBEBE;" id="textarea3"
							placeholder="多个请用逗号分割"><c:if test="${!empty mdaDoccrawlconfigDTO.keywords }">${mdaDoccrawlconfigDTO.keywords}</c:if></textarea></td>
				</tr>
				<tr>
					<th width="10%"><label for="name">要过滤的关键词:</label></th>
					<td colspan="2"><textarea rows="3" name="docFilterWords"
							cols="100" style="color: #BEBEBE;" id="textarea4"
							placeholder="多个请用逗号分割"><c:if test="${!empty mdaDoccrawlconfigDTO.filterwords }">${mdaDoccrawlconfigDTO.filterwords }</c:if></textarea></td>
				</tr>
				<tr>
					<th width="10%"><label for="name">文件采集类型:</label></th>
					<td width="39%"><input type="hidden" name="docSaveType"
						id="docSaveType_id" />  <!-- 为空  --> <c:forEach var="docType"
							items="${docTypeArr}">
							<span class="docSaveType_class"> <input type="checkbox"
								name="Type" checked="checked" value="${docType}">${docType}&nbsp;
							</span>
						</c:forEach></td>
				</tr>

				<tr>
					<th width="10%"><label for="name">时间范围:</label></th>
					<td width="10%">
					<table >
					   <tr>
					     <td style="width:200px;"><span> <input type="radio"
								checked="checked" name='radio' value="notime"/> 不限
						     </span>
						     <span class="noneclass"><input
								type="radio" name='radio' id="selectedId" value="time"/>规定范围</span>
						 </td>
						 <td style="width:50px;" class="timeRange">
						 		<label for="docCrawlStartTime">开始:</label>
						 </td>
					     <td class="timeRange">
					           <input class="easyui-datebox" type="text" name="docCrawlStartTime" style=""
									id="docCrawlStartTime" value="<%=datetime %>"/>
					     </td >
					     <td style="width:50px;" class="timeRange">
						 		<label for="docCrawlEndTime">结束:</label>
						 </td>
					     <td class="timeRange">
								 <input class="easyui-datebox" type="text" style=""
									name="docCrawlEndTime" id="docCrawlEndTime" value="<%=datetime %>" style="width:100px;"/>
					     </td>
					     
					   </tr>
					
					</table>
					</td>
				</tr>
				<tr>
					<th width="10%"><label for="name">存储为中间文件:</label></th>
					<td width="10%" colspan="3"><input type="hidden"
						name="saveType" id="saveType_id" /> <!-- 	<span class="saveType_class">
		        		<input id="saveToDB_id" type="checkbox" value="db"  >
		        		<a href="javascript:void(0)"  onclick="filesToDB();">数据库</a>
					</span>  --> <span class="saveType_class">&nbsp;&nbsp;&nbsp;
							<input id="saveToJSON_id" type="checkbox" value="doc"> <a
							href="javascript:void(0)" onclick="filesToDOC();">中间文档</a>
					</span> <%--    	<span>&nbsp;&nbsp;&nbsp;
		          		<input type="checkbox" value="3" <c:if test="${bean.savetype eq 3 }">checked="checked"</c:if> name='radio' >
		          		<a href="javascript:void(0)" onclick="filesToSolr();">存到索引库</a>
		 		   </span> --%></td>
				</tr>
				<tr>
					<th width="10%"><label for="name">更新方式:</label></th>
					<td width="10%" colspan="3"><select
						style="width: 80px; height: 35px; min-height: 35px;"
						name="docUpdateType">
							<option value="1">全量更新</option>
							<option value="2">增量更新</option>
					</select></td>
				</tr>
				<tr>
					<th width="10%"><label for="classifyids"></label></th>
					<td width="39%">
						<div>
							<ul id="crawlitem_classify" class="ztree"></ul>
						</div>
					</td>
					<th width="10%"><label for="status"></label></th>
					<td></td>

				</tr>
			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="下一步" id="mdaCrawlitems_saveForm"
						class="easyui-linkbutton primary-btn">下一步</a> </td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>