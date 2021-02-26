function MenuList(datagrid,url,searchD,form,keyWordId,searchNames,dataGridColModel){
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
	this.MenuShow={0:'显示',1:'隐藏'};
}
//初始化操作
MenuList.prototype.init=function(){
	var _self = this;
	this._$grid=$(_self._datagridId).jqGrid({
    	//url: this.getUrl()+'getDemoSinglesByPage.json',
    	mtype: 'POST',
    	datatype: "json",
    	toolbar: [true,'top'],
    	colModel: this.dataGridColModel,
    	height:this._doc.documentElement.clientHeight-93,
        scrollOffset: 10, //设置垂直滚动条宽度
        altRows:true,
        rowNum: 200	,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		multiboxonly:true,
		autowidth: true,
		responsive:true//开启自适应
	});
	
	$(this._jqgridToolbar).append($("#tableToolbar"));

   
		$(_self._keyWordId).on('keydown',function(e){
			if(e.keyCode == '13'){
				_self.searchByKeyWord();
			}
		});
		return this;
	};
//添加页面
MenuList.prototype.insert=function(pid){
	this.insertIndex = layer.open({
		type: 2,
		area: ['100%', '100%'],
		title: '添加',
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: this.getUrl()+'/'+pid+'/null' 
    });      
};
//编辑页面
MenuList.prototype.modify=function(pid){
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
        content: this.getUrl()+'/'+pid+'/'+ids[0]
    });   
};

//打开高级查询框
MenuList.prototype.openSearchForm = function(searchDiv){
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
MenuList.prototype.formValidate=function(form){
	form.validate({
		rules: {
			menuName: {
				required: true,
				maxlength: 100
			},
			menuCode:{
				required:true,
				maxlength:50
			},
			menuOrder:{
				max:1000,
                required:true,
			}
		}
	});
};
//保存功能
MenuList.prototype.save=function(form,id){

	var _self = this,_menutree=menuTree;
	var saveNode=serializeObject(form);
	if(_menutree._selectNode.isParent&&!_menutree._selectNode.open){//如果是父节点先展开
		_menutree.tree.expandNode(_menutree._selectNode,true,false,false);
	}
	$.ajax({
		url:_self.getUrl()+"/save/"+id,
		data : {data :JSON.stringify(saveNode)},
		type : 'post',
		dataType : 'json',
		success : function(r){
			if (r.flag == "success"){
				// _self.reLoad();
				if(id == "insert"){//添加
					_self._$grid.addRowData(r.id,saveNode,'first');
					saveNode.id=r.id;
					saveNode.text=saveNode.menuName;

					//if(_menutree._selectNode.open){
						_menutree.tree.addNodes(_menutree._selectNode,[saveNode]);
					//}else{
					//	_menutree.tree.addNodes(_menutree._selectNode,[saveNode]);
					//}
					layer.close(_self.insertIndex);
                }else{//更新
					_self._$grid.setRowData(saveNode.id,saveNode);
					var updateNode =_menutree.tree.getNodeByParam("id",saveNode.id,_menutree._selectNode);
                    var cuurentSelectNode = _menutree._selectNode;
					if(updateNode){
						updateNode.text=saveNode.menuName;
						updateNode._parentId=saveNode.parentId;
						//_menutree.tree.updateNode(updateNode);
					}
					//移除修改前节点下的被修改菜单
                    _menutree.tree.removeNode(updateNode);
					//修改后的父级菜单
                    var afterNode = _menutree.tree.getNodeByParam("id",saveNode.parentId);
                    //防止修改后子节点重复显示,当节点是打开状态时手动添加，否则刷新该节点
					if(afterNode != null && afterNode != "" && afterNode != undefined){
                        if(afterNode.open == true){
                            _menutree.tree.addNodes(afterNode,updateNode);
                        }else{
                            //移动到没有子节点的节点下时设置afterNode.isParent=true，reAsyncChildNodes方法才有效
                            if(afterNode.isParent == false){
                                afterNode.isParent = true;
                            }
                            _menutree.tree.reAsyncChildNodes(afterNode, "refresh",false);
                        }
					}
                    layer.close(_self.eidtIndex);
				}
				//_self.loadByPid(saveNode.parentId);
				//目前右侧列表显示修改前父级菜单的子菜单
				if(cuurentSelectNode != null && cuurentSelectNode != "" && cuurentSelectNode != undefined){
                    _self.loadByPid(cuurentSelectNode.id);
				}else{
                    _self.loadByPid(saveNode.parentId);
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
MenuList.prototype.del=function(){
	
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
				data:JSON.stringify(ids),
				contentType : 'application/json',
				type : 'post',
				dataType : 'json',
				success : function(r){
					var _menutree=menuTree;
					if (r.flag == "success") {
						//_self.reLoad();
						l =ids.length;
						for(;l--;){
							//ids.push(rows[l]);
							_self._$grid.delRowData(ids[l]);//删除grid
							var deleteNode =_menutree.tree.getNodeByParam("id",ids[l],_menutree._selectNode);
							if(deleteNode){
								_menutree.tree.removeNode(deleteNode);
							}
						}
						layer.msg('删除成功！',{
							icon: 1,
							area: ['200px', ''],
							closeBtn: 0
						});
					}else{
						layer.alert(r.e, {
							icon: 2,
							area: ['400px', ''],
							closeBtn: 0
						});
					}
				}
			});
			parent.layer.close(index);
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
// 导出菜单xml
MenuList.prototype.doexport = function () {

    var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var _self = this;
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        for (; l--;) {
            ids.push(rows[l]);
        }
        var params = {};
        params.ids = JSON.stringify(ids);
        var url = _self.getUrl() + '/export';
        var ep = new exportData('export', 'export', params, url);
        ep.excuteExport();
    } else {
        parent.layer.alert('请选择要导出的数据！', {
            icon: 0,
            title: '提示',
            area: ['400px', ''],
            closeBtn: 0
        });
    }

};
// 导入菜单xml
MenuList.prototype.doimport = function() {
    var _self = this;
    var _menuList = menuList;
    var _menutree = menuTree;
    var currentNode = _menutree._selectNode;
    var currentSelectId = _menutree._selectNode.id;
    layer.open({
        type : 2,
        area : [ '70%', '70%' ],
        title : '导入',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, //开启最大化最小化按钮
        content : _self.getUrl() + '/importManage',
        success: function(layero, index){
            var iframeWin = layero.find('iframe')[0].contentWindow;
            iframeWin.$('#currentNodeId').val(_menutree._selectNode.id);
        },
        cancel: function(index, layero){
            var iframeWin = $(layero).find('iframe')[0].contentWindow;
            if (iframeWin.needReload == true) {
                var node = _menutree.tree.getNodeByParam('id', currentNode.id);
                node.isParent = true;
                _menutree.tree.reAsyncChildNodes(node, "refresh");
                _self.loadByPid(currentNode.id);
            }

        }
    });
};
//多应用菜单引用
MenuList.prototype.mappMenuLink = function () {
	var selectNode = menuTree._selectNode;

	if (mappLength === 1) {
		layer.msg('没有多应用菜单可引用！', {icon: 7});
	} else {
		layer.open({
			type: 2,
			area: ['50%', '80%'],
			title: '多应用菜单引用',
			skin: 'bs-modal',
			maxmin: false,
			content: 'console/menu/portal/mappMenuLink?toMenuId=' + selectNode.id
		});
	}
};
//重载数据
MenuList.prototype.reLoad=function(){
	var searchdata = {param:JSON.stringify(serializeObject($(this._formId)))};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");

};
MenuList.prototype.loadByPid=function(pId){
	var _self=this;
	$.ajax({
		url:_self.getUrl()+'/list',
		data:	{pid:pId},
		contentType : 'application/json',
		type : 'get',
        cache:false,
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
MenuList.prototype.closeDialog=function(id){
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};
//高级查询
MenuList.prototype.searchData =function(){
	var searchdata = {
		keyWord: null,
		param:JSON.stringify(serializeObject($(this._formId)))
	};
	$(this._datagridId).jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
};
//关键字段查询
MenuList.prototype.searchByKeyWord =function(){
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
MenuList.prototype.hideSearchForm =function(){
	layer.close(searchDialogindex);
};
/*清空查询条件*/
MenuList.prototype.clearData =function(){
	clearFormData(this._formId);
	this.searchData();
};
