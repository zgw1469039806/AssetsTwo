function ColDetail(searchIndex,datagrid, url, formSub, dataGridColModel,searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord){
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
	this.searchIndexId = "#"+ searchIndex;
	this.Toolbardiv = "#t_"+ datagrid;
	this.Toolbar = "#toolbar_"+ datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId="#" + demoSubUser_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
ColDetail.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: 'platform/new/search/listDetails.json',
    	postData : {pid : _self.pid},
        mtype: 'POST',
        datatype: "json",
        toolbar: [false,'top'],
        colModel: this.dataGridColModel, 
        height:$('#north2').height() - 40 - 38,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
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
        cellEdit:true,
        cellsubmit: 'clientArray'
    });
	
    $(_self.Toolbardiv).append($(_self.Toolbar)); 
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};


//添加页面
var newRowIndex = 0;
var newRowStart = "new_row";
ColDetail.prototype.insert=function(columnName){
	$(this._datagridId).jqGrid('endEditCell');
	var newRowId = newRowStart + newRowIndex;
	var parameters = {
		rowID : newRowId,
		initdata : {
			columnName: columnName,
			indexed: '0',
			stored:'1',
			secreted:'0',
			belong:'0'},
		position :"first",
		useDefValues : true,
		useFormatter : true,
		addRowParams : {extraparam:{}}
	}
	$(this._datagridId).jqGrid('addRow', parameters);
	newRowIndex++;  
};
//编辑页面
ColDetail.prototype.modify=function(){
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
ColDetail.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","850","450",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
*/

//验证
ColDetail.prototype.formValidate=function(form){
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

var op_indexed = [
	    		    {indexedid:'1',indexedname:'是'},
	    		    {indexedid:'0',indexedname:'否'}
];

var op_belong = [
	    		    {belongid:'0',belongname:'无'},
	    		    {belongid:'1',belongname:'标题'},
	    		    {belongid:'2',belongname:'正文'}
];

//保存功能
ColDetail.prototype.save=function(){
	var _self = this;
	$(this._datagridId).jqGrid('endEditCell');
	var data = $(this._datagridId).jqGrid('getRowData');
	if (data && data.length > 0) {
		for ( var j = 0; j < data.length; j++) {
			if (data[j].id == ''||data[j].id ==null) {
				data[j].maindataId = this.pid;
			}
			
			for(var i=0; i<op_indexed.length; i++){
				if (op_indexed[i].indexedname == data[j].indexed) 
					data[j].indexed=op_indexed[i].indexedid;
				if (op_indexed[i].indexedname == data[j].stored) 
					data[j].stored=op_indexed[i].indexedid;
				if (op_indexed[i].indexedname == data[j].secreted) 
					data[j].secreted=op_indexed[i].indexedid;
			}
			for(var i=0; i<op_belong.length; i++){
				if (op_belong[i].belongname == data[j].belong) 
					data[j].belong=op_belong[i].belongid;
			}
		}

		avicAjax.ajax({
			url : 'platform/new/search/save_detail.html',
			data : {
				data : JSON.stringify(data)
			},
			type : 'post',
			dataType : 'json',
			success : function(r) {
				if (r.success) {
					_self.reLoad();
					layer.msg('保存成功！');
				} else {
					layer.alert('保存失败！' + r.error, {
						icon : 7,
						area : [ '400px', '' ], //宽高
						closeBtn : 0
					});
				}
			}
		});
	} else {
		layer.alert('请先修改数据！', {
			icon : 7,
			area : [ '400px', '' ], //宽高
			closeBtn : 0
		});
	}
};


//删除
ColDetail.prototype.del=function(rowId){
	var _self = this;
	var rowData = $(this._datagridId).jqGrid('getRowData',rowId);
	var mainId=$(this.searchIndexId).jqGrid('getGridParam','selrow');
	var id = rowData.id;
		layer.confirm('确定要删除该数据吗?', {icon : 3,area : [ '400px', '' ], closeBtn : 0,title :'提示'}, function(index){
			$.ajax({
				 url:'platform/new/search/delete_detail.html',
				 data : {
					 	id : rowData.id
					},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.success){
						 _self.reLoad(mainId);
						 layer.msg('删除成功！');
					 }else{
						 layer.msg('删除失败！');
					 } 
				 }
			 });
			 layer.close(index);
		});   
	
};
//重载数据
ColDetail.prototype.reLoad = function(pid){
	if(pid != null){
		this.pid = pid;
	}
	var searchdata = {pid:this.pid};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', datatype: 'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
ColDetail.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(insertIndex);
	}else{
		layer.close(eidtIndex);
	}
};

//打开高级查询框
ColDetail.prototype.openSearchForm = function(searchDiv,par){
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
ColDetail.prototype.searchData =function(){
	var searchdata = {
		keyWord: null,
		pid:this.pid,
		param:JSON.stringify(serializeObject($(this.searchForm)))
	};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json', postData: searchdata}).trigger("reloadGrid");
};

//隐藏查询框
ColDetail.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
ColDetail.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};


//关键字段查询
ColDetail.prototype.searchByKeyWord =function(){
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

