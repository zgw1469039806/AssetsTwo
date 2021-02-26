function SysMenu(tree,url,searchId,form){
	if(!tree || typeof(tree)!=='string'&&tree.trim()!==''){
		throw new Error("tree不能为空！");
	}
	var _selectId='';
    var	_url=url;
    this.level={};//级别
    this.getUrl = function(){
    	return _url;
    };
    this._searchId = "#"+searchId;
	this._treeId="#"+tree;
	this._tree={};
	this._doc = document;
	this._formId='#'+form;
	this._rootId='';
	//当前选中的node
	this._selectNode={};
	this._iDg={};//添加菜单窗口对象
	this._eDg={};//编辑菜单窗口对象
	this._cData={};//语言设置窗口对象
	/***********************封装各种事件***********/
	var _onLoadSuccess=function(){};//加载数据和查找数据成功后的回调
	this.getOnLoadSuccess=function(){
		return _onLoadSuccess;
	};
	this.setOnLoadSuccess=function(func){
		_onLoadSuccess=func;
	};
	var _onSelect=function(){};//选中node事件
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
	};
	var _onClick=function(){};//单击node事件
	this.getOnClick=function(){
		return _onClick;
	};
	this.setOnClick=function(func){
		_onClick=func;
	};
	
	
	this.init.call(this);
};

//初始化操作
SysMenu.prototype.init=function(){
	var _self = this;
	$(this._searchId).searchbox({
	 	width: 200,
        searcher: function (value) {
        	if(value==null||value==""){
        		_self._tree.tree('reload');
        		return;
        	}
        	$.ajax({
                cache: true,
                type: "post",
                url:_self.getUrl()+"/search",
                dataType:"json",
                data:{search_text:value},
                async: false,
                error: function(request) {
                	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
					if(data){
						_self._tree.tree('loadData',data);
					}else{
						_self._tree.tree('loadData',{});
					}
                }
            });
        },
        prompt: "请输入菜单名称！"
    });
	this.setOnLoadSuccess(this.selectRootNode);
	this._tree=$(this._treeId).tree({    
		url:this.getUrl()+"/sysmenutree/2",
		formatter:function(node){
			if(node._parentId ==="-1"){
				_self._rootId=node.id;
			}
			if(node.attributes.va ==='0' && node.attributes.s){//搜索出的无效
				return '<a style="color:red;font-weight:normal;background:#3399ff;padding:0 4px;">' + node.text + '</a>';
			}else if(node.attributes.va ==='1' && node.attributes.s){//搜索出的正常的
				return '<a style="color:#fff;font-weight:normal;background:#3399ff;padding:0 4px;">' + node.text + '</a>';
			}else if(node.attributes.va ==='0'){
				return '<a style="color:red;">'+node.text+'</a>';
			}else{//正常的
				return node.text;
			}
			
		},
		onSelect:function(node){
			_self._selectNode=node;
			if(node.attributes.isMenu=='0'){//资源
				$(".res").css('display','none');
			}else{
				$(".res").css('display','');
			}
			_self.getOnSelect()(_self,node);
			},
		onClick:function(node){
			_self.getOnClick()(_self,node);
			},
		onLoadSuccess:function(node, data){
			_self.getOnLoadSuccess()(_self,node,data);
		}
	});
};
//选择根节点
SysMenu.prototype.selectRootNode=function(self,n){
	if(!n){
		var node = self._tree.tree('find', self._rootId);
		if(node){
			self._tree.tree('select', node.target);
		}
	}
};
SysMenu.prototype.loadMenuById=function(_self,node){
	$.ajax({
        cache: true,
        type: "get",
        url:_self.getUrl()+"/sysmenu/"+node.id,
        dataType:"json",
        async: false,
        error: function(request) {
        	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
        },
        success: function(data) {
			$(_self._formId).form('load',data);
        }
    });
};
//添加平级菜单
SysMenu.prototype.insert=function(){
	if(this._selectNode._parentId=== '-1'){
		alert('不能添加与'+this._selectNode.text+'平级的菜单');
		return;
	}
	this._iDg = new CommonDialog("insert","700","400",this.getUrl()+'/operation/add/'+this._selectNode._parentId,"添加菜单",false,true,false);
	this._iDg.show();
};
//添加子菜单
SysMenu.prototype.insertsub=function(){
	if(this._selectNode.attributes.isMenu=='0'){
		alert('资源下面不能在添加菜单!');
		return;
	}
	this._iDg=new CommonDialog("insert","700","400",this.getUrl()+'/operation/add/'+this._selectNode.id,"添加菜单",false,true,false);
	this._iDg.show();
};

//添加菜单资源
SysMenu.prototype.insertRes=function(){
	if(this._selectNode.attributes.isMenu=='0'){
		alert('资源下面不能在添加资源!');
		return;
	}
	this._iDg=new CommonDialog("insertRes","700","400",this.getUrl()+'/res/add/'+this._selectNode.id,"添加资源",false,true,false);
	this._iDg.show();
};

//编辑子菜单
SysMenu.prototype.modify=function(){
	if(this._selectNode.attributes.isMenu=='0'){
		alert('不能编辑资源!');
		return;
	}
	this._eDg=new CommonDialog("modify","700","400",this.getUrl()+'/operation/modify/'+this._selectNode.id,"编辑菜单",false,true,false);
	this._eDg.show();
};
//编辑资源
SysMenu.prototype.modifyRes=function(){
	if(this._selectNode.attributes.isMenu=='1'){
		alert('不能编辑菜单!');
		return;
	}
	this._eDg=new CommonDialog("modifyRes","700","400",this.getUrl()+'/res/modify/'+this._selectNode.id,"编辑资源",false,true,false);
	this._eDg.show();
};

//打开语言选择
SysMenu.prototype.openLanguageForm=function(){
	if(this._selectNode.attributes.isMenu=='0'){
		alert('资源没有多语言!');
		return;
	}
	this._cData = new CommonDialog("chooseL","700","400",this.getUrl()+'/chooseLanguage/'+this._selectNode.id,"多语言设置",false,true,false);
	this._cData.show();
};

SysMenu.prototype.afterSaveLanguage=function(name,comments,dialog){
	var _self = this;
	if (typeof(name)=="string"){
		$(this._formId).form('load',{name:name,comments:comments});
		this._tree.tree('update',{
				target:_self._selectNode.target,
				text:name
			  });
	}
	$(dialog).dialog('close');
};

SysMenu.prototype.save=function(form,url,dialog,id){
	var _self = this;
	$.ajax({
		 url:url,
		 data : JSON.stringify(form),
		 type : 'post',
		 contentType : 'application/json',
		 dataType : 'json',
		 async : false,
		 success : function(r){
			 if (r.flag == "success"){
				 if(r.type =='1'){//新建
					 var selected = _self._tree.tree('find',r.pid);
					 _self._tree.tree('append', {
					 	parent: selected.target,
					 	data: [r.data]
					 });
					 selected.state='open';
				 }else if(r.type =='2'){//修改
					 form.menuGroupName=r.menuGroupName;
					 $(_self._formId).form('load',form);
					 _self._tree.tree('update',{
						 				target:_self._selectNode.target,
						 				text:form.name
					 				  });
					 
				 }
				 $(dialog).dialog('close');
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
SysMenu.prototype.del=function(){
	if(this._selectNode.attributes.count > 0){
		//alert("当前选中菜单含有子菜单项，请先删除子菜单！");
		 $.messager.show({
			 title : '提示',
			 msg : '当前选中菜单含有子菜单项，请先删除子菜单！'
		});
		return;
	}
	var _self = this;
	var ids = [];
	ids.push(this._selectNode.id);
	  $.messager.confirm('请确认','您确定要删除当前节点？',function(b){
		 if(b){
			 $.ajax({
				 url:'platform/sysmenu/operation/sysmenu/delete',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self._tree.tree('remove',_self._selectNode.target);
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						 });
						 //删除当前节点，选择父节点
						 var node =_self._tree.tree('find',_self._selectNode._parentId);
						 node.attributes.count--;
						 _self._tree.tree('select', node.target);
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
};
//关闭对话框
SysMenu.prototype.closeDialog=function(id){
	$(id).dialog('close');
};
SysMenu.prototype.reload=function(){
	 $.ajax({
		 url:'platform/sysmenu/reload',
		 type : 'get',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success") {
				 $.messager.show({
					 title : '提示',
					 msg : '刷新成功！'
				 });
			}else{
				$.messager.show({
					 title : '提示',
					 msg : r.e
				});
			}
		 }
	 });
};
SysMenu.prototype.toMove=function(){
	if(this._selectNode.attributes.isMenu=='0'){
		alert('只能移动菜单!');
		return;
	}
	this._cData = new CommonDialog("moveMenu","300","400",this.getUrl()+'/move',"移动菜单到",false,true,false);
	this._cData.show();
};
SysMenu.prototype.filterMenu=function(self){
	var node = self._tree.tree('find', this._selectNode.id);
	if(node){
		self._tree.tree('remove',node.target);
	}
};
SysMenu.prototype.saveToNode=function(node){
	var _self = this,tnode,bo;
	if(this._selectNode._parentId ===node.id){
		_self.closeDialog("#moveMenu"); 
		return true;
	}
	if(node.attributes.isMenu=='0'){
		alert('菜单不能移动到资源下面!');
		return true;
	}
	tnode =this._tree.tree('find', node.id);
	if(tnode){
		if(tnode.state=="closed"){
			bo=2;
		}else{
			bo=3;
		}
	}else{
		bo=1;
	}
	
	$.ajax({
		 url:_self.getUrl()+"/save/move",
		 data:{src:_self._selectNode.id,des:node.id,callback:bo},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if(!r.flag){
				 var dnode =_self._tree.tree('pop',_self._selectNode.target);
				 if(bo==2){
					 _self._tree.tree("append",{
						 parent: tnode.target,
						 data:r.sub
					 });
					 _self._tree.tree('select', tnode.target);
				 }else if(bo==3){
					 dnode._parentId=node.id;
					 _self._tree.tree("append",{
						 parent: tnode.target,
						 data:[dnode]
					 });
					 _self._tree.tree('select', tnode.target);
				 }else if(bo==1){
					 _self.selectRootNode(_self);
				 }
				 _self.closeDialog("#moveMenu"); 
			 }else{
				 alert(r.msg);
			 }
		 }
	 });
};

