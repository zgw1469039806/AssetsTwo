/**
 * div的控制
 */
$(function() {
	$(".required").on("blur", function(){
		if($.notNull($(this).val())){
			$(this).removeClass("requiredInput");
		}else{
			$(this).addClass("requiredInput");
		}
	});
	// 显示名称监听
	$("input[id = 'xian_shi_ming_cheng']").ipt(function() {
		var value = $(this).val();
		_myCellMap.get(_myCurCellId).labelChanged(value);
	});
	//类型,主要改变tagName 
	$(".tagChange").on("change", function() {
		var value = $(this).val();
		_myCellMap.get(_myCurCellId).endpointChanged(value);
	});
	//单向双向,主要改变图标
	$(".imageChange").on("change", function() {
		var value = $(this).val();
		_myCellMap.get(_myCurCellId).imageChanged(value);
	});
	//choice的是否默认check框
    $('table.need_check').find('input[type="checkbox"]').on('change',function (){
        var key = $(this).prop('checked');
        $(this).parent().siblings().find('input').attr('disabled', key);
        if(key){
        	$(this).parent().parent().siblings().find('input[type="checkbox"]:checked').attr('checked', false);
        	$(this).parent().parent().siblings().find('.prop_txt').attr('disabled', false);
        }
    });
	//含有单选框的控制事件
    $('.js_open').on('click',function (){
        var $toggle=$(this).find('.js_onoff').prop('checked');
        if($toggle){
            $(this).nextAll().find('.js_show').show();
            $(this).parent().nextAll().find('.js_show').show();
            $(this).parents("form").nextAll().find('.js_show').show();
            
            $(this).nextAll().find('.js_hide').hide();
            $(this).parent().nextAll().find('.js_hide').hide();
            $(this).parents("form").nextAll().find('.js_hide').hide();
            
            //
//            $(this).nextAll().find('.js_enabled').attr('disabled',false);
//            $(this).parent().nextAll().find('.js_enabled').attr('disabled',false);
//            
//            $(this).nextAll().find('.js_disabled').attr('disabled',true);
//            $(this).parent().nextAll().find('.js_disabled').attr('disabled',true);
            
        }else{
            $(this).nextAll().find('.js_show').hide();
            $(this).parent().nextAll().find('.js_show').hide();
            $(this).parents("form").nextAll().find('.js_show').hide();
            
            $(this).nextAll().find('.js_hide').show();
            $(this).parent().nextAll().find('.js_hide').show();
            $(this).parents("form").nextAll().find('.js_hide').show();
            
            //
//            $(this).nextAll().find('.js_enabled').attr('disabled',true);
//            $(this).parent().nextAll().find('.js_enabled').attr('disabled',true);
//            
//            $(this).nextAll().find('.js_disabled').attr('disabled',false);
//            $(this).parent().nextAll().find('.js_disabled').attr('disabled',false);
        }
    });
    //数字
    $('.num_only').on('focus',function (){
        $(this).css('ime-mode','disabled');
        $(document).on('keydown',function (e){
            var num=e.keyCode;
            if((num<48&&num!==8)||num>57&&num<96||num>105){
                return false;
            }
        });
    }).on('blur',function (){
        $(document).off('keydown');
        var str=$(this).val();
        var s=str.replace(/\D/g,'');
        $(this).val(s);
    });
    //点击选择框对应的文字，触发选择框点击事件
    $('.label_for').on('click',function (){
    	$(this).prev().trigger("click");
    });
    $(".db_connector").on("change", function(){
    	var parentId = $(this).val();
    	var dbArr = _myConnector.dbSql.get(parentId);
    	var queryKey = $(this).parents("table").find("#queryKey");
    	queryKey.empty();
    	var blank = $("<option>").val("").text("");
    	queryKey.append(blank);
    	if($.notNull(parentId, dbArr)){
    		$.each(dbArr, function(i, n){
    			var option = $("<option>").val(n).text(n);
    			queryKey.append(option);
    		});
    	}
    	queryKey.val("");
    });
    //connector添加
    $(".js_connector_add").on('click',function (){
    	_myConnector.id = $(this).attr("connectorType");
    	_myConnector.selectDom = $(this).prevAll(".prop_txt");
    	_myConnector.parentId = "";
    	if(_myConnector.id == "db_sql"){
    		var parentId = $(this).parents("table").find("#connector-ref").val();
    		if(parentId != ""){
    			_myConnector.parentId = parentId;
    			_myConnector.openDialog(true);
    		}
    	}else{
    		_myConnector.openDialog(true);
    	}
    });
    //connector编辑
    $(".js_connector_edit").on('click',function (){
    	var str = $(this).prevAll(".prop_txt").val();
    	if($.notNull(str)){
    		_myConnector.id = $(this).attr("connectorType");
    		_myConnector.name = str;
    		_myConnector.load();
    	}
    });
    //关闭connector窗口
    $(".js_goback").on('click',function (){
    	_myConnector.closeDialog();
    });
    //js_tcp_add
    $(".js_tcp_add").on('click',function (){
    	_myConnector.saveTcpConnector();
    });
    //js_db_add
    $(".js_db_add").on('click',function (){
    	_myConnector.saveDbConnector();
    });
    //js_db_sql_add
    $(".js_db_sql_add").on('click',function (){
    	_myConnector.saveDbSqlConnector();
    });
    //js_db_dataSource_add
    $(".js_db_dataSource_add").on('click',function (){
    	_myConnector.saveDbDataSourceConnector();
    });
    //js_conn_smtp_add
    $(".js_conn_smtp_add").on('click',function (){
    	_myConnector.saveSmtpConnector();
    });
    
    /****************************************/
    $('.port_only').on('focus',function (){
        $(document).on('keydown',function (e){
            var num=e.keyCode;
            if((num<48&&num!==8)||num>57&&num<96||num>105){
                return false;
            }
        });
    }).on('blur',function (){
        $(document).off('keydown');
        var str=$(this).val();
        var s=str.replace(/\D/g,'');
        if(s != "" && !isNaN(s)){
        	var ns = Number(s);
        	//端口区间1000~65535
        	if(ns < 1000 || ns > 65535){
        		easyHelp.showMsg("端口区间1000~65535");
        		$(this).val("");
        	}else{
        		$(this).val(s);
        	}
        }else{
        	$(this).val("");
        }
    });
});