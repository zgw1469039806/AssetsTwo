/**
 * 内容
 */
//$(document).bind("contextmenu",function(){return false;});
var TreeObj=(function($){
	var _tree,_selectNode,_setting,_url,_searchbtnId,
	_onclick=function(){},
	_int=function(url,serachId){
		_url=url;
		_searchbtnId='#'+serachId;
		_setting = {
			view: {
				selectedMulti: false,
				showIcon: true
			},
			data: {
				key: {
					id: "id",
					name: "text",
					children: "children",
					type:'type'
				}
			},
			async: {
				enable: true,
				url:url+'/list',
				autoParam:['id','type']

			},
			callback: {
				onClick: function(event, treeId, treeNode){ //绑定左右联动事件
					_selectNode=treeNode;
					_onclick(treeNode.id,treeNode.type=='1'?'D':'O');	
				},
				onAsyncError:  function(){alert("加载失败！");}
			}
		};
		_tree = $.fn.zTree.init($('#deptTree'),_setting, []);

		$(_searchbtnId+'Val').on('keyup',function(e){
			if(e.keyCode == 13){
				onseach(13,$(this).val());
			}
		});
		$(_searchbtnId).on('click',function(e){
			onseach(13,$(_searchbtnId+'Val').val());
		});
	},
	onseach = function(ecode, value){
		var _self = this;
		if(ecode == 13){
			if(value == null||value == ""){
				_tree = $.fn.zTree.init($('#deptTree'),_setting, []);
				return;

			}
			$.ajax({
				type: "post",
				url:  _url+"/search",
				dataType:"json",
				data:{v:value},
				async: false,
				error: function(request) {
					throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
				},
				success: function(r) {
					if(r.flag==="0"){
						layer.alert('部门查询失败！' + r.msg, {
							icon: 2,
                            title:'提示',
							area: ['400px', ''],
							closeBtn: 0
						});
					}
					var rootNode=_tree.getNodeByParam("_parentId","-1",null);
					_tree.removeNode(rootNode);
					_tree.addNodes(null,r.data);
					_selectNode=null;
					/*rootNode=_self.tree.getNodeByParam("_parentId","-1",null);
					if(rootNode){
						_self.tree.selectNode(rootNode);
						_self.setting.callback.onClick(null, 'treeid', rootNode);
					}else{
						_self.setting.callback.onClick(null,'treeid', {id:'-111'});
					}*/
				}
			});	
		}
	};
	
	
	return {
		"init":function(url,searchId){
			_int(url,searchId);
			return this;
		},
		"setClick":function(fn){
			_onclick=fn;
			return this;
		},
		"getSelectNode":function(){
			return _selectNode;
		}
	};
}(jQuery));

