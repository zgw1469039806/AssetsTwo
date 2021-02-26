<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
	<style>
		* {
			font-family:'Microsoft YaHei';
		}
		td {
    		word-break: break-all;
    		padding: 5px 0;
		}
		body{
			font-size: 13px;
		}
	</style>
</head>
<body class="" style="">
	<table class="table table-striped table-bordered table-hover">
	<tbody>
		<tr>
			<td class="left" width="35%">ip地址:</td>
			<td id="hostIp" class="left">${systemInfo.hostIp}</td>
		</tr>
		<tr>
			<td class="left" width="35%">主机名:</td>

			<td class="left" id="hostName">${systemInfo.hostName}</td>
		</tr>
		<tr>
			<td class="left" width="35%">操作系统的名称:   </td>

			<td class="left" id="osName">${systemInfo.osName}-(版本${systemInfo.osVersion})-(${systemInfo.arch})</td>
	
		</tr>
		<tr>
			<td class="left" width="35%">CPU个数:</td>

			<td class="left" id="processors">${systemInfo.processors}</td>
		</tr>
		<tr>
			<td class="left" width="35%">CPU主频:</td>

			<td class="left" id="cpuInfo">${systemInfo.cpuInfo}</td>
		</tr>
		<tr>
			<td class="left" width="35%">物理内存大小:</td>

			<td class="left" id="ramSize">${systemInfo.ramSize}</td>
		</tr>
		<tr>
			<td class="left" width="35%">磁盘使用:</td>

			<td class="left" id="fileSystem">${systemInfo.diskUsePercent}</td>
		</tr>
		<tr>
			<td class="left" width="35%">Java版本:</td>
			<td class="left" id="javaVersion">${systemInfo.javaVersion}</td>
		</tr>
		<tr>
			<td class="left" width="35%">Java供应商的URL:</td>

			<td class="left" id="javaUrl">${systemInfo.javaUrl}</td>
		</tr>
		<tr>
			<td class="left" width="35%">Java的安装路径:</td>

			<td class="left" id="javaHome">${systemInfo.javaHome}</td>
		</tr>
	</tbody>
</table>
</body>
</html>