function ProgramRalation(datagrid, url, deptList,dataGridColModel,searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._searchDialogId ="#" + searchDialogSub;
    this.pid = pid;
    this.deptList=deptList;
	this._datagridId = "#"+ datagrid;
	this.Toolbardiv = "#t_"+ datagrid;
	this.Toolbar = "#toolbar_"+ datagrid;
	this.Pagerlbar = "#" + datagrid + "Pager";
	this._keyWordId="#" + demoSubUser_KeyWord;
	this._searchNames = searchSubNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
};
//初始化操作
ProgramRalation.prototype.init=function(pid){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url: this.getUrl()+'getProgramRalation',
    	postData : {pid : _self.pid,
    				deptList : _self.deptList},
        mtype: 'POST',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel, 
        height:$(window).height()-152-17,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        width:$(window).width*0.5,
        scrollOffset: 10, //设置垂直滚动条宽度
        rowNum: 20	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
		loadComplete:function(){
			$(this).jqGrid('getColumnByUserIdAndTableName');
		},
        styleUI : 'Bootstrap', 
		viewrecords: true, //
		multiselect: true,
		//autowidth: true,
		shrinkToFit: true,
		responsive:true,//开启自适应
        pager: _self.Pagerlbar
    });
	
    $(_self.Toolbardiv).append($(_self.Toolbar)); 
    
    $('.date-picker').datepicker({
		beforeShow: function () {
			setTimeout(function () {
				$('#ui-datepicker-div').css("z-index", 99999999);
			}, 100);
		}
    });
	$('.time-picker').datetimepicker({
	 	oneLine:true,//单行显示时分秒
	 	closeText:'确定',//关闭按钮文案
	 	showButtonPanel:true,//是否展示功能按钮面板
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
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
};
//添加页面
ProgramRalation.prototype.insert=function(pid){
	if(this.pid == null || this.pid == ""){
	   layer.alert('请选择一条主表数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		);
		 return false;
	}
	this.insertIndex = layer.open({
	    type: 2,
	    title: '添加',
	    skin: 'bs-modal',
	    area: ['100%', '100%'],
        maxmin: false,
	    content: this.getUrl()+'Add/null' 
	});    
};


//修改页面
ProgramRalation.prototype.modify=function(){
	if(this.pid == null || this.pid == ""){
		 layer.alert('请选择一条主表数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		);
		 return false;
	}
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		);
		return false;
	}else if(ids.length > 1){
		layer.alert('请选择一条数据！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0
				}
		);
		return false;
	}

	var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
	this.eidtIndex = layer.open({
	    type: 2,
	    title: '编辑',
	    skin: 'bs-modal',
	    area: ['100%', '100%'],
        maxmin: false,
	    content: this.getUrl()+'Edit/'+rowData.id 
	});
};
//详细页
ProgramRalation.prototype.detail=function(id){
	this.detailIndex = layer.open({
	    type: 2,
	    area: ['100%', '100%'],
	    title: '详细页',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: this.getUrl()+'Detail/'+id
	});
};
//控件校验   规则：表单字段name与rules对象保持一致
ProgramRalation.prototype.formValidate=function(form){
	form.validate({
		rules: {
						  		     			 		  				  		     			    				   					proRalaType:{
						maxlength: 2
				    },
				    							 		  				  		     			    				   					proRalaObjectId:{
						maxlength: 50
				    },
				    							 		  				  		     			    				   					programId:{
						maxlength: 50
				    },
				    							 		  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  				  			  }
	});
}
//保存功能
ProgramRalation.prototype.save=function(form,ids,type){
	var _self = this;
	avicAjax.ajax({
		 url:_self.getUrl()+"saveList",
		 data : {data :JSON.stringify(serializeObject(form)),ids:ids, type:type, pid:_self.pid},
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
				 layer.msg('保存成功！');
			 }else{
				 layer.alert('保存失败！' + r.error, {
					  icon: 7,
					  area: ['400px', ''], //宽高
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
ProgramRalation.prototype.del=function(){
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要删除该数据吗?', {icon: 3, title:"请确认：", area: ['400px', '']}, function(index){
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
		layer.alert('请选择要删除的记录！', {
				  icon: 7,
				  area: ['400px', ''],
				  closeBtn: 0
				}
		);
	}
};
//重载数据
ProgramRalation.prototype.reLoad=function(pid){
	if(pid != undefined){
		this.pid = pid;
	}
	var searchdata = {pid:pid};
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
};
//关闭对话框
ProgramRalation.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};


//关键字段查询
ProgramRalation.prototype.searchByKeyWord =function(){
	var keyWord = $(this._keyWordId).val()==$(this._keyWordId).attr("placeholder") ? "" :  $(this._keyWordId).val();
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
	$(this._datagridId).jqGrid('setGridParam',{datatype:'json',postData: searchdata}).trigger("reloadGrid");
}
//隐藏查询框
ProgramRalation.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
ProgramRalation.prototype.clearData =function(){
	clearFormData(this.searchForm);
	this.searchData();
};



