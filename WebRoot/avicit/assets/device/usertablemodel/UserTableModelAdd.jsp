<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/usertablemodel/userTableModelController/operation/Add/null" -->
    <title>添加视图</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>

	<!-- 切换卡 样式 -->
	<link href="avicit/platform6/switch_card/yyui.css" rel="stylesheet" type="text/css">
</head>

<style type="text/css">
	th {
		text-align: left;
	}
	.form_commonTable{
		border-spacing: 0;
	}
	.form_commonTable tr.commonTableTr th {
		text-align: left;
		background-color: rgba(228, 228, 228, 1);
		border-bottom: 2px solid #ffffff;
		padding: 0 5px;
	}

	.fieldSelectDiv{
		overflow-x: hidden; /*x轴禁止滚动*/
		overflow-y: scroll;/*y轴滚动*/
	}
	.fieldSelectDiv::-webkit-scrollbar {
		display: none;/*隐藏滚动条*/
	}

	.fieldSelectedDiv{
		overflow-x: hidden; /*x轴禁止滚动*/
		overflow-y: scroll;/*y轴滚动*/
	}
	.fieldSelectedDiv::-webkit-scrollbar {
		display: none;/*隐藏滚动条*/
	}

	.viewLi{
		line-height: 28px;
		border: solid 1px #E4E4E4;
		background-color: #F2F4FF;
		text-align: center;
	}
</style>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
		<table class="form_commonTable">
			<tbody>
				<tr class="commonTableTr">
					<th width="10%">
						<label for="viewName">视图名称:</label>
						<span style="color: red">*</span>
					</th>
					<td width="15%">
						<input class="form-control input-sm" type="text" name="viewName" id="viewName" required="required">
					</td>
					<td width="75%"></td>
				</tr>
			</tbody>
		</table>
		<div class="yyui_tab" style="margin-left:2%; margin-top:10px; width:95%;">
			<ul>
				<li class="yyui_tab_title_this">构造列表</li>
			</ul>
			<div class="yyui_tab_content_this">
				<div id="headSource" style="float: left; width:20%; height:460px; background-color:#F2F4FF;">
					<div class="fieldSelectDiv" style="height:25px;">
						<table class="form_commonTable" style="margin-top:0px; margin-left:0px; margin-right:0px;">
							<tbody>
								<tr class="commonTableTr">
									<td width="85%" style="font-weight:700;">候选字段</td>
									<td width="15%" ><img src="static/images/tabAdd-hightlight.gif" onclick="addAllField();"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="fieldSelectDiv" style="height:435px;">
						<table class="form_commonTable" style="margin-top:0px; margin-left:0px; margin-right:0px;">
							<tbody>
								<c:forEach items="${sysModelList}" var="model">
									<c:if test="${model.fieldModel.indexOf('\"hidden\":true') < 0}">
										<tr class="commonTableTr" id=${model.fieldIdentify}>
											<td width="85%">${model.fieldName}</td>
											<td width="15%">
												<img src='static/images/tabAdd-hightlight.gif' onclick="addField('${model.fieldIdentify}')"/>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="inter_bet" style="width:31px; float:left;position:relative; height:460px; vertical-align:center; margin-left:10px;margin-right:10px;">
					<img class="inter_bet_img" src="static/images/right.png" style="margin-top:200px; margin-bottom:200px;"/>
				</div>
				<div id="selectSource" style="float:left; width:30%; height:460px; background-color:#F2F4FF;">
					<div class="fieldSelectDiv" style="height:25px;">
						<table class="form_commonTable" style="margin-top:0px; margin-left:0px; margin-right:0px;">
							<tbody>
								<tr class="commonTableTr">
									<td width="60%" style="font-weight: 700">选中字段</td>
									<td width="25%" style="font-weight: 700">宽度(px)</td>
									<td width="15%"><img src="static/images/tabDel-hightlight.gif" onclick="delAllField();"/></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="fieldSelectedDiv" style="height:435px;">
						<table class="form_commonTable" style="margin-top:0px; margin-left:0px; margin-right:0px;">
							<tbody id="selectedTbody">
								<tr id="theLine" style="position: absolute; display:none; background-color:#FFE0B3;"></tr>
							</tbody>
						</table>
				</div>
			</div>
		</div>
		<div class="yyui_tab" style="margin-top:10px; width:95%; float:left;">
			<ul>
				<li class="yyui_tab_title_this">列表预览</li>
			</ul>
			<div class="yyui_tab_content_this" style="overflow-x:scroll;" >
				<ul id="tablePreview" style="width: 20000px;"></ul>
			</div>
		</div>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera" style="border:0px;">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="userTableModel_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="userTableModel_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">
	var sysModelJson;
	var myModelJson = [];

	//关闭创建视图页面
    function closeForm() {
		parent.userTableModel.closeDialog("insert");
    }

    //保存视图
    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        //限制保存按钮多次点击
        $('#userTableModel_saveForm').addClass('disabled').unbind("click");

		myModelJson[1] = document.getElementById('viewName').value;
        parent.userTableModel.save(myModelJson);
    }

    $(document).ready(function () {
		myModelJson.push('insert');
		myModelJson.push('viewName');
		myModelJson.push('${belongTable}');

        //添加字段校验
        parent.userTableModel.formValidate($('#form'));

        //保存按钮绑定事件
        $('#userTableModel_saveForm').bind('click', function () {
            saveForm();
        });

        //返回按钮绑定事件
        $('#userTableModel_closeForm').bind('click', function () {
			closeForm();
        });

		//获取系统默认列表json
		sysModelJson = ${sysModelJson};

		for(i=0; i<sysModelJson.length; i++){
			if(sysModelJson[i].hidden == true){
				myModelJson.push(sysModelJson[i]);
			}
		}
    });

    //高亮预览字段列头
	function highlightPreviewTr(eleId) {
		$(".viewLi").css("background-color", "#F2F4FF");
		$("#" + eleId).css("background-color", "#FFE0B3");
	}

	//高亮选中行
	function highlightSelectTr(eleId) {
		$(".commonTableTrSec").css("background-color", "");
		$("#" + eleId).css("background-color", "#FFE0B3");
	}

	//选中字段的列表行添加拖拽事件
	function myMousedown(){
		$(".commonTableTrSec").mousedown(function(){
			var drag;

			//获取被拖拽的元素行
			for(i=0; i<event.path.length; i++){
				//event.path为当前被点击元素的元素谱系列表
				drag = event.path[i];

				//确保drag为行元素，而不是td元素
				if(drag.outerHTML.indexOf('<tr') == 0){
					break;
				}
			}

			//获取被拖拽行元素的元素id
			var startId = drag.id;

			//高亮新增的选中字段行
			highlightSelectTr(drag.id);

			startId = startId.replace('_Sec', '');
			var isDrag = true;
			var isMove = false;

			//拖拽元素的显影效果
			var theLine = document.getElementById('theLine');
			theLine.innerHTML = drag.innerHTML;
			theLine.style.width = drag.style.width;
			theLine.style.top = event.clientY + 'px';
			theLine.style.width = '150px';

			//鼠标移动事件
			$(".commonTableTrSec").mousemove(function () {
				if(isDrag == true){
					//移动被拖拽元素的显影
					theLine.style.left = (event.clientX + 10) + 'px';
					theLine.style.top = event.clientY+ 'px';

					theLine.style.display = "inline";
					isMove = true;
				}
			});

			//鼠标弹起事件
			$("#selectedTbody").mouseup(function () {
				//只有在选中字段行上点击鼠标时才触发拖拽事件
				if((isDrag == true) && (isMove == true)){
					var endEle;

					//获取拖拽结束时鼠标指向的元素
					for(i=0; i<event.path.length; i++){
						//event.path为当前被点击元素的元素谱系列表
						endEle = event.path[i];

						//确保endEle为行元素，而不是td元素
						if(endEle.outerHTML.indexOf('<tr') == 0){
							break;
						}
					}

					//获取结束行元素的id
					var endId = endEle.id;
					endId = endId.replace('_Sec', '');

					var startIndex = -1; //被拖拽元素在myModelJson中的下标
					var endIndex = -1; //拖拽结束时指向的元素在myModelJson中的下标

					//获取被拖拽元素、拖拽结束时指向的元素在myModelJson中的下标
					for(j=0; j<myModelJson.length; j++){
						if(myModelJson[j].name == startId){
							startIndex = j;
						}
						if(myModelJson[j].name == endId){
							endIndex = j;
						}

						if((startIndex>-1) && (endIndex>-1)){
							break;
						}
					}

					//上移
					if(startIndex > endIndex){
						//被拖拽元素移动至拖拽结束时指向元素的前面（insertBefore为原生js方法）
						document.getElementById('selectedTbody').insertBefore(drag, endEle);

						//列表预览模块将相应的拖拽元素移动至拖拽结束时指向元素的前面（insertBefore为原生js方法）
						var startPreview = document.getElementById(startId + '_preview');
						var endPreview = document.getElementById(endId + '_preview');
						document.getElementById('tablePreview').insertBefore(startPreview, endPreview);

						//更新myModelJson中数据的顺序
						var tempModel = myModelJson[startIndex];
						for(k=startIndex; k>endIndex; k--){
							myModelJson[k] = myModelJson[k-1];
						}
						myModelJson[endIndex] = tempModel;
					}
					//下移
					if(startIndex < endIndex){
						//被拖拽元素移动至拖拽结束时指向元素的后面（insertAfter为jQuery方法）
						$('#'+startId+'_Sec').insertAfter(endEle);

						//列表预览模块将相应的拖拽元素移动至拖拽结束时指向元素的后面（insertAfter为jQuery方法）
						var endPreview = document.getElementById(endId + '_preview');
						$('#'+startId+'_preview').insertAfter(endPreview);

						//更新myModelJson中数据的顺序
						var tempModel = myModelJson[startIndex];
						for(k=startIndex; k<endIndex; k++){
							myModelJson[k] = myModelJson[k+1];
						}
						myModelJson[endIndex] = tempModel;
					}
				}
			});
			//鼠标弹起事件，不论鼠标在何处弹起，隐藏theLine元素
			$(document).mouseup(function () {
				theLine.style.display = "none";
				isDrag = false;
				isMove = false;
			});
		});
	}

	//监控宽度输入框取值变化
	function inputChange(fieldIdentify){
		var width = document.getElementById(fieldIdentify+'Width_Sec').value;

		$('#'+ fieldIdentify + '_preview').css("width", width+"px");
		for(i=0; i<myModelJson.length; i++){
			var model = myModelJson[i];

			if(fieldIdentify == model.name){
				myModelJson[i].width = width;
				break;
			}
		}

		//高亮预览字段列头
		highlightPreviewTr(model.name + '_preview');
	}
	
	//添加全部表头字段
	function addAllField() {
		var tBody = document.getElementById('selectedTbody');
		var tablePreview = document.getElementById('tablePreview');

		for(i=0; i<sysModelJson.length; i++){
			var model = sysModelJson[i];
			var hasField = false;

			if(model.hidden == true){
				continue;
			}

			for(j=0; j<myModelJson.length; j++){
				if(model == myModelJson[j].name){
					hasField = true;
					break;
				}
			}

			//该字段之前未被选中
			if(!hasField){
				myModelJson.push(model);

				//在选中字段列表中增加相应的字段行
				tBody.innerHTML += '<tr class="commonTableTrSec" id="' + model.name + '_Sec">' +
										'<td width="60%">' + model.label + '</td>' +
										'<td width="25%">' +
											'<input class="form-control input-sm" type="text" value="' + model.width + '" id= "' + model.name + 'Width_Sec"\n' + 'onchange="inputChange(\'' + model.name + '\')"' +
												' onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,\'\')}else{this.value=this.value.replace(/\\D/g,\'\')}"' +
												' onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,\'\')}else{this.value=this.value.replace(/\\D/g,\'\')}">' +
										'</td>' +
										'<td width="15%"><img src="static/images/tabDel-hightlight.gif" onclick="delField(\'' + model.name + '\')"/></td>' +
									'</tr>';

				//在候选字段列表中隐藏对应的字段行
				document.getElementById(model.name).style.display = 'none';

				//在列表预览区显示相应的字段列头
				tablePreview.innerHTML += '<li class="viewLi" id="' + model.name + '_preview" style="width:' + model.width +'px; float:left;">' + model.label + '</li>';

				//为选中列表新增行添加拖拽事件
				myMousedown();
			}
		}
	}

	//添加表头字段
    function addField(fieldIdentify) {
    	var tBody = document.getElementById('selectedTbody');
    	var tablePreview = document.getElementById('tablePreview');

    	for(i=0; i<sysModelJson.length; i++){
    		var model = sysModelJson[i];
    		if(fieldIdentify == model.name){
				myModelJson.push(model);

				//在选中字段列表中增加相应的字段行
				tBody.innerHTML += '<tr class="commonTableTrSec" id="' + model.name + '_Sec">' +
										'<td width="60%">' + model.label + '</td>' +
										'<td width="25%">' +
											'<input class="form-control input-sm" type="text" value="' + model.width + '" id= "' + model.name + 'Width_Sec"\n' + 'onchange="inputChange(\'' + model.name + '\')"' +
												' onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,\'\')}else{this.value=this.value.replace(/\\D/g,\'\')}"' +
												' onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,\'\')}else{this.value=this.value.replace(/\\D/g,\'\')}">' +
										'</td>' +
										'<td width="15%"><img src="static/images/tabDel-hightlight.gif" onclick="delField(\'' + model.name + '\')"/></td>' +
									'</tr>';

				//在候选字段列表中隐藏对应的字段行
				document.getElementById(model.name).style.display = 'none';

				//在列表预览区显示相应的字段列头
				tablePreview.innerHTML += '<li class="viewLi" id="' + model.name + '_preview" style="width:' + model.width +'px; float:left;">' + model.label + '</li>';

				//高亮新增的选中字段行
				highlightSelectTr(model.name + '_Sec');

				//高亮预览字段列头
				highlightPreviewTr(model.name + '_preview');

				//为选中列表新增行添加拖拽事件
				myMousedown();

				break;
			}
		}
	}

	//删除选中的字段
	function delField(fieldIdentify) {
		//删除选中字段列表中相应的字段行
		var selectedFieldTr = document.getElementById(fieldIdentify + '_Sec');
		selectedFieldTr.parentNode.removeChild(selectedFieldTr);

		//在候选字段列表中恢复相应隐藏字段行的显示
		var fieldTr = document.getElementById(fieldIdentify);
		fieldTr.style.display = '';

		//删除列表预览中的相应表头
		var selectedFieldTr = document.getElementById(fieldIdentify + '_preview');
		selectedFieldTr.parentNode.removeChild(selectedFieldTr);

		//更新myModelJson
		for(i=0; i<myModelJson.length; i++){
			var model = myModelJson[i];

			if(fieldIdentify == model.name){
				myModelJson.splice(i, 1);
				break;
			}
		}
	}

	//删除全部选中字段
	function delAllField() {
		for(i=(myModelJson.length-1); i>2; i--){
			if(myModelJson[i].hidden == true){
				continue;
			}

			//删除选中字段列表中相应的字段行
			var selectedFieldTr = document.getElementById(myModelJson[i].name + '_Sec');
			selectedFieldTr.parentNode.removeChild(selectedFieldTr);

			//在候选字段列表中恢复相应隐藏字段行的显示
			var fieldTr = document.getElementById(myModelJson[i].name);
			fieldTr.style.display = '';

			//删除列表预览中的相应表头
			var selectedFieldTr = document.getElementById(myModelJson[i].name + '_preview');
			selectedFieldTr.parentNode.removeChild(selectedFieldTr);

			myModelJson.splice(i, 1);
		}
	}
</script>
</body>
</html>