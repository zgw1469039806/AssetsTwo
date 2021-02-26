
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
				name: "name",
				children: "children"
			}
		},
		async: {
			enable: true,
			url: _self.getUrl(),
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
						var rootNode=_self.tree.getNodeByParam("parentId","root",null);
						if(rootNode){
							_self.tree.selectNode(rootNode);
							_self.setting.callback.onClick(null, rootNode.id, rootNode);
							_self.tree.expandNode(rootNode);
						}
						
					}
					// _self.setting.callback.onClick(null, _self.tree.setting.treeId, node);//调用点击事件 ;
				}
			}
		};
		_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
}
