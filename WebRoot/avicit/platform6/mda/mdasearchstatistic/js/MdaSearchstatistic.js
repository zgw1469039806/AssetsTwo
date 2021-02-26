/**
 * 
 */
function MdaSearchstatistic(datagrid,url,searchD,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var _selectId='';
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	this.init.call(this);
};
//初始化操作
MdaSearchstatistic.prototype.init=function(){
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
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl()+"getMdaSearchstatisticsByPage.json"
		});
};
//添加页面
MdaSearchstatistic.prototype.insert=function(){
	this.nData = new CommonDialog("insert","850","500",this.getUrl()+'Add/null',"添加",false,true,false);
	this.nData.show();
};
//编辑页面
MdaSearchstatistic.prototype.modify=function(){
	var rows = this._datagrid.datagrid('getChecked');
	if(rows.length !== 1){
		$.messager.alert('提示','请选择1条要编辑的记录！','warning');
		return false;
	}
	this.nData = new CommonDialog("edit","850","500",this.getUrl()+'Edit/'+rows[0].id,"编辑",false,true,false);
	this.nData.show();
};
//详细页
MdaSearchstatistic.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","850","500",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
//保存功能
MdaSearchstatistic.prototype.save=function(form,id){
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
MdaSearchstatistic.prototype.del=function(){
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
MdaSearchstatistic.prototype.reLoad=function(){
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//关闭对话框
MdaSearchstatistic.prototype.closeDialog=function(id){
	$(id).dialog('close');
};
//打开查询框
MdaSearchstatistic.prototype.openSearchForm =function(){
	this.searchDialog.dialog('open',true);
};
//去后台查询
MdaSearchstatistic.prototype.searchData =function(){
	var datebox = $('.easyui-datebox');
	var data = [];
	$.each(datebox,function(i,item){
		 data[i] = $(item).datebox("getValue");
	});
	for (var i=0;i<(data.length/2);i++) {
		if(data[2*i] == "" || data[2*i+1] == "" || data[2*i] == null || data[2*i+1] == null){
			continue;
		}
		if(data[2*i]>data[2*i+1]){
			$.messager.show({
				title : '提示',
				msg : "查询时,结束日期不能小于起始日期 ！",
				timeout:3000,  
	            showType:'slide'  
			});
			return;
		}
	}
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//隐藏查询框
MdaSearchstatistic.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
};
/*清空查询条件*/
MdaSearchstatistic.prototype.clearData =function(){
	this.searchForm.find('input[type=text]').val('');
	this.searchForm.find('input[type=hidden]').val('');
	this.searchForm.find('textarea').val('');//对 textarea中内容进行清除
	this.searchForm.find("input[type=checkbox]").attr("checked",false);//对 checkbox中内容进行清除
	this.searchForm.find("input[type=radio]").attr("checked",false);//对 radio中内容进行清除
	this.searchData();
};
MdaSearchstatistic.prototype.format=function(value){
	if(value){
		if($.browser.msie){
			if(typeof(value) == "number"){
				return new Date(value).format("yyyy-MM-dd");
			}else{
				var num = new Date((value).replace(new RegExp("-","gm"),"/")).getTime();
				return new Date(num).format("yyyy-MM-dd");
			}
		}else{
			return new Date(value).format("yyyy-MM-dd");
		}
	}
	return '';
};
MdaSearchstatistic.prototype.formatDateTime=function(value){
	if(value){
		if($.browser.msie){
			if(typeof(value) == "number"){
				return new Date(value).format("yyyy-MM-dd hh:mm:ss");
			}else{
				var num = new Date((value).replace(new RegExp("-","gm"),"/")).getTime();
				return new Date(num).format("yyyy-MM-dd hh:mm:ss");
			}
		}else{
			return new Date(value).format("yyyy-MM-dd hh:mm:ss");
		}
	}
	return '';
};
MdaSearchstatistic.prototype.searchDataBySfn =function(conditions){
    this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    this._datagrid.datagrid('load',conditions);
};
                                         