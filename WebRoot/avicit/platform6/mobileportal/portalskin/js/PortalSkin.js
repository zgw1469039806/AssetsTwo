/**
 * 
 */
function PortalSkin(datagrid, url, searchForm, dataGridColModel, searchDialog, afterInit, clickRowLoad,searchMainNames,demoMainDept_KeyWord){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId = "#"+datagrid;
	this.Toolbardiv = "#t_"+datagrid;
	this.Toolbar = "#toolbar_"+datagrid;
	this._searchDialogId ="#"+searchDialog;
	this.Pagerlbar = "#" +datagrid + "Pager";
	this.searchForm = "#" + searchForm;
	this._keyWordId="#"+demoMainDept_KeyWord;
	this._searchNames = searchMainNames;
	this.dataGridColModel = dataGridColModel;
	this.afterInit = afterInit;
	this.clickRowLoad = clickRowLoad;
	this.init.call(this);
}
//初始化操作
PortalSkin.prototype.init=function(){
	var _self = this;
	var issubinit = false;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getPortalSkinsByPage.json',
        mtype: 'POST',
        multiselect:true, 
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:$(window).height()-390-17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        scrollOffset: 10,
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        userDataOnFooter: true,
        pagerpos:'left',
        styleUI : 'Bootstrap', 
		viewrecords: true,
		multiboxonly:true,
		autowidth: true,
		shrinkToFit: true,
		responsive:true,
        pager: _self.Pagerlbar,
        onSelectAll: function(){
			_self.clickRowLoad("");
		},
        onSelectRow : function(rowid, status) {
			var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
			if (issubinit &&  rows.length == 1) {
				_self.clickRowLoad(rows[0]);
			}else{
				if(issubinit){
					_self.clickRowLoad("");
				}
			}
		},
        loadComplete:function(){
        	$(this).jqGrid('getColumnByUserIdAndTableName');
        	var rowdata = $(_self._datagridId).jqGrid('getRowData');
        	if(issubinit == false){
		        if(rowdata != null && rowdata.length > 0){
		            $(_self._datagridId).setSelection(rowdata[0].id);
		            _self.afterInit(rowdata[0].id);
		            issubinit = true;
	        	}else{
	        		_self.afterInit("-1");
	        		issubinit = true;
	        	}
	        }else{
	        	if(rowdata != null && rowdata.length > 0){
		            $(_self._datagridId).setSelection(rowdata[0].id);
		            _self.clickRowLoad(rowdata[0].id);

	        	}else{
	        		_self.clickRowLoad("");
	        	}
        	}
        }
    });
	
    $(_self.Toolbardiv).append($(_self.Toolbar));
    
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
PortalSkin.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['70%', '80%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});
};
//编辑页面
PortalSkin.prototype.modify=function(){
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
	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['70%', '80%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
PortalSkin.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	}); 
};
//控件校验   规则：表单字段name与rules对象保持一致
PortalSkin.prototype.formValidate=function(form){
	form.validate({
		rules : {
			skinName : {
				required : true,
				maxlength : 200
			},
			skinCode : {
				required : true,
				maxlength : 200
			},
			skinImg : {
				maxlength : 200
			},
			skinResponsibles : {
				maxlength : 2000
			},
			skinDesc : {
				maxlength : 2000
			},
			skinState : {
				required : true,
				maxlength : 2
			},  
				   							 		  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  			  }
	});
};
/*
 * //保存功能 PortalSkin.prototype.save=function(form,id){ var _self = this;
 * avicAjax.ajax({ url:_self.getUrl()+"save", data : {data
 * :JSON.stringify(serializeObject(form)),file:file}, type : 'post', dataType :
 * 'json', success : function(r){ if (r.flag == "success"){ _self.reLoad();
 * if(id == "insert"){ layer.close(_self.insertIndex); }else{
 * layer.close(_self.eidtIndex); } layer.msg('保存成功！'); }else{
 * layer.alert('保存失败！' + r.error,{ icon: 7, area: ['400px', ''], //宽高 closeBtn:
 * 0, btn: ['关闭'], title:"提示" } ); } } }); };
 */

//保存功能
PortalSkin.prototype.save=function(form,id,file){
	var _self = this;
	$.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(form),
			 file:file
			 },
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
				 layer.alert('用户代码已被占用',{
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

//删除
PortalSkin.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var rowDatas = [];
	var rl= rows.length;			// 通过id的list得到rowData的list
	for(;rl--;){
		 var rowData = $(this._datagridId).jqGrid('getRowData', rows[rl]);
		 rowDatas.push(rowData);
	}
	var _self = this;
	var ids = [];
	var l = rowDatas.length ;
	if(l > 0){
		layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					 if("启用"==rowDatas[l].skinState){
						 layer.confirm('有程序已经启动!', {
								icon : 3,
								title : "提示",
								area : [ '400px', '' ]
							});
						 return;
					 }
					 ids.push(rowDatas[l].id);
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
							 layer.alert('删除失败！'+ r.error, {
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
/*启动按钮*/
PortalSkin.prototype.start =function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var l =ids.length;
	if (l> 0) {
		/*layer.confirm('确认要启动选中的数据吗?', {
			icon : 3,
			title : "提示",
			area : [ '400px', '' ]
		},function(){*/
		avicAjax.ajax({
			url : _self.getUrl() + "updateState2",
			data:	JSON.stringify(ids),
			 contentType : 'application/json',
				type : 'post',
				dataType : 'json',
			success : function(r) {
				if (r.flag == "success") {
					_self.reLoad();
					var id = this.id ;
					if (id == "insert") {
						layer.close(_self.insertIndex);
					} else {
						layer.close(_self.eidtIndex);
					}
					layer.msg('启用成功！');
				} else {
					layer.alert('启用失败！' + r.error, {
						icon : 7,
						area : [ '400px', '' ], // 宽高
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}
			}
		});
		
		/*});*/
	}

};
/*禁用按钮*/
PortalSkin.prototype.stop =function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var l =ids.length;
	if (l> 0) {
		/*layer.confirm('确认要禁用选中的数据吗?', {
			icon : 3,
			title : "提示",
			area : [ '400px', '' ]
		},function(){*/
		avicAjax.ajax({
			url : _self.getUrl() + "updateState",
			data:	JSON.stringify(ids),
			 contentType : 'application/json',
				type : 'post',
				dataType : 'json',
			success : function(r) {
				if (r.flag == "success") {
					_self.reLoad();
					var id = this.id ;
					if (id == "insert") {
						layer.close(_self.insertIndex);
					} else {
						layer.close(_self.eidtIndex);
					}
					layer.msg('禁用成功！');
				} else {
					layer.alert('禁用失败！' + r.error, {
						icon : 7,
						area : [ '400px', '' ], // 宽高
						closeBtn : 0,
						btn : [ '关闭' ],
						title : "提示"
					});
				}
			}
		});
		
		/*});*/
	}

};
//重载数据
PortalSkin.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this.searchForm)))};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
PortalSkin.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//打开高级查询框
PortalSkin.prototype.openSearchForm = function(searchDiv,par){
	var _self = this;
	par = null;
	//if(!par) par = $(window);
	var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
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
		area: [contentWidth + 'px', '400px'],
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
			layer.close(index);
		},
		btn2: function(index, layero){
			_self.clearData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
//高级查询
PortalSkin.prototype.searchData =function(){
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this.searchForm)))
		};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
PortalSkin.prototype.searchByKeyWord =function(){
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
		};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//隐藏查询框
PortalSkin.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
PortalSkin.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};

