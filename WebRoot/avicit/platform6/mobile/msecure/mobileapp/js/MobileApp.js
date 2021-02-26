/**
 * 
 */
function MobileApp(datagrid,url,searchD,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var _selectId='';
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	//this.init.call(this);
	
	//add
	 var _onSelectRow=null;//对象化封装，防止别人篡改
	    this.getOnSelectRow=function(){
	    	return _onSelectRow;
	    };
	    this.setOnSelectRow=function(f){
	    	_onSelectRow = f;
	    };
	    var _onLoadSuccess=null;
	    this.getOnLoadSuccess=function(){
	    	return _onLoadSuccess;
	    };
	    this.setOnLoadSuccess=function(f){
	    	_onLoadSuccess=f;
	    };
};
//初始化操作
MobileApp.prototype.init=function(){
	var _self = this;
	this.searchDialog =$(this._searchDiaId).css('display','block').dialog({
		title:'查询'
	});
	this.searchForm = $(this._formId).form();
	this.searchForm.find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			_self.searchData();
		}
	});
	this.searchDialog.dialog('close',true);
	//changer
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl()+"getMobileAppsByPage.json",
		onSelect: function(rowIndex, rowData){
			_self._selectId=rowData.id;
			_self.getOnSelectRow()(rowIndex, rowData,rowData.id);
		},
		onLoadSuccess :function(data){
			_self.getOnLoadSuccess()();
			if(data.total>0){
				_self._datagrid.datagrid('selectRow',0);
			}else{
				_self.getOnSelectRow()(null, null,-1);
			}
		}
		});
};
//添加页面
MobileApp.prototype.insert=function(){
	this.nData = new CommonDialog("insert","790","500",this.getUrl()+'Add/null',"添加",false,true,false);
	this.nData.show();
};
//修改页面
MobileApp.prototype.modify=function(){
	var rows = this._datagrid.datagrid('getChecked');
	if(rows.length !== 1){
		alert("请选择一条数据编辑！");
		return false;
	}
	this.nData = new CommonDialog("edit","790","500",this.getUrl()+'Edit/'+rows[0].id,"编辑",false,true,false);
	this.nData.show();
};
//详细页
MobileApp.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","790","500",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
//保存功能
MobileApp.prototype.save=function(form,id){
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
MobileApp.prototype.del=function(){
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
MobileApp.prototype.reLoad=function(){
	this._datagrid.datagrid('load',{});
};
//关闭对话框
MobileApp.prototype.closeDialog=function(id){
	$(id).dialog('close');
};

//打开查询框
MobileApp.prototype.openSearchForm =function(){
	this.searchDialog.dialog('open',true);
};
//去后台查询
MobileApp.prototype.searchData =function(){
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//隐藏查询框
MobileApp.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
};
/*清空查询条件*/
MobileApp.prototype.clearData =function(){
	this.searchForm.find('input').val('');
	this.searchData();
};
MobileApp.prototype.formate=function(value){
	if(value){
		return new Date(value).format("yyyy-MM-dd");
	}
	return '';
};
MobileApp.prototype.formateDateTime=function(value){
	if(value){
		return new Date(value).format("yyyy-MM-dd hh:mm:ss");
	}
	return '';
};
//返回主表的id
MobileApp.prototype.getSelectID=function(){
	return this._selectId;
};
MobileApp.prototype.searchDataBySfn =function(conditions){
    this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    this._datagrid.datagrid('load',conditions);
};
                                             