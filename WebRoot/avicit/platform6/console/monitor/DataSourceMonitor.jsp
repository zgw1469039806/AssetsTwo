<%@page import="com.jolbox.bonecp.BoneCP"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@page import="com.jolbox.bonecp.BoneCPDataSource"%>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 
BoneCPDataSource boneCPDataSource = (BoneCPDataSource)SpringFactory.getBean("defaultDataSource");
BoneCP boneCP = boneCPDataSource.getPool();
String maxConnect=String.valueOf(boneCP.getConfig().getPartitionCount()*boneCP.getConfig().getMaxConnectionsPerPartition());
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>连接池监控信息</title>
</head>
<style>
html, body {
	margin: 0;
	font-family: "Microsoft YaHei" "Helvetica Neue", Helvetica, Arial,
		sans-serif;
}

body {
	padding: 20px;
	background-color: #fff;
}

table, th, td {
	border: 1px solid #dddddd;
}

table {
	width: 100%;
	border-collapse: collapse;
}

.tableBorder h1 {
	font-size: 16px;
	line-height: 20px;
	border-left: 4px solid #1182fa;
	padding-left: 14px;
	margin: 0 0 10px 0;
}

.table-bordered th, .table-bordered td {
	padding: 8px;
	line-height: 20px;
	text-align: left;
	vertical-align: top;
	font-size: 12px;
	font-family: "Microsoft YaHei";
	color: #333333;
}

.table-bordered td.table-td {
	background-color: #eaeaea;
}

.table-bordered td.td-title {
	font-weight: bold;
	width: 240px;
}

.table-bordered th {
	text-align: center;
	background-color: #eaeaea;
}
</style>
<body>
	<div class="tab-content">
		<div class="tableBorder">
			<h1>连接池资源信息</h1>
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td valign="top" class="td-title"><span class="font-title">*
						</span>当前已创建连接数</td>
						<td><%=boneCP.getTotalCreatedConnections()%></td>
					</tr>
					<tr>
						<td valign="top" class="td-title"><span class="font-title">*
						</span>当前已使用连接</td>
						<td><%=boneCP.getTotalLeased()%></td>
					</tr>
					<tr>
						<td valign="top" class="td-title"><span class="font-title">*
						</span>剩余空闲连接数</td>
						<td><%=boneCP.getTotalFree()%></td>
					</tr>
					<tr>
						<td valign="top" class="td-title"><span class="font-title">*
						</span>可用最大连接数</td>
						<td><%=maxConnect%></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="tableBorder" style="margin-top: 20px;">
			<h1>连接池配置信息</h1>
			<table class="table table-bordered">
				<thead>
					<th width="240px">属性</th>
					<th width="100px">当前系统数值</th>
					<th>说明</th>
					<th width="300px">建议值（生产环境）</th>
				</thead>
				<tbody>
					<tr>
						<td style="line-height: 40px;" class="td-title">partitionCount</td>
						<td style="line-height: 40px;"><%=boneCP.getConfig().getPartitionCount()%></td>
						<td>设置分区数,在PLSQL中运行select count(*) from v$process语句查看当前oracle数据库已使用连接数，根据最大连接数减去使用中连接数的差值来配置，一般设置3或4。</td>
						<td style="line-height: 40px;">3-4</td>
					</tr>
					<tr>
						<td class="td-title">maxConnectionsPerPartition</td>
						<td><%=boneCP.getConfig().getMaxConnectionsPerPartition()%></td>
						<td>设置每个分区含有connection最大个数。</td>
						<td>根据最大连接数减去使用中连接数的差值来配置,maxConnectionsPerPartition一般为100-150</td>
					</tr>
					<tr>
						<td class="td-title">minConnectionsPerPartition</td>
						<td><%=boneCP.getConfig().getMinConnectionsPerPartition()%></td>
						<td>设置每个分区含有connection最小个数。</td>
						<td>根据最大连接数减去使用中连接数的差值来配置,minConnectionsPerPartition一般为30-50</td>
					</tr>
					<tr>
						<td class="td-title">idleMaxAgeInMinutes</td>
						<td><%=boneCP.getConfig().getIdleMaxAgeInMinutes()%></td>
						<td>connection的空闲存活时间,通过ConnectionTesterThread观察每个分区中的connection，如果这个connection距离最后使用的时间大于这个参数就会被清除。注意：这个参数仅和idleConnectionTestPeriod搭配使用。</td>
						<td>4</td>
					</tr>
					<tr>
						<td style="line-height: 40px;" class="td-title">acquireIncrement</td>
						<td style="line-height: 40px;"><%=boneCP.getConfig().getAcquireIncrement()%></td>
						<td>设置分区中的connection增长数量,当每个分区中的connection大约快用完时，BoneCP动态批量创建connection,注意：这个配置属于每个分区的设置。</td>
						<td style="line-height: 40px;">5</td>
					</tr>
					<tr>
						<td class="td-title">poolAvailabilityThreshold</td>
						<td><%=boneCP.getConfig().getPoolAvailabilityThreshold()%></td>
						<td>设置连接池阀值,连接池为每个分区至少维持20%数量的可用connection。设置为0时，每当需要connection的时候，连接池就要重新创建新connection，这个时候可能导致应用程序可能会为了获得新connection而小等一会。</td>
						<td>2</td>
					</tr>
					<tr>
						<td class="td-title">connectionTimeoutInMs</td>
						<td><%=boneCP.getConfig().getConnectionTimeout()%></td>
						<td>获取connection超时的时间/ms,在调用getConnection获取connection时，获取时间超过了这个参数，就视为超时并报异常。</td>
						<td>5</td>
					</tr>
					<tr>
						<td style="line-height: 40px;" class="td-title">idleConnectionTestPeriodInMinutes</td>
						<td style="line-height: 40px;"><%=boneCP.getConfig().getIdleConnectionTestPeriodInMinutes()%></td>
						<td>测试connection的间隔时间,ConnectionTesterThread观察每个分区中的connection，
							若connection距最后使用的时间大于这个参数就会向数据库发送一条测试语句，若执行失败则将这个connection清除。</td>
						<td style="line-height: 40px;">1</td>
					</tr>
				</tbody>
			</table>
		</div>
		<%-- <div class="tableBorder" style="margin-top: 20px;">
			<h1>连接池统计信息</h1>
			<table class="table table-bordered">
				<thead>
					<th width="240px">属性</th>
					<th width="100px">当前系统数值</th>
					<th>说明</th>
				</thead>
				<tbody>
					<tr>
						<td style="line-height: 40px;" class="td-title">ConnectionWaitTimeAvg</td>
						<td style="line-height: 40px;"><%=boneCP.getStatistics().getConnectionWaitTimeAvg()%></td>
						<td>Return the average time it takes for a getConnection request to be services (in ms).</td>
					</tr>
					<tr>
						<td class="td-title">StatementExecuteTimeAvg</td>
						<td><%=boneCP.getStatistics().getStatementExecuteTimeAvg()%></td>
						<td>Return the average execution time for prepared statements to execute (in ms).</td>
					</tr>
					<tr>
						<td class="td-title">StatementPrepareTimeAvg</td>
						<td><%=boneCP.getStatistics().getStatementPrepareTimeAvg()%></td>
						<td>Return the statement prepare time average (in ms).</td>
					</tr>
					<tr>
						<td class="td-title">getCacheHits</td>
						<td><%=boneCP.getStatistics().getCacheHits()%></td>
						<td>Returns the cacheHits field.</td>
					</tr>
					<tr>
						<td class="td-title">CacheMiss</td>
						<td ><%=boneCP.getStatistics().getCacheMiss()%></td>
						<td>Returns the cacheMiss field.</td>
					</tr>
					<tr>
						<td class="td-title">StatementsCached</td>
						<td><%=boneCP.getStatistics().getStatementsCached()%></td>
						<td>Returns the number of statements that have been cached.</td>
					</tr>
					<tr>
						<td class="td-title">StatementsPrepared</td>
						<td><%=boneCP.getStatistics().getStatementsPrepared()%></td>
						<td>Returns the number of statements prepared.</td>
					</tr>
					<tr>
						<td  class="td-title">ConnectionsRequested</td>
						<td ><%=boneCP.getStatistics().getConnectionsRequested()%></td>
						<td>Returns the connectionsRequested field.</td>
					</tr>
					<tr>
						<td  class="td-title">CumulativeConnectionWaitTime</td>
						<td ><%=boneCP.getStatistics().getCumulativeConnectionWaitTime()%></td>
						<td>Returns the total time that the application waited in order to obtain its connections (in ms).</td>
					</tr>
					<tr>
						<td  class="td-title">CumulativeStatementExecutionTime</td>
						<td ><%=boneCP.getStatistics().getCumulativeStatementExecutionTime()%></td>
						<td>Returns the time taken for the prepared statements to execute (in ms).</td>
					</tr>
					<tr>
						<td  class="td-title">CumulativeStatementPrepareTime</td>
						<td ><%=boneCP.getStatistics().getCumulativeStatementPrepareTime()%></td>
						<td>Returns the time taken to prepare statements (or obtain from cache) (in ms).</td>
					</tr>
					<tr>
						<td  class="td-title">CacheHitRatio</td>
						<td ><%=boneCP.getStatistics().getCacheHitRatio()%></td>
						<td>Returns the cache hit ratio calculated as hits/(hits+misses).</td>
					</tr>
					<tr>
						<td  class="td-title">StatementsExecuted</td>
						<td ><%=boneCP.getStatistics().getStatementsExecuted()%></td>
						<td>Returns the number of statements that have been executed. </td>
					</tr>
				</tbody>
			</table>
		</div> --%>
	</div>
</body>
</html>