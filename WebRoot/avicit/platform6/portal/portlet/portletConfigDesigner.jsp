<%@page import="avicit.platform6.api.sysshirolog.impl.AfterLoginSessionProcess"%>
<%@page import="java.util.Enumeration"%>
<%@page language="java"  pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page import="avicit.platform6.api.sysuser.dto.SysUser" %>
<!DOCTYPE html>
<%
/*String userId = SessionHelper.getLoginSysUserId(request);*/
SysUser loginSysUser = SessionHelper.getLoginSysUser(request);
String consoleType = loginSysUser.getConsoleType();
String skinsValue = (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN);
String colorValue =  (String)session.getAttribute(AfterLoginSessionProcess.SESSION_CURRENT_USER_SKIN_TYPE);
String isPortal = request.getParameter("isPortal") == null ? "false" : request.getParameter("isPortal");
if(skinsValue == null || isPortal.equals("false")){
	skinsValue="avicit/platform6/portal/themes/oa/skins/blue/skin/style.css";
}
if(colorValue == null  || isPortal.equals("false")){
	colorValue = "blue";
}
%>
<html>
<head>
<meta charset="utf-8">
<base href="<%=ViewUtil.getRequestPath(request)%>">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="renderer" content="webkit|ie-stand">
<title>自定义个人首页</title>

<!-- Le styles -->
<link href="avicit/platform6/portal/portlet/css/bootstrap-combined.min.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="static/h5/skin/css/toolbar.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/skin/iconfont/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="static/h5/skin/default.css"/>

<link href="avicit/platform6/portal/portlet/css/layoutit.css" rel="stylesheet">
<link href="avicit/platform6/portal/portlet/css/layoutit_extend.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="avicit/platform6/portal/portlet/css/guider.css"/>
<link rel="stylesheet" type="text/css" id="skin_link" href="<%=skinsValue%>"/>
<link rel="stylesheet" type="text/css" id="color_link" href="avicit/platform6/portal/skin/<%=colorValue %>.css"/>

<style>
  input, textarea {
      box-sizing: border-box;
  }
  .form-tool-btn i {
    margin-top:3px;
  }
  .form-tool-btn .caret {
    margin-top:12px;
    margin-left:5px;
    border-top-color:#888;
  }
   .form-tool-btn:hover .caret,.form-tool-btn:FOCUS .caret{
     border-top-color:#fff;
   }
  label, input, button, select, textarea {
      font-size: 13px !important;
  }
  .form-tool-btn, .layui-layer-btn1, .layui-layer-btn2{
      line-height: 28px !important;
  }
  #elmJS .preview{
      width: 80%;
      white-space: nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
  }
</style>

<!--[if lt IE 9]>
<script src="static/h5/bootstrap/html5shiv.js"></script>
<script src="static/h5/bootstrap/respond.min.js"></script>
<![endif]-->

<script type="text/javascript" src="static/h5/jquery/jquery-1.9.1.js"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<![endif]-->
<script type="text/javascript" src="static/h5/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script type="text/javascript" src="avicit/platform6/portal/portlet/js/jquery-ui.js"></script>
<script type="text/javascript" src="avicit/platform6/portal/portlet/js/jquery.ui.touch-punch.min.js"></script>
<script type="text/javascript" src="avicit/platform6/portal/portlet/js/jquery.htmlClean.js"></script>
<script type="text/javascript" src="static/h5/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="static/h5/ckeditor/config.js"></script>
<script type="text/javascript" src="avicit/platform6/portal/portlet/js/scripts.js"></script>
<script type="text/javascript" src="static/h5/layer-v2.3/layer/layer.js"></script>
<body style="min-height: 660px;min-width:400px; cursor: auto;" class="edit">
<div class="navbar navbar-inverse navbar-fixed-top" style='display:block'>
  <div class="navbar-inner" >
    <div class="container-fluid" >
    	<div id="tableToolbar" class="toolbar" style="padding: 7px 2px 6px 0px;">
            <span style="font-size: 13px;margin-left: 10px;"><font color="red">&nbsp;*&nbsp;</font>首页名称：</span>
            <c:choose>
                <c:when test="${isPortal}">
                    <input type="text" id="portletName" name="portletName"  style="width:200px;height: 28px;" class="form-control input-sm" ${disabled} value="${portletName}">
                </c:when>
                <c:otherwise>
                    <input type="text" id="portletName" name="portletName"  style="width:200px;height: 28px;" class="form-control input-sm" value="${portletName}">
                </c:otherwise>
            </c:choose>

    		<span style="font-size: 13px;margin-left: 10px;"><font color="red">&nbsp;*&nbsp;</font>排序：</span>
            <%--portal入口进入,只有用户自定义的才可以编辑--%>
            <c:choose>
                <c:when test="${isPortal}">
                    <input type="text" id="orderBy" name="orderBy"  style="width:200px;height: 28px;" class="form-control input-sm" ${disabled} value="${orderBy}">
                </c:when>
                <c:otherwise>
                    <input type="text" id="orderBy" name="orderBy"  style="width:200px;height: 28px;" class="form-control input-sm" value="${orderBy}">
                </c:otherwise>
            </c:choose>
			<div class="toolbar-right" style="margin-top: -5px;">
				<div class="dropdown" style="display: inline">
					<a id="config" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="设置" data-toggle="dropdown" id="dropdownMenu"><i class="icon icon-shezhi"></i> 设置<span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
            <c:choose>
                <c:when test="${isPortal}">  
                   <li role="presentation" id="setDefault"><a href="javascript:void(0);">设置默认门户</a></li>
               </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${isRestDefault}">  
                   <li role="presentation" id="restDefault"><a href="javascript:void(0);">恢复默认门户</a></li>
               </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${isDisplayDelete}">
                   <li role="presentation" id="delete"><a href="javascript:void(0);">删除此门户</a></li>
               </c:when>
            </c:choose>
					</ul>
				</div>
                <a id="edit" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" style="display: none;" role="button" title="编辑"><i class="icon iconfont icon-bianji"></i> 编辑</a>
                <a id="sourcepreview" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"  role="button" title="预览"><i class="icon icon-view1"></i> 预览</a>
        		<a id="save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="icon icon-save "></i> 保存</a>
        		<a id="cancel" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存"><i class="icon icon-guanbi1 "></i> 取消</a>

			</div>
		</div>
      <!--/.nav-collapse --> 
    </div>
  </div>
</div>
<div class="container-fluid" >
  <div class="row-fluid">
    <div class="">
      <div class="sidebar-nav">
        <ul class="nav nav-list accordion-group">
          <li class="nav-header">布局设置  <i class='icon-chevron-up'></i></li>
          <li style="display: list-item;margin-right:15px;" class="rows" id="estRows">
            <div class='lyrow ui-draggable'> <a href='#close' class='remove label'><i class='icon-trash'></i></a> <span class='drag label'><i class="icon-move"></i></span>
              <div class="preview">
                <input value="一列" type="text" disabled="disabled"/>
              </div>
              <div class="view one_column">
                <div class="row-fluid clearfix">
                  <div class="span12 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
              <div class="preview">
                <input value="两列(50/50)" type="text" disabled="disabled"/>
              </div>
              <div class="view two_column_5_5">
                <div class="row-fluid clearfix">
                  <div class="span6 column"></div>
                  <div class="span6 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
              <div class="preview">
                <input value="两列(30/70)" type="text" disabled="disabled"/>
              </div>
              <div class="view two_column_3_7">
                <div class="row-fluid clearfix">
                  <div class="span3 column"></div>
                  <div class="span9 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
              <div class="preview">
                <input value="两列(70/30)" type="text" disabled="disabled"/>
              </div>
              <div class="view two_column_7_3">
                <div class="row-fluid clearfix">
                  <div class="span9 column"></div>
                  <div class="span3 column"></div>
                </div>
              </div>
            </div>
              <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
                  <div class="preview">
                      <input value="两列(40/60)" type="text" disabled="disabled"/>
                  </div>
                  <div class="view two_column_4_6">
                      <div class="row-fluid clearfix">
                          <div class="span4 column"></div>
                          <div class="span8 column"></div>
                      </div>
                  </div>
              </div>
              <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
                  <div class="preview">
                      <input value="两列(60/40)" type="text" disabled="disabled"/>
                  </div>
                  <div class="view two_column_6_4">
                      <div class="row-fluid clearfix">
                          <div class="span8 column"></div>
                          <div class="span4 column"></div>
                      </div>
                  </div>
              </div>
              <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
                  <div class="preview">
                      <input value="三列(33/33/33)" type="text" disabled="disabled"/>
                  </div>
                  <div class="view three_column_4_4_4">
                      <div class="row-fluid clearfix">
                          <div class="span4 column"></div>
                          <div class="span4 column"></div>
                          <div class="span4 column"></div>
                      </div>
                  </div>
              </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
              <div class="preview">
                <input value="三列(30/40/30)" type="text" disabled="disabled"/>
              </div>
              <div class="view three_column_3_4_3">
                <div class="row-fluid clearfix">
                  <div class="span3 column"></div>
                  <div class="span6 column"></div>
                  <div class="span3 column"></div>
                </div>
              </div>
            </div>
            <div class="lyrow ui-draggable"> <a href="#close" class="remove label"><i class="icon-trash"></i></a> <span class="drag label"><i class="icon-move"></i></span>
              <div class="preview">
                <input value="三列(20/50/30)" type="text" disabled="disabled"/>
              </div>
              <div class="view three_column_2_5_3">
                <div class="row-fluid clearfix">
                  <div class="span2 column"></div>
                  <div class="span6 column"></div>
                  <div class="span4 column"></div>
                </div>
              </div>
            </div>
          </li>
        </ul>
        <ul class="nav nav-list accordion-group">
          <li class="nav-header"> 门户小页 <i class='icon-chevron-down'></i></li>
          <li style="display: none;overflow:auto;" class="boxes mute" id="elmJS">
             <!-- portlet 组件内容  -->
               ${portletComponetContent}
             <!-- end 扩展iframe  -->
          </li>
        </ul>
      <%--只有后台用户从后台进入才可见--%>
      <%--<c:set var="tmp" value="<%=consoleType%>" scope="session"></c:set>--%>
      <c:if test="${!isPortal}">
          <ul class="nav nav-list accordion-group">
              <li class="nav-header"> 模板页面 <i class='icon-chevron-down'></i></li>
              <li style="display: none;overflow:auto;" class="boxes mute" id="tempJS">
                  <!-- portlet 模板内容开始  -->
                  <jsp:include page="portletTempletPart.jsp" flush="true"/>
                  <!-- portlet 模板内容结束  -->
              </li>
          </ul>
      </c:if>
      </div>
    </div>
    <!--/span-->
    <div style="min-height: 590px;" class="demo ui-sortable">

    </div>
    <!--/span-->
  </div>
  <!--/row--> 
</div>
<!-- setting -->
<div id="setting" style='display:none;'>
	<table border='0' width="276" style="border-collapse:separate; border-spacing:0px 4px;">
		<tr> 
			<td height='30' align='right' valign='center' nowrap width='20%'><label>标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：</label></td>
			<td valign='top'><input type='text' name='portletName' id='portletName' style='width:170px;'></td>
		</tr> 
		<tr> 
			<td height='30' align='right' valign='center' nowrap><label>显示标题：</label></td>
			<td valign='top'><input type='checkbox' name='isDisplayPortletTitle'/></td>
		</tr> 
	<!-- 	<tr> 
			<td height='30'  align='right' valign='top' nowrap>主     题:</td>
			<td valign='top'>
				<div style="width:170px;">
					<div class="changeThemesColorColumn" style="background-color:#f5f5f5"></div>
				    <div class="changeThemesColorColumn" style="background-color:#428bca"></div>
				    <div class="changeThemesColorColumn" style="background-color:#f2dede"></div>
				    <div class="changeThemesColorColumn" style="background-color:#d9edf7"></div>
				    <div class="changeThemesColorColumn" style="background-color:#dff0d8"></div>
				    <div class="changeThemesColorColumn" style="background-color:#fcf8e3"></div>
				    
				    <div class="changeThemesColorColumn" style="background-color:#dcdcdc"></div>
				    <div class="changeThemesColorColumn" style="background-color:#eee8aa"></div>
				    <div class="changeThemesColorColumn" style="background-color:#f0fff0"></div>
				    <div class="changeThemesColorColumn" style="background-color:#eed2ee"></div>
				    <div class="changeThemesColorColumn" style="background-color:#00c5cd"></div>
				    <div class="changeThemesColorColumn" style="background-color:#3aa8e6"></div>
				    
				</div>
			</td> 
		</tr> --> 
		<tr> 
			<td height='30' align='right' valign='center' nowrap><label>高&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：</label></td>
			<td valign='top'><div id='slider' style='width:170px;'></div></td>
		</tr> 
		<tr> 
			<td height='30' align='right' valign='center' nowrap><label>高&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度：</label></td>
			<td valign='top'>
			 <input id='sliderValue' type='text' style='width:170px;'/>&nbsp;PX
			</td> 
		</tr>
        <tr>
            <td height='30' align='right' valign='center' nowrap><label>小页路径：</label></td>
            <td valign='top' class="input-readonly">
                <textarea disabled id='miniPagePath' type='text' style='width:170px;background-color: #F7F7F7;resize:none;'></textarea>
            </td>
        </tr>
        <tr style="display:none;">
			<td height='30' align='right' valign='top' nowrap>自动刷新：</td>
			<td valign='top'><input type='checkbox' name='isAutoRefresh'/></td> 
		</tr> 
		<tr id="refreshRateStatus" style="display:none;"> 
			<td height='30' align='right' valign='top' nowrap>刷新频率：</td>
			<td valign='top'><div><input type='text' name='refreshRate' id='refreshRate' style='width:110px;'/>&nbsp;<a href='##'>确定</a><br/>--单位(毫秒)</div></td> 
		</tr>
	</table>
</div>
<!-- end setting -->
<!--/.fluid-container--> 
<div class="modal hide fade" role="dialog" id="editorModal">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h3>编辑</h3>
  </div>
  <div class="modal-body">
    <p>
      <textarea id="contenteditor"></textarea>
    </p>
  </div>
  <div class="modal-footer"> <a id="savecontent" class="btn btn-primary" data-dismiss="modal">保存</a> <a class="btn" data-dismiss="modal">关闭</a> </div>
</div>
<div class="modal hide fade" role="dialog" id="downloadModal">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h3>下载</h3>
  </div>
  <div class="modal-body">
    <p>已在下面生成干净的HTML, 可以复制粘贴代码到你的项目.</p>
    <div class="btn-group">
      <button type="button" id="fluidPage" class="active btn btn-info"><i class="icon-fullscreen"></i> 自适应宽度</button>
      <button type="button" class="btn btn-info" id="fixedPage"><i class="icon-screenshot"></i> 固定宽度</button>
    </div>
    <br>
    <br>
    <p>
      <textarea></textarea>
    </p>
  </div>
  <div class="modal-footer"> <a class="btn" data-dismiss="modal">关闭</a> </div>
</div>
<div class="modal hide fade" role="dialog" id="shareModal">
  <div class="modal-header"> <a class="close" data-dismiss="modal">×</a>
    <h3>保存</h3>
  </div>
  <div class="modal-body">保存成功</div>
  <div class="modal-footer"> <a class="btn" data-dismiss="modal">Close</a> </div>
</div>
<input type='hidden' name="id" id="id" value='${id}' />
<input type='hidden' name="resourceType" id="resourceType" value='${resourceType}' />
<input type='hidden' name="isPortal" id="isPortal" value='${isPortal}' />
<input type='hidden' name="orgId" id="orgId" value='${orgId}' />
</body>
</html>