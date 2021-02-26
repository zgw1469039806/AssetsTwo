/**
 * 
 */
function MdaClassify(tree,url,searchId){
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
	this._rootId='';
	//当前选中的node
	this._selectNode={};
	
	/***********************封装各种事件***********/
	var _onLoadSuccess=function(){};
	this.getOnLoadSuccess=function(){
		return _onLoadSuccess;
	};
	this.setOnLoadSuccess=function(func){
		_onLoadSuccess=func;
	};
	var _onSelect=function(){};
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
	};
	var _onClick=function(){
	};
	this.getOnClick=function(){
		return _onClick;
	};
	this.setOnClick=function(func){
		_onClick=func;
	};
};
//初始化操作
MdaClassify.prototype.init=function(){
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
						_self._tree.tree("expandAll");
						_self.selectRootNode(_self);
					}else{
						_self._tree.tree('loadData',{});
					}
                }
            });
        },
        prompt: "请输入树节点名称！"
    });
	this._tree=$(this._treeId).tree({    
		url:this.getUrl()+"/gettree/10",
		formatter:function(node){
			if(node._parentId ==="-1"){
				_self._rootId=node.id;
			}
			if(node.attributes && node.attributes.s){
				return '<a style="color:#fff;font-weight:normal;background:#3399ff;padding:0 4px;">' + node.text + '</a>';
			}else{
				return node.text;
			}
		},
		onSelect:function(node){
			_self._selectNode=node;
			_self.getOnSelect()(_self,node);
			},
		onClick:function(node){
			_self.getOnClick()(_self,node);
			parent.$("#classifyids").val(node.text);
			parent.selectMdaType.selectDialog.close();
			},
		onLoadSuccess:function(node, data){
			if(!node){
				_self._tree.tree("collapseAll");
				var node = _self._tree.tree('find', _self._rootId);
				_self._tree.tree("expand",node.target);
				_self.selectRootNode(_self);
				_self.getOnLoadSuccess()(_self,node,data);
			}
		}
	});
};
//选择根节点
MdaClassify.prototype.selectRootNode=function(self){
	var node = self._tree.tree('find', self._rootId);
	if(node){
		self._tree.tree('select', node.target);
	}else{
		throw new Error('根节点丢失');
	}
};
MdaClassify.prototype.loadNodeById=function(_self,node){
};
