function BpmManager(tree,url){
	if(!tree || typeof(tree)!=='string'&&tree.trim()!==''){
		throw new Error("tree不能为空！");
	}
    var	_url=url;
    this.level={};//级别
    this.getUrl = function(){
    	return _url;
    };
	this._treeId="#"+tree;
	this._tree={};
	this._doc = document;
	this._rootId='';
	//当前选中的node
	this._selectNode={};
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
BpmManager.prototype.init=function(){
	var _self = this;

	this.setOnLoadSuccess(this.selectRootNode);
	this._tree=$(this._treeId).tree({    
		url:this.getUrl(),
        formatter:function(node){
            if(node._parentId ==="root"){
                _self._rootId=node.id;
            }
            return node.text;
        },
		onSelect:function(node){
			_self._selectNode=node;

			_self.getOnSelect()(_self,node);
			},
		onClick:function(node){
			_self.getOnClick()(_self,node);
			},
		onLoadSuccess:function(node){
            !node && _self.selectRootNode(_self);
		}
	});
};
//选择根节点
BpmManager.prototype.selectRootNode=function(self){
    var node = self._tree.tree('find', self._rootId);
    node&&self._tree.tree('select', node.target);
};
BpmManager.prototype.loadMenuById=function(_self,node){
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



