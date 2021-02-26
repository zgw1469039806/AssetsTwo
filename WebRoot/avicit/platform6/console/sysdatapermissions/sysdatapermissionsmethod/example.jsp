<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<title>示例</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta charset="utf-8">
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="avicit/platform6/console/sysdatapermissions/plugins/layui/css/layui.css"  media="all">
<link rel="stylesheet" href="static/h5/layer-v2.3/layer/skin/layer.css"  media="all">
</head>
<body>
<pre class="layui-code" lay-height="150px">
package avicit.platform6.msystem;

import java.util.Map;

public class Test {

	/**
	 * 配置的方法路径为：avicit.platform6.msystem.Test.getSql
	 */
	public String getSql(Map&lt;String, String> paramMap) {
		String tableName = paramMap.get("tableName"); // 配置的表名
		String loginUserId = paramMap.get("loginUserId"); // 登录人ID
		String loginOrgId = paramMap.get("loginOrgId"); // 登录组织ID
		String loginDeptId = paramMap.get("loginDeptId"); // 登录人部门ID
		return " 列 比较符 ( select XXX from XXX where XXX )"; // 返回的SQL，格式为：列 比较符 值
	}

}
</pre>       
</body>
<script src="static/h5/layer-v2.3/layer/layer.js" charset="utf-8"></script>
<script>
	layui.use('code', function(){});
</script>
</html>