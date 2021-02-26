/**
 * 单表附件流程
 * @param datagrid 
 * @param url 
 * @param searchD
 * @param form
 * @param keyWordId
 * @param searchNames
 * @param dataGridColModel
 */
function AssetsReconstructionProc(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
    this._formCode = "assetsReconstructionProc"; //表单的code，启动流程时需要
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
	//定义流程帮助类
	this.flowListEditor;
};
/**
 * 初始化操作
 */
AssetsReconstructionProc.prototype.init=function(){
	var _self = this;
	//初始化流程帮助类
	flowListEditor = new FlowListEditor(this._formCode);
	$(_self._datagridId).jqGrid({
    	url: _self.getUrl()+'getAssetsReconstructionProcsByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],//启用toolbar
        colModel: _self.dataGridColModel, //表格列的属性
        height:$(window).height()-120, //初始化表格高度
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,//每页条数
        rowList:[200,100,50,30,20,10], //每页条数可选列表
        altRows:true,//斑马线
        userDataOnFooter: true,
        pagerpos:'left',//分页栏位置
        hasColSet:false,//设置显隐属性
        loadComplete:function(){
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
        styleUI : 'Bootstrap',//Bootstrap风格
		viewrecords: true, //是否要显示总记录数
		multiselect: true, //可多选
		multiboxonly: true,
		autowidth: true, //列宽度自适应
		shrinkToFit: true,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
    $(_self._jqgridToolbar).append($("#tableToolbar"));
    
    $('.date-picker').datepicker({
		beforeShow: function () {
			setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
    });
	$('.time-picker').datetimepicker({
	 	oneLine:true,//单行显示时分秒
	 	closeText:'确定',//关闭按钮文案
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	showSecond:false,//是否可以选择秒，默认否
	 	beforeShow: function(selectedDate) {
	 		if($('#'+selectedDate.id).val()==""){
	 			$(this).datetimepicker("setDate", new Date());
	 			$('#'+selectedDate.id).val('');
	 		}
	 		setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
	 	}
	});
	//禁止时间和日期格式手输
	$('.date-picker').on('keydown',nullInput);
	$('.time-picker').on('keydown',nullInput);
	//回车查询
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
/**
 * 添加页面
 */
AssetsReconstructionProc.prototype.insert=function(){
	//添加流程
	flowListEditor.addFlow();
};
/**
 * 编辑页面
 */
AssetsReconstructionProc.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要编辑的数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  btn: ['关闭'],
			  title:"提示"
			}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  btn: ['关闭'],
			  title:"提示"
			}
		);
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.editIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
/**
 * 详情页面
 */
AssetsReconstructionProc.prototype.detail=function(id,value){
	flowUtils.detail(id);
};
/**
 * 打开高级查询框
 */
AssetsReconstructionProc.prototype.openSearchForm = function(searchBtn, contentWidth, contentHeight){
	var _self = this;
	var _resizeFunc;
	
	var _top =  $(searchBtn).offset().top + $(searchBtn).outerHeight(true);
	var _left = $(searchBtn).offset().left + $(searchBtn).outerWidth() - contentWidth;
	var _text = $(searchBtn).text();
	
	layer.open({
		type: 1,
		shift: 5,
		title: false,
		scrollbar: false,
		move : false,
		area: [contentWidth + 'px', contentHeight + 'px'],
		offset: [_top + 'px', _left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(_self._searchDialogId),
		end : function() {
			$(window).unbind('resize', _resizeFunc);
		},
		success : function(layero, index) {
			var serachLabel = $('<div class="searchTabs"><span>'+ _text +'</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			//窗口改变后调整位置
			_resizeFunc = function(){
				setTimeout(function(){
				   if(searchBtn){
					   var _newtop =  $(searchBtn).offset().top + $(searchBtn).outerHeight(true);
					   var _newleft = $(searchBtn).offset().left + $(searchBtn).outerWidth() - contentWidth;
					   layer.style(index, {
					      left: _newleft + 'px',
					      top: _newtop + 'px',
					   });  
				   }
			    }, 500)
			};
			$(window).bind('resize', _resizeFunc);
		},
		yes: function(index, layero){
			_self.searchData();
			layer.close(index);//查询框关闭
		},
		btn2: function(index, layero){
			_self.clearData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
/**
 * 控件校验   规则：表单字段name与rules对象保持一致
 */
AssetsReconstructionProc.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  		     			    				   				   reconstructionId:{
						required:true,
						maxlength: 50
				   },  
				   							 		  				  				  		     			    				   					createdByDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					formState:{
						maxlength: 10
				    },
				    							 		  				  				  				  				  				  				  		     			    				   					ownerDept:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					ownerId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					ownerTel:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceName:{
						maxlength: 30
				    },
				    							 		  				  		     			    				   					secretLevel:{
						maxlength: 10
				    },
				    							 		  				  		     			    				   					unifiedId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceModel:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					deviceSpec:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					manufacturerId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   			       likaDate:{
						dateISO:true
				   },
				   							 		  				  		     			    				   				   originalValue:{
						number:true
				   },
				   							 		  				  		     			    				   					existingPerformance:{
						maxlength: 1024
				    },
				    							 		  				  		     			    				   					reformingReason:{
						maxlength: 1024
				    },
				    							 		  				  		     			    				   					afterPerformance:{
						maxlength: 1024
				    },
				    							 		  				  		     			    				   					transformWay:{
						maxlength: 1024
				    },
				    							 		  				  		     			    				   					budget:{
						maxlength: 50
				    },
				    							 		  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  			  }
	});
}
/**
 * 保存方法
 */
AssetsReconstructionProc.prototype.save=function(form,windowName,callback){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(typeof(callback)=="function"){
					 callback(r.id);
				 }
				 //layer.close(layer.getFrameIndex(windowName));
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败,请联系管理员!', {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0,
					  btn: ['关闭'],
					  title:"提示"
					}
				);
			 } 
		 }
	 });
};
/**
 * 删除方法
 */
AssetsReconstructionProc.prototype.del=function(){
	var _self = this;
	var rows = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 avicAjax.ajax({
					 url:_self.getUrl()+'delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
						 if (r.flag == "success") {
							 _self.reLoad();
						}else{
							layer.alert('删除失败,请联系管理员!', {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0,
								  btn: ['关闭'],
								  title:"提示"
								}
							);
						}
					 }
				 });
				 layer.close(index);
			});   
	}else{
	    layer.alert('请选择要删除的数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  btn: ['关闭'],
			  title:"提示"
			}
		);
	}
};
/**
 * 重载数据
 */
AssetsReconstructionProc.prototype.reLoad=function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关闭对话框
 */
AssetsReconstructionProc.prototype.closeDialog=function(windowName, msg){
	layer.close(layer.getFrameIndex(windowName));
	if(msg && msg !== ''){
		layer.msg(msg);
	}
};
/**
 * 后台查询	
 */
AssetsReconstructionProc.prototype.searchData =function(){
	var datebox = $('.date-picker,.time-picker');
	var data = [];
	$.each(datebox,function(i,item){
		 data[i] = $(item).val();
	});
	for (var i=0;i<(data.length/2);i++) {
		if(data[2*i] == "" || data[2*i+1] == "" || data[2*i] == null || data[2*i+1] == null){
			continue;
		}
		if(data[2*i]>data[2*i+1]){
			layer.alert("查询时,结束日期不能小于起始日期 ！", {
				icon : 7,
				area : [ '400px', '' ], //宽高
				closeBtn : 0,
				btn : [ '关闭' ],
				title : "提示"
			});
			return;
		}
	}
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this._formId)))
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
/**
 * 关键字段查询
 */
AssetsReconstructionProc.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var bpmState = $('#bpmState').val();
	var names = this._searchNames;

	var param = {bpmState: bpmState};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
			keyWord: JSON.stringify(param),
			param: null
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
}
/**
 * 根据流程状态查询
 */
AssetsReconstructionProc.prototype.initWorkFlow = function(status){
	$('#bpmState').val(status);
	if(status == "start"){
		$("#assetsReconstructionProc_modify").show();
		$("#assetsReconstructionProc_del").show();
	}else{
		$("#assetsReconstructionProc_modify").hide();
		$("#assetsReconstructionProc_del").hide();
	}
	this.searchData();
};
/**
 * 清空查询条件
 */
AssetsReconstructionProc.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};
