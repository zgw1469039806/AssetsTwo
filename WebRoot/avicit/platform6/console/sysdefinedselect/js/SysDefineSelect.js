/**
 * 
 */
function SysDefineSelect(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
SysDefineSelect.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getSysDefineSelectsByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:$(window).height()-120,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        userDataOnFooter: true,
        pagerpos:'left',
        loadComplete:function(){
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
        styleUI : 'Bootstrap',
		viewrecords: true, 
		multiselect: true,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
    $(this._jqgridToolbar).append($("#tableToolbar"));
    
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
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
//添加页面
SysDefineSelect.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['80%', '60%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});
};
//编辑页面
SysDefineSelect.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要编辑的数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据，进行编辑！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	//update  by suntao 2020-06-04
	/*if(rowData.sign_ == '是'){
		layer.alert('该数据为系统标识无法修改!', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
		return false;
	}*/
	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['80%', '60%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
SysDefineSelect.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['80%', '60%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	}); 
};
//跳转到测试页面
SysDefineSelect.prototype.test=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择模拟使用的数据！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据,进行模拟使用！', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0,
			  title:'提示'
			}
		);
		return false;
	}
	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '模拟使用',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'avicit/platform6/console/sysdefinedselect/SysDefineSelectTest.jsp?code_=' + rowData.code_
	}); 
};
//打开高级查询框
SysDefineSelect.prototype.openSearchForm = function(searchDiv){
	var _self = this;
	var contentWidth = 800;
	var top =  $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
	var text = $(searchDiv).text();
	var width = $(searchDiv).innerWidth();
	
	
	layer.config({
		  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	
	layer.open({
		type: 1,
		shift: 5,
		title: false,
		scrollbar: false,
		move : false,
		area: [contentWidth + 'px', '150px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
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
//控件校验   规则：表单字段name与rules对象保持一致
SysDefineSelect.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  		     			    				   				   code_:{
						required:true,
						maxlength: 50,
						validateCode:true
				   },  
				   							 		  				  		     			    				   				   des_:{
						required:true,
						maxlength: 50
				   },  
				   							 		  				  		     			    				   				   sql_:{
						required:true,
						maxlength: 1000
				   },  
				   							 		  				  		     			    				   				   sign_:{
						required:true,
						maxlength: 50
				   },  
				   							 		  				  				  				  				  				  				  			  }
	});
}
//保存功能
SysDefineSelect.prototype.save=function(form,id){
	var _self = this;
	var flag = form.find('textarea').val();
	if(!flag.startsWith("select") || flag.indexOf("delete")>-1 || flag.indexOf("update")>-1 || flag.indexOf("insert")>-1 || flag.indexOf("from")<0){
		layer.alert('请填写正确格式的查询语句', {
			  icon: 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return false;
	}
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 layer.close(_self.insertIndex);
				 }else{
					 layer.close(_self.eidtIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error, {
					  icon: 7,
					  area: ['400px', ''], //宽高
					  closeBtn: 0
					}
				);
			 } 
		 }
	 });
};
//删除
SysDefineSelect.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	for(var i=0;i<rows.length;i++){
		var rowData = $(_self._datagridId).jqGrid('getRowData', rows[i]);
		if(rowData.sign_ == '是'){
			layer.alert('该数据是系统标识的数据无法删除，请检查数据!', {
				  icon: 7,
				  title : '提示',
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
			);
			return false;
		}
	}
	if(l > 0){
		layer.confirm('确认要删除选择的数据吗?',  {icon: 3, title:"提示", closeBtn: 0,area: ['400px', '']}, function(index){
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
							layer.alert('删除失败！' + r.error, {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0
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
			  title:'提示'
			}
		);
	}
};
//重载数据
SysDefineSelect.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
SysDefineSelect.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//高级查询
SysDefineSelect.prototype.searchData =function(){
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this._formId)))
		}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
SysDefineSelect.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
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
//隐藏查询框
SysDefineSelect.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SysDefineSelect.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};
