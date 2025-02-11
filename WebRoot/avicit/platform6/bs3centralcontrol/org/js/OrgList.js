function OrgList(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var	_url=url;
	this.getUrl = function(){
		return _url;
	};
	this._datagridId="#"+datagrid;
	this._$grid;
	this._jqgridToolbar="#t_"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDialogId ="#"+searchD;
	this._keyWordId="#"+keyWordId;
	this._searchNames = searchNames;
	this.dataGridColModel = dataGridColModel;
	this.init.call(this);
	this.MenuStatus={0:'禁用',1:'启用'};
	this.MenuShow={0:'展示',1:'隐藏'};
}
//初始化操作
OrgList.prototype.init=function(){
	var _self = this;
	this._$grid=$(_self._datagridId).jqGrid({
    	url: 'platform/console/dept/getSysOrgDeptList.json',
    	mtype: 'POST',
    	datatype: "json",
    	toolbar: [true,'top'],
    	colModel: this.dataGridColModel,
    	height:this._doc.documentElement.clientHeight-93,
        scrollOffset: 20, //设置垂直滚动条宽度
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		multiboxonly:true,
		autowidth: true,
		forceFit:true,
		responsive:true//开启自适应
	});
	
	$(this._jqgridToolbar).append($("#tableToolbar"));

   /* $('.date-picker').datepicker({
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
	$('.dropdown-menu').click(function(e) {
		    e.stopPropagation();
		});*/
		$(_self._keyWordId).on('keydown',function(e){
			if(e.keyCode == '13'){
				_self.searchByKeyWord();
			}
		});
		return this;
	};
//添加页面
OrgList.prototype.insert=function(pid){
	
	this.insertIndex = layer.open({
		type: 2,
		area: ['100%', '100%'],
		title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'/'+pid+'/null' 
    });      
};

//添加页面
OrgList.prototype.insertOrg=function(pid){
	
	var _orgtree=orgtree;
	if(!_orgtree._selectNode){
		layer.alert('请选择组织数据！', {
			  title : '提示',
			  icon : 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return;
	}
	
	this.insertIndexOrg = layer.open({
		type: 2,
		area: ['70%', '70%'],
		title: '添加组织',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'/operation/Add/org/null' 
    });      
};

//添加页面
OrgList.prototype.insertDept=function(pid){


	var _orgtree=orgtree;
	
	
	if(!_orgtree._selectNode){
		layer.alert('请选择组织或部门数据！', {
			  title : '提示',
			  icon : 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
		return;
	}
	
	var parentid = _orgtree._selectNode.id;
	
	var type = _orgtree._selectNode.nodeType;
	
	
	this.insertIndexDept = layer.open({
		type: 2,
		area: ['70%', '70%'],
		title: '添加部门',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'/operation/Add/dept/null/'+ parentid+'/'+type
    });      
};
//编辑页面
OrgList.prototype.modifyOrg=function(pid){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择数据！');
		return false;
	}else if(ids.length > 1){
		layer.alert('请选择一条数据！');
		return false;
	}
	this.eidtIndex = layer.open({
		type: 2,
		area: ['100%', '100%'],
		title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'/'+pid+'/'+ids[0]
    });   
};


//编辑页面
OrgList.prototype.modifyDept=function(pid){
	var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	if(ids.length == 0){
		layer.alert('请选择数据！');
		return false;
	}else if(ids.length > 1){
		layer.alert('请选择一条数据！');
		return false;
	}
	this.eidtIndex = layer.open({
		type: 2,
		area: ['100%', '100%'],
		title: '编辑',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'/'+pid+'/'+ids[0]
    });   
};


//打开高级查询框
OrgList.prototype.openSearchForm = function(searchDiv){
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
OrgList.prototype.formValidate=function(form){
	form.validate({
		rules: {
			orgCode: {
				required: true,
				maxlength: 50
			},
			orgName:{
				required:true,
				maxlength:100
				
			},
			orderBy:{
				required:true,
				digits:true,
				maxlength:10
			},
			email: {
				email: true,
			},
			tel: {
				
				isMobile:true,
			},
			post:{
			
				isZipCode:true,
			},
			fax:{
			
				isFax:true,
			},
            orgPlace:{
                maxlength:100
            },
			orgDesc:{
			
				maxlength:200
			}
			
		}
	});
};

//验证
OrgList.prototype.formValidatedept=function(form){
	form.validate({
		rules: {
			deptCode: {
				required: true,
				maxlength: 50
			},
			deptName:{
				required:true,
				maxlength:100
				
			},
			deptAlias:{
				maxlength:50
			},
			
			orderBy:{
				required:true,
				digits:true,
				maxlength:10
			},
			email: {
				email: true,
			},
			tel: {
				
				isMobile:true,
			},
			post:{
			
				isZipCode:true,
			},
			
			fax:{
			
				isFax:true,
			},
            deptPlace:{
                maxlength:100
            },
			deptDesc:{
			
				maxlength:200
			}
		}
	});
};
OrgList.prototype.showEditOrg=function(id,type){
    var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
    var orgData = $(this._datagridId).jqGrid('getRowData',ids[0]);
    var orgName = orgData.name;
	editOrg = layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '编辑'+'【' + orgName + '】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content:'platform/console/dept/operation/Edit/org/'+id
	});    
};

OrgList.prototype.showEditDept=function(id){
	var _orgtree=orgtree;
	
	var parentid = _orgtree._selectNode.id;
	
	var type = _orgtree._selectNode.nodeType;

    var ids = $(this._datagridId).jqGrid('getGridParam','selarrrow');
    var deptData = $(this._datagridId).jqGrid('getRowData',ids[0]);
    var deptName = deptData.name;

	editDept = layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '编辑'+'【' + deptName + '】',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/console/dept/operation/Edit/dept/'+id+"/"+parentid+'/'+type
	});    
};
//保存功能
OrgList.prototype.saveorg=function(form,id){
	
	var _self = this,_orgtree=orgtree;

	if(_orgtree._selectNode==undefined){
		_orgtree._selectNode = {
			id: "-1",
			parentId: null,
			name: "",
			type: "org",
			isParent: true,
			open: true
		}
	}

	var orgData = {};
	var saveNode=serializeObject(form);
	if(_orgtree._selectNode.isParent&&!_orgtree._selectNode.open){//如果是父节点先展开
		_orgtree.tree.expandNode(_orgtree._selectNode,true,false,false);
	}
	var type='';
	if(id=="editOrg"){
		type = 'edit';
	}else{
		type = 'Add';
	}
	$.ajax({
		url:'platform/console/org/operation/save',
		data : {data :JSON.stringify(saveNode),parentOrgId:_orgtree._selectNode.id,type:type},
		type : 'post',
		dataType : 'json',
		success : function(r){
			if (r.flag == "success"){
				// _self.reLoad();
				if(id == "insertIndexOrg"){//添加
					orgData.validFlag = saveNode.validFlag;
					orgData.name = saveNode.orgName;
					orgData.code = saveNode.orgCode;
					orgData.email = saveNode.email;
					orgData.place = saveNode.orgPlace;
					orgData.fax = saveNode.fax;
					orgData.id = saveNode.id;
					orgData.type = 'org';
					_self._$grid.addRowData(r.id,orgData,'first');
					saveNode.id=saveNode.id;
					saveNode.text=saveNode.orgName;
					saveNode.nodeType = 'org';
					saveNode.iconSkin='trv-icon-zuzhi';
					_orgtree.tree.addNodes(_orgtree._selectNode,[saveNode]);
					layer.close(_self.insertIndexOrg);
				}else{//更新
					orgData.validFlag = saveNode.validFlag;
					orgData.name = saveNode.orgName;
					orgData.code = saveNode.orgCode;
					orgData.email = saveNode.email;
					orgData.fax = saveNode.fax;
					orgData.id = saveNode.id;
					orgData.type = 'org';
					_self._$grid.setRowData(saveNode.id,orgData);
					var updateNode =_orgtree.tree.getNodeByParam("id",saveNode.id,null);
					if(updateNode){
						updateNode.text=saveNode.orgName;
						_orgtree.tree.updateNode(updateNode);
					}
					layer.close(editOrg);
				}

				layer.msg('保存成功！',{
					icon: 1,
					area: ['200px', ''],
					closeBtn: 0
				});
			}else{
                form.parents("body").find("#demoSingle_saveForm").removeClass("disabled");
				layer.alert('保存失败！' + r.error, {
					icon: 2,
					area: ['400px', ''],
					closeBtn: 0
				});
			} 
		}
	});
};



//删除
OrgList.prototype.del=function(){
	
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var rowsdata = $(this._datagridId).jqGrid('getRowData',rows[0]);
	var ids = [];
	var types= [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确认要删除选择的数据吗?', {
		    title : '提示',
		    icon : 3,
		    area: ['400px', ''],
			btn: ['确定','取消']
		}, function(index){
			for(;l--;){
				ids.push(rows[l]);
				var rowsdata = $(_self._datagridId).jqGrid('getRowData',rows[l]);
				types.push(rowsdata.type);
			}
			var idsStr=ids.join('@');
			var typesStr=types.join('@');
			$.ajax({
				url:'platform/console/org/operation/delete',
				data : {ids : idsStr, types: typesStr},
				type : 'post',
				dataType : 'json',
				success : function(r){
					var _orgtree=orgtree;
					if (r.result == "0") {
						//_self.reLoad();
						l =ids.length;
						for(;l--;){
							//ids.push(rows[l]);
							_self._$grid.delRowData(ids[l]);//删除grid
							var deleteNode =_orgtree.tree.getNodeByParam("id",ids[l],_orgtree._selectNode);
							if(deleteNode){
								_orgtree.tree.removeNode(deleteNode);
							}
						}
						layer.msg('删除成功！',{
							icon: 1,
							area: ['200px', ''],
							closeBtn: 0
						});
					}else{
						layer.alert('删除失败！' + r.msg, {
							icon: 2,
							area: ['400px', ''],
							closeBtn: 0
						});
					}
				},
				error:function(r){
					
				}
			});
			layer.close(index);
		});   
	}else{
		layer.alert('请选择要删除的数据！', {
			  title : '提示',
			  icon : 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);

	}
};



OrgList.prototype.setValidFlag=function(){
	
	var rows = $(this._datagridId).jqGrid('getGridParam','selarrrow');
	var _self = this;
	var rowsdata = $(this._datagridId).jqGrid('getRowData',rows[0]);
	var ids = [];
	var types= [];
	var l =rows.length;
	if(l > 0){
		layer.confirm('确定要执行该操作吗?', function(index){
			for(;l--;){
				ids.push(rows[l]);
				var rowsdata = $(_self._datagridId).jqGrid('getRowData',rows[l]);
				if(rowsdata.code=="ORG_ROOT"){
					layer.alert('根组织不能设置失效', {
							icon: 2,
							area: ['400px', ''],
							closeBtn: 0
						});
						return;
				}
				types.push(rowsdata.type);
			}
			var idsStr=ids.join('@');
			var typesStr=types.join('@');
			$.ajax({
				url:'platform/console/org/operation/updateValidFlag',
				data : {ids : idsStr, types: typesStr},
				type : 'post',
				dataType : 'json',
				success : function(r){
					var _orgtree=orgtree;
					if (r.result == "0") {
						
						if(_orgtree._selectNode.nodeType=="dept"){
							var parentId=_orgtree._selectNode.id;
							var orgId=_orgtree._selectNode.attributes.ORG_ID;
		
							loadOrgDeptInfo(parentId, orgId);
						}else{
							var parentId=_orgtree._selectNode.id;
							var orgId=_orgtree._selectNode.id;
					
							loadOrgDeptInfo(parentId, orgId);
						}
						
						layer.msg('设置成功！',{
							icon: 1,
							area: ['200px', ''],
							closeBtn: 0
						});
					}else{
						layer.alert('设置失败！' + r.e, {
							icon: 2,
							area: ['400px', ''],
							closeBtn: 0
						});
					}
				}
			});
			layer.close(index);
		});   
	}else{
		layer.alert('请选择要设置的数据！', {
			  title : '提示',
			  icon : 7,
			  area: ['400px', ''], //宽高
			  closeBtn: 0
			}
		);
	}
};



//重载数据
OrgList.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");

};
OrgList.prototype.loadByPid=function(pId){
	var _self=this;
	$.ajax({
		url:_self.getUrl()+'/list',
		data:	{pid:pId},
		contentType : 'application/json',
		type : 'get',
		dataType : 'json',
		success : function(r){
			if (r.flag == "success") {
				_self._$grid.resetSelection();
				_self._$grid[0].addJSONData(r.data);
			}else{
				layer.alert('菜单列表加载失败！' + r.e, {
					icon: 2,
					area: ['400px', ''],
					closeBtn: 0
				});
			}
		}
	});
};



//关闭对话框
OrgList.prototype.closeDialog=function(id){
	if(id == "insertIndexOrg"){
		layer.close(this.insertIndexOrg);
	}else if(id == "insertIndexDept"){
		layer.close(this.insertIndexDept);
	}else if(id == "editOrg"){
		layer.close(editOrg);
	}else if(id == "editDept"){
		layer.close(editDept);
	}
};
//保存功能
OrgList.prototype.savedept=function(form,id){
	
	var _self = this,_orgtree=orgtree;
	var orgData = {};
	var saveNode=serializeObject(form);
	if(_orgtree._selectNode.isParent&&!_orgtree._selectNode.open){//如果是父节点先展开
		_orgtree.tree.expandNode(_orgtree._selectNode,true,false,false);
	}
	var type='';
	if(id=="editDept"){
		type = 'edit';
	}else{
		type = 'Add';
	}
	$.ajax({
		url:_self.getUrl()+"/operation/save",
		data : {data :JSON.stringify(saveNode),parentDeptId:_orgtree._selectNode.id,type:type,parentType:_orgtree._selectNode.nodeType},
		type : 'post',
		dataType : 'json',
		success : function(r){
			if (r.flag == "success"){
				// _self.reLoad();
				if(id == "insertIndexDept"){//添加
					orgData.validFlag = saveNode.validFlag;
					orgData.name = saveNode.deptName;
					orgData.code = saveNode.deptCode;
					orgData.email = saveNode.email;
					orgData.place = saveNode.deptPlace;
					orgData.fax = saveNode.fax;
					orgData.id = saveNode.id;
					orgData.type = 'dept';
					_self._$grid.addRowData(r.id,orgData,'first');
					saveNode.id=saveNode.id;
					saveNode.text=saveNode.deptName;
					saveNode.nodeType='dept';
					saveNode.attributes={};
					if(_orgtree._selectNode.nodeType=="org"){
						saveNode.attributes.ORG_ID=_orgtree._selectNode.id;
					}else{
						saveNode.attributes.ORG_ID=_orgtree._selectNode.attributes.ORG_ID;
					}
					
					saveNode.iconSkin='trv-icon-zuzhijiegou';
					_orgtree.tree.addNodes(_orgtree._selectNode,[saveNode]);
					layer.close(_self.insertIndexDept);
					
				}else{//更新
				
					orgData.validFlag = saveNode.validFlag;
					orgData.name = saveNode.deptName;
					orgData.code = saveNode.deptCode;
					orgData.email = saveNode.email;
					orgData.fax = saveNode.fax;
					orgData.id = saveNode.id;
					orgData.type = 'dept';
					_self._$grid.setRowData(saveNode.id,orgData);
					var updateNode =_orgtree.tree.getNodeByParam("id",saveNode.id,_orgtree._selectNode);
					if(updateNode){
						updateNode.text=saveNode.deptName;
						_orgtree.tree.updateNode(updateNode);
					}
					layer.close(editDept);
				}

				layer.msg('保存成功！',{
					icon: 1,
					area: ['200px', ''],
					closeBtn: 0
				});
			}else{
                form.parents("body").find("#demoSingle_saveForm").removeClass("disabled");
				layer.alert('保存失败！' + r.error, {
					icon: 2,
					area: ['400px', ''],
					closeBtn: 0
				});
			} 
		}
	});
};
//高级查询
OrgList.prototype.searchData =function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this._formId)))
	};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
OrgList.prototype.searchByKeyWord =function(){
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
//隐藏查询框
OrgList.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
OrgList.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};


OrgList.prototype.importorg =function(){
	importorgIndex = layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '导入组织',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/excelImportController/excelimportnew/importOrgInfo/xls' 
	});   
};


OrgList.prototype.importdept =function(){
	importdeptIndex = layer.open({
	    type: 2,
	    area: ['70%', '70%'],
	    title: '导入部门',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
	    content: 'platform/excelImportController/excelimportnew/importDeptInfo/xls' 
	});   
};


