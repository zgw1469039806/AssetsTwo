function RudgpObj(datagrid,url,type,dataGridColModel,menuId,applictionId,orgId,utype){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url+'/'+type,_self=this;
    this.getUrl = function(){
    	return _url;
    }
    this.__url=url;
	this._datagridId="#"+datagrid+type;
	this._jqgridToolbar="#t_"+datagrid+type;
	this._doc = document;
	this.appId=menuId;
	this.applictionId=applictionId;
	this.orgId=orgId;
	this._utype=utype;
	this._type=type;
	this._keyWordId="#keyWord"+type;
	this._searchNames = "";
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


};
//初始化操作
RudgpObj.prototype.init=function(){
	var _self = this;
	$(_self._datagridId).jqGrid({
    	url:_self.getUrl()+'/list',
        mtype: 'get',
        postData:{menuId:_self.appId},
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:this._doc.documentElement.clientHeight-193,
        scrollOffset: 20, //设置垂直滚动条宽度
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
        hasTabExport:false,
        hasColSet:false,
		autowidth: true,
		multiselect: true,
		multiboxonly:true,
		responsive:true,//开启自适应
		rowNum: -1,
		height: $(window).height()-120
    });
	
    $(this._jqgridToolbar).append($("#tableToolbar"+this._type));
    
   
	$(_self._keyWordId).on('keydown',function(e){
		if(e.keyCode == '13'){
			_self.searchByKeyWord();
		}
	});
	$("#keyWordLable"+_self._type).on('click',function(e){
		_self.searchByKeyWord();
	});

	//添加
	$('#add'+this._type).bind('click',function(){
        if(menuTree._selectNode._parentId=='-1'){
            layer.alert('根菜单不需要添加授权!', {
                icon: 7,
                area: ['400px', ''],
                title:'提示',
                closeBtn: 0
            });
            return false;
        }
		if(menuTree._selectNode.text=='门户小页'){
			layer.alert('门户小页不需要添加授权!', {
                icon: 7,
                area: ['400px', ''],
                title:'提示',
                closeBtn: 0
            });
            return false;
		}
        if(_self.appId ==='-111'){
            layer.alert('请选择要授权的菜单项!', {
                icon: 7,
                title:'提示',
                area: ['400px', ''],
                closeBtn: 0
            });
            return false;
        }
		var _layer=layer.open({
			area: ['800px', '500px'],
			title: '添加',
	    	skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        	maxmin: false, //开启最大化最小化按钮
        	type: 1,
        	btn: ['确定', '取消'],
  			content:$('#select'+_self._type),
  			success: function(layero, index){

  				if('R'===_self._type){
  					var dataGridColModel =  [
  					{ label: 'id', name: 'id', key: true, hidden:true },
  					{ label: '角色名称', name: 'roleName', width: 100,sortable:false,align:'center'},
  					{ label: '角色描述', name: 'roleDesc', width: 80,sortable:false,align:'center' }
  					];
  					_self.listRole = new ListObj('jqGridRole','console/auth/'+_self.orgId+'/R','R','keyWordRole',["roleName"],dataGridColModel,_self.applictionId);
  					return true;
  				}
  				if('U'===_self._type){
  					var dataGridColModel1 =  [
  					{ label: 'id', name: 'id', key: true, hidden:true },
  					{ label: '用户登录名', name: 'loginName', width: 100,sortable:false,align:'center'},
  					{ label: '用户名称', name: 'name', width: 80,sortable:false,align:'center' }
  					];
  					_self.listUser = new ListObj('jqGridUser','console/auth/'+_self.orgId+'/'+_self._utype+'/U','U','keyWordUser',['loginName','name'],dataGridColModel1,_self.applictionId);
  					return true;
  				}
  				if('P'===_self._type){
  					var dataGridColModel3 =  [
  					{ label: 'id', name: 'id', key: true, hidden:true },
  					{ label: '岗位名称', name: 'name', width: 100,sortable:false,align:'center'},
  					{ label: '岗位描述', name: 'desc', width: 80,sortable:false,align:'center' }
  					];
  					_self.listPost = new ListObj('jqGridPost','console/auth/'+_self.orgId+'/P','P','keyWordPost', ['name'],dataGridColModel3,_self.applictionId);
  					return true;
  				}
  				if('G'===_self._type){
  					var dataGridColModel2 =  [
  					{ label: 'id', name: 'id', key: true, hidden:true },
  					{ label: '群组名称', name: 'name', width: 100,sortable:false,align:'center'},
  					{ label: '群组描述', name: 'desc', width: 80,sortable:false,align:'center' }
  					];
  					_self.listGroup = new ListObj('jqGridGroup','console/auth/'+_self.orgId+'/G','G','keyWordGroup',['name'],dataGridColModel2,_self.applictionId);
  					return true;
  				}
  				if('D'===_self._type){
  					_self.treeDept =TreeObj.init('console/auth/'+_self.orgId+'/D','searchDept');	
  				}

  				
  			},
  			yes: function(index, layero){

				if('R'===_self._type){
					var rows = $(_self.listRole._datagridId).jqGrid('getGridParam','selarrrow');
					var ids = [];
					var l =rows.length;
					if(l > 0){
						layer.confirm('您确定要添加当前所选的角色?',{icon: 3, title:"提示", area: ['400px', '']}, function(index){
							for(;l--;){
								ids.push(rows[l]);
							}
							$.ajax({
								url:_self.__url+'/allow/add',
								data:{	data : JSON.stringify(ids),type:'R',menuId:_self.appId},
								type : 'post',
								dataType : 'json',
								success : function(r){
									if (r.flag == "success") {
										_self.reLoad();
										layer.close(_layer);
										/*layer.msg('添加成功！',{
											icon: 1,
											area: ['200px', ''],
											closeBtn: 0
										});*/
                                        layer.msg('添加成功！', {icon : 1 ,title: "提示",area: ['400px', ''],closeBtn:0});
									}else{
										layer.alert('添加失败！' + r.e, {
											icon: 2,
											area: ['400px', ''],
											closeBtn: 0
										});
									}
								}
							});
						});   
					}else{
                        layer.alert('请选择要添加的角色！', {
                            icon: 7,
                            title:'提示',
                            area: ['400px', ''],
                            closeBtn: 0
                        });
					}
					return true;
				}
				if('U'===_self._type){
					var rows = $(_self.listUser._datagridId).jqGrid('getGridParam','selarrrow');
					var ids = [];
					var l =rows.length;
					if(l > 0){
						layer.confirm('您确定要添加当前所选的用户?',{icon: 7, title:"提示", area: ['400px', '']}, function(index){
							for(;l--;){
								ids.push(rows[l]);
							}
							$.ajax({
								url:_self.__url+'/allow/add',
								data:{	data : JSON.stringify(ids),type:'U',menuId:_self.appId},
								type : 'post',
								dataType : 'json',
								success : function(r){
									if (r.flag == "success") {
										_self.reLoad();
										layer.close(_layer);
										layer.msg('添加成功！',{
											icon: 1,
											area: ['400px', ''],
											closeBtn: 0
										});
									}else{
										layer.alert('添加失败！' + r.e, {
											icon: 2,
											area: ['400px', ''],
											closeBtn: 0
										});
									}
								}
							});
						});   
					}else{
						layer.msg('请选择要添加的用户!');
					}
					return true;
				}
				if('G'===_self._type){
					var rows = $(_self.listGroup._datagridId).jqGrid('getGridParam','selarrrow');
					var ids = [];
					var l =rows.length;
					if(l > 0){
						layer.confirm('您确定要添加当前所选的群组?',{icon: 7, title:"提示", area: ['400px', '']}, function(index){
							for(;l--;){
								ids.push(rows[l]);
							}
							$.ajax({
								url:_self.__url+'/allow/add',
								data:{	data : JSON.stringify(ids),type:'G',menuId:_self.appId},
								type : 'post',
								dataType : 'json',
								success : function(r){
									if (r.flag == "success") {
										_self.reLoad();
										layer.close(_layer);
										layer.msg('添加成功！',{
											icon: 1,
											area: ['400px', ''],
											closeBtn: 0
										});
									}else{
										layer.alert('添加失败！' + r.e, {
											icon: 2,
											area: ['400px', ''],
											closeBtn: 0
										});
									}
								}
							});
						});   
					}else{
						layer.msg('请选择要添加的群组!');
					}
					return true;
				}
				if('P'===_self._type){
					var rows = $(_self.listPost._datagridId).jqGrid('getGridParam','selarrrow');
					var ids = [];
					var l =rows.length;
					if(l > 0){
						layer.confirm('您确定要添加当前所选的岗位?', {icon: 7, title:"提示", area: ['400px', '']},function(index){
							for(;l--;){
								ids.push(rows[l]);
							}
							$.ajax({
								url:_self.__url+'/allow/add',
								data:{	data : JSON.stringify(ids),type:'P',menuId:_self.appId},
								type : 'post',
								dataType : 'json',
								success : function(r){
									if (r.flag == "success") {
										_self.reLoad();
										layer.close(_layer);
										layer.msg('添加成功！',{
											icon: 1,
											area: ['200px', ''],
											closeBtn: 0
										});
									}else{
										layer.alert('添加失败！' + r.e, {
											icon: 2,
											area: ['400px', ''],
											closeBtn: 0
										});
									}
								}
							});
						});   
					}else{
						layer.msg('请选择要添加的岗位!');
					}
					return true;
				}
				if('D'===_self._type){
					var selectNode =_self.treeDept.getSelectNode()
					if(selectNode&&selectNode.type==1){
						layer.confirm('您确定要添加当前所选的部门?', {icon: 7, title:"提示", area: ['400px', '']},function(index){
							
							$.ajax({
								url:_self.__url+'/allow/add',
								data:{	data : JSON.stringify([selectNode.id]),type:'D',menuId:_self.appId},
								type : 'post',
								dataType : 'json',
								success : function(r){
									if (r.flag == "success") {
										_self.reLoad();
										layer.close(_layer);
										layer.msg('添加成功！',{
											icon: 1,
											area: ['200px', ''],
											closeBtn: 0
										});
									}else{
										layer.alert('添加失败！' + r.e, {
											icon: 2,
											area: ['400px', ''],
											closeBtn: 0
										});
									}
								}
							});
						});   
					}else{
						layer.msg('请选择要添加的部门!');
					}
				}
  			},
  			btn2: function(index, layero){
  			}
  		});
	});
	//授权

	$('#allow'+this._type).bind('click',function(){

		var rows = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
		var ids = [];
		var l =rows.length;
		if(l > 0){
			layer.confirm('确定要授权该对象吗?', {icon:3, title:"提示", area: ['400px', '']},function(){
				for(;l--;){
					ids.push(rows[l]);
				}
				$.ajax({
					url:_self.__url+'/allow',
					data:{	data : JSON.stringify(ids)},
					type : 'post',
					dataType : 'json',
					success : function(r){
						if (r.flag == "success") {
							_self.reLoad();

							layer.msg('授权成功！',{
								icon: 1,
								area: ['400px', ''],
								closeBtn: 0
							});
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
            layer.alert('请选择要授权的角色！', {icon : 7 ,title: "提示",area: ['400px', ''],closeBtn:0});
		}
	});

	//删除
	$('#del'+this._type).bind('click',function(){
		var rows = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
		var ids = [];
		var l =rows.length;
		if(l > 0){
			layer.confirm('确定要删除该对象吗?',{icon: 3, title:"提示", area: ['400px', '']}, function(){
				for(;l--;){
					ids.push(rows[l]);
				}
				$.ajax({
					url:_self.__url+'/del',
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
            layer.alert('请选择要删除的角色！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''],
                closeBtn:0
            });
		}
	});

	//拒绝
	$('#deny'+this._type).bind('click',function(){
		var rows = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
		var ids = [];
		var l =rows.length;
		if(l > 0){
			layer.confirm('确定要禁止该对象吗?',{icon:3, title:"提示", area: ['400px', '']}, function(){
				for(;l--;){
					ids.push(rows[l]);
				}
				$.ajax({
					url:_self.__url+'/deny',
					data:{	data : JSON.stringify(ids)},
					type : 'post',
					dataType : 'json',
					success : function(r){
						if (r.flag == "success") {
							_self.reLoad();

							layer.msg('禁止成功！',{
								icon: 1,
								area: ['400px', ''],
								closeBtn: 0
							});
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
            layer.alert('请选择要禁止的角色！',{
                icon: 7,
                title:'提示',
                area: ['400px', ''],
                closeBtn:0
            });
		}
	});
};
//关键字段查询
RudgpObj.prototype.searchByKeyWord =function(){

	var searchdata = {
			keyWord:$(this._keyWordId).val(),
			menuId: this.appId
		};
	var keyword = $(this._keyWordId).val();
	if(keyword === '输入名称查询'){
		keyword = '';
	}
	$(this._datagridId).jqGrid('setGridParam',{postData: {menuId:this.appId,keyWord:keyword}}).trigger("reloadGrid");
};
RudgpObj.prototype.loadByAppId=function(appId){
	this.appId=appId;
	$(this._datagridId).jqGrid('setGridParam',{postData:{menuId:appId}}).trigger("reloadGrid");
};
//重载数据
RudgpObj.prototype.reLoad=function(){
	$(this._datagridId).trigger("reloadGrid");

};
