function MenuPortlet(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.MenuStatus={0:'禁用',1:'启用'};
	this.init.call(this);
}
//初始化操作
MenuPortlet.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'/getPortletsByPage.json',
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:this._doc.documentElement.clientHeight-113,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		multiboxonly:true,
		autowidth: true,
		responsive:true,//开启自适应
        hasTabExport:false,
        hasColSet:false,
        pager: "#jqGridPager"
    });
	
    $(this._jqgridToolbar).append($("#tableToolbar"));
  
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
//添加页面
MenuPortlet.prototype.insert=function(){
	
	this.insertIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'/null' 
	});      
};
//编辑页面
MenuPortlet.prototype.modify=function(){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');

    if(ids.length == 0){
    	parent.layer.alert('请选择要编辑的数据！', {
            icon: 7,
            area: ['400px', ''],
            title:'提示',
            closeBtn: 0
        });
        return false;
    }else if(ids.length > 1){
        parent.layer.alert('只允许选择一条数据，进行编辑！', {
            icon: 7,
            area: ['400px', ''],
            title:'提示',
            closeBtn: 0
        });
        return false;
    }

	this.eidtIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'/'+ids[0]
	});   
};
//详细页
MenuPortlet.prototype.detail=function(id){
	detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	});   
};
//打开高级查询框
MenuPortlet.prototype.openSearchForm = function(searchDiv){
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
//验证
MenuPortlet.prototype.formValidate=function(form){
	form.validate({
		rules: {
			menuName: {
				required: true,
				maxlength: 1000
			},
			menuCode:{
				required:true,
				maxlength:50
			},
			menuOrder:{
				required: true,
				max:1000
			},
			menuUrl:{
				required:true,
				maxlength: 1000
			},
			css:{
				maxlength:4000
			}
		}
	});
};
//保存功能
MenuPortlet.prototype.save=function(form,id){
	
	var _self = this;
	$.ajax({
		 url:_self.getUrl()+"/save/"+id,
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
		 		layer.msg('保存成功！',{
		 			icon: 1,
		 			area: ['200px', ''],
		 			closeBtn: 0
		 		});
		 	}else{
		 		layer.alert('保存失败！' + r.e, {
		 			icon: 2,
		 			area: ['400px', ''],
		 			closeBtn: 0
		 		});
		 	} 
		 }
	 });
};
//删除
MenuPortlet.prototype.del=function(){
	
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		parent.layer.confirm('确认要删除选择的数据吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/delete',
					 data:	JSON.stringify(ids),
					 contentType : 'application/json',
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	if (r.flag == "success") {
					 		_self.reLoad();
                            parent.layer.msg('删除成功！',{
					 			icon: 1,
					 			area: ['200px', ''],
					 			closeBtn: 0
					 		});
					 	}else{
                            parent.layer.alert('删除失败！' + r.e, {
					 			icon: 2,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}
					 }
				 });
				 //layer.close(index);
			});   
	}else{
		parent.layer.alert('请选择要删除的数据！', {
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}
};
//重载数据
MenuPortlet.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");

};
//关闭对话框
MenuPortlet.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//高级查询
MenuPortlet.prototype.searchData =function(){
	var searchdata = {
			keyWord: null,
			param:JSON.stringify(serializeObject($(this._formId)))
		};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
MenuPortlet.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val();

    if(keyWord=='输入名称或编码查询'){
        keyWord="";
    }
	var names = this._searchNames;

	var param = {};
	for(var i in names){
		var name = names[i];
		param[name] = keyWord;
	}
	var searchdata = {
			keyWord: JSON.stringify(param),
		};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//隐藏查询框
MenuPortlet.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
MenuPortlet.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};
