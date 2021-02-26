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
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<jsp:include
	page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='initForm'>
        <input type="hidden" id="eformTypeId" name="eformTypeId">

        <table id="table" class="form_commonTable">
           <!-- <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentName">名称：</label>
                </th>
                <td width="35%">
                    <input title="名称" class="form-control date-picker" type="text" style="width: 99%;" type="text"
                           name="componentName" id="componentName"/>
                </td>
                <th width="10%"><label for="disappearDate">到期时间:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="disappearDate" id="disappearDate" />
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
            </tr>

              <tr>
                <th width="15%" style="word-break: break-all; word-warp: break-word;">
                    <label for="componentDesc">描述：</label>
                </th>
                <td colspan="3" width="85%">
                    <textarea title="描述" rows="3" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="componentDesc" id="componentDesc"></textarea>
                </td>
            </tr>  -->
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" align="right">
                    <a href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="保存" id="saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>
</body>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
<script type="text/javascript">
	function getParams(key) {
	    var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
	    var r = window.location.search.substr(1).match(reg);
	    if (r != null) {
	        return unescape(r[2]);
	    }
	    return null;
    }
    $(function () {
		//alert(getParams("dbid"))
		$.ajax({
		    url: 'platform/eform/eformViewInfoController/getDbCol/' + getParams("dbid"),
		    contentType: "application/xml; charset=utf-8",
		    type: 'post',
		    dataType: 'json',
		    async: true,
		    success: function (r) {
		        if (r != null) {
		            var list = $.parseJSON(r.data);
		            drawListArea(list);
		            dateDeal(list);
		          }
		       }
		    }); 
	});
	  
	  //画页面
	  function drawListArea(list){
		  var html = "<tr>";
		  var j = 1;
		  for (var i = 0; i < list.length; i++) {
              //alert(list[i].colName);
              if(list[i].colIsPk != 'Y' && list[i].colIsSys != 'Y'){
            	  var temp = "";
                   if(list[i].colType === 'DATE'){//date类型
                	  	temp = '<th width="10%"><label for="' + list[i].colName + '">' + list[i].colComments + '：</label></th><td width="35%">'
								   	+ '<div class="input-group input-group-sm">'
					 			   	+ '<input class="form-control time-picker" type="text" name="' + list[i].colName + '" id="' + list[i].colName + '" />'
								   	+ '<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span></div></td>'; 
                   }else{
                	   var root = '';
                	   if(list[i].colName === getParams("pid")){
                		   root = 'value=' + getParams("root") + '  readonly="readonly"/>';
                	   }else{
                		   root = ' />';
                	   }
                	   temp = '<th width="15%" style="word-break: break-all; word-warp: break-word;">'
		                           + '<label for="' + list[i].colName + '">' + list[i].colComments + '：</label></th>'
		                           + '<td width="27%">'
		                           + '<input title="' + list[i].colComments + '" class="form-control input-sm" type="text" style="width: 99%;" type="text"' 
		                           + 'name="' + list[i].colName + '" id="' + list[i].colName + '"' + root
		                           + '</td>';
                   }
                  if(j%2==0){
                	  temp = temp + '</tr><tr>';
                	  j=1;
                  }else{
                      j++;
                  } 
                  html += temp;
              }
             
          }
		  $("#table").append(html + '</tr>');
	  }
	  
	  //处理时间控件
	function dateDeal(list) {
		for (var i = 0; i < list.length; i++) {
			//alert(list[i].colName);
			if(list[i].colType === 'DATE'){//date类型
				var tempDate = $('#' + list[i].colName);
				tempDate.datetimepicker({//
					oneLine : true,//单行显示时分秒
					closeText : '确定',//关闭按钮文案
					showButtonPanel : true,//是否展示功能按钮面板
					showSecond : false,//是否可以选择秒，默认否
					beforeShow : function(selectedDate) {
						if ($('#' + selectedDate.id).val() == "") {
							$(this).datetimepicker("setDate", new Date());
							$('#' + selectedDate.id).val('');
							tempDate.datetimepicker('option', 'minDate',
									new Date());
						}
					},
					onClose : function(dateText, inst) {
					},
					onSelect : function(selectedDateTime) {
					}
				});
			}
		}
	}

	$('#closeForm').bind('click', function () {
        parent.closeDialog();
    });
	
	$('#saveForm').bind('click', function () {
        var formSerializeValue = $("#initForm").serialize();
        var formDataJson = convertFormSerializeValueToJson(formSerializeValue);
        var parm = "formDataJson=" + formDataJson + "&tableName=" + getParams("tableName") 
        				+ "&dbid=" + getParams("dbid") + "&pid=" + getParams("pid");
        $.ajax({
            url: "platform/eform/eformViewInfoController/saveInitTreeForm",
            data: parm,
            type: "post",
            async: false,
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    parent.closeDialog("1");
                }
                else {
                    layer.msg(backData.result,{icon: 2});
                }
            }
        });
    });
	
	$('.date-picker').on('keydown', nullInput);
	$('.time-picker').on('keydown', nullInput);
</script>
</html>