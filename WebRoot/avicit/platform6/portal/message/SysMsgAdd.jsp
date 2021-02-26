<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<% 
String importlibs = "common,table,form";	
%>
<!DOCTYPE html>
<html>
<head>
<!-- ControllerPath = "platform6/msystem/sysmsg/sysMsgController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" class='overflow-y:auto;border:10px solid red;'>
		<form id='form'>
			<input type="hidden" name="id" />
			<input type="hidden" id="sourceCode" value="personal" name="sourceCode"/>
			<table class="form_commonTable">
				<tr>
					<th width="10%"><label for="title">标题:</label></th>
					<td width="88%" colspan="3"><input class="form-control input-sm"
						type="text" name="title" id="title" /></td>
				</tr>
				<tr>
					<th width="10%"><label for="content">内容:</label></th>
					<td width="88%" colspan="3"><textarea class="form-control input-sm"
							rows="3" name="content" id="content" style="resize:none;"></textarea></td>
				</tr>
				
				<tr>
					<th width="10%"><label for="msgType">所有人:</label></th>
					<td width="40"  id="msgType_radio">
						<pt6:h5radio  css_class="radio-inline"
							name="msgType" title="msgType" canUse="0"
							defaultValue="0" id="msgType"
							lookupCode="PLATFORM_SYSTEM_FLAG" />
					</td>
					<th width="10%"><span id='recvUsesrAlias_remind'
							class="remind">*</span> <span id='recvUsesrAlias_span'><label for="recvUsesrAlias">消息接收人:</label></span></th>
					<td width="40%" >
						<div class="input-group  input-group-sm" id='recvUsesrAlias_div'>
							<input type="hidden" id="recvUser" name="recvUser"> <input
								class="form-control" placeholder="请选择用户" type="text"
								id="recvUsersAlias" name="recvUsersAlias"> 
								<span class="input-group-addon" id="userbtn"> <i
								class="glyphicon glyphicon-user"></i>
							</span>
						</div>
					</td>
				</tr>
			
				<tr>
					<th width="10%"><label for="sendDate">发送日期:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="sendDate" id="sendDate" />
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
					<th width="10%"><label for="disappearDate">到期时间:</label></th>
					<td width="40%">
						<div class="input-group input-group-sm">
							<input class="form-control time-picker" type="text" name="disappearDate" id="disappearDate" />
							<span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
						</div>
					</td>
				</tr>
				
				

			</table>
		</form>
	</div>
	<div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;float:right;display:block;" align="right">
						<a href="javascript:void(0)" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" title="保存" id="sysMessage_saveForm">保存</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="sysMessage_closeForm">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
	<script src='avicit/platform6/portal/message/js/moment.min.js'></script>
	
	<script type="text/javascript">

		function closeForm() {
			parent.sysMessage.closeDialog("insert");
		}
		function saveForm() {
			var isValidate = $("#form").validate();
			if (!isValidate.checkForm()) {
				isValidate.showErrors();
				return false;
			}
			var sendDateValue = $('#sendDate').datetimepicker('getDate');
			var disappearDateValue = $('#disappearDate').datetimepicker('getDate');
            var msgType=$('input[name="msgType"]:checked').val();
            var recvUsersAlias = $('#recvUsersAlias').val();

            if(msgType=='0' && (recvUsersAlias=="" || recvUsersAlias=="请选择用户")){
                layer.alert('消息接收人不能为空！', {
                        icon: 7,
                        title :'提示',
                        area: ['400px', ''], // 宽高
                        closeBtn: 0
                    }
                );
                return;
            }

            if(sendDateValue >= disappearDateValue){
				layer.alert('[发送日期]不允许大于或等于[到期日期]！', {
					  icon: 7,
					  title :'提示',
					  area: ['400px', ''], // 宽高
					  closeBtn: 0
					}
				);
				return;
			}

			parent.sysMessage.save($('#form'), "insert");
		}

		$(document).ready(function() {
			var sendDate = $('#sendDate');
			//$('.date-picker').datepicker();
			sendDate.datetimepicker({//发送时间
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
				minDate: new Date(),
				beforeShow : function(selectedDate) {
					if ($('#' + selectedDate.id).val() == "") {
						// $(this).datetimepicker("setDate", new Date());
						$('#' + selectedDate.id).val('');
					}
					// sendDate.datetimepicker('option', 'minDate', new Date());
                    setTimeout(function () {
                        resetSelectStyle();
                    }, 100 );
				},
				onClose: function(dateText, inst) {
					if (disappearDate.val() != '') {
						var startDate = sendDate.datetimepicker('getDate');
						var endDate = disappearDate.datetimepicker('getDate');
						if (startDate > endDate)
							disappearDate.datetimepicker('setDate', startDate);
					} else {
						disappearDate.val(dateText);
					}
				},
				onSelect: function (selectedDateTime){
                    resetSelectStyle();
					disappearDate.datetimepicker('option', 'minDate', sendDate.datetimepicker('getDate') );
				}
			}).on('change',function(){
                setTimeout(function () {
                    resetSelectStyle();
                },5);
            });
            $('#sendDate').focus(function () {
                setTimeout(function () {
                    resetSelectStyle();
                },5);
            });
			
			var disappearDate = $('#disappearDate');
			disappearDate.datetimepicker({//到期时间
				oneLine : true,//单行显示时分秒
				closeText : '确定',//关闭按钮文案
				showButtonPanel : true,//是否展示功能按钮面板
				showSecond : false,//是否可以选择秒，默认否
				minDate: new Date(),
				beforeShow : function(selectedDate) {
					if ($('#' + selectedDate.id).val() == "") {
						// $(this).datetimepicker("setDate", new Date());
						$('#' + selectedDate.id).val('');
						// disappearDate.datetimepicker('option', 'minDate', new Date());
					}
                    setTimeout(function () {
                        resetSelectStyle();
                    }, 100 );
				},
				onClose: function(dateText, inst) {
					if (sendDate.val() != '') {
						var startDate = sendDate.datetimepicker('getDate');
						var endDate = disappearDate.datetimepicker('getDate');
						if (sendDate > endDate)
							sendDate.datetimepicker('setDate', endDate);
					} else {
						sendDate.val(dateText);
					}
				},
				onSelect: function (selectedDateTime){
                    resetSelectStyle();
					sendDate.datetimepicker('option', 'maxDate', disappearDate.datetimepicker('getDate') );
				}
			}).on('change',function(){
                setTimeout(function () {
                    resetSelectStyle();
                },5);
            });

            $('#disappearDate').focus(function () {
                setTimeout(function () {
                    resetSelectStyle();
                },5);
            });

			parent.sysMessage.formValidate($('#form'));
			//保存按钮绑定事件
			$('#sysMessage_saveForm').bind('click', function() {
				saveForm();
			});
			//返回按钮绑定事件
			$('#sysMessage_closeForm').bind('click', function() {
				closeForm();
			});

			$('#sendUserAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'userSelect',
					idFiled : 'sendUser',
					textFiled : 'sendUserAlias'
				});
			});
			$('#sendUser_userbtn').on('click', function() {
				new H5CommonSelect({
					type : 'userSelect',
					idFiled : 'sendUser',
					textFiled : 'sendUserAlias'
				});
			});

			$('#recvUsersAlias').on('focus', function(e) {
				new H5CommonSelect({
					selectModel:'multi',
					type : 'userSelect',
					idFiled : 'recvUser',
					textFiled : 'recvUsersAlias'
				});
			});
			$('#recvUsers_userbtn').on('click', function() {
				new H5CommonSelect({
					selectModel:'multi',
					type : 'userSelect',
					idFiled : 'recvUsers',
					textFiled : 'recvUsersAlias'
				});
			});

			$('#sendDeptidAlias').on('focus', function(e) {
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'sendDeptid',
					textFiled : 'sendDeptidAlias'
				});
			});
			$('#sendDeptid_deptbtn').on('click', function() {
				new H5CommonSelect({
					type : 'deptSelect',
					idFiled : 'sendDeptid',
					textFiled : 'sendDeptidAlias'
				});
			});
			
			
			$("input:radio[name='msgType']").on('click',function (){ 
				var value = $("input[name='msgType']:checked").val();
				if(value == 1){
					document.getElementById('recvUsesrAlias_remind').style.display = 'none';
					document.getElementById('recvUsesrAlias_span').style.display = 'none';
					document.getElementById('recvUsesrAlias_div').style.display = 'none';
				} else {
					document.getElementById('recvUsesrAlias_remind').style.display = '';
					document.getElementById('recvUsesrAlias_span').style.display = '';
					document.getElementById('recvUsesrAlias_div').style.display = '';
				}
				$('#recvUser').val("");
				$('#recvUsersAlias').val("");
			});

			$('.date-picker').on('keydown', nullInput);
			$('.time-picker').on('keydown', nullInput);
			$('#sendDate').val(moment().format('YYYY-MM-DD HH:mm'));

		});

        /**
         * IE浏览器下下拉框会超出浏览器区域，重置下拉框样式解决该问题
         */
        function resetSelectStyle(){
            var targets = new Array();
            targets.push("ui_tpicker_hour_slider");
            targets.push("ui_tpicker_minute_slider");
            //设置样式
            var selectCss = {
                "width":"18%",
                "position":"absolute",
                "z-index":"9999",
                "top":"88%"
            }
            for (var i = 0; i < targets.length; i++) {
                if(targets[i] === "ui_tpicker_minute_slider"){
                    selectCss.left = "44%";
                }
                $("." + targets[i] + " .ui-timepicker-select" ).css(selectCss);
            }
            $(".ui-timepicker-div .ui_tpicker_minute").css({'margin-left':"18%"})
            $(".ui-timepicker-div .ui_tpicker_time_label").css({'margin-top':"2px"})

            //设置属性
            for (var i = 0; i < targets.length; i++) {
                $("." + targets[i] + " .ui-timepicker-select" ).attr({
                    "onmousedown":"if(this.options.length>6){this.size=6}",
                    "onblur":"this.size=1",
                    "onchange":"this.size=1"
                });
            }

        }
	</script>
</body>
</html>