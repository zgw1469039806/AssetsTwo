<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript"
	src="avicit/platform6/portalie/js/SysMsgIe6.js"></script>
<script type="text/javascript">
var SysMsgIe6;
function GetQueryString(name) { 
	  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
	  var r = window.location.search.substr(1).match(reg); //获取url中"?"符后的字符串并正则匹配
	  var context = ""; 
	  if (r != null) 
	     context = r[2]; 
	  reg = null; 
	  r = null; 
	  return context == null || context == "" || context == "undefined" ? "" : context; 
	}
	var type = GetQueryString("type");
    document.ready = function () {
		$("#recvUsersAlias").on('click', function(e) {
			new EasyuiCommonSelect({
									selectModel:'multi',
									type : 'userSelect',
				                    idFiled : 'recvUser',
				                    textFiled : 'recvUsersAlias'
				                   }
			);
			this.blur();
		});
	inputPlaceHolder(); 
	commonExecte();
		//发送日期当前时间
		var curr_time=new Date();     
	    var strDate=curr_time.getFullYear()+"-";     
	    strDate +=curr_time.getMonth()+1+"-";     
	    strDate +=curr_time.getDate()+"-";     
	    strDate +=" "+curr_time.getHours()+":";     
	    strDate +=curr_time.getMinutes()+":";     
	    strDate +=curr_time.getSeconds();     
	    $("#sendDate").datetimebox("setValue",strDate); 
	    //消息接收人隐藏
	    $("input:radio[name='msgType']").on('click',function (){ 
			var value = $("input[name='msgType']:checked").val();
			if(value == 1){
				document.getElementById('recvUsesrAlias_span').style.display = 'none';
				document.getElementById('recvUsesrAlias_div').style.display = 'none';
			} else {
				document.getElementById('recvUsesrAlias_span').style.display = '';
				document.getElementById('recvUsesrAlias_div').style.display = '';
			}
			$('#recvUser').val("");
			$('#recvUsersAlias').val("");
		});
	
	};
	//关闭
	function closeForm() {
		var index = parent.layer.getFrameIndex(window.name);  
		parent.layer.close(index); 
	}
	//保存 根据不同进入方式走不同方法
	function saveForm() {
		var content = $("#content").val();
		if(content == null || content == ""){
			layer.alert('内容不能为空', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			return;
		}
		var sendDate = $("#sendDate").datetimebox("getValue");
		var disappearDate =$("#disappearDate").datetimebox("getValue");
        if(sendDate == null || sendDate == ""){
            layer.alert('发送日期不能为空', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            });
            return;
        }

		if(disappearDate == null || disappearDate == ""){
			layer.alert('到期时间不能为空', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				});
			return;
		}else if(sendDate != null && disappearDate != null && disappearDate != "" && sendDate != ""){
			if(sendDate>disappearDate){
				layer.alert('发送日期不能大于到期时间！', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					});
				return;
			}  
			if(type == "addButton"){
				parent.SysMsgIe6.save($("#form"),'insert');
			}else{
				
				avicAjax.ajax({
					 url:"msystem/sysmsg/sysMsgController/operation/save",
					 data : {
						 data :JSON.stringify(serializeObject($('#form'))),
                         j: Math.random()
					 		},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success"){
							 layer.msg('保存成功！');
							 var index = parent.layer.getFrameIndex(window.name);  
							 parent.layer.close(index); 
						 }else{
							 layer.alert('保存失败！' + r.error, {
								  icon: 7,
								  area: ['400px', ''], // 宽高
								  closeBtn: 0
								}
							);
						 } 
					 }
				 }); 
				
			}
		}
	 } 
</script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<form id='form'>
			<input type="hidden" name="id" />
			<input type="hidden" id="sourceCode" value="personal" name="sourceCode"/>
			<table class="form_commonTable">
				<tr>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span> 标题:</th>
					<td width="37%" colspan="3"><input title="标题" class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[50]'"
						style="width: 99%;" type="text" name="title" id="title" />
					</td>
				</tr>
				<tr>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span> 内容:</th>
					<td width="37%" colspan="3" ><textarea title="内容" name="content"
					         id="content" class="textareabox " onkeyup="this.value = this.value.slice(0, 500)" style="width: 99%;" rows='8'
							data-size="100" required></textarea></td>
				</tr>
				<tr>

					<th width="12%"
						style="word-break: break-all; word-warp: break-word;">所有人:</th>
					<td width="37%"><pt6:JigsawRadio name="msgType" title="msgType" defaultValue="0"
					 css_class="radio-inline"
							canUse="0" lookupCode="PLATFORM_SYSTEM_FLAG" /></td>
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span id='recvUsesrAlias_span'><label for="recvUsesrAlias">消息接收人:</label></span></th>
					<td width="37%">
						<span id='recvUsesrAlias_div' class="combo" style="width: 100%; height: 20px;">
							<input type="text" class="combo-text validatebox-text validatebox-invalid" title="消息接收人" placeholder="请选择用户" title="请选择用户"
								name="recvUsersAlias" id="recvUsersAlias" readonly />
								<span>
									<span class="ext-input-right-icon icon-all-file ext-input-right-icon-from" name="recvUsersAlias" id="recvUsersAlias"></span>
								</span>
							<input type="hidden" id="recvUser" name="recvUser" value="" />
						</span>
					</td>
				</tr>
				<tr>
				
				<tr>
				<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span>发送日期:</th>
					<td width="37%">
					<input title="发送日期" class="easyui-datetimebox" data-options="required:true"
						editable="false" style="width: 99%;" type="text" name="sendDate"
						id="sendDate" /></td>
				
					<th width="12%"
						style="word-break: break-all; word-warp: break-word;"><span
						class="remind">*</span>到期时间:</th>
					<td width="37%"><input title="到期时间" class="easyui-datetimebox"
						editable="false" style="width: 99%;" type="text" name="disappearDate"
						id="disappearDate" /></td>
				
				</tr>
				</table>
		</form>

	</div>
	</div>
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton primary-btn" onclick="saveForm()" role="button" title="发送">发送</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeForm()" role="button" title="返回" id="closeButton">返回</a>
					</td>
				</tr>
			</table>
		</div>

</body>
</html>