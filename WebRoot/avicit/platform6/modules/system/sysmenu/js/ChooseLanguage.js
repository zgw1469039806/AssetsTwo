/**
 * @author zhanglei
 */
function ChooseLanguage(datagrid,url,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	this._datagridId="#"+datagrid;
	this._formId="#"+form;
	this._doc = document;
	this._url=url;
	this.comboData = {};
	//正在编辑的行
	this._indexEditing=-1;
	//是否可以结束编辑
	this._isEndEdit=true;
	this.init.call(this);
}

ChooseLanguage.prototype.init=function(){
	var _self = this;
	this._datagrid=$(this._datagridId).datagrid({
		url:this._url +'/getAllLanguage.json',
		onAfterEdit :function(rowIndex, rowData, changes){
			var rows = dg.datagrid('getRows');
			var l = rows.length;
			_self._isEndEdit=true;
		},
		onClickRow :function(rowIndex, rowData){
			if(_self._indexEditing != rowIndex &&_self.endEdit())
				_self._indexEditing=-1;
			_self.edit();
		}
	});
	var dg =this._datagrid;
};

//保存
ChooseLanguage.prototype.save=function(callback){
	if(!this.endEdit()){
		$.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
		return false;
	}

	var _self = this;
	var rows = this._datagrid.datagrid('getChanges');

	var data =JSON.stringify(rows);
	for (var i=0;i<rows.length;i++){
		if ( rows[i].name == null || rows[i].name == "" ){
			$.messager.show({
				 title : '提示',
				 msg : '不能保存，请确保数据填写完整'
			});
			_self._isEndEdit=true;
			return;
		}
		
	}
	if(rows.length > 0){
		 _self._indexEditing=-1;
		 $.ajax({
			 url: this._url+'/save.json',
			 data : {datas : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 if(typeof(callback)=="function"){
						callback(r.name,r.comments,'#chooseL');
					 }
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.error
					});
				 } 
			 }
		 });
	 }else{
		 $.messager.show({
			 title : '提示',
			 msg : '没有要提交的数据！'
		});
	 } 
};
//编辑
ChooseLanguage.prototype.edit=function(){
	var temp = this._datagrid;
	var rows = temp.datagrid('getChecked');
	var index = temp.datagrid('getRowIndex',rows[0]);
	//编辑正在编辑的数据
	if(this._indexEditing===index){
		temp.datagrid('beginEdit',index);
		return true;
	}

	if(!this.endEdit()){
		$.messager.alert('提示','不能编辑，请确保上一条数据填写完整','warning');
		return false;
	}
	var l=rows.length;
	if(l !==1){
		$.messager.alert('提示','请选择一条数据！','warning');
		return false;
	}
	temp.datagrid('beginEdit',index);
	this._indexEditing=index;
};
//删除
ChooseLanguage.prototype.del=function(){
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l =rows.length;
  	if(l > 0){
  		
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 _self._indexEditing=-1;
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 if(ids.length ==0) return;
			 $.ajax({
				 url:_self._url+'/delete.json',
				 data:{
					 ids : ids.join(',')
				 },
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self._datagrid.datagrid('reload',{});//刷新当前页
						 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						});
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.e
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
//结束当前编辑行
ChooseLanguage.prototype.endEdit=function(){
	if(this._indexEditing === -1) return true;
	this._isEndEdit=false;
	this._datagrid.datagrid('endEdit',this._indexEditing);
	return this._isEndEdit;
};
