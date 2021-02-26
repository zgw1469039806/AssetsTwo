
/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function MenuTree(ztreeId, url, form, searchD, searchbtn){
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
	this._formId="#"+form; //formId
	this._searchId ="#"+searchD;
	this._searchbtnId ="#"+searchbtn;

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
MenuTree.prototype.init=function(){
	var _self = this;
	$(_self._searchId).on('keyup',function(e){
		if(e.keyCode == 13){
			_self.onseach(13,$(_self._searchId).val());
		}
	});
	$(_self._searchbtnId).on('click',function(e){
		_self.onseach(13,$(_self._searchId).val());
	});
	_self.setting = {
		view: {
			selectedMulti: false,
			showIcon: true
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
			url: _self.getUrl()+"/2/tree",
			autoParam:["id"]
		},
		callback: {
				onClick: function(event, treeId, treeNode){ //绑定左右联动事件
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
							_self.setting.callback.onClick(null, rootNode.id, rootNode);
						}
						
					}
					// _self.setting.callback.onClick(null, _self.tree.setting.treeId, node);//调用点击事件 ;
				}
			}
		};
		_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
}


//查询框查询
MenuTree.prototype.onseach = function(ecode, value){
	var _self = this;
	if(ecode == 13){
		if(value == null||value == ""||value=='输入名称查询'){
            _self.firstAsyncSuccessFlag=true;
			_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
			return;

		}
		$.ajax({
			cache: true,
			type: "post",
			url:  _self.getUrl()+"/search",
			dataType:"json",
			data:{search_text:$.trim(value)},
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
};
