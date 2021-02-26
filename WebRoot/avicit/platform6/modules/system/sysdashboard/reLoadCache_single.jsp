<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>刷新缓存</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
td span {
	padding: 0px 10px;
	height: 25px;
	display:block;
	float:left;
}
button {
	height: 25px;
	width: 150px;
	color: #606060;
	border: solid 1px #b7b7b7;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top, #fff, #ededed);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}
</style>
</head>

<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false">
		<p>
			<table>
				<tbody>
					<tr>
						<td>
							<button _type="user" _host="local">刷新大用户模块缓存</button>
						</td>
						<td>
							<span>刷新组织机构及用户基础数据，包括组织、部门、用户、角色、岗位、群组及他们之间的关联关系信息。注：默认是自动同步缓存的，如果出现缓存出现差错，可以通过该功能手动同步缓存。</span>
						</td>
					</tr>
				</tbody>
			</table>
		</p>
		<p>
			<table>
				<tbody>
					<tr>
						<td>
							<button _type="other" _host="local">刷新其他基础数据缓存</button>
						</td>
						<td>
							<span>刷新其他基础数据，包括多应用、个人设置、多语言、通用代码、菜单、消息、密码、数据权限、系统参数、系统资源、IP限制、PORTLET等数据。注：默认是自动同步缓存的，如果出现缓存出现差错，可以通过该功能手动同步缓存。</span>
						</td>
					</tr>
				</tbody>
			</table>
		</p>
		<p>
			<table>
				<tbody>
					<tr>
						<td>
							<button _type="auth" _host="local">刷新菜单授权缓存</button>
						</td>
						<td>
							<span>刷新菜单资源授权缓存，如果你使用了菜单授权模块或集中授权模块，需要使用该按钮刷新缓存。注：在菜单授权模块和集中授权模块内部也有对应的刷新缓存的按钮，可以在做完授权操作后即刻刷新对应缓存。</span>
						</td>
					</tr>
				</tbody>
			</table>
		</p>
		<p>
			<table>
				<tbody>
					<tr>
						<td>
							<button _type="process" _host="local">刷新流程缓存</button>
						</td>
						<td>
							<span>刷新业务流程管理中的缓存，包括流程定义文件、流程表单、目录、元素权限、表单与流程的关联关系等缓存。注：在业务流程管理下的对应模块中也有刷新缓存的按钮，可以在做完操作后即刻刷新对应数据的缓存。</span>
						</td>
					</tr>
				</tbody>
			</table>
		</p>
		<p>
			<table>
				<tbody>
					<tr>
						<td>
							<button _type="all" _host="local">刷新全部缓存</button>
						</td>
						<td>
							<span>刷新以上全部缓存。</span>
						</td>
					</tr>
				</tbody>
			</table>
		</p>
	</div>
	<script type="text/javascript">
		$(function() {
			$("button").on("click", function() {
				var type = $(this).attr("_type");
				var url = "platform/cache/RefreshCacheController/refresh";
				$.messager.progress({
					title : '请稍后',
					msg : '正在刷新缓存...'
				});
				$.ajax({
					type : "POST",
					data : {
						type : type
					},
					url : url,
					dataType : "json",
					success : function(r) {
						$.messager.progress('close');
						if (r.success) {
						//	$.messager.alert("提示", "刷新成功！", "info");
							$.messager.show({title:"提示", msg:"刷新成功！"});
						} else {
							$.messager.alert("提示", "刷新失败！", "error");
						}
					}
				});
			});
		});
	</script>
</body>
</html>
