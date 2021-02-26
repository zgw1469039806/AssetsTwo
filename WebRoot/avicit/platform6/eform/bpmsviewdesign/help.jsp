<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>视图帮助</title>
</head>
<body>
    <h3>1.页面全局JS参数说明</h3>
    <span>
        电子表单封装全局js对象pageParams，可通过该对象获取到当前页面的相关信息：
        <br>
        <span style="color: red;">pageParams.urlParam</span> 返回对象；表示页面URL参数；
         <br>
        <span style="color: red;">pageParams.baseUrl</span> 返回字符串；表示基地址；
        <br>
        <span style="color: red;">pageParams.session</span> 返回对象；表示页面session数据；具体如下：
        <ul style="margin-top:0">
        <li>orgIndentity：当前组织应用ID</li>
        <li>appId：当前应用ID</li>
        <li>userId：当前用户ID</li>
        <li>userName：当前用户名称</li>
        <li>loginName：当前用户登录名</li>
        <li>deptId：当前部门ID</li>
        <li>deptName：当前部门名称</li>
        <li>user：当前用户对象</li>
        </ul>
    </span>
</body>
</html>