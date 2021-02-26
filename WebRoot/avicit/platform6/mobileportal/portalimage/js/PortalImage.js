/**
 * 单表附件
 * @param Jqgrid 
 * @param url 
 * @param searchDialogId
 * @param form
 * @param keyWordId
 * @param searchNames
 * @param dataGridColModel
 */
function PortalImage(datagrid, url, searchDialogId, form, keyWordId, searchNames, dataGridColModel){
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
	this._searchDialogId="#"+searchDialogId;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
PortalImage.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getPortalImagesByPage.json',
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
		viewrecords: true,
        styleUI : 'Bootstrap',
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
	 	showButtonPanel:true,//是否展示功能按钮面板
	 	closeText:'确定',
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
	//form回车事件
	$(_self._formId).find('input').bind('keyup',function(e){
		if(e.keyCode == 13){
			_self.searchData();
		}
	});
	$('.dropdown-menu').click(function(e) {
		e.stopPropagation();
	});
};
 //添加页面
PortalImage.prototype.insert=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['80%', '80%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Add/null' 
	});     
};







//编辑页面
PortalImage.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择要编辑的数据！',{
			  icon: 7,
			  area: ['400px', ''],
			  closeBtn: 0,
			  btn: ['关闭'],
			  title:"提示"
			}
		);
		return false;
	}else if(ids.length > 1){
	    layer.alert('只允许选择一条数据！',{
			  icon: 7,
			  area: ['400px', ''],
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
	    area: ['80%', '80%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Edit/'+rowData.id 
	});   
};
//详细页
PortalImage.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['80%', '80%'],
	    title: '详细',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id 
	});  
};
  //验证
PortalImage.prototype.formValidate=function(form){
    var _self = this;
	form.validate({
		rules : {
			imageName : {
				required : true,
				maxlength : 200
			},
			imagePath : {
				required : true,
				maxlength : 200
			},
			imageOrder : {
				required : true,
				number : true,
				maxlength : 16
			},
				    				   							 		  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  			  }
	});
}
// 保存功能
PortalImage.prototype.save=function(form,versionId){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form)),
		 versionId : versionId
		 },
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error, {
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
};
//删除
PortalImage.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
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
							layer.alert('删除失败！' + r.error, {
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
//重载数据
PortalImage.prototype.reLoad=function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
PortalImage.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};

//打开查询框
PortalImage.prototype.openSearchForm =function(searchDiv){
	var _self = this;
	var _resizeFunc;

	var contentWidth = 800;//查询弹窗宽度
	var _top =  $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
	var _left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
	var _text = $(searchDiv).text();
	var _width = $(searchDiv).innerWidth();
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
		offset: [_top + 'px', _left + 'px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['查询', '清空', '取消'],
		content: $(this._searchDialogId),
		success : function(layero, index) {
			var serachLabel = $('<div class="serachLabel"><span>'+ _text +'</span><span class="caret"></span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', _width + 'px');
		},
		yes: function(index, layero){
			_self.searchData();
			layer.close(index);
		},
		btn2: function(index, layero){
		    clearFormData(_self._formId);
			_self.searchData();
			return false;
		},
		btn3: function(index, layero){
			
		}
	});
};
//去后台查询
PortalImage.prototype.searchData =function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this._formId)))
	}
	$(this._datagridId).jqGrid('setGridParam',{datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};

//关键字查询
PortalImage.prototype.searchByKeyWord = function(){
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

//地址替换页面
PortalImage.prototype.toAlterPath = function(){
    layer.open({
        type: 2,
        area: ['80%', '50%'],
        title: '地址替换',
        btn: ['提交', '关闭'],
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'toAlterPath',
        yes: function (index, layero) {
            if (window["layui-layer-iframe" + index].save()) {
                layer.msg('保存成功！', {
                    icon: 1,
                    area: ['200px', ''],
                    closeBtn: 0
                });
            }
            layer.close(index);
        },
    });
}

//地址替换
PortalImage.prototype.alterPath  = function(oldPath,contextPath){
	var _self = this;
	var ret = false;
    avicAjax.ajax({
        url:_self.getUrl()+"alterPath",
        data : {oldPath :oldPath,
            	contextPath :contextPath
				},
        type : 'post',
        dataType : 'json',
        async : false,
        success : function(r){
            if (r.flag == "success"){
                _self.reLoad();
                ret = true;
            }else{
                layer.alert('保存失败！' + r.error, {
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

    return ret;
}

