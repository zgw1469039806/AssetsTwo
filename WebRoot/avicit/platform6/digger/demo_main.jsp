<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>图形报表demo</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body>
       <h4>图形报表demo</h4>
      <div class="panel panel-primary">
          <div class="panel-heading">柱状图</div>
          <div class="panel-body">
             <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/bar-simple.html' ></iframe>
             <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/bar-dataset-simple0.html' ></iframe>
             <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/bar-y-category-stack.html' ></iframe>
             <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/bar-line.html' ></iframe>
          </div>
          <div class="panel-footer"></div>
      </div>

      <div class="panel panel-primary">
            <div class="panel-heading">折线图</div>
            <div class="panel-body">
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/line-simple.html' ></iframe>
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/line-area-basic.html' ></iframe>
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/line-stack.html' ></iframe>
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/line-area-stack.html' ></iframe>
            </div>
            <div class="panel-footer"></div>
        </div>

        <div class="panel panel-primary">
            <div class="panel-heading">饼图</div>
            <div class="panel-body">
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/pie-simple.html' ></iframe>
            </div>
            <div class="panel-footer"></div>
        </div>

         <div class="panel panel-primary">
            <div class="panel-heading">散点图</div>
            <div class="panel-body">
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/scatter-simple.html' ></iframe>
            </div>
            <div class="panel-footer"></div>
        </div>

        <div class="panel panel-primary">
            <div class="panel-heading">漏斗图</div>
            <div class="panel-body">
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/funnel.html' ></iframe>
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/funnel-customize.html' ></iframe>
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/funnel-mutiple.html' ></iframe>
            </div>
            <div class="panel-footer"></div>
        </div>

         <div class="panel panel-primary">
            <div class="panel-heading">特性</div>
            <div class="panel-body">
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/advance-line-area-bar.html' ></iframe>
               <iframe style="width: 600px;height:400px;border:0;" src='avicit/platform6/digger/event-line-area-bar.html' ></iframe>
            </div>
            <div class="panel-footer"></div>
        </div>


</body>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</html>