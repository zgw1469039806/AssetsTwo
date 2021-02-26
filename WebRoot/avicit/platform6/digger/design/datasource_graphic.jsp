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
	#diggersql{
    	width:100%;
    	margin:2px;
    	border:1px solid #6497e9;
    	height: 50px;
    }
    .expressionDisplay{
    	width:70%;
    	border:1px solid #6497e9;
    	height:165px;
    	position: absolute;
    	z-index: 99999;
    	background-color: #ffffff;
    	box-shadow:3px 3px 2px #a5c7fe;
    	-moz-box-shadow:3px 3px 2px #a5c7fe;
    	-webkit-box-shadow:3px 3px 2px #a5c7fe;
    	border-bottom-left-radius:5px;
    	border-bottom-right-radius:5px;
    	margin-left:2px;
    	margin-top:-6px;
    	display:none;
    	overflow: auto;
    }
    .ztree li span.button.icon_ico_docu{
    	margin-right:2px;
    	background: url(static/images/platform/common/function.gif) no-repeat scroll 0 0 transparent;
    	vertical-align:top;
    	*vertical-align:middle
    }
</style>
<script type="text/javascript">
	var uid='${uid}';
</script>
</head>
<body >
	<form id='datasourceForm' enctype="multipart/form-data" style="margin-top: 20px">
        <input type='hidden' name='id' id='id' value='<c:out  value='${diggerInfo.id}'/>'>
        <input type='hidden' name='diggerType' id='diggerType' value='<c:out  value='${diggerInfo.diggertype}'/>'>
        <div style='width: 80%;height: 28px;padding:1px; border-bottom: 1px solid #d7d7d7;'>
            <label><input type='radio'  name='datasourcetype' value='1' checked>BO数据源</input></label>&nbsp;
            <label><input type='radio' name='datasourcetype' value='0' >SQL数据源</input></label>
        </div>
        <br />
        <table class="form_commonTable" style='width: 90%;'>
            <tr style="height:48px;" id="bo_datasource">
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="manager">数据源(<font color='red'>*</font>):</label></th>
                <td width="90%">
                   <div class="input-group">
                     <input type="text" id="sssss" class="form-control" placeholder="请选择数据源..."  value="${datasourceFormDisplayName}">
                     <input type="hidden" id="datasourceFormId" name="diggerurl" class="form-control" value="${diggerurl}" placeholder="请选择数据源...">
                     <span class="input-group-btn">
                       <button class="btn btn-default" type="button" onClick='selectForm();return false;'><i class="glyphicon glyphicon-search" id="saveBut" title=""></i></button>
                     </span>
                   </div>
                </td>
            </tr>
            <tr style="height:48px;display:none" id="sql_datasource">
                <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="manager">SQL(<font color='red'>*</font>):</label></th>
                <td width="90%">
                   <div class="input-group" style="width:100%">
                        <textarea id="sql" name="sql" class="form-control" style="width:100%"></textarea>

                   </div>
                </td>
            </tr>
            <tr style="height:48px;">
                 <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="componentType">where子句:</label></th>
                <td width="90%" >
                   <textarea id="diggersql" name="diggersql" style='width:100%'><c:out  value='${diggerInfo.diggersql}'/></textarea>
                   <div class="expressionDisplay">
                        <ul id="exprTree" class="ztree"></ul>
                    </div>
                </td>
            </tr>
            <tr style="height:48px;">
                 <th width="10%" style="word-break: break-all; word-warp: break-word;"><label for="componentType">&nbsp;</label></th>
                <td width="90%" style="color:#999999">
                   如果你具备数据库SQL语言能力,你可以修改上面的SQL Where语句!
                   注意:Where子句不包含Where关键字，可限制用户查询范围内的数据。这些参与过滤的字段应该被定义在所查询的元数据中，表达式的值可以是常量，也可以是平台内部的rule表达式组合，或者是rule表达式与任何字符进行拼装。例如userName='@{userName}' and ...
                </td>
        </tr>
        </table>
        <div style='width: 80%;height: 28px;padding:1px; border-bottom: 1px solid #d7d7d7;'>
           列属性
           <div id="tableToolbar" class="toolbar" style="padding-top: 10px;">
               <div class="toolbar-left">
                     <a id="datasource_insert" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm"
                           role="button" title="添加"><i class="icon icon-add"></i> 添加</a>
                     <a id="datasource_del" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button"
                          title="删除"><i class="icon icon-delete"></i> 删除</a>
               </div>
           </div>
           <table id="diggerColumnGrid"></table>
        </div>
    </form>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>

	<script type="text/javascript" src="static/h5/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
	<script type="text/javascript" src="static/h5/jquery-form/jquery.form.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerDatasource.js"></script>
    <script src="avicit/platform6/digger/design/js/DiggerColumnGrid.js"></script>
	<script src="avicit/platform6/digger/design/js/DiggerDatasourceGroupCountGrid.js"></script>
	<script src="avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.js"></script>

	<script type="text/javascript">
		var isAdmin ='${isAdmin}';
        var maxSize = '${maxSize}';
		if(isAdmin=="true"){
			viewScopeType = '';
		}else{
			viewScopeType = 'allowAcross';
		}
		var datasourcetype = '<c:out  value='${diggerInfo.datasourcetype}'/>'//数据源类型
		$(function() {

            $(":radio[name='datasourcetype'][value='" + datasourcetype + "']").prop("checked", "checked");
            //隐藏或显示BO数据源或sql数据源配置框
            if(datasourcetype == "1" || datasourcetype == ""){
                $('tr#bo_datasource').show();
                $('tr#sql_datasource').hide();
            } else {
                $('tr#bo_datasource').hide();
                $('tr#sql_datasource').show();
                //如果值为0,把datasourceFormId文本框的内容赋给sql文本框
                $('#sql').val($('#datasourceFormId').val());
            }
           // $('#baseinfo_saveForm').click(function(){
           //         diggerFormInfo.baseInfoSave($("#baseinfoForm"));
           // });
		});

		var selectPublishEform = new SelectPublishEform("datasourceFormId", "sssss", null, "N", "eform");
        selectPublishEform.init(function(data){});
		function selectForm(){
            $("#sssss").click();
            $("#ssss").click();
		}

		function setValue(e){
                var v = $(e.target).val();
                var rowid = $("#diggerColumnGrid").jqGrid("getGridParam","selrow");
                $("#diggerColumnGrid").jqGrid('setCell',rowid , 'roleCode' ,v + '-a');
         }

		var dataGridGroupCountColModel = [{
               label : 'id',
               name : 'id',
               width : 75,
               sortable : false,
               hidden : true
           }, {
               label : '<span class="remind">*</span>'+'列名称',
               name : 'fieldName',
               width : 200,
               sortable : false,
               editable : true,
               edittype : 'select'

           }, {
               label : '<span class="remind">*</span>'+'列显示名称',
               name : 'fieldTitle',
               width : 200,
               sortable : false,
               editable : true
           },  {
               label : '分组',
               name : 'mapType',
               width : 200,
               editable : true,
               sortable : false,
               edittype : 'select',
               editoptions:{
                 defaultValue:'0',
                 value:{0:'不分组',1:'分组'}
               },
                formatter : formatGroupColumn
           },{
               label : '统计类型',
               name : 'statType',
               width : 200,
               sortable : false,
               editable : true,
               edittype : 'select',
               editoptions:{
                   value:{'DEFAULT':'不统计','COUNT':'计数(COUNT)','COUNTDISTINCT':'不重复计数(COUNTDISTINCT)','SUM':'求和(SUM)','MAX':'最大值(MAX)','MIN':'最小值(MIN)','AVG':'平均值(AVG)'},
                   defaultValue:'DEFAULT'
               },
               formatter : formatCountColumn,
           },{
                label : '显示位置',
                name : 'displayPosition',
                width : 200,
                sortable : false,
                editable : true,
                edittype : 'select',
                editoptions:{
                    value:{'0':'X轴','1':'Y轴','2':'Z辅助轴'},
                    defaultValue:'0'
                },
                formatter : formatterDisplayPosition,
            },{
               label : '表名称',
               name : 'entityName',
               width : 200,
               sortable : false,
               editable : false
           }
         ];
          var diggerDatasourceGroupCountGrid;
          $(function() {
                   diggerDatasourceGroupCountGrid = new DiggerDatasourceGroupCountGrid('diggerColumnGrid','${url}',dataGridGroupCountColModel,'<c:out  value='${diggerInfo.id}'/>');
                   $('#datasource_insert').bind('click', function() {
                          diggerDatasourceGroupCountGrid.insert();
                  });
                   $('#datasource_del').bind('click', function() {
                          diggerDatasourceGroupCountGrid.del();
                  });

                $("input[name='datasourcetype']").bind('change', function() {
                    diggerDatasourceGroupCountGrid.deleteAll($(this).val());
                });
          });

          function getFormId(){
               return $('#datasourceFormId').val();
          }
	</script>
</body>
</html>