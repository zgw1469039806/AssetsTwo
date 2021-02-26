<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<HTML>
<head>
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>

</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form' enctype="multipart/form-data">
			<input type="hidden" name="opinionId" id="opinionId" />
			<table class="form_commonTable">
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="opinionName">名称:</label></th>
					<td width="39%"><input title="名称" class="form-control input-sm" type="text" name="opinionName" id="opinionName" /></td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="opinionCode">代码:</label></th>
					<td width="39%"><input title="代码" class="form-control input-sm" type="text" name="opinionCode" id="opinionCode" /></td>
				</tr>
				<tr>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="opinionType">类型:</label></th>
					<td width="39%">
						<select class="form-control input-sm"  name="opinionType" id="opinionType" title="">
							<option value="0">自用类型</option>
							<option value="1">引用类型</option>
						</select>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="opinionOrder">排序:</label></th>
					<td width="39%"><input title="排序" class="form-control input-sm" type="text" name="opinionOrder" id="opinionOrder" /></td>
				</tr>
				<tr class="type1">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="subopinionName">流程意见:</label></th>
					<td width="39%">
					<div class="input-group  input-group-sm">
						<input type="hidden" name="subprocessDefId" id="subprocessDefId"/>
						<input type="hidden" name="subopinionCode" id="subopinionCode"/>
						<input title="流程意见" class="form-control" type="text" name="subopinionName" id="subopinionName" readonly/>
						<span class="input-group-btn">
							<button class="btn btn-default subprocessOrOpinionBtn" type="button" ><span class="glyphicon glyphicon-equalizer"></span></button>
						</span>
					</div>
					</td>
				</tr>
				<tr class="type0">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="opinionNodeText">节点:</label></th>
					<td width="39%">
					  <div id="nodeSelectBox" class="input-group input-group-sm avicselect">
		                    <input type="hidden" name="opinionNode" id="opinionNode" value>
		                    <input type="text" class="form-control" name="opinionNodeText" id="opinionNodeText" readonly />
		                    <span class="input-group-addon avicselect-act"><i class="glyphicon glyphicon-calendar"></i></span>
		                    <div class="avicselect-list"></div>
		                </div>
						<!-- <select class="form-control input-sm"  name="opinionNode" id="opinionNode" title="节点">
							<option value="">选择节点</option>
						</select> -->
					</td>
				</tr>
				<tr class="type0">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="positionbtn">查看岗位:</label></th>
							<td width="39%" >
								<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="positionId" name="positionId">
							      <input class="form-control" placeholder="请选择查看岗位" type="text" id="positionText" name="positionText" readonly>
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="positionTextBtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						        </div>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="ShowPositionbtn">显示岗位:</label></th>
							<td width="39%" >
								<div class="input-group  input-group-sm">
							   	  <input type="hidden"  id="showPositionId" name="showPositionId" value=''>
							      <input class="form-control" placeholder="请选择显示岗位" type="text" id="showPositionText" name="showPositionText" readonly>
							      <span class="input-group-btn">
							        <button class="btn btn-default" type="button" id="showPositionIdBtn" ><span class="glyphicon glyphicon-equalizer"></span></button>
							      </span>
						        </div>
					</td>
				</tr>
					<tr class="type0">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="e-sign">电子签名:</label></th>
					<td width="35%" >
						<select class="form-control input-sm"  name="eSign" id="eSign" title="">
							<option value="0">不启用</option>
							<option value="1">启用</option>
						</select>
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="ideaStyle">显示样式:</label></th>
					<td width="35%"  >
						<input title="显示样式" class="form-control input-sm" type="text" name="ideaStyle" id="ideaStyle" value="idea,day,user"/>
					</td>
				</tr>
				<tr class="type0">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="35%" >
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="35%"  >
						<select class="form-control input-sm"  id="ideaStyle_select" title="">
							<option value="idea,day,user" selected>意见，日期，用户</option>
							<option value="user,day,idea">用户，日期，意见</option>
							<option value="idea,time,user">意见，时间，用户</option>
							<option value="user,time,idea">用户，时间，意见</option>
						</select>
					</td>
				</tr>
				<tr class="type0">
					<th width="10%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="35%" >
					</td>
					<th width="10%" style="word-break: break-all; word-warp: break-word;"></th>
					<td width="35%"  >
						<small>
							显示样式格式：user,dept,day,time,idea,compel的任意组合，用,分割。比如：idea,user,day 显示格式为：意见，用户，日期,compel表示强制表态
						</small>
					</td>
				</tr>
			</table>

		</form>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script type="text/javascript" src="static/h5/avicSelectBar/compent/avicSelect_old/js/avicSelect.js"></script>
	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/bpmcommon/flowUtils.js"></script>
	<script type="text/javascript" src="avicit/platform6/bpmreform/forthird/BpmIdeaStyleSelect4Designer.js"></script>
	<script type="text/javascript">
	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
	var pid = flowUtils.getUrlQuery("id");
		function initTaskNode() {
			var values = parent.designerEditor.myCellMap.values();
			var taskData = [];
			$.each(values, function(i, n){
				if(n.tagName == "task"){
					var task = {
							'alias' : n.alias,
							'name' : n.name
					}
					taskData.push(task);
				}
			});

			 $('#nodeSelectBox').avicselect({
			        type: 1,
			        multi: true,
			        format:"name(alias)",
			        dataBind:{'name':'opinionNode'},
			        data: taskData,
			        remote:false,
			        tpl: '<ul>' +
			            '<@for ( var index in this ) {@>' +
			            '<li class="av-child" data-val=\'<@ JSON.stringify(this[index])@>\'><@ this[index].name@>(<@this[index].alias@>)</li>' +
			            '<@}@>' +
			            '</ul>'
			  });
		}

		$(function() {
			initTaskNode();

			/*  $('#applyOpinionNodeBtn').on('click',function(){
				  new H5CommonSelect({type:'positionSelect', idFiled:'showPositionId',textFiled:'showPositionText'});
			}); */
			 //viewScope : 'currentOrg'
			$('#showPositionIdBtn').on('click',function(){
				new H5CommonSelect({type:'positionSelect', idFiled:'showPositionId',textFiled:'showPositionText', selectModel : 'multi'});
			});

			$('#positionTextBtn').on('click',function(){
		    	new H5CommonSelect({type:'positionSelect', idFiled:'positionId',textFiled:'positionText', selectModel : 'multi'});
			});
			$('.subprocessOrOpinionBtn').on('click',function(){
		    	new BpmIdeaStyleSelect(function(subprocessDefId, subopinionCode, subopinionName){
		    		$("#subprocessDefId").val(subprocessDefId);
					$("#subopinionCode").val(subopinionCode);
					$("#subopinionName").val(subopinionName);
		    	}).show();;
			});
            var codes = parent.MyProcess.prototype.getInitOpinionCodes(pid, -1);
            $.validator.addMethod("unique", function(value, element) {
                var length = value.length;
                if(length != 0){
                    var index = $.inArray(value,codes);
                    if(index >= 0){
                        return false;
                    }
                }
                return true;
            }, "代码重复");
			$("form").validate({
				rules: {
					opinionName: {
						required: true
					},
					opinionCode: {
						required: true,
                        unique: true
					},
					opinionOrder: {
						required: true
					},
					opinionNodeText: {
						required: true
					},
					subopinionName: {
						required: true
					},
					opinionType: {
						required: true
					},
                    ideaStyle : {
                        required: true
                    }
				}
			});

			$("#opinionType").on("change", function(){
				if($(this).val() == "0"){
					$(".type0").show();
					$(".type1").hide();
				}else{
					$(".type0").hide();
					$(".type1").show();
				}
			});

            $("#ideaStyle_select").on("change", function () {
                $("#ideaStyle").val($(this).val())
            });

			$("#opinionType").trigger("change");
		});
	</script>
</body>
</html>
