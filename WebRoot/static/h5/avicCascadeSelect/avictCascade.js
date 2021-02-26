(function($) {
	var that;
    var options = {
            baseUrl:'console/LookupHiberarchy',//controller路径
            $obj: '', //控件id前缀
            baseMethodTopUrl:'/searchTopLookupType/',//初始化一级通用代码controller方法的路径
            baseMethodNextUrl:'/searchNextlookuptype/', //查找下一级通用代码controller方法的路径
            setData:'',
            getData:''
    };
    var setting;
    var $obj = "";
    /**
     * 查找下一级
     * @param  {[object]} data
     * @param  {[string]} type
     */
    function findnextlookuptype(flag){
    	$("#"+$obj + flag).nextAll().remove(); 
    	avicAjax.ajax({
	        cache: true,
	        type: "post",
	        url: setting.baseUrl + setting.baseMethodNextUrl + $("#"+$obj + flag).val().split(',')[0],
	        dataType:"json",
	        async: false,
	        error: function(request) {
	        	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
	        },
	        success: function(r) {
				if (r.flag == "success") {
					if(r.sysLookupHiberarchyDTOs.length > 0){
						 var h = parseInt($('.form-control.lookupHiberarchy:last-child').attr('id').split('_')[1]) + 1;
						 $('<select id="'+$obj + h + '" class="form-control lookupHiberarchy" style="width:100px;float:left;"><option value=\'"0"\'>请选择</option></select>').insertAfter("#"+$obj + flag); 
						 $.each(r.sysLookupHiberarchyDTOs, function(index,value){
							 $("#"+$obj + h).append("<option value='"+value.id+"'>"+value.typeValue+"</option>");
	                     });
						 $('#'+$obj + h).on('change',function(){
							findnextlookuptype(h);
						 });
					}
				}
	        }
	    });
    }
    
    
    var methods = {
    		getRootData:function(opt){
    			that = this;
    			$obj = $(that).attr('id').split('_')[0]+'_';
		         setting = $.extend({},options, opt);
		         avicAjax.ajax({
    		        cache: true,
    		        type: "post",
    		        url: setting.baseUrl + setting.baseMethodTopUrl+$(that).attr("data-lookupCodeType"),
    		        dataType:"json",
    		        async: false,
    		        error: function(request) {
    		        	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
    		        },
    		        success: function(r) {
    					if (r.flag == "success") {
    						if(r.sysLookupHiberarchyDTOs.length > 0){
    							 $.each(r.sysLookupHiberarchyDTOs, function(index,value){
    								 $(that).append("<option value='"+value.id+"'>"+value.typeValue+"</option>");
    		                     });
    						}
    					}
    		        }
    		    });
    			$(that).on('change',function(e){
    				findnextlookuptype(0);
    			});
    		},
    		getSelectData:function(){
    			var $objs = [];
            	$.each($('.form-control.lookupHiberarchy:visible'),function(index,item){
            		if($(item).find("option:selected").text()!='请选择'){
            		  $objs.push({lookTypeValue:$(item).find("option:selected").val(),lookTypeText:$(item).find("option:selected").text()});
            		}
            	});
            	return $objs;
    		},
    		setSelectData:function(array){
    			if(array && array.length > 0){
    				for(var i = 0;i < array.length;i++){
    					if(i == 0){
    					   $(that).val(array[0].lookTypeValue);
    	    			   findnextlookuptype(0);
    					}else{
        				   $(".form-control.lookupHiberarchy:last-child").val(array[i].lookTypeValue);
        				   findnextlookuptype($(".form-control.lookupHiberarchy:last-child").attr('id').split('_')[1]);
    					}
    				}
    			}
    		}
    }
    $.fn.cascadeSelect = function(method) {
    	if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || !method) {
			return methods.getRootData.apply(this, arguments);
		} else {
			$.error('Method ' + method + ' does not exist on jQuery.cascadeSelect');
		}
    }
})(jQuery);