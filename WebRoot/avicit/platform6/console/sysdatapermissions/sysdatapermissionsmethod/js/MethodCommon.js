// 类型选择事件
$("input[name='type']").on("click",function(){
	var selectVal = this.value;
	$("#tableName").val("");
	$("#tableRemarks").val("");
	if(selectVal == "0"){ // 非电子表单
		$(".defaultTr").show();
		$(".defaultAndEformTr").show();
		$(".selectTr").hide();
		$(".selectCustomTr").hide();
		$(".EformTr").hide();
	} else if(selectVal == "1"){ // 电子表单
		$(".defaultAndEformTr").show();
		$(".EformTr").show();
		$(".defaultTr").hide();
		$(".selectTr").hide();
		$(".selectCustomTr").hide();
	} else if(selectVal == "2"){ // 选择页
		$(".defaultAndEformTr").hide();
		$(".defaultTr").hide();
		$(".EformTr").hide();
		$(".selectTr").show();
		if($("#id").val() == ""){
			$(":radio[name='selectType'][value='0']").prop("checked", "checked");
		} else {
			var selectTypeVal = $("input[name='selectType']:checked").val();
			if(selectTypeVal == "2"){ // 自定义选择页面
				$(".selectCustomTr").show();
			}
		}
	}
});

//选择页面事件
$("input[name='selectType']").on("click",function(){
	var selectVal = this.value;
	$("#selectId").val("");
	if(selectVal == "0"){ // 平台选择页
		$(".selectCustomTr").hide();
	} else if(selectVal == "1"){ // 电子表单数据字典
		$(".selectCustomTr").hide();
	} else if(selectVal == "2"){ // 自定义选择页
		$(".selectCustomTr").show();
	}
});

$("#showOldSqlSelect").on("change",function(){
	$("#textareaHtmlTd").find("textarea").css("display","none");
	$("#" + this.value).show();
});

var tipsIndex;
$(".sysdatapermissionTips1").mouseover(function(){
	var message="选择表将自动匹配对应的Mapper，如没有匹配出请手动选择！手动选择的Mapper需要和表有关联！";
	tipsIndex= layer.tips(message, $(this), {
		  tips: [1, '#3595CC'],
		  time: 0
	});
}).mouseout(function(){
	layer.close(tipsIndex);
});
$(".sysdatapermissionTips2").mouseover(function(){
	var message="平台自定义选择页：请填写编码值<br/>电子表单数据字典：请填写电子表单编码-字段id<br/>自定义选择页：请填写能代表该页面的唯一标识";
	tipsIndex= layer.tips(message, $(this), {
		  tips: [1, '#3595CC'],
		  time: 0,
		  area: ['300px', 'auto']
	});
}).mouseout(function(){
	layer.close(tipsIndex);
});
$(".sysdatapermissionTips3").mouseover(function(){
	var message="平台自定义选择页：系统>>配置管理>>自定义选择页<br/>" +
				"电子表单数据字典：电子表单设计>>高级控件>>数据字典控件<br/>" +
				"自定义选择页：将SQL维护在数据库中，弹出页面只有1个，页面通过传递标识来读取对应的SQL进行数据展示";
	tipsIndex= layer.tips(message, $(this), {
		  tips: [1, '#3595CC'],
		  time: 0,
		  area: ['610px', 'auto']
	});
}).mouseout(function(){
	layer.close(tipsIndex);
});
$(".sysdatapermissionTips4").mouseover(function(){
    var message='执行方法至少需要包含以下参数：@Param("code") String code @Param("sql") String sql';
    tipsIndex= layer.tips(message, $(this), {
        tips: [1, '#3595CC'],
        time: 0,
        area: ['200px', 'auto']
    });
}).mouseout(function(){
    layer.close(tipsIndex);
});
$(".sysdatapermissionTips5").mouseover(function(){
    var message='SqlServer:<br />' +
        'jdbc:sqlserver://地址:端口;DatabaseName=数据库名<br />' +
        'Oracle:<br />' +
        'jdbc:oracle:thin:@地址:端口:数据库名<br />' +
        'MySQL:<br />' +
        'jdbc:mysql://地址:端口/数据库名?useUnicode=true&characterEncoding=utf8<br />' +
        'DM DBMS:<br />' +
        'jdbc:dm://地址:端口<br />' +
        'KingbaseES:<br />' +
        'jdbc:kingbase8://地址:端口/数据库名<br />' +
        'OSCAR:<br />' +
        'jdbc:oscar://地址:端口/数据库名'
    tipsIndex= layer.tips(message, $(this), {
        tips: [1, '#3595CC'],
        time: 0,
        area: ['330px', 'auto']
    });
}).mouseout(function(){
    layer.close(tipsIndex);
});
$(".sysdatapermissionTips6").mouseover(function(){
    var message='DM DBMS数据库请填写DM'
    tipsIndex= layer.tips(message, $(this), {
        tips: [1, '#3595CC'],
        time: 0,
        area: ['200px', 'auto']
    });
}).mouseout(function(){
    layer.close(tipsIndex);
});

// 检验表单
function validateForm(idVal){
	var b = false;
	
	var selectVal = $("input[name='type']:checked").val();
	if(selectVal == "0"){// 普通模块
		var tableNameVal = $("#tableName").val();
		if("" == tableNameVal){
			layer.msg("请填写表名称");
			return false;
		}
		var tableRemarksVal = $("#tableRemarks").val();
		if("" == tableRemarksVal){
			layer.msg("请填写表说明");
			return false;
		}
		var mapperNameVal = $("#mapperName").val();
		var mapperRemarksVal = $("#mapperRemarks").val();
		var methodVal = $("#method").val();
		var methodRemarksVal = $("#methodRemarks").val();
		if("" == mapperNameVal){
			layer.msg("请选择mapper");
			return false;
		}
		if("" == mapperRemarksVal){
			layer.msg("请填写mapper说明");
			return false;
		}
		if(null == methodVal){
			layer.msg("请选择方法");
			return false;
		}
		if("" == methodRemarksVal){
			layer.msg("请填写方法说明");
			return false;
		}
		avicAjax.ajax({
			url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/checkMapperAndMethodIsUnique",
			data : {mapperName : $("#mapperName").val() , method : $("#method").val().join(",") , id : idVal},
			type : 'get',
			dataType : 'json',
			async : false,
			success : function(r){
				if (r.flag == "success"){
					b = true;
				} else {
					layer.alert("可以配置同一个mapper但方法不能重复，如下方法已存在：<br/>" + r.list , {icon: 2});
				}
			}
		});
	} else if(selectVal == "1"){ // 电子表单 20200602表名称+视图编码
		var tableNameVal = $("#tableName").val();
		if("" == tableNameVal){
			layer.msg("请填写表名称");
			return false;
		}
		var tableRemarksVal = $("#tableRemarks").val();
		if("" == tableRemarksVal){
			layer.msg("请填写表说明");
			return false;
		}
		
		var viewCodeVal = $("#viewCode").val();
		var viewNameVal = $("#viewName").val();
		if("" == viewCodeVal){
			layer.msg("请填写视图编码");
			return false;
		}
		if("" == viewNameVal){
			layer.msg("请填写视图名称");
			return false;
		}
		
		avicAjax.ajax({
			url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/checkViewCodeIsUnique",
			data : {viewCode : $("#viewCode").val() ,tableName:tableNameVal, id : idVal},
			type : 'get',
			dataType : 'json',
			async : false,
			success : function(r){
				if (r.flag == "success"){
					b = true;
				} else {
					layer.alert("视图编码存在！", {icon: 2});
				}
			}
		});
	} else if(selectVal == "2"){ // 选择页
		var selectIdVal = $("#selectId").val();
		if("" == selectIdVal){
			layer.msg("请填写唯一标识");
			return false;
		}
		var selectTypeVal = $("input[name='selectType']:checked").val();
		if("0" == selectTypeVal){ // 平台自定义选择页
		} else if("1" == selectTypeVal){ // 电子表单数据字典
		} else if("2" == selectTypeVal){ // 自定义
			var selectMapperNameVal = $("#selectMapperName").val();
			var selectMethodNameVal = $("#selectMethodName").val();
			if("" == selectMapperNameVal){
				layer.msg("请填写选择页mapper");
				return false;
			}
			if("" == selectMethodNameVal){
				layer.msg("请填写方法");
				return false;
			}
		}
		avicAjax.ajax({
			url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/checkSelectIdIsUnique",
			data : {selectId : selectIdVal, id : idVal , type : selectTypeVal},
			type : 'get',
			dataType : 'json',
			async : false,
			success : function(r){
				if (r.flag == "success"){
					b = true;
				} else {
					layer.alert("标识符已存在！", {icon: 2});
				}
			}
		});
		$("#tableRemarks").val($("#selectIdRemarks").val());
	}
	
	return b;
}

//选择数据库
$('#dataSourceBtn,#tableName').on('click', function() {
	var val = $('input:radio[name="type"]:checked').val();
	if(val == "0"){
		layer.open({
			type : 2,
			area : [ '70%', '70%' ],
			title : '请选择数据表',
			skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
			shade : 0.3,
			maxmin : false, //开启最大化最小化按钮
			content : 'avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/SelectDataTable.jsp',
			btn : [ '确定', '关闭' ],
			yes : function(index, layero) {
				var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
				var rowData = iframeWin.selectRow();
				if (!rowData) {
					return false;
				}
				$("#tableName").val(rowData.tableName);
				$("#tableRemarks").val(rowData.tableComment);
				$("#mapperRemarks").val(rowData.tableComment);
				avicAjax.ajax({
					url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getMapperName",
					data : {tableName : rowData.tableName},
					type : 'get',
					dataType : 'json',
					async : false,
					success : function(r){
						if(r.mapperName == ""){
							parent.layer.alert("未匹配出mapper，请手动选择!",{icon:0});
						} else {
							if (r.flag == "success"){
								$("#mapperName").val(r.mapperName);
								var methodHtml = "";
								var checkedOption = "";
								$.each(r.method,function(i,d){
									var str = d.substr(d.lastIndexOf(".")+1);
									methodHtml+="<option value='"+str+"'>"+str+"</option>";
									if(str.indexOf("ByPage") != -1){
										checkedOption += str+",";
									}
								});
								$("#method").html(methodHtml);
								$('#method').val(checkedOption.split(','));
				                $('#method').trigger('change.select2');

				                $("#showOldSqlSelect").html(r.selectHtml);
				                $("#textareaHtmlTd").html(r.textareaHtml);
							}
						}
					}
				});
				layer.close(index);
			},
			cancel : function(index, layero) {
				layer.close(index);
			}
		});
	}else if(val == "1"){ // 电子表单
		layer.open({
        	type: 2,
            title: '选择已经创建的表',
            skin: 'bs-modal',
            area: ['350px', '350px'],
            maxmin: false,
            content: "avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/selectCreatedDbTable.jsp"
    	});
	}
	$("#tableName").blur();
});

//选择电子表单视图code
$('#viewCodeBtn,#viewCode').on('click', function() {
	layer.open({
		type : 2,
		area : [ '70%', '70%' ],
		title : '请选择视图编码',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		shade : 0.3,
		maxmin : false, //开启最大化最小化按钮
		content : 'avicit/platform6/console/sysdatapermissions/sysdatapermissionsmethod/selectEformViewCode.jsp',
		btn : [ '确定', '关闭' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
			var rowData = iframeWin.selectRow();
			if (!rowData) {
				return false;
			}
			$("#viewCode").val(rowData.VIEW_CODE);
			$("#viewName").val(rowData.VIEW_NAME);
			layer.close(index);
		},
		cancel : function(index, layero) {
			layer.close(index);
		}
	});
	
});

//选择mapper
$('#mapperNameBtn,#mapperName').on('click', function() {
	layer.open({
		type : 2,
		area : [ '70%', '70%' ],
		title : '请选择mapper文件',
		skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
		shade : 0.3,
		maxmin : false, //开启最大化最小化按钮
		content : 'platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/toSelectMapperPage',
		btn : [ '确定', '关闭' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;//子页面的窗口对象
			var rowData = iframeWin.selectRow();
			if (!rowData) {
				return false;
			}
			$("#mapperName").val(rowData.mapperName);
			avicAjax.ajax({
				url:"platform6/sysdatapermissionsmethod/sysDataPermissionsMethodController/getMethodHtml",
				data : {mapperName : rowData.mapperName},
				type : 'get',
				dataType : 'json',
				async : false,
				success : function(r){
					if (r.flag == "success"){
						if("" != r.method){
							var methodHtml = "";
							var checkedOption = "";
							$.each(r.method,function(i,d){
								var str = d.substr(d.lastIndexOf(".")+1);
								methodHtml+="<option value='"+str+"'>"+str+"</option>";
								if(str.indexOf("ByPage") != -1){
									checkedOption += str+",";
								}
							});
							$("#method").html(methodHtml);
							$('#method').val(checkedOption.split(','));
			                $('#method').trigger('change.select2');

			                $("#showOldSqlSelect").html(r.selectHtml);
			                $("#textareaHtmlTd").html(r.textareaHtml);
						}
					}
				}
			});
			layer.close(index);
		},
		cancel : function(index, layero) {
			layer.close(index);
		}
	});
});
