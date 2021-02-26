<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
 	String importlibs = "common,table,form,tree";
%>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>搜索</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<!-- 样式标准化 boostrap.css -->

<!-- 公用 样式 -->
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/modules/system/newsearch/searchEntrance/css/common.css">
<!-- ztree 样式 -->
<link rel="stylesheet"
	href="avicit/platform6/modules/system/newsearch/searchEntrance/compent/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<!-- 时间选择 -->
<link rel="stylesheet"
	href="avicit/platform6/modules/system/newsearch/searchEntrance/compent/datepicker/dist/css/bootstrap-datepicker3.min.css"
	type="text/css">
<!-- 当前页 样式 -->
<!-- 框架依赖 jquery-1.9.1.js -->
<link rel="stylesheet" type="text/css"
	href="avicit/platform6/modules/system/newsearch/searchEntrance/compent/bootstrap/3.3.4/css_default/bootstrap.css">
<script type="text/javascript"
	src="avicit/platform6/modules/system/newsearch/searchEntrance/js/jquery-1.9.1.js"></script>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
 <jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>

<link rel="stylesheet" type="text/css"
	href="avicit/platform6/modules/system/newsearch/searchEntrance/css/search.css">
<style type="text/css">
</style>
</head>

<body>
	<div>
		<div class="searchHead">
		<div class="search-bar-box"> 
			<div class="search-bar">
				<form id="searchForm" name="sysFullTextSearchForm" method="post"
					action="platform/search/search.html" style="height: 40px;">
					<div class="input-group search-group clearfix">
						<%-- <input id="searchType" type="text" style="display:none" value="${searchType}" name="searchType"/> --%>
						<input id="keywords" placeholder="请输入搜索内容..." class="form-control"
							type="text" value="${keyword}" name="keywords" maxlength="100"
							class="s_ipt" autocomplete="off" /> <input id="histKey"
							type="hidden" value="1" name="histKey" /> <span
							class="input-group-btn">
							<button id="searchBtn1" type="button" class="btn search-icon">
								<span class="icon icon-search"></span>
							</button>
							<button id="searchBtn2" class="btn btn-primary" type="button">搜索</button>
						</span>
					</div>
					<!-- <div class="super-search">
                    	<a href="#"><button type="button" class="btn btn-primary">高级搜索</button></a>
                	 </div> -->
				</form>
			</div>
		</div>
			
			<div class="search-type">
				<ul id="myTab" class="nav nav-pills">
					<c:if test="${searchType eq ''}">
		               	<c:set var="activeST" value="active"/>
					</c:if> 
					<li class="${activeST}">
						<a href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=&dateParam=${dateParam}'">
							全部
						</a>
					</li>
					<c:forEach var="item" items="${typeList}" varStatus="status">
						<c:if test="${searchType eq item.code}">
							<c:set var="activeST" value="active" />
						</c:if>
						<c:if test="${searchType ne item.code}">
							<c:set var="activeST" value="" />
						</c:if>
						<li class="${activeST}"><a
							href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${item.code}&dateParam=${dateParam}'">
								${item.name} </a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<div class="searchBody">
			<!-- 搜索结果栏Start -->

			<div class="result-list">
				<!-- 结果头Start -->
				<div class="clearfix">
					<div class="result-list-top clearfix">
						<span style="vertical-align: middle;">时间区间 :</span>
						<div class="btn-group">
							<c:set var="timeShow" value="不限时间" />
							<c:if test="${dateParam eq '1'}">
								<c:set var="timeShow" value="一个月内" />
							</c:if>
							<c:if test="${dateParam eq '2'}">
								<c:set var="timeShow" value="二个月内" />
							</c:if>
							<c:if test="${dateParam eq '3'}">
								<c:set var="timeShow" value="三个月内" />
							</c:if>
							<c:if test="${dateParam eq '4'}">
								<c:set var="timeShow" value="四个月内" />
							</c:if>
							<c:if test="${dateParam eq '5'}">
								<c:set var="timeShow" value="五个月内" />
							</c:if>
							<c:if test="${dateParam eq '6'}">
								<c:set var="timeShow" value="六个月内" />
							</c:if>
							<c:if test="${dateParam eq '1200'}">
								<c:set var="timeShow" value="不限时间" />
							</c:if>
							<button type="button" class="btn btn-default">${timeShow}</button>
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<span class="caret"></span> <span class="sr-only"></span>
							</button>
							<ul id="dateRange " class="dropdown-menu">
								<c:set var="activeDR1" value="${dateParam==1?'active':''}" />
								<li class="${activeDR1}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=1'">一个月内</a>
								</li>
								<c:set var="activeDR2" value="${dateParam==2?'active':''}" />
								<li class="${activeDR2}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=2'">二个月内</a>
								</li>
								<c:set var="activeDR3" value="${dateParam==3?'active':''}" />
								<li class="${activeDR3}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=3'">三个月内</a>
								</li>
								<c:set var="activeDR4" value="${dateParam==4?'active':''}" />
								<li class="${activeDR4}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=4'">四个月内</a>
								</li>
								<c:set var="activeDR5" value="${dateParam==5?'active':''}" />
								<li class="${activeDR5}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=5'">五个月内</a>
								</li>
								<c:set var="activeDR6" value="${dateParam==6?'active':''}" />
								<li class="${activeDR6}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=6'">六个月内</a>
								</li>
								<c:set var="activeDR7" value="${dateParam==1200?'active':''}" />
								<li class="${activeDR7}"><a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=1200'">不限时间</a>
								</li>
							</ul>
							<%-- <select id="dateRange">
								<c:set var="activeDR1" value="${dateParam==1?'selected':''}" />
								<option value="1" selected="${activeDR1}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=1'">一个月内</a>
								</option>
								<c:set var="activeDR2" value="${dateParam==2?'selected':''}" />
								<option value="2" selected="${activeDR2}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=2'">二个月内</a>
								</option>
								<c:set var="activeDR3" value="${dateParam==3?'selected':''}" />
								<option value="3" selected="${activeDR3}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=3'">三个月内</a>
								</option>
								<c:set var="activeDR4" value="${dateParam==4?'selected':''}" />
								<option value="4" selected="${activeDR4}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=4'">四个月内</a>
								</option>
								<c:set var="activeDR5" value="${dateParam==5?'selected':''}" />
								<option value="5" selected="${activeDR5}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=5'">五个月内</a>
								</option>
								<c:set var="activeDR6" value="${dateParam==6?'selected':''}" />
								<option value="6" selected="${activeDR6}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=6'">六个月内</a>
								</option>
								<c:set var="activeDR7" value="${dateParam==1200?'selected':''}" />
								<option value="1200" selected="${activeDR7}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=1200'">不限时间</a>
								</option>
							</select> --%>						
						</div>
					</div>
					<%-- <div class="result-list-top clearfix">
						<span style="vertical-align: middle;">密级 :</span>
						<div class="btn-group">
							<button type="button" class="btn btn-default">全部</button>
							<button type="button" class="btn btn-default dropdown-toggle"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false">
								<span class="caret"></span> <span class="sr-only"></span>
							</button>
							<ul id="dateRange " class="dropdown-menu">
								<c:set var="activeDR6" value="${dateParam==6?'active':''}" />
								<li class="${activeDR6}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=6'">秘密
								</a></li>
								<c:set var="activeDR7" value="${dateParam==1200?'active':''}" />
								<li class="${activeDR7}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=1200'">非密</a>
								</li>
								<c:set var="activeDR6" value="${dateParam==6?'active':''}" />
								<li class="${activeDR6}"><a
									href="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&dateParam=6'">全部</a>
								</li>
							</ul>
						</div>
					</div> --%>
					<div class="result-list-top search-result-sort-time">
						<span class="active">排序：</span>
						<span class="active"><a href="javascript:void(0);">发布时间</a>
							<i></i></span>
					</div>
				</div>
				<div class="result-head">
					<div class="result-title">
						搜索<span class="kw">${keyword}</span>为您找到的结果为<span class="num">${totalCount}</span>个
					</div>
				</div>
			</div>

			<div class="date-range">

				<!-- 结构头End -->
				<div class="result-body">
					<c:forEach var="item" items="${result.result}" varStatus="status">
						<div class="each-result">
							<h3>${item.displayName}:
								<c:if test="${item.docType eq '1'}">
									<c:if test="${item.displayUrl eq null}">
										<a href="javascript:void(0);">${item.title}</a>
									</c:if>
									<c:if test="${item.displayUrl ne null}">
										<a href="javascript:void(0);" id="${item.id}"
											onclick="openUrl('${item.displayUrl}','${item.openType}','${item.id}')">${item.title}</a>
									</c:if>
									<%-- <a href="${item.displayUrl}" >${item.title}</a> --%>
								</c:if>
								<c:if test="${item.docType eq '2'}">
									<a href="platform/search/download/${item.id}.html">${item.title}</a>
								</c:if>
							</h3>
							<div class="desc">
								<%--
				       			<c:if test="${item.docType eq '1'}">
				        			摘要：描述:${item.customInfo.system_desc},id:${item.customInfo.id}
				        		</c:if>
				        	--%>
								<c:if
									test="${item.docType eq '1' && item.content ne null && item.content ne ''}">
				        			摘要：${item.content}
				        		</c:if>
								<c:if test="${item.docType eq '2'}">
				        			摘要：${item.content}
				        		</c:if>
							</div>
							<div class="sub">
								<%-- <c:if test="${item.docType eq '1'}">
		                            <span class="form">时间：${item.displayDate}</span>
		                        </c:if>
		                        <c:if test="${item.docType eq '2'}">
		                            <span class="form">时间：${item.displayDate}</span>
		                        </c:if> --%>
								<fmt:parseDate value="${item.displayDate}" type="both"
									pattern="yyyy-MM-dd HH:mm:ss" var="receiveDate" />
								<c:if test="${item.docType eq '1'}">
									<span class="form">时间：<fmt:formatDate
											value='${receiveDate}' pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>		创建人：${item.customInfo.created_name}</span>
								</c:if>
								<c:if test="${item.docType eq '2'}">
									<span class="form">时间：<fmt:formatDate
											value='${receiveDate}' pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>		创建人：${item.customInfo.created_name}</span>
								</c:if>
							</div>

						</div>
					</c:forEach>
				</div>
				<c:set var="pageShow" value="${totalCount > (rows==null?5:rows) ? '' : 'display:none'}" />
				<div class="page" style="${pageShow}">
					<nav>
						<ul class="pagination">
							<li><a
								href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&page=1&rows=5&dateParam=${dateParam}'">首页</a></li>
							<li><a
								href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${page-1>1?page-1:1}'">&laquo;</a></li>
							<c:forEach begin="1" end="${totalPages}" varStatus="loop">
								<c:if test="${loop.index<=10 && totalPages<=10}">
									<c:set var="active" value="${loop.index==page?'active':''}" />
									<li class="${active}"><a
										href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${loop.index}'">${loop.index}</a>
									</li>
								</c:if>
								<c:if
									test="${page+3<=totalPages && page-6>=1 && totalPages>10 }">
									<c:if test="${loop.index<=page+3 && loop.index>=page-6  }">
										<c:set var="active" value="${loop.index==page?'active':''}" />
										<li class="${active}"><a
											href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${loop.index}'">${loop.index}</a>
										</li>
									</c:if>
								</c:if>
								<c:if
									test="${page+3>totalPages && loop.index>=totalPages-9 && totalPages>10}">
									<c:set var="active" value="${loop.index==page?'active':''}" />
									<li class="${active}"><a
										href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${loop.index}'">${loop.index}</a>
									</li>
								</c:if>
								<c:if
									test="${page-6<1 && page+3<=totalPages && loop.index<=10 && totalPages>10}">
									<c:set var="active" value="${loop.index==page?'active':''}" />
									<li class="${active}"><a
										href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${loop.index}'">${loop.index}</a>
									</li>
								</c:if>
							</c:forEach>
							<li><a
								href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${page+1<totalPages?page+1:totalPages}'">&raquo;</a>
							</li>
							<li><a
								href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${keyword}'))+'&searchType=${searchType}&rows=5&dateParam=${dateParam}&page=${totalPages}'">尾页</a></li>
						</ul>
					</nav>
				</div>
			</div>

			<!-- 搜索结果栏End -->
			<!-- 类别栏目Start -->
			<div class="cate-list">
				<div class="cate-box">
					<div class="cate-win">
						<div class="group">
							<div class="title">
								热词：<span class="action s-up"><em>收起</em><i class="icon"></i></span>
							</div>
							<div class="cont" style="word-break: break-all;">
								<a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${hot0}'))+'&histKey=1'"
									class="keyword">${hot0}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${hot1}'))+'&histKey=1'"
									class="keyword">${hot1}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${hot2}'))+'&histKey=1'"
									class="keyword">${hot2}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${hot3}'))+'&histKey=1'"
									class="keyword">${hot3}</a>
							</div>
						</div>
						<div class="group">
							<div class="title">
								相关搜索：<span class="action s-up"><em>收起</em><i class="icon"></i></span>
							</div>
							<div class="cont" style="word-break: break-all;">
								<a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate0}'))+'&histKey=1'"
									class="keyword">${relate0}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate1}'))+'&histKey=1'"
									class="keyword">${relate1}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate2}'))+'&histKey=1'"
									class="keyword">${relate2}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate3}'))+'&histKey=1'"
									class="keyword">${relate3}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate4}'))+'&histKey=1'"
									class="keyword">${relate4}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate5}'))+'&histKey=1'"
									class="keyword">${relate5}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate6}'))+'&histKey=1'"
									class="keyword">${relate6}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate7}'))+'&histKey=1'"
									class="keyword">${relate7}</a> <a
									href="javascript:void(0);" onclick="javascript:location.href='<%=ViewUtil.getRequestPath(request)%>platform/search/search.html?keywords='+encodeURI(encodeURI('${relate8}'))+'&histKey=1'"
									class="keyword">${relate8}</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 类别栏End -->
		</div>
	</div>
	<jsp:include
		page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs" />
	</jsp:include>
	<!-- ztree 组件 -->
	<script type="text/javascript"
		src="avicit/platform6/modules/system/newsearch/searchEntrance/compent/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/modules/system/newsearch/searchEntrance/compent/jquery-ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js"></script>
	<!-- 时间组件 -->
	<script type="text/javascript"
		src="avicit/platform6/modules/system/newsearch/searchEntrance/compent/datepicker/dist/js/bootstrap-datepicker.min.js"></script>
	<script type="text/javascript"
		src="avicit/platform6/modules/system/newsearch/searchEntrance/compent/datepicker/dist/locales/bootstrap-datepicker.zh-CN.min.js"
		charset="UTF-8">
		
	</script>
	<!-- 页面脚本 search.js-->
	<script type="text/javascript"
		src="avicit/platform6/modules/system/newsearch/searchEntrance/js/search.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#searchBtn1").click(function() {
				var searchtext = $("#keywords").val();
				if(searchtext != "请输入搜索内容..."){
					$("#searchForm").submit();
					alert("123");
					$(".myTab li").addClass("active"); 
				}
			})
			$("#searchBtn2").click(function() {
				var searchtext = $("#keywords").val();
				if(searchtext != "请输入搜索内容..."){
					$("#searchForm").submit();
					$(".myTab li").addClass("active"); 
				}
			})
		});
		function openUrl(url, openType, aId) {
			if (openType == "dialog") {
				layer.open({
					type : 2,
					title : '详细页',
					skin : 'bs-modal',
					area : [ '70%', '70%' ],
					maxmin : false,
					content : url
				});
			} else if (openType == "mainFrame") {
				parent.addTab('详细页', url);
			} else {
				document.getElementById(aId).href = url;
				document.getElementById(aId).target = "_blank";
			}
		}
	</script>
</body>
</html>