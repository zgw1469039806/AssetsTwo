/**
 * 
 */
function MobileCommandHeaders(datagrid,url){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId="#"+datagrid;
	this._doc = document;
	//this.init.call(this);
};

function getRnd(){
	var rnd = Math.random();
	return rnd;
};
//初始化操作
MobileCommandHeaders.prototype.init=function(pid){
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl()+"getMobileCommandHeaders/"+pid
		});
};
MobileCommandHeaders.prototype.loadByPid=function(pid){
	return this._datagrid ? this._datagrid.datagrid({url : this.getUrl() +"getMobileCommandHeaders/"+ pid}):this.init(pid);
};
//添加页面
MobileCommandHeaders.prototype.insert=function(pid){
	if (pid){
		this.nData = new CommonDialog("insert","790","400",this.getUrl()+'Add/'+pid,"添加",false,true,false);
		this.nData.show();
	}else{
		$.messager.show({
			 title : '提示',
			 msg : '请先选择方法数据，再进行添加！'
		 });
	}
};
//修改页面
MobileCommandHeaders.prototype.modify=function(){
	var rows = this._datagrid.datagrid('getChecked');
	if(rows.length !== 1){
		alert("请选择一条数据编辑！");
		return false;
	}
	this.nData = new CommonDialog("edit","790","400",this.getUrl()+'Edit/'+rows[0].id,"编辑",false,true,false);
	this.nData.show();
};
//详细页
MobileCommandHeaders.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","790","400",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
//保存功能
MobileCommandHeaders.prototype.save=function(form,id){
	var _self = this;
	$.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(form)},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
				 $(id).dialog('close');
				$.messager.show({
					 title : '提示',
					 msg : '保存成功！'
				 });
			 }else{
				 $.messager.show({
					 title : '提示',
					 msg : r.error
				});
			 } 
		 }
	 });
};
//删除
MobileCommandHeaders.prototype.del=function(){
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
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
						 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						});
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.error
						});
					}
				 }
			 });
		 } 
	  });
	}else{
	  $.messager.alert('提示','请选择要删除的记录！','warning');
	}
};
//重载数据
MobileCommandHeaders.prototype.reLoad=function(){
	var rnd = getRnd();
	this._datagrid.datagrid('load',{avic_random : rnd});
};
//关闭对话框
MobileCommandHeaders.prototype.closeDialog=function(id){
	$(id).dialog('close');
};
                                        