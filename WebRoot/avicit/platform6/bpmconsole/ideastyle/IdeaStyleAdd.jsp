<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<%
		String pdId = request.getParameter("pdId");
		String id = request.getParameter("id");
	%>
	
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
	<title>添加流程意见样式</title>
	<style>
		body td{
			font-family: Microsoft Yahei,sans-serif,Arial,Helvetica;
			font-size: 12px;
			padding-left: 0.5em;
		}
	</style>
	<script type="text/javascript">
	
	var baseurl = '<%=request.getContextPath()%>';
	var id = '<%=id%>';
	$(function(){
		if(id != '' && id != 'null'){
			ajaxRequest("POST","id=<%=id%>","platform/bpm/bpmconsole/ideaStyleManagerAction/getBpmIdeaStyle","json","getBpmIdeaStyleBack");
		}
    });
   
   	function getBpmIdeaStyleBack(retValue){
    	var ideaStyle=retValue.obj;
    	$("#id").attr("value",ideaStyle.id);
    	$("#title").attr("value",ideaStyle.title);
    	$("#quoteId").attr("value",ideaStyle.quoteId);
    	$("#code").attr("value",ideaStyle.code);
    	$("#orderBy").attr("value",ideaStyle.orderBy);
    	$("#styleName").attr("value",ideaStyle.styleName);
    	$("#position").val(ideaStyle.position);
    	$("#positionName").val(ideaStyle.positionName);
    	$("#attribute01").val(ideaStyle.attribute01);
    	$("#attribute01Name").val(ideaStyle.attribute01Name);
    	$("#activityAlias").attr("value",ideaStyle.activityAlias);
    	$("#activityName").attr("value",ideaStyle.activityName);
    	$("#type").combobox("setValue", ideaStyle.type);
    	$("#showSign").combobox("setValue", ideaStyle.showSign);
    }
   	
   	$(function(){
   		$(".positionImg").on("click",function(){
   	   		//var $inputs = $(this).prevAll("input");
   	   		var $inputs = $(this).parent().prev().find("input");
			var loadIds = $inputs.eq(0).val();
			var loadNames = $inputs.eq(1).val();
			positionLoadData = [];
			if(loadIds != null && loadIds != ""){
				var loadIdArr = loadIds.split(",");
				var loadNameArr = loadNames.split(",");
				for(var i = 0; i < loadIdArr.length; i++){
					var record = {
	 			    		positionId : loadIdArr[i],
	 			    		positionName : loadNameArr[i],
	 			    		positionCode : loadIdArr[i]
	 				};
					positionLoadData.push(record);
				}
			}
   			var usd = new UserSelectDialog('userSelectCommonDialog', 700, 400,
   					getPath2() + '/platform/user/bpmSelectUserAction/positionSelectCommon?isMultiple=true&isOrgIdentity=Y&idFlg=code',
   					'选择岗位');
   			var buttons = [ {
   				text : '确定',
   				id : 'processSubimt',
   				//iconCls : 'icon-submit',
   				handler : function() {
   					var frmId = $('#userSelectCommonDialog iframe').attr('id');
   					var frm = document.getElementById(frmId).contentWindow;
   					var resultDatas = frm.getSelectedResultDataJson();
   					var ids = "";
   					var names = "";
   					for ( var i = 0; i < resultDatas.length; i++) {
   						var resultData = resultDatas[i];
   						ids = ids + resultData.positionCode + ",";
   						names = names + resultData.positionName + ",";
   					}
   					if(ids!=null&&ids!=""){
   						ids = ids.substring(0,ids.length-1);
   						names = names.substring(0,names.length-1);
   					}else{
   						//$.messager.alert('提示', "请选择岗位");
   						//return ;
   					}
   					//$("#positionName").val(names);
   					$inputs.eq(0).val(ids);
   					//$("#position").val(ids);
   					$inputs.eq(1).val(names);
   					usd.close();
   				}
   			} ];
   			usd.createButtonsInDialog(buttons);
   			usd.show();
   	   	});
   	});
	
   	var positionLoadData = [];
   	function getPositionLoadData(){
   		return positionLoadData;
   	}
   	
	function selectProcessActivity(){
		actNamesForLoad = "";
		var actNamesVal = $("#activityName").val();
		if(actNamesVal != null && actNamesVal != ""){
			actNamesForLoad = actNamesVal;
		}
		var usd = new UserSelectDialog('processActivityDialog', 700, 400,
				getPath2() + '/avicit/platform6/bpmconsole/ideastyle/ProcessActivityList.jsp?pdId=<%=pdId%>',
				'选择流程节点');
		var buttons = [ {
			text : '确定',
			id : 'processSubimt',
			//iconCls : 'icon-submit',
			handler : function() {
				var frmId = $('#processActivityDialog iframe').attr('id');
				var frm = document.getElementById(frmId).contentWindow;
				var resultDatas = frm.getSelectedResultDataJson();

				var selfActName = '';
				var selfAlias = '';
				var bpmStyleIds = '';
				var relName = '';
				var processName = '';
				for ( var i = 0; i < resultDatas.length; i++) {
					var bool = false;
					var resultData = resultDatas[i];
					if (typeof(resultData.processType)!= 'undefined') {
						if(resultData.processType == "本流程"){
							bool = true;
						}
					}
					
					if(bool){ //本流程
						if (typeof(resultData.activityName) != 'undefined') {
							selfActName += resultData.activityName + ',';
						}
						if (typeof(resultData.activityAlias) != 'undefined') {
							selfAlias += resultData.activityAlias + ',';
						}
						if (typeof(resultData.processName) != 'undefined') {
							processName = resultData.processName;
						}
						
					}else{
						//父子流程
						if (typeof(resultData.bpmStyleId) != 'undefined') {
							bpmStyleIds += resultData.bpmStyleId + ',';
						}
						
						if (typeof(resultData.activityAlias) != 'undefined') {
							relName += resultData.activityAlias + ',';
						}
					}
				}

				
				selfAlias=selfAlias.substring(0,selfAlias.length-1);
				selfActName=selfActName.substring(0,selfActName.length-1);
				relName=relName.substring(0,relName.length-1);
				bpmStyleIds=bpmStyleIds.substring(0,bpmStyleIds.length-1);
				
				var activityAlias = "";
				//没有引用流程节点
				if(bpmStyleIds == "" && selfAlias !=""){
					activityAlias = processName+"["+selfAlias+"]";
				}
				
				//没有本流程节点
				if(bpmStyleIds != "" && selfAlias == ""){
					activityAlias = relName;
				}
				
				if(bpmStyleIds != "" && selfAlias != ""){
					activityAlias = processName+"["+selfAlias+"],"+relName;
				}
				$("#activityName").val(selfActName);
				$("#activityAlias").val(activityAlias);
				$("#quoteId").val(bpmStyleIds);
				usd.close();
			}
		} ];
		usd.createButtonsInDialog(buttons);
		usd.show();
	}
	
	var actNamesForLoad = "";
	function getActNames(){
		return actNamesForLoad;
	}
	</script>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id="form1" method="post">
			<input type="hidden" id="id" name="id"/>
        	<table class="form_commonTable">
				<tr>
					<th width="10%"><span class="remind">*</span>名称:</th>
					<td width="35%">
						<input id="quoteId"  name="quoteId" style="display:none;" />
						<input id="processDefinitionId"  name="processDefinitionId" style="display:none;" value="<%=pdId%>"/>
                        <input title="名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="title" id="title" />
					</td>
					<td width="5%"></td>
					<th width="10%"><span class="remind">*</span>代码:</th>
					<td width="35%">
						<input title="代码" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="code" id="code" />
					</td>
					<td width="5%"></td>
				</tr>
				<tr>
					<th><span class="remind">*</span>类型:</th>
					<td>
						<select class="easyui-combobox" name="type" id="type" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">   
							<option value="0">自用类型</option>
							<option value="1">引用类型</option>  
						</select> 
					</td>
					<td></td>
					<th><span class="remind">*</span>排序:</th>
					<td>
						<input title="排序" class="easyui-validatebox" data-options="required:true,validType:'maxLength[10]'" type="text" name="orderBy" id="orderBy" />
					</td>
					<td></td>
				</tr>
				<tr>
					<th><span class="remind">*</span>节点:</th>
					<td col = 4>
						<input id="activityName"  name="activityName" style="display:none;"/>
						<input title="节点" class="easyui-validatebox" data-options="required:true" type="text" name="activityAlias" id="activityAlias" readonly="readonly"/>
					</td>
					<td>
						<img  src="static/images/platform/bpm/client/images/button/tiaozhuan.png" title="选择流程节点" onclick="selectProcessActivity();" style="align:center;cursor:pointer;"/>
					</td>
				</tr>
				<tr>
					<th>查看岗位:</th>
					<td>
						<input id="position"  name="position" style="display:none;"/>
						<input title="配置那些岗位人员可以看到意见区域" class="easyui-validatebox" data-options="" type="text" name="positionName" id="positionName" readonly="readonly"/>
					</td>
					<td>
						<img class="positionImg" src="static/images/platform/bpm/client/images/button/renyuan.png" title="选择岗位" style="align:center;cursor:pointer;"/>
					</td>
					<th>显示岗位:</th>
					<td>
						<input id="attribute01"  name="attribute01" style="display:none;"/>
						<input title="配置意见区域显示哪些岗位人员的意见" class="easyui-validatebox" data-options="" type="text" name="attribute01Name" id="attribute01Name" readonly="readonly"/>
					</td>
					<td>
						<img class="positionImg" src="static/images/platform/bpm/client/images/button/renyuan.png" title="选择岗位" style="align:center;cursor:pointer;"/>
					</td>
				</tr>	
				<tr>
					<th>电子签名:</th>
					<td>
						<select class="easyui-combobox" name="showSign" id="showSign" data-options="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel">   
							<option value="0">不启用</option>
							<option value="1">启用</option> 
						</select> 
					</td>
					<td></td>
					<th><span class="remind">*</span>样式:</th>
					<td>
						<input title="样式" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" type="text" name="styleName" id="styleName" value="idea,user,day"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<th></th>
					<td>
					</td>
					<td></td>
					<th></th>
					<td>
						<small>格式：user,dept,day,time,idea,compel的任意组合，用,分割。比如：idea,user,day 显示格式为：意见，用户，日期,compel表示强制表态</small>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>

