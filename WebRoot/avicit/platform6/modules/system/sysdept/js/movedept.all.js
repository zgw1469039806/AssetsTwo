/**
 * 内容
 */
//$(document).bind("contextmenu",function(){return false;});
var MoveDept=(function($){
	var _tree,_orgIdentity,_srcDeptId,_selectNode,
	_int=function(orgIdentity,srcDeptId){
		_orgIdentity=orgIdentity;
		_srcDeptId=srcDeptId;
		_tree=$('#tree').tree({    
			url:"platform/sysdept/move/deptTree/list",
			onBeforeLoad:function(node, param){
				if(!node){
					param.id=orgIdentity;
					param.root=1;
					param.level=2;
					param.type=0;
					return;
				}
				param.root=2;
				param.level=1;
				param.type=node.attributes.type;
			},
			onLoadSuccess:function(node, data){
				var node1 = _tree.tree('find', _srcDeptId);
				if(node1){
					_tree.tree('remove',node1.target);
				}
			},
			onSelect:function(node){
				_selectNode=node;
			},
			formatter:function(node){
				if(node.attributes.v){//搜索出的正常的
					return '<a style="color:#fff;font-weight:normal;background:#3399ff;padding:0 4px;">' + node.text + '</a>';
				}
				return node.text;
			},
			
		});
		$('#search').searchbox({
		 	width: 200,
	        searcher: function (value) {
	        	if(value==null||value==""){
	        		_tree.tree('reload');
	        		return;
	        	}
	        	$.ajax({
	                type: "post",
	                url:"platform/sysdept/move/deptTree/search/list",
	                dataType:"json",
	                data:{s:value,
	                	  c:_srcDeptId,
	                	  i:_orgIdentity},
	                error: function(request) {
	                	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
	                },
	                success: function(r) {
	                	if(r.flag==0){
	                		alert(r.msg);
	                		return ;
	                	}
						if(r.data){
							_tree.tree('loadData',r.data);
						}else{
							_tree.tree('loadData',{});
						}
	                }
	            });
	        },
	        prompt: "请输入部门名称！"
	    });
	},
	_save=function(){
		if(parent.$tree.tree('getParent',parent.currTreeNode.target).id ===_selectNode.id){
			_close(); 
			return true;
		}
		var tnode =parent.$tree.tree('find', _selectNode.id);
		$.ajax({
			 url:"platform/sysdept/move/deptTree/save",
			 data:{src:_srcDeptId,des:_selectNode.id,type:_selectNode.attributes.type},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if(!r.flag){
					 var dnode;
					 if(tnode){
						 dnode =parent.$tree.tree('pop',parent.currTreeNode.target);
						 if(tnode.state==='open'){
							 parent.$tree.tree("append",{
								 parent: tnode.target,
								 data:[dnode]
							 });
							 parent.$tree.tree('select', dnode.target);
							 parent.deptTreeOnClickRow(dnode);
						 }else{
							 parent.$tree.tree('select', tnode.target);
							 parent.deptTreeOnClickRow(tnode);
						 }
					 }else{
						 var parentNode =parent.$tree.tree('getParent',parent.currTreeNode.target)
						 parent.$tree.tree('pop',parent.currTreeNode.target);
						 parent.$tree.tree('select', parentNode.target);
						 parent.deptTreeOnClickRow(parentNode);
					 }
					 _close();
				 }else{
					 alert(r.msg);
				 }
			 }
		 });
	},
	_close=function(){
		if(parent){
			parent.closeMove();
		}
	};
	
	
	return {
		"init":function(orgIdentity,srcDept){
			_int(orgIdentity,srcDept);
			return this;
		},
		"saveMove":function(){
			if(!_selectNode){
				alert("请选择一个组织或者部门!");
				return false;
			}
			_save();
		},
		"closeForm":function(){
			_close();
			return false;
		}
	};
}(jQuery));

