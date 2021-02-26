/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function MenuTree(ztreeId, url,type){
	if(!ztreeId || typeof(ztreeId)!=='string'&&ztreeId.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var _self=this;
    var	_url = url;
   
    this.getUrl = function(){
    	return _url;
    }
    this.addRetIdFlag = null; //初始化添加节点标记
    this.firstAsyncSuccessFlag =true; //第一次加载
    this.tree = null;
    this.ztreeId  = ztreeId;
	this._ztreeId="#"+ztreeId;
	this.setting = {};
	this._doc = document;
	this._selectNode={};
	this._type=type;
	/*this._formId="#"+form; //formId
	this._searchId ="#"+searchD;
	this._searchbtnId ="#"+searchbtn;*/

	var _onSelect=function(){};//单击node事件
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
		return _self;
	};
};



//初始化树节点
MenuTree.prototype.init=function(param){
	var _self = this;

	var fmt=function(treeId,treeNode){
		if(treeNode.type===2){
			return {color:'#333'};
		}
		if(treeNode.type===1){
			return {color:'blue'};
		}
		return {color:'red'};
		
	}
	_self.setting = {
		view: {
			selectedMulti: false,
			showIcon: true,
			fontCss: fmt
		},
		check: {
					enable: true
				},
		data: {
			key: {
				id: "id",
				name: "text",
				children: "children"
			}
		},
		async: {
			enable: true,
			url: _self.getUrl()+"/list",
			autoParam:["id"]
		},
		callback: {
				onClick: function(event, treeId, treeNode){ //绑定左右联动事件
					if(_self._selectNode.id===treeNode.id){
						return false;
					}
					_self._selectNode=treeNode;
					_self.getOnSelect()(treeNode,_self);
				},
				onAsyncError:  function(){alert("加载失败！");},
				onAsyncSuccess:  function(event, treeId, msg){
					if(_self.firstAsyncSuccessFlag){
						_self.firstAsyncSuccessFlag=false;
						var rootNode=_self.tree.getNodeByParam("_parentId","-1",null);
						if(rootNode){
							_self.tree.selectNode(rootNode);
							//_self.setting.callback.onClick(null, rootNode.id, rootNode);
						}
						
					}
				}
			}
		};
		_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);

		return this;
}
//递归允许权限
MenuTree.prototype.allowCur=function(){
	if(this._type==='O'){
		layer.msg('不能对组织操作!');
		return false;
	}
	var checkedNodes=this.tree.getCheckedNodes(true);
	var objs=[],_self=this,checkNode;
	var l =checkedNodes.length;
	if(l > 0){
		layer.confirm('确定要授权该菜单吗?',{icon: 3, title:"提示", area: ['400px', '']},function(){
				for(;l--;){
					checkNode=checkedNodes[l];
					 objs.push({id:checkNode.id,status:checkNode.getCheckStatus().half});
				 }
				 $.ajax({
					 url:_self.getUrl()+'/allowCur',
					 data:{	data : JSON.stringify(objs)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	var authType=1,cNodes=checkedNodes,s=cNodes.length,iconSkin,checkNode;
					 	if (r.flag == "success") {
					 		//_self.reLoad();

					 		for(;s--;){
					 			checkNode=cNodes[s];
					 			iconSkin=checkNode.iconPrefix+authType;
					 			if(checkNode.iconSkin!==iconSkin){
					 				checkNode.iconSkin=iconSkin;
					 				checkNode.type=authType;
					 				_self.tree.updateNode(checkNode);
					 			}
					 		}
							_self.tree.checkAllNodes(false);
					 		layer.msg('授权成功！',{
					 			icon: 1,
                                title: "提示",
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
					 	}else{
					 		layer.alert('授权失败！' + r.e, {
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
        layer.alert('请选择要授权的菜单！',{
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}

};


//允许权限
MenuTree.prototype.allow=function(){
	if(this._type==='O'){
		layer.msg('不能对组织操作!');
		return false;
	}
	var checkedNodes=this.tree.getCheckedNodes(true);
	var needChange=[],_self=this,checkNode,ids=[];
	var l =checkedNodes.length;
	if(l > 0){
		layer.confirm('确定要授权该菜单吗?', {icon: 3, title:"提示", area: ['400px', '']},function(){
				for(;l--;){
					ids.push(checkedNodes[l].id);
				 }
				 $.ajax({
					 url:_self.getUrl()+'/allow',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	var authType=1,cNodes=checkedNodes,s=checkedNodes.length,iconSkin,checkNode;
					 	if (r.flag == "success") {
					 		//_self.reLoad();

					 		for(;s--;){
					 			checkNode=cNodes[s];
					 			iconSkin=checkNode.iconPrefix+authType;
					 			if(checkNode.iconSkin!==iconSkin){
					 				checkNode.iconSkin=iconSkin;
					 				checkNode.type=authType;
					 				_self.tree.updateNode(checkNode);
					 			}
					 		}
					 		_self.tree.checkAllNodes(false);

					 		layer.msg('授权成功！',{
					 			icon: 1,
                                title: "提示",
					 			area: ['200px', ''],
					 			closeBtn: 0
					 		});
					 	}else{
					 		layer.alert('授权失败！' + r.e, {
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
        layer.alert('请选择要授权的菜单！',{
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}
};

//禁止权限
MenuTree.prototype.deny=function(){
	if(this._type==='O'){
		layer.msg('不能对组织操作!');
		return false;
	}
	var checkedNodes=this.tree.getCheckedNodes(true);
	var needChange=[],_self=this,checkNode,ids=[];
	var l =checkedNodes.length;
	if(l > 0){
		layer.confirm('确定要禁止该菜单权限吗?',{icon: 3, title:"提示", area: ['400px', '']}, function(){
				for(;l--;){
					checkNode=checkedNodes[l];
				/*	console.info(checkNode.text);
					console.info(checkNode.getCheckStatus());*/
					if(!checkNode.getCheckStatus().half){
						needChange.push(checkNode);
						ids.push(checkNode.id);
					}
					
				 }
				 $.ajax({
					 url:_self.getUrl()+'/deny',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	var authType=0,cNodes=needChange,s=needChange.length,iconSkin,checkNode;
					 	if (r.flag == "success") {
					 		//_self.reLoad();

					 		for(;s--;){
					 			checkNode=cNodes[s];
					 			iconSkin=checkNode.iconPrefix+authType;
					 			if(checkNode.iconSkin!==iconSkin){
					 				checkNode.iconSkin=iconSkin;
					 				checkNode.type=authType;
					 				_self.tree.updateNode(checkNode);
					 			}
					 		}
					 		_self.tree.checkAllNodes(false);

					 		layer.msg('禁止成功！',{
					 			icon: 1,
                                title: "提示",
					 			area: ['200px', ''],
					 			closeBtn: 0
					 		});
					 	}else{
					 		layer.alert('禁止失败！' + r.e, {
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
        layer.alert('请选择要禁止的菜单！',{
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}
};


//移除权限
MenuTree.prototype.remove=function(){
	if(this._type==='O'){
		layer.msg('不能对组织操作!');
		return false;
	}
	var checkedNodes=this.tree.getCheckedNodes(true);
	var needChange=[],_self=this,checkNode,ids=[];
	var l =checkedNodes.length;
	if(l > 0){
		layer.confirm('确定要移除该菜单权限吗?', {icon: 3, title:"提示", area: ['400px', '']}, function(){
				for(;l--;){
					checkNode=checkedNodes[l];
					/*console.info(checkNode.text);
					console.info(checkNode.getCheckStatus());*/
					if(!checkNode.getCheckStatus().half){
						needChange.push(checkNode);
						ids.push(checkNode.id);
					}
					
				 }
				 $.ajax({
					 url:_self.getUrl()+'/remove',
					 data:{	data : JSON.stringify(ids)},
					 type : 'post',
					 dataType : 'json',
					 success : function(r){
					 	var authType=2,cNodes=needChange,s=needChange.length,iconSkin,checkNode;
					 	if (r.flag == "success") {
					 		//_self.reLoad();

					 		for(;s--;){
					 			checkNode=cNodes[s];
					 			iconSkin=checkNode.iconPrefix+authType;
					 			if(checkNode.iconSkin!==iconSkin){
					 				checkNode.iconSkin=iconSkin;
					 				checkNode.type=authType;
					 				_self.tree.updateNode(checkNode);
					 			}
					 		}
					 		_self.tree.checkAllNodes(false);

					 		layer.msg('移除成功！',{
					 			icon: 1,
                                title: "提示",
					 			area: ['400px', ''],
					 			closeBtn: 0
					 		});
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
        layer.alert('请选择要移除的菜单！',{
            icon: 7,
            title:'提示',
            area: ['400px', ''],
            closeBtn: 0
        });
	}
};

//查询框查询
/*MenuTree.prototype.onseach = function(ecode, value){
	var _self = this;
	if(ecode == 13){
		if(value == null||value == ""){
			_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
			return;

		}
		$.ajax({
			type: "post",
			url:  _self.getUrl()+"/search",
			dataType:"json",
			data:{search_text:value},
			async: false,
			error: function(request) {
				throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
			},
			success: function(data) {
				var rootNode=_self.tree.getNodeByParam("_parentId","-1",null);
				_self.tree.removeNode(rootNode);
				_self.tree.addNodes(null,data);
				rootNode=_self.tree.getNodeByParam("_parentId","-1",null);
				if(rootNode){
					_self.tree.selectNode(rootNode);
					_self.setting.callback.onClick(null, 'treeid', rootNode);
				}else{
					_self.setting.callback.onClick(null,'treeid', {id:'-111'});
				}
           }
       });	
	}
};*/

