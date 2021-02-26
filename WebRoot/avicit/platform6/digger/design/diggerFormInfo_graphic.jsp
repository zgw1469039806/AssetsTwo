<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% 
String importlibs = "common,table,form,tree";
%>
<!DOCTYPE html>
<HTML>
<head>
<title>${diggername}-设计</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/jquery-ui-1.9.2.custom/css/base/jquery-ui-1.9.2.custom.css"/>
<style type="text/css">
	a{
		color : #555;
	}

	.img-delete {
		 position: absolute;
		 top: 0px;
		 right: 0px;
		 dispaly: inline-block;
		 z-index: 2;
		 font-size: 15px;
		width: 20px;
		height: 20px;
		background-color: #ffffff;
		text-align: center;
		opacity:0.7
	 }
	.img-delete:hover{
		cursor: pointer;
		opacity:0.9;
	}
	.nav>li>a {
        position: relative;
        display: block;
        padding: 5px 5px;
    }
    .navbar {
        position: relative;
        min-height: 50px;
        margin-bottom: 1px;
        border: 1px solid transparent;
    }
</style>
</head>
<body class="easyui-layout" fit="true">
    <div id="navbar" class="navbar ace-save-state" style="background-color:#FFF">
            <div class="navbar-header pull-left" style="padding-top:10px;padding-left:10px;">
                    <h4 id="formName">报表模型库/${diggerType}${diggerComponentName}/${diggername}</h4>
            </div>
            <div class="navbar-buttons navbar-header pull-right" style="padding-top:5px;">
                <div class="navbar-form navbar-left">
                    <span style="color: #2fae95;"> <i class="icon iconfont icon-Preservation" style="font-size:23px;cursor: pointer;" id="saveBut" title="保存"></i></span>
                    <span style="border-left: 1px solid #B5B5B5;padding-bottom: 0px;padding-top: 7px;padding-left:5px;"></span>
                    <span style="color: #B5B5B5;">
                   		 <i class="icon iconfont icon-preview" style="font-size:23px;cursor: pointer;"  id="preview" title="预览" ></i>
                	</span>
                </div>
            </div>
    </div>
	<div style="margin:1px 10px">
		<ul class="nav nav-tabs" role="tablist" id="nav-tabs">
			<li role="presentation" class="active"><a href="#diggerBaseInfo" aria-controls="diggerBaseInfo" role="tab" data-toggle="tab" style="font-size: 14px">基本信息</a></li>
			<li role="presentation"><a href="#diggerDatasource" onclick="datasource_refresh()" aria-controls="diggerDatasource" role="tab" data-toggle="tab" style="font-size: 14px">数据源</a></li>
			<li role="presentation"><a href="#diggerGraphical" aria-controls="diggerGraphical" role="tab" data-toggle="tab" style="font-size: 14px">图形</a></li>
			<li role="presentation"><a href="#diggerToolbar" aria-controls="diggerToolbar" role="tab" data-toggle="tab" style="font-size: 14px; display: none;">工具条</a></li>
			<li role="presentation"><a href="#diggerQuery" onclick="queryConfig_refresh()" aria-controls="diggerQuery" role="tab" data-toggle="tab" style="font-size: 14px">查询器</a></li>
			<li role="presentation"><a href="#diggerJavaEvent" aria-controls="diggerJavaEvent" role="tab" data-toggle="tab" style="font-size: 14px;display: none;">java程序</a></li>
		</ul>
		<div class="tab-content">
			<%--基本信息 --%>
			<div role="tabpanel" class="tab-pane active" id="diggerBaseInfo">
				<div data-options="region:'center',split:true,border:false">
					<form id='baseinfoForm' enctype="multipart/form-data" style="margin-top: 20px">
                        <input type='hidden' name='id' id='id' value='${id}' />
                        <input type='hidden' name='diggerType' id='diggerType' value='${diggerType}'/>
						<table class="form_commonTable">
							<tr style="height:48px;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="diggername">名称:</label></th>
								<td width="39%">
									<input title="" class="form-control input-sm" type="text" name="diggername" id="diggername" value='<c:out  value='${diggerInfo.diggername}'/>'/>
								</td>
                                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="diggercode">编码:</label></th>
                                <td width="39%">
                                    <input title="" class="form-control input-sm" type="text" name="diggercode" id="diggercode" value='<c:out  value='${diggerInfo.diggercode}'/>'/>
                                </td>

							</tr>
							<tr style="height:48px;display:none;">
								<th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="componentType">模型分类:</label></th>
								<td width="39%" >
									<input title="" class="form-control input-sm" type="text" name="componentType" id="componentType" value=''/>
								</td>
								<th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="master">模型管理员:</label></th>
								<td width="38%">
									<input title="" class="form-control input-sm" type="text" name="master" id="master" value='<c:out  value='${diggerInfo.master}'/>'/>
								</td>
							</tr>
							<tr style="height:48px;">
                                <th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="graphictype">图形类型:</label></th>
                                <td width="38%">
                                    <select id='graphictype' name='graphictype' class='form-control input-sm'>
                                        <option value='0'>饼图</option>
                                        <option value='1'>折线图</option>
                                        <option value='2'>折线面积图</option>
                                        <option value='3'>柱状图</option>
                                        <option value='4'>柱状折线图</option>
                                        <option value='5'>柱状堆叠图</option>
                                        <option value='6'>漏斗图</option>
                                    </select>
                                </td>
                               <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="conditionCol">条件区每行列数:</label></th>
                               <td width="39%" >
                                   <select id='conditionCol' name='conditionCol' class='form-control input-sm'>
                                       <option value='2' select>2列</option>
                                       <option value='3'>3列</option>
                                       <option value='4'>4列</option>
                                   </select>
                               </td>
                            </tr>

                            <tr style="height:48px;">
                                <th width="11%" style="word-break: break-all; word-warp: break-word;"><label for="autoExec">是否自动执行结果:</label></th>
                                <td width="38%" colspan="3">
                                   <input type='radio' name='autoExec' value='1'>是</input>&nbsp;
                                   <input type='radio' name='autoExec' value='0' checked>否</input>
                                </td>

                            </tr>
                            <tr style="height:48px;">
                                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="diggerDesc">描述:</label></th>
                                <td width="39%" colspan='3'>
                                    <textarea style='width:100%;' id='diggerDesc' name='diggerDesc'><c:out  value='${diggerInfo.diggerDesc}'/></textarea>
                                </td>
                            </tr>

						</table>

					</form>
				</div>
<%--				<div data-options="region:'south',border:false" style="height: 40px;margin-top: 80px">--%>
<%--					<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">--%>
<%--						<table class="tableForm" style="border:0;cellspacing:1;width:100%">--%>
<%--							<tr>--%>
<%--								<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">--%>
<%--									<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="baseinfo_saveForm">保存111</a>--%>
<%--								</td>--%>
<%--							</tr>--%>
<%--						</table>--%>
<%--					</div>--%>
<%--				</div>--%>

			</div>
			<%--基本信息 end--%>
			<%--数据源--%>
			<div role="tabpanel" class="tab-pane" id="diggerDatasource">
				<div data-options="region:'center',split:true,border:false">
					<iframe id="diggerDatasourceConfigFrame" frameborder="0" src="" style="width: 100%;height: 607px;"></iframe>
				</div>
			</div>
            <%--数据源 end--%>
			<%--图形--%>
			<div role="tabpanel" class="tab-pane" id="diggerGraphical">
              <div  data-options="region:'center',split:true,border:false" style="border: 1px solid #ffff;">
                   <div style='width:70%;float:left; border:0px solid yellow;padding:2px'>
                       <iframe id="diggerGraphicalDisplayFrame" frameborder="0" src="" style="width: 100%;height: 607px;"></iframe>
                   </div>
                    <div style='width:29%;float:right;padding:2px'>
                        <form id='graphicalForm' style="margin-top: 20px">
                            <input type="hidden" id="diggerId" name="diggerId" value='<c:out value="${diggerInfo.id}" />' />
                            <input type="hidden" id="id" name="id"  />
                            <div style='width:100%;background:#D7d7d7;height:28px;border:1px solid #dddddd;'>
                                <table style="width: 100%;">
                                    <tr><td width="90%">标题</td><td width="10%" align="center"><input  type="checkbox" id="titleShow" name="titleShow"  value=""></td></tr>
                                </table>
                            </div>
                            <div id="titleShowDiv" style='width:100%;border:1px solid #dddddd;height: 300px;overflow-x: auto;display: none'>
                                <table class="form_commonTable" style='margin:0px 0px 0px 0px;'>
                                    <tr style="height:48px;">
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="titleName">主标题:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="titleName" id="titleName" value=''/>
                                        </td>
                                     </tr>
                                     <tr>
                                        <th width="10%" style="white-space:nowrap"><label for="link">主标题连接:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="link" id="link" value=''/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="subtext">副标题:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="subtext" id="subtext" value=''/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="10%" style="white-space:nowrap;"><label for="subLink">副标题连接:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="subLink" id="subLink" value=''/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="titleAlign">对齐方式:</label></th>
                                        <td width="39%">
                                            <select id='titleAlign' name='titleAlign' class='form-control input-sm'>
                                                <option value='0'>居左</option>
                                                <option value='1'>居中</option>
                                                <option value='2'>居右</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="titleTop">上边距:</label></th>
                                        <td width="39%">
                                            <table style='width:100%;'>
                                                <tr>
                                                    <td>
                                                        <input title="" class="form-control input-sm"  type="text" name="titleTop" id="titleTop" value=''/>
                                                    </td>
                                                    <td>
                                                        <select id='titleUnit' name="titleUnit" class='form-control input-sm'>
                                                            <option value='0'>像素</option>
                                                            <option value='1'>百分比</option>
                                                        </select>
                                                     </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="titleTextSize">字体大小:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="titleTextSize" id="titleTextSize" value=''/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="titleTextColor">前景色:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="titleTextColor" id="titleTextColor" value=''/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style='width:100%;background:#D7d7d7;height:28px;border:1px solid #dddddd;margin-top:2px;'>
                                <table style="width: 100%;">
                                    <tr><td width="90%">图形</td><td width="10%" align="center"></td></tr>
                                </table>
                            </div>
                            <div style='width:100%;border:1px solid #dddddd;'>
                                <table class="form_commonTable" style='margin:0px 0px 0px 0px;'>
                                    <tr style="height:48px;">
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="backgroundColor">背景色:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="backgroundColor" id="backgroundColor" value=''/>
                                        </td>
                                     </tr>
                                     <tr>
                                        <th width="10%" style="white-space:nowrap;"><label for="tipBoxType">是否显示提示框:</label></th>
                                        <td width="39%">
                                                <input type='radio' name='tipBoxType' value='1' >是</input>&nbsp;
                                                <input type='radio' name='tipBoxType' value='0' >否</input>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="10%" style="white-space:nowrap;"><label for="tipformatter">提示框格式化内容:</label></th>
                                        <td width="39%">
                                            <input title="" class="form-control input-sm" type="text" name="tipformatter" id="tipformatter" value=''/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style='width:100%;background:#D7d7d7;height:28px;border:1px solid #dddddd;'>
                                <table style="width: 100%;">
                                    <tr><td width="90%">标注</td><td width="10%" align="center"><input type="checkbox" id="calloutShow" name="calloutShow" value=""></td></tr>
                                </table>
                            </div>
                            <div id="calloutShowDiv" style='width:100%;border:1px solid #dddddd;display: none;'>
                                <table class="form_commonTable" style='margin:0px 0px 0px 0px;'>
                                    <tr style="height:48px;">
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="arrayType">显示方式:</label></th>
                                        <td width="39%">
                                            <input type='radio' name='arrayType' value='1' checked>水平</input>&nbsp;
                                            <input type='radio' name='arrayType' value='0' >垂直</input>
                                        </td>
                                     </tr>
                                     <tr>
                                        <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="legendAlign">对齐方式:</label></th>
                                        <td width="39%">
                                            <select id='legendAlign' name="legendAlign" class='form-control input-sm'>
                                                <option value='left'>居左</option>
                                                <option value='center'>居中</option>
                                                <option value='right'>居右</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </form>
                    </div>

              </div>
                <div data-options="region:'south',border:false" style="height: 40px;margin-top: 235px;border: 0px solid red;">
                    <div id="graphical_toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
                        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
                            <tr>
                                <td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
                                    <a href="javascript:graphicalSave();" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" >保存</a>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
			</div>
            <%--图形 end--%>
			<%--工具条--%>

			<%--工具条 end--%>
			<%--查询器--%>
            <div role="tabpanel" class="tab-pane" id="diggerQuery">
                <iframe id="diggerQueryConfigFrame" frameborder="0" src="" style="width: 100%;height: 607px;"></iframe>
            </div>
            <%--查询器 end--%>
            <%--java程序 --%>

            <%--java程序 end--%>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
	<script src="avicit/platform6/digger/design/js/DiggerFormInfo.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>
    <link rel="stylesheet" href="static/h5/colorpicker/css/colorpicker.css" type="text/css" />
    <script type="text/javascript" src="static/h5/colorpicker/js/colorpicker.js"></script>

	<script type="text/javascript">
        var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	    var diggerFormInfo = new DiggerFormInfo("formArea", "formInfoDiv");
		var isAdmin ='${isAdmin}';
        var maxSize = '${maxSize}';
		var viewScopeType='';
		if(isAdmin=="true"){
			viewScopeType = '';
		}else{
			viewScopeType = 'allowAcross';
		}
		var graphictype = '<c:out  value='${diggerInfo.graphictype}'/>'//图形类型
		var conditionCol = '<c:out  value='${diggerInfo.conditionCol}'/>'//条件区每行列数
		var autoExec = '<c:out  value='${diggerInfo.autoExec}'/>'//是否自动执行结果
		var isdiycond = '<c:out  value='${diggerInfo.isdiycond}'/>'//提供用户自定义查询
		$(function() {
            $("#graphictype ").get(0).value = graphictype;
            $("#conditionCol ").get(0).value = conditionCol;
            $(":radio[name='autoExec'][value='" + autoExec + "']").prop("checked", "checked");
            $(":radio[name='isdiycond'][value='" + isdiycond + "']").prop("checked", "checked");
            diggerFormInfo.formValidate($('#baseinfoForm'));//添加较验
           // $('#baseinfo_saveForm').click(function(){
           //      diggerFormInfo.baseInfoSave($("#baseinfoForm"));
           // });
            $('#saveBut').click(function(){
                var tabLength = $('#nav-tabs').children("li").length;
                var tabName;
                for(var i = 0 ; i < tabLength ; i++){
                    if ($("#nav-tabs").children('li')[i].className == "active") {
                        tabName = $("#nav-tabs").children('li')[i].innerText
                        break;
                    }
                }
                if(tabName == '基本信息'){
                    diggerFormInfo.baseInfoSave($("#baseinfoForm"));//保存基本信息
                } else if(tabName == '数据源'){
                    //保存数据源配置diggerDatasourceConfigFrame
                    document.getElementById('diggerDatasourceConfigFrame').contentWindow.datasourceSave()
                 } else if(tabName == '查询器'){
                    //保存查询器配置
                    document.getElementById('diggerQueryConfigFrame').contentWindow.saveQuery();
                } else if(tabName == ''){

                }
            });

            $('#preview').click(function() {//预览按钮事件
                var diggerId = $("#baseinfoForm").find("#id").val();
                window.open(baseUrl + "platform/digger/diggerExecuteController/preview/" + diggerId, "_blank");
            });
		});




        //数据源保存
        //   function datasourceSave(){
        //       diggerFormInfo.datasourceSave($("#datasourceForm"));
        //   }
          //图形配置保存
          function graphicalSave(){
              diggerFormInfo.graphicalSave($("#graphicalForm"));
          }

          function getFormId(){
               return $('#datasourceFormId').val();
          }

          $(function(){
              $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
                     if(e.delegateTarget.innerText == '图形'){
                         //请求图形预览
                         document.getElementById('diggerGraphicalDisplayFrame').src = 'digger/diggerManageController/getGraphicalDisplay?diggerId=<c:out value="${diggerInfo.id}" />';
                         //请求图形配置数据
                         diggerFormInfo.graphicalreRendering($("#graphicalForm"));
                     }
              });

              //绑定前景色拾色器
              $('#titleTextColor').ColorPicker({
                  color: '#0000ff',
                  onShow: function (colpkr) {
                      $(colpkr).fadeIn(500);
                      return false;
                  },
                  onHide: function (colpkr) {
                      $(colpkr).fadeOut(500);
                      return false;
                  },
                  onChange: function (hsb, hex, rgb) {
                      $('#titleTextColor').val('#' + hex);
                  }
              });

              //绑定背景色拾色器
              $('#backgroundColor').ColorPicker({
                  color: '#0000ff',
                  onShow: function (colpkr) {
                      $(colpkr).fadeIn(500);
                      return false;
                  },
                  onHide: function (colpkr) {
                      $(colpkr).fadeOut(500);
                      return false;
                  },
                  onChange: function (hsb, hex, rgb) {
                      $('#backgroundColor').val('#' + hex);
                  }
              });

          });

        function datasource_refresh(){
            //设置数据源iframe url地址
            document.getElementById('diggerDatasourceConfigFrame').src = 'digger/diggerManageController/getDatasourceConfig?diggerId=<c:out value="${diggerInfo.id}" />';
        }
        // 重新加载diggerQueryConfigFrame
        function queryConfig_refresh(){
            document.getElementById('diggerQueryConfigFrame').src = 'digger/diggerManageController/getQueryConfig?diggerId=<c:out value="${diggerInfo.id}" />';

        }

	</script>
</body>
</html>