function ComObj(datagrid,url,dataGridColModel,menuid,type){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url,_self=this;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId="#"+datagrid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this.menuid=menuid;
	this._type=type;
	this.dataGridColModel = dataGridColModel;
	var _onClick=function(){};//单击事件
	this.getOnClick=function(){
		return _onClick;
	};
	this.setOnClick=function(func){
		_onClick=func;
		return _self;
	};
	this._selectId='-11';

	this.init.call(this);
}
//初始化操作
ComObj.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url:_self.getUrl()+'/list',
        mtype: 'get',
        postData:{menuid:_self.menuid},
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:this._doc.documentElement.clientHeight-135,
		rowNum: 100,
        scrollOffset: 20, //设置垂直滚动条宽度
        styleUI : 'Bootstrap',
		viewrecords: true, //
		autowidth: true,
		multiselect: true,
        hasTabExport:false,
        hasColSet:false,
		responsive:true//开启自适应
    });
	
    $(this._jqgridToolbar).append($('#tableToolbarCom'));
};
//关键字段查询
ComObj.prototype.searchByKeyWord =function(){
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
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
ComObj.prototype.loadByMenuId=function(appId){

	$(this._datagridId).jqGrid('setGridParam',{url:this.getUrl()+'/list',postData:{menuid:appId}}).trigger("reloadGrid");
	return  this;
};

ComObj.prototype.reLoadCom=function(){
	/*var searchdata={
		key:'zhang'
	};*/
	var _self =this;
	$.ajax({
		type: "post",
		url: _self.getUrl()+'/reloadComp',
		dataType:"json",
		data:{menuid:_self.menuid},
		error: function(request) {
			throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
		},
		success: function(r) {
			if(r.flag!=="success"){
				layer.alert('重载组件失败！' + r.e, {
					icon: 2,
					area: ['400px', ''],
					closeBtn: 0
				});
				return false;
			}
			$(_self._datagridId).trigger("reloadGrid");
		}
	});	
	return this;
	
};
ComObj.prototype.del=function(){
var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要删除该数据吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(index){
				for(;l--;){
					 ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/delete',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	if (r.flag == "success") {
					 		_self.reLoad();
					 		layer.msg('删除成功！',{
					 			icon: 1,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}else{
					 		layer.alert('删除失败！' + r.e, {
					 			icon: 2,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}
					 }
				 });
			});   
	}else{
        layer.alert('请选择要删除的记录！',{
            icon: 7,
            title:'提示',
            area: ['400px', '']
        });
	}
};
ComObj.prototype.reLoad=function(){
	$(this._datagridId).jqGrid('setGridParam',{postData:{menuid:this.menuid}}).trigger("reloadGrid");

};
//允许权限
ComObj.prototype.allow=function(){
	if(this._type==='O'){
		layer.msg('不能对组织操作!');
		return false;
	}
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要授权该组件吗?', {icon: 3, title:"提示", area: ['400px', '']},function(){
				for(;l--;){
					ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/allow',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	if (r.flag == "success") {
					 		_self.reLoad();


                            layer.msg('授权成功！', {icon : 1 ,title: "提示",area: ['400px', '']});
					 	}else{
					 		layer.alert('授权失败！' + r.e, {
					 			icon: 2,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}
					 }
				 });
			});   
	}else{
        layer.alert('请选择要授权的组件！',{
            icon: 7,
            title:'提示',
            area: ['400px', '']
        });
	}
};

//禁止权限
ComObj.prototype.deny=function(){
	if(this._type==='O'){
		//layer.msg('不能对组织操作!');
        //layer.msg('不能对组织操作！', {icon : 1 ,title: "提示",area: ['400px', '']});
        layer.alert('不能对组织操作！',{
            icon: 7,
            title:'提示',
            area: ['400px', '']
        });
        return false;
	}
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要禁止该组件权限吗?',  {icon: 3, title:"提示", area: ['400px', '']},function(){
				for(;l--;){
					ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/deny',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	if (r.flag == "success") {
					 		_self.reLoad();

					 		/*layer.msg('禁止成功！',{
					 			icon: 1,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});*/
                            layer.msg('禁止成功！', {icon : 1 ,title: "提示",area: ['400px', '']});
					 	}else{
					 		layer.alert('禁止失败！' + r.e, {
					 			icon: 2,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}
					 }
				 });
			});   
	}else{
        layer.alert('请选择要禁止的菜单！',{
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}
};


//移除权限
ComObj.prototype.remove=function(){
	if(this._type==='O'){
		layer.msg('不能对组织操作!');
		return false;
	}
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要移除该组件权限吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(){
				for(;l--;){
					ids.push(rows[l]);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/remove',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	if (r.flag == "success") {
					 		_self.reLoad();

					 	

					 		/*layer.msg('移除成功！',{
					 			icon: 1,
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});*/
                            layer.msg('移除成功！', {icon : 1 ,title: "提示",area: ['400px', '']});
					 	}else{
					 		layer.alert('移除失败！' + r.e, {
					 			icon: 2,
                                title: "提示",
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}
					 }
				 });
			});   
	}else{
        layer.alert('请选择要移除的组件！',{
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}
};
ComObj.prototype.clear=function(){
	$(this._datagridId).jqGrid('clearGridData');
};
