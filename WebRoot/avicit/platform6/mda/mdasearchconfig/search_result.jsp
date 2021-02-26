<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<head>
<title>${searchwords}_搜索结果</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdasearchconfig/js/MdaSearchconfig.js" type="text/javascript"></script>
<script src="avicit/platform6/mda/mdasearchconfig/js/JSon.js" type="text/javascript"></script>
<link rel="shortcut icon" href="static/images/search_imgs/favicon.ico" />
<link rel="bookmark" href="static/images/search_imgs/favicon.ico" />
<style type="text/css">
body {
	font: Arial, Helvetica, sans-serif normal 10px;
	background: #ffffff;
	margin:0px 0px 0px 0px;
}

a{
color:blue;
}

a.big{ 
	color:#FFCC00;
	text-align:center;
	
	font-size:48px;
	
}
a.small{
	color:#000000;
	text-align:center;
	font-size:20px;
}
a.title{
	color:#000000;
	font-size:16px;
	font-weight:500;
}
a.content{
	color:#000000;
	font-size:13px;
}
a.linker{
	color:#0000ff;
	font-size:12px;
}
a.numlinker{
	color:#0000ff;
	font-size:15px;
}
a.mtime{
	color:#808080;
	font-size:12px;
}

a.supic{
	font-size:13px;
}
a.supic:link{color: #A0522D}/*#FF0000 未访问的链接 */
a.supic:visited{color: #A0522D}/* 已访问的链接 #00FF00绿色*/
a.supic:hover{
	color: #009d00;
}/* 当有鼠标悬停在链接上 */
a.supic:active{color: #0000FF}


.divtwo{
	float:left;
	border:none;
	width:650;
	height:42;
	margin:12px 5px 5px 2px;
	
}

p{
	font-size: 12px;
}
.sp{
	text-align:center;
	height:80px;
	background:#FFFFFF; 
	margin:auto;
	padding:0 0 0 5px; 
	float:left;
	border-right:#cccccc 3px solid;
	border-color:#cccccc;
}
.spactive{
	text-align:center;
	height:80px;
	background:#FFFFFF; 
	margin:auto;
	padding:0px; 
	float:left;
	border-right:#cccccc 3px solid;
	border-color:#A0522D;
}

.main1{
	float:left;
	border:none;
	width:60%;
	list-style-type:none;
}
.main2{
	float:left;
	border:none;
	width:45%;
	list-style-type:none;
	 
}
.foot{


	font-family:Arial, Helvetica, sans-serif;
    background:#666666; 
	height:33px;
	font-size:12px;
	width:100%;
	padding-top:20px; 
	margin-top:0px;
	color:#FFFFFF;
	text-align:center;
}
.footdiv{
	background:#a7a7a7;
	height:33px;
	font-size:14px;
	text-align:center;
	line-height:33px;
}

#page { margin:15px auto; text-align:left; clear:both;  padding-top:5px;  height:21px;}
#page a { padding:3px 6px 2px; margin:3px; background:#e9e9e9; text-align:center; color:#000;}/* 第一个是框框背景色，第二个是数字的颜色，  */
#page a:hover,#pages a.now:hover{ background:#878787;  color:#fff;}/*第一个是鼠标放上去的颜色，第二个是放上去时字的颜色*/


</style>

<script type="text/javascript">
    function ok_onclick(start){
        console.log('----------click');
        var searchwords=document.getElementById("sousuo").value;
       // var start = 0;
        var rows = 20;
       var url="platform6/mda/mdasearchconfig/mdaSearchController/operation/search?start="+start+"&rows="+rows+"&searchword="+searchwords;
       console.log('----------url:'+url);
       window.location.href = url;
    }
   
    
    //查看详情
    function supic(jsonData){
        var data = JSON.stringify(jsonData);
        alert(data);
        var URL = "platform6/mda/mdasearchconfig/mdaSearchController/operation/show/3/"+data;
        //alert("============="+jsonData.USERNAME);
        //弹出页面
        document.getElementById("ifrm").src= URL;
        document.getElementById("ifrm").hidden="";
        var spanlist = document.getElementsByTagName("span");
    }

    document.onkeydown = function(e){
        if(!e) e = window.event;//火狐中是 window.event
        if((e.keyCode || e.which) == 13){
            document.getElementById("subok").click();
        }
      }
    
    
  //进入索引数据管理按钮绑定事件
    function doJump4URL(URL) {
    	layer.open({
    	    type: 2,
    	    area: ['100%', '100%'],
    	    title: '自定义URL跳转',
    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, //开启最大化最小化按钮
    	    content: URL
    	   // content: 'http://www.baidu.com/'
    	}); 
    }	
  //进入索引数据管理按钮绑定事件
    function solrconfigFlag(solrcoreID) {
	  
	  var URL = 'platform6/mda/mdacollections/mdaCollectionsController/toSolrCoreManage/'+solrcoreID+'.';
    //	document.getElementById("ifrm").src= URL;
	  
    	layer.open({
    	    type: 2,
    	    area: ['100%', '100%'],
    	    title: '搜索数据详情',
    	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
            maxmin: false, //开启最大化最小化按钮
            content: URL
    	});  
    }	
  
  
</script>
</head>

<body>
<div id="f1" name="f1"  modelAttribute="search" >
	<div class="divtwo">
		<table  style=" valign:top;border:none;margin-left:3px;">
			<tr align="center">
				<td align="center">
				  <div class="row" style="width:550px;left:6%; margin:0 0 0 0; position:absolute; top:5%;" >
						<div class="input-group  input-group-sm">
					      <input id="sousuo" name="word" class="form-control" value="${searchwords}" placeholder="请输入关键字。。。" type="text" >
					      <span class="input-group-btn">
					        <button id="subok" class="btn btn-default ztree-search" type="button"  onclick="ok_onclick('${searchResult.start}')" ><span class="glyphicon glyphicon-search"><font style="margin:5px;" >搜索一下</font></font></font></span></button>
					      </span>
					    </div>
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<div style="clear:both"></div>
	
	 <table style="margin-left:75px;margin-top:55px;padding:13px 0 3px 4px">
	 
		<c:if test="${searchResult.total == -1}">
		   <tr>
				<td>
					<table>
						<tr>
							<th><b >很抱歉<em style="color: red;">“${searchwords}”</em>涉及敏感词，未搜到相关信息...换个词试试吧！</b></th>
						</tr>
					</table>
				</td>
			</tr>
		 </table>
		</c:if>
		<c:if test="${searchResult.total == 0}">
		   <tr>
				<td>
					<table>
						<tr>
							<th><b >很抱歉，未搜到相关信息...换个词试试吧！</b></th>
						</tr>
					</table>
				</td>
			</tr>
		 </table>
		</c:if>
		<c:if test="${searchResult.total >0}">
		<c:forEach  var="solrData" items="${searchResult.solrDataList}"  >
			<tr  height="30">
				<td>
					<table>
						<tr>
							<th><b >标题：</b></th>
							<td>${solrData.title }</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="20" >
				<td>
					<table>
						<tr>
							<th><b >所属数据源：</b></th>
							<td>${solrData.solrDataSourceName }</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<th><b >所属分类：</b></th>
							<td>${solrData.solrDataClassify }</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="20" style="margin-top:75px;">
				<td>
					<table>
						<tr>
							<th><b >采集日期：</b></th>
							<td>${solrData.crawledate }</td>
							<th><b style="margin-left:30px;">自定义链接：</b></th>
							<td><a href="javascript:void(0);"  onclick="doJump4URL('${solrData.url}')">${solrData.url}</a></td>
							<th><b style="margin-left:30px; "><a  href="javascript:solrconfigFlag('${solrData.id}')">详情信息</a></b></th>
						</tr>
					</table>
				</td>
			</tr>
			<tr height="23" style="margin-top:75px;">
				<td>
					<table>
						<tr>
						<th><b>概述：</b></th>
						<td>${solrData.content}</td>
						</tr>
					</table>
				</td>
			</tr>
			
			<tr >
				<td>
					<table>
						<tr>
							<td style="hight:50px;">---------------</td>
						</tr>
					</table>
				</td>
			</tr>
		</c:forEach>
      </table>
   </div>
  <div style="margin-left:80px;margin-bottom: 40px;">
	   <p id="page">
	    <input type="hidden" name="currentPage"  id ="currentPage_id" />
	   		<c:if test="${(searchResult.start-5) > 0}">
		    	<a href="javascript:void(0)" onclick="ok_onclick('${searchResult.start-1}')">上一页</a>
		    </c:if>
		    <c:forEach begin="${(searchResult.start-5)<0?0:(searchResult.start-5)}" end="${(searchResult.start+5)>searchResult.pageCount?searchResult.pageCount:(searchResult.start+5)}" step="1" var="num">
                  <c:choose>
                      <c:when test="${num == searchResult.start}">
                          <strong> 
			   					<span class=""></span>
			   					<a class="numlinker">
			   					${num+1}
			   					</a>
			   				</strong>
                      </c:when>
                      <c:otherwise>
                          <a href="javascript:void(0)" onclick="ok_onclick('${num}')">${num+1 }</a>
                      </c:otherwise>
                  </c:choose>
               </c:forEach>
		    
	   		<c:if test="${(searchResult.start+5) < searchResult.pageCount}">
		    	<a href="javascript:void(0)" onclick="ok_onclick('${searchResult.start+1}')">下一页</a>
		    </c:if>
	          &nbsp;&nbsp;&nbsp;&nbsp; <b>共${searchResult.pageCount+1}页，总 计 ${searchResult.total}条记录</b>
	   </p>
   </div>
 </c:if>
   <div class="main2"   style="right:1%; margin:0 0 0 0; position:absolute; top:15%;"> 
   		<iframe src="" name="ifrm" id="ifrm" width="95%"  height="900px" frameborder="none"></iframe>
   </div>
<!-- <div style="clear:both"></div>
<div class="footdiv">
	<p>版权所有 &copy;</p>
</div> -->
</body>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/mda/mdacollections/js/MdaCollections.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function () {
	 // var URL = 'platform/platform6/mda/mdasearchconfig/mdaSearchconfigController/toStatic';
	 // var URL = 'platform6/mda/mdakeywords/mdaKeywordsController/toMdaKeywordsManage';
	//  document.getElementById("ifrm").src= URL;
});
</script>
</html>                    