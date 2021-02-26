function SearchIndex(datagrid, url, searchForm, dataGridColModel, searchDialog, afterInit, clickRowLoad,searchMainNames,demoMainDept_KeyWord){
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
SearchIndex.prototype.init=function(){
	var _self = this;
	var issubinit = false;
	$(_self._datagridId).jqGrid({
    	url: 'platform/new/search/list.json',
        mtype: 'POST',
        multiselect:true, 
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:$('#north1').height() - $("#toolbar_searchIndex").innerHeight() -36  -48,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        //width:652,
        scrollOffset: 10,
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		loadonce: true,
		viewrecords: true,
		multiboxonly:true,
		hasTabExport:false, //导出
		hasColSet:false,  //设置显隐
		rownumbers:false,
		autowidth: true,
		responsive:true,
        pager: _self.Pagerlbar,
        onSelectRow: function(rowid) {
        	if(issubinit){
        		_self.clickRowLoad(rowid);
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
        	
        	setTimeout(function(){
        		$(document).trigger('resize');
        	},100)
        }
    });
	
    $(_self.Toolbardiv).append($(_self.Toolbar));
    
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
//添加数据库页面
SearchIndex.prototype.insertDb=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    title: '添加数据库数据源',
	    skin: 'bs-modal',
	    area: ['100%', '100%'],
        maxmin: false,
	    content: 'avicit/platform6/modules/system/newsearch/management_add.jsp'
	});      
};
//添加文档页面
SearchIndex.prototype.insertDoc=function(){
	this.insertIndex = layer.open({
	    type: 2,
	    title: '添加文档数据源',
	    skin: 'bs-modal',
	    area: ['100%', '100%'],
        maxmin: false,
	    content: 'avicit/platform6/modules/system/newsearch/management_add_doc.jsp' 
	});      
};
//设置为有效
SearchIndex.prototype.setOk=function() {
	var _self = this;
	url='platform/new/search/setOk.html';
	var row = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if (row.length == 0) {
		layer.alert('请选择要设置为【有效】的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title : '提示'
		});
		return false;
	}
	var ids = [];
	var rowLength = row.length;
	for(var i = 0;i<rowLength;i++){
		ids.push(row[i]);
	}
	if (row) {
		layer.confirm('确认设置为【有效】吗?',{icon: 3, title:"提示", area: ['400px', '']}, function(index){
			 $.ajax({
				 url:url,
				 data : JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.success) {
						 _self.reLoad(row);
						 layer.alert('设置成功！');
					}else{
						layer.alert('设置失败！');
					}
				 }
			 });
			 layer.close(index);
		}); 
		
	}
};
//设置为无效
SearchIndex.prototype.setCancel=function() {
	var _self = this;
	url='platform/new/search/setCancel.html';
	var row = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if (row.length == 0) {
		layer.alert('请选择要设置为【无效】的数据！！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title :'提示'
		});
		return false;
	}
	var ids = [];
	var rowLength = row.length;
	for(var i = 0;i<rowLength;i++){
		ids.push(row[i]);
	}
	if (row) {
		layer.confirm('确认设置为【无效】吗?',{icon: 3, title:"提示", area: ['400px', '']}, function(index){
			 $.ajax({
				 url:url,
				 data : JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.success) {
						 _self.reLoad(row);
						 layer.alert('设置成功！');
					}else{
						layer.alert('设置失败！');
					}
				 }
			 });
			 layer.close(index);
		}); 
		
	}
};
//重建索引
SearchIndex.prototype.buildIndex=function(){
	var _self = this;
	var avicAjaxLoading2;
	url='platform/new/search/bulidIndex.html';
	layer.confirm('确认重新建立索引吗?', {icon : 3,area : [ '400px', '' ], closeBtn : 0,title :'提示'}, function(index){
		avicAjaxLoading2 = layer.load(2,{shade: [0.2, '#000'],scrollbar: false});
		 $.ajax({
			 url:url,
			 data : {
				 	id : 'id'
				},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 layer.close(avicAjaxLoading2);
				 if (r.success) {
					 _self.reLoad();
					 layer.alert('重建成功！');
				}else{
					layer.alert('重建失败！');
				}
			 }
		 });
		 layer.close(index);
	}); 
	
};
//编辑页面
SearchIndex.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var rowData = $(this._datagridId).jqGrid('getRowData',ids);
	if(ids.length == 0){
		layer.alert('请选择要编辑的数据！', {
            icon: 7,
            area: ['400px', ''],
            title:'提示',
            closeBtn: 0
        });
		return false;
	}else if(ids.length > 1){
		layer.alert('只允许选择一条数据，进行编辑！', {
            icon: 7,
            area: ['400px', ''],
            title:'提示',
            closeBtn: 0
        });
		return false;
	}
	if (rowData) {
		if(rowData.type=='数据库数据源'){
			this.eidtIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    title: '编辑',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: 'platform/new/search/initedit?id='+rowData.id 
			});
		}
		if(rowData.type=='文档数据源'){
			this.eidtIndex = layer.open({
			    type: 2,
			    area: ['100%', '100%'],
			    title: '编辑',
			    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
		        maxmin: false, //开启最大化最小化按钮
			    content: 'platform/new/search/initdocedit?id='+rowData.id 
			});
		}
	} 
};
//详细页
/*
DemoMainDept.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","850","450",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
*/

//验证
SearchIndex.prototype.formValidate=function(form){
	form.validate({
		rules: {
			deptCode: {
				required: true,
				maxlength: 100
			},
			deptName: {
				required: true,
				maxlength: 50
			},
			deptType: {
				required: true,
				maxlength: 50
			}
		}
	});
};
//保存添加功能
SearchIndex.prototype.save=function(form,id){
	var _self = this;
	var url;
	if(id == "add"){
		url = 'platform/new/search/adddb.html';
	}else{
		url = 'platform/new/search/adddoc.html';
	}
	$.ajax({
		 url:url,
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.success){
				 _self.reLoad();
				 layer.close(_self.insertIndex);
				 layer.msg('保存成功！');
			 }else if(r.msg=="conflict"){
				 layer.alert('保存失败，请修改数据源名称！', {
					icon : 7,
					area : [ '400px', '' ], //宽高
					closeBtn : 0
				});
			 }else{
				 layer.msg('保存失败！');
			 } 
		 }
	 });
};

//保存编辑功能
SearchIndex.prototype.saveEdit=function(form,id){
	var _self = this;
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var url;
	if(id == "eidt"){
		url = 'platform/new/search/editdb.json';
	}else{
		url = 'platform/new/search/editdoc.json';
	}
	$.ajax({
		 url:url,
		 data : {
			 id:ids[0],
			 data :JSON.stringify(serializeObject(form))
		 },
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.success){
				 _self.reLoad();
				 layer.close(_self.eidtIndex);
				 layer.msg('保存成功！');
			 }else{
				 layer.msg('保存失败！');
			 } 
		 }
	 });
};
//删除
SearchIndex.prototype.del = function() {
	var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
	var _self = this;
	var ids = [];
	var l = rows.length;
	if (l > 0) {
		layer.confirm('确认要删除选择的数据吗?', {
			icon : 3,
			title : "提示",
			closeBtn : 0,
			area : [ '400px', '' ]
		}, function(index) {
			for (; l--;) {
				ids.push(rows[l]);
			}
			avicAjax.ajax({
				url : 'platform/new/search/delete.html',
				data : JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r) {
					if (r.success) {
						_self.reLoad();
					} else {
						layer.alert('删除失败！' + r.error, {
							icon : 7,
							area : [ '400px', '' ],
							closeBtn : 0,
							title : "提示",
						});
					}
				}
			});
			layer.close(index);
		});
	} else {
		layer.alert('请选择要删除的数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0,
			title :'提示'
		});
	}
};
//添加数据源配置
SearchIndex.prototype.addDataSourceConf=function(){
	//打开详细页
    layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '数据源配置',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'avicit/platform6/modules/system/newsearch/connection.jsp'
	});
};
//重载数据
SearchIndex.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', postData: searchdata}).trigger("reloadGrid");

};
//关闭对话框
SearchIndex.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};



//打开高级查询框
SearchIndex.prototype.openSearchForm = function(searchDiv,par){
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
			var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span></div>').appendTo(layero);
			serachLabel.bind('click', function(){
				layer.close(index);
			});
			serachLabel.css('width', width + 'px');
		},
		yes: function(index, layero){
			_self.searchData();
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
SearchIndex.prototype.searchData =function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', postData: searchdata}).trigger("reloadGrid");
};

//隐藏查询框
SearchIndex.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SearchIndex.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};

//关键字段查询
SearchIndex.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();
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
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', postData: searchdata}).trigger("reloadGrid");
};


/*
//字段查询
DemoMainDept.prototype.searchPart =function(){
	var searchpartdata = {param:JSON.stringify(serializeObject($(this._searchformId)))}
	$(this._datagridId).jqGrid('setGridParam',{postData: searchpartdata}).trigger("reloadGrid");
}

//隐藏查询框
DemoMainDept.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
//
DemoMainDept.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};
*/