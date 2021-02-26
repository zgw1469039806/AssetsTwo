$.fn.sysMsgPubAdd = function(options) {
	//默认参数 暂时不传参  不是公用的
	var defaults = {
		        'baseUrl': 'msystem/sysmsg/sysMsgController/operation/'		        
		    };
	
	//合并默认参数与用户参数到setings
	var settings = $.extend({},defaults, options);
	
	//返回按钮用
	function closeForm() {
		//先得到当前iframe层的索引
		var index = parent.layer.getFrameIndex(window.name); 
		//再执行关闭
		parent.layer.close(index); 
	} 
	
	//保存按钮用
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

			if(msgType == "0" && (recvUsersAlias=="" || recvUsersAlias=="请选择用户")){
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
			saveMsg($('#form'));		
	}
	
	
	// 保存功能
	function saveMsg(form){
		$('#sysMessage_saveForm').attr('disabled',true);
//		console.log(JSON.stringify(serializeObject(form)));
		$.ajax({
			 url:settings.baseUrl+"save",
			 data : {
				 data :JSON.stringify(serializeObject(form))				 
			 		},
			 type : 'POST',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 layer.msg('发送成功！', {
						  icon: 1,
						  time: 1000//1秒关闭
						}, function(){
						  //do something
							var index = parent.layer.getFrameIndex(window.name); 
							parent.layer.close(index); 
						});   				
				 }else{
					 layer.alert('发送失败！' + r.error, {
						  icon: 7,
						  area: ['400px', ''], // 宽高
						  closeBtn: 0
						}
					);
                     $('#sysMessage_saveForm').removeAttr("disabled");
				 } 
			 }
		 });
	}
		
	//控件校验   规则：表单字段name与rules对象保持一致
	 function formValidate(form) {
		form.validate({
			rules : {
				title : {
					required : true,
					maxlength : 255
				},
				content : {
					required : true,
					maxlength : 1000
					
				},
				sendUserAlias : {
					required : true,
					maxlength : 50
				},
				sendDate : {
					required : true,
//					dateISO : true
				},
                disappearDate : {
                    required : true,
                },
				recvUserAlias : {
					required : true,
					maxlength : 50
				},
				autoDisappear : {
					maxlength : 2
				},
				sendDeptid : {
					maxlength : 50
				},
				sysApplicationId : {
					maxlength : 32
				},
			}
		});
	}

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
				$('#ui-datepicker-div').css("z-index", 10);
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
		//	disappearDate.datetimepicker('option', 'minDate', dateText);
		},
        onSelect: function (selectedDateTime){
            disappearDate.datetimepicker('option', 'minDate', sendDate.datetimepicker('getDate') );
        }
	});
	
	var disappearDate = $('#disappearDate');
	disappearDate.datetimepicker({//到期时间
		oneLine : true,//单行显示时分秒
		closeText : '确定',//关闭按钮文案
		showOptions: { direction: "up" },
		showButtonPanel : true,//是否展示功能按钮面板
		showSecond : false,//是否可以选择秒，默认否
		minDate: new Date(),
		beforeShow : function(selectedDate) {
			if ($('#' + selectedDate.id).val() == "") {
				//$(this).datetimepicker("setDate", new Date());
				$('#' + selectedDate.id).val('');
				// disappearDate.datetimepicker('option', 'minDate', new Date());
			}
			setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 10);
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
			//sendDate.datetimepicker('option', 'maxDate', dateText);
		},

        onSelect: function (selectedDateTime){
            sendDate.datetimepicker('option', 'maxDate', disappearDate.datetimepicker('getDate') );
        }
	});


	//保存按钮绑定事件
	$('#sysMessage_saveForm').on('click', function() {
		saveForm();
	});
	//返回按钮绑定事件
	$('#sysMessage_closeForm').on('click', function() {
		closeForm();
	});

	
	$('#sendUserAlias').on('focus', function(e) {
		new H5CommonSelect({
			type : 'userSelect',
			idFiled : 'sendUser',
			textFiled : 'sendUserAlias',
			viewScope:'currentOrg'
		});
	});
	$('#sendUser_userbtn').on('click', function() {
		new H5CommonSelect({
			type : 'userSelect',
			idFiled : 'sendUser',
			textFiled : 'sendUserAlias',
			viewScope:'currentOrg'
		});
	});

	$('#recvUsersAlias').on('focus', function(e) {
		new H5CommonSelect({
			selectModel:'multi',
			type : 'userSelect',
			idFiled : 'recvUser',
			textFiled : 'recvUsersAlias',

		});
	});
	$('#recvUsers_userbtn').on('click', function() {
		new H5CommonSelect({
			selectModel:'multi',
			type : 'userSelect',
			idFiled : 'recvUsers',
			textFiled : 'recvUsersAlias',
		});
	});

	$('#sendDeptidAlias').on('focus', function(e) {
		new H5CommonSelect({
			type : 'deptSelect',
			idFiled : 'sendDeptid',
			textFiled : 'sendDeptidAlias',
			viewScope:'currentOrg'
		});
	});
	$('#sendDeptid_deptbtn').on('click', function() {
		new H5CommonSelect({
			type : 'deptSelect',
			idFiled : 'sendDeptid',
			textFiled : 'sendDeptidAlias',
			viewScope:'currentOrg'
		});
	});
	
	
//	$("input:radio[name='msgType']").change(function (){ 
//		$('#recvUsersAlias_div').toggle();
//		$('#recvUser').val("");
//		$('#recvUsersAlias').val("");
//	});
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

	//$('.date-picker').on('keydown', nullInput);
	//$('.time-picker').on('keydown', nullInput);
	
	//初始化校验
	formValidate($('#form'));
	//初始化发送时间，为当前时间
	$('#sendDate').val(moment().format('YYYY-MM-DD HH:mm'));
	//初始化接收人，如果传了接收人参数的话
	if (recvUserStr) {
		$("#recvUser").val(recvUserStr);
		$("#recvUsersAlias").val(recvUserAlStr);
	}


	//返回，用于支持链式调用
	return this;
	
}