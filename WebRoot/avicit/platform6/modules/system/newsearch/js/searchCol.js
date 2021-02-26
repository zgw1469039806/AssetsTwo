function SearchCol(datagrid, url, formSub, dataGridColModel,searchDialogSub, pid, searchSubNames, dbClickRowLoad){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._searchDialogId ="#" + searchDialogSub;
	this.searchForm = "#" + formSub;
    this.pid = pid;
	this._datagridId = "#"+ datagrid;
	this.Toolbardiv = "#t_"+ datagrid;
	this.Toolbar = "#toolbar_"+ datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId="";
	this._searchNames = searchSubNames;
	this.dbClickRowLoad = dbClickRowLoad;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
SearchCol.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: 'platform/new/search/listColumns.json',
    	postData : {pid : _self.pid},
        mtype: 'POST',
        datatype: "json",
        toolbar: [false,'top'],
        colModel: this.dataGridColModel, 
        height:$('#north2').height() - 40,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        //width:300,
        scrollOffset: 10, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        loadonce: true,
        styleUI : 'Bootstrap', 
		viewrecords: true, //
		multiselect: true,
		loadComplete:function(){
	        $(this).jqGrid('getColumnByUserIdAndTableName');
	    },
		autowidth: true,
		rownumbers:false,//显示行号
		responsive:true,//开启自适应
        pager: _self.Pagerlbar,
        ondblClickRow:function(rowid) {
        	_self.dbClickRowLoad(rowid);
        }
    });
	
    $(_self.Toolbardiv).append($(_self.Toolbar)); 
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};


//添加页面
SearchCol.prototype.insert=function(){
	if(this.pid == null || this.pid == ""){
		 layer.msg('请选择一条主表数据！');
		 return false;
	}
	insertIndex = layer.open({
	    type: 2,
	    title: '添加',
	    skin: 'bs-modal',
	    area: ['100%', '100%'],
        maxmin: false,
	    content: this.getUrl()+'Add/null' 
	});      
};
//编辑页面
SearchCol.prototype.modify=function(){
	if(this.pid == null || this.pid == ""){
		 layer.msg('请选择一条主表数据！');
		 return false;
	}
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择数据！');
		return false;
	}else if(ids.length > 1){
		layer.alert('请选择一条数据！');
		return false;
	}

	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	eidtIndex = layer.open({
	    type: 2,
	    title: '编辑',
	    skin: 'bs-modal',
	    area: ['100%', '100%'],
        maxmin: false,
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
/*
SearchCol.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","850","450",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
*/

//验证
SearchCol.prototype.formValidate=function(form){
	form.validate({
		rules: {
			name: {
				required: true,
				maxlength: 100
			},
			nameEn: {
				required: true,
				maxlength: 50
			},
			no: {
				required: true,
				maxlength: 50
			},
			loginName: {
				required: true,
				maxlength: 50
			},
			loginPassword: {
				required: true,
				maxlength: 50
			},
			secretLevel: {
				required: true,
				maxlength: 50
			}
		},messages: {   
	        required: "请输入{1}!",
	        maxlength:"输入数据太长!{1}"
	    } 
	});
}
//保存功能
SearchCol.prototype.save=function(form,id){
	var _self = this;
	$.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(serializeObject(form))},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 if(id == "insert"){
					 layer.close(insertIndex);
				 }else{
					 layer.close(eidtIndex);
				 }
				 layer.msg('保存成功！');
			 }else{
				 layer.msg('保存失败！');
			 } 
		 }
	 });
};

//删除
SearchCol.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要删除该数据吗?', function(index){
			for(;l--;){
				 ids.push(rows[l]);
			 }
			 $.ajax({
				 url:_self.getUrl()+'delete',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self.reLoad();
					}else{
						layer.alert('删除失败！');
					}
				 }
			 });
			 layer.close(index);
		});   
	}else{
		layer.msg('请选择要删除的记录！');
	}
};
//重载数据
SearchCol.prototype.reLoad = function(pid){
	if(pid != null){
		this.pid = pid;
	}
	var searchdata = {pid:this.pid};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
SearchCol.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(insertIndex);
	}else{
		layer.close(eidtIndex);
	}
};

//打开高级查询框
SearchCol.prototype.openSearchForm = function(searchDiv,par){
	var _self = this;
	//if(!par) par = $(window);
	var contentWidth = 600;//(par.width()*.6 >= 600)?600:par.width()*.6;
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
SearchCol.prototype.searchData =function(){
	var searchdata = {
		keyWord: null,
		pid:this.pid,
		param:JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', postData: searchdata}).trigger("reloadGrid");
};

//隐藏查询框
SearchCol.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
SearchCol.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};


//关键字段查询
SearchCol.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}

	var searchdata = {
		keyWord: JSON.stringify(param),
		pid:this.pid,
		param: null
	};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', postData: searchdata}).trigger("reloadGrid");
};

