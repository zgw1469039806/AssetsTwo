/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function OrgTree(ztreeId, url, form, searchD, searchbtn){
	if(!ztreeId || typeof(ztreeId)!=='string'&&ztreeId.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url = url;
    this.getUrl = function(){
    	return _url;
    };
    
    var _selectNode = {};
    
    var _onSelect=function(){};//单击node事件
    
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
		return this;
	};
    
    this.addRetIdFlag = null; //初始化添加节点标记
    this.firstAsyncSuccessFlag = 0; //第一次加载
    this.tree = null;
    this.ztreeId  = ztreeId;
	this._ztreeId="#"+ztreeId;
	this.setting = {};
	this._doc = document;
	this._formId="#"+form; //formId
	this._searchId ="#"+searchD;
	this._searchbtnId ="#"+searchbtn;
}
//初始化树节点
OrgTree.prototype.init=function(){
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
				selectedMulti: false
			},
			data: {
				key: {
					id: "id",
					name: "text",
					children: "children"
				},
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: -1
				}
			},
			async: {
				enable: true,
				url: _self.getUrl()+"/getDeptList",
				autoParam:["id","nodeType","orgId"],
				dataFilter: function(treeId, parentNode, childNodes){
					if (!childNodes)
			            return null;
			        childNodes = eval(childNodes);
			        return childNodes;
				}
			},
			callback: {
				onClick: function(event, treeId, treeNode){ //绑定左右联动事件
					 _self._selectNode = treeNode;
					 _self.loadUserData(event, treeId, treeNode);
			    },
				onAsyncError:  function(){alert("加载失败！");},
				onAsyncSuccess:  function(event, treeId, msg){
					 if (_self.firstAsyncSuccessFlag == 0) {
                         var node = _self.tree.getNodeByParam('id', curOrgId);
                         if (node == null) {
                             node = _self.tree.getNodes()[0];
                         }
                         _self.tree.expandNode(node, true);
                         $("#" + node.tId + "_span").click();
		                 _self.firstAsyncSuccessFlag = 1;   
					 } 
					var node = _self.tree.getNodeByParam("id", $('#id').val());
					_self.tree.selectNode(node);
					_self.addRetIdFlag = null;  //初始化添加节点标记
				}
		    }
		};
	    _self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
};

//查询框查询
OrgTree.prototype.onseach = function(ecode, value){
	var _self = this;
	if(ecode == 13){
		if(value == null||value == ""||value=='输入名称查询'){
			_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
			_self.loadUserDataRoot();
   		   return;
   		   
   	}
   	$.ajax({
           cache: true,
           type: "post",
           url:  _self.getUrl()+"/search",
           dataType:"json",
           data:{search_text:value},
           async: false,
           error: function(request) {
           	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
           },
           success: function(data) {
        	   _self.tree = $.fn.zTree.init($(_self._ztreeId), {
           			view: {
           				selectedMulti: false,
           				fontCss: function(treeId, treeNode) {
       						if(treeNode.attributes && treeNode.attributes.s){
       							return {color:'blue'} ;
       						}else{
       							return {};
       						}
           				}
           			},
           			data: {
           				key: {
           					id: "id",
           					name: "text",
           					children: "children"
           				},
           				simpleData: {
           					enable: false,
           					idKey: "id",
           					pIdKey: "parentId",
           					rootPId: -1
           				}
           			},
           			callback: {
           				onClick: function(event, treeId, treeNode){ //查询后绑定左右联动事件
           				 _self._selectNode = treeNode;
    					 _self.loadUserData(event, treeId, treeNode);
           			    }
	           		  }
             }, data);
			   if (data != undefined && data != null && data != "") {
				   var node = _self.tree.getNodeByParam("id", data[0].id);
				   _self.tree.selectNode(node);
				   _self.setting.callback.onClick(null, _self.tree.setting.treeId, node);//调用点击事件 ;
			   }
           }
       });	
	}
};

//表单加载json对象数据
OrgTree.prototype.loadUserData = function (event, treeId, treeNode) {

	//if(treeNode.id !='ORG_ROOT'){
		
		try{
			var frmWindow =  document.getElementById("iframeUserList").contentWindow;
			frmWindow.loadUserData(treeNode);
		
		}catch(e){
		
		}
		
	//}
	
};

OrgTree.prototype.loadUserDataRoot = function () {

	
		var frmWindow =  document.getElementById("iframeUserList").contentWindow;
		try{
			
			frmWindow.loadUserDataRoot();
		
		}catch(e){
		
		}
		
	
	
};
//添加平级节点
OrgTree.prototype.insert=function(){
	    var _self = this;
		var selectedNodes = _self.tree.getSelectedNodes();
		if(null == selectedNodes[0] || undefined == selectedNodes[0]){
			layer.alert('请选择节点后进行操作');
			return;
		}
		if(selectedNodes[0]._parentId=== '-1'){
			layer.alert('不能添加与'+selectedNodes[0].text+'平级的节点！');
			return;
		}
		_self.clearData(_self._formId);
		_self.edit();
};

//添加子节点
OrgTree.prototype.insertSub=function(){
	var _self = this;
	_self.addRetIdFlag = 'sub';
	var selectedNodes = _self.tree.getSelectedNodes();
	if(null == selectedNodes[0]){
		layer.alert('请选择节点后进行操作');
		return;
	}
	_self.clearData(_self._formId);
	_self.edit(1);
};

//保存表单
OrgTree.prototype.save=function(){
	    var _self = this;
		var selectedNodes = _self.tree.getSelectedNodes();
		if(null == selectedNodes[0] || undefined == selectedNodes[0]){
			layer.alert('请选择节点后进行操作');
			return;
		}
		var isValidate = $(_self._formId).validate();//校验表单
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
		$.ajax({
			 url:_self.getUrl()+'/saveOrgTree',
			 data : JSON.stringify(serializeObject($(_self._formId))),
			 type : 'post',
			 contentType : 'application/json',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 if(r.type =='1'){//新建成功
						 var treeObj = $.fn.zTree.getZTreeObj(_self.ztreeId);
						 if(selectedNodes[0].isParent == false){
							 selectedNodes[0].isParent = true;
						 }
						 $('#id').val( r.data.id);
						 if(_self.addRetIdFlag=='sub'){ //添加子节点
							 treeObj.reAsyncChildNodes(selectedNodes[0], "refresh");
						    if($(_self._searchId).val() != ""){
						    	$(_self._searchId).val('');
						    	_self.onseach(13, $(_self._searchId).val());
						    }
						 }else{//添加平级节点
							 treeObj.reAsyncChildNodes(selectedNodes[0].getParentNode(), "refresh");
						 }
					     layer.msg("添加成功");
					 }else if(r.type =='2'){//编辑成功
						 if (selectedNodes.length > 0) {
							 selectedNodes[0].text = r.data.text;
							 _self.tree.updateNode(selectedNodes[0]);
						 }
						 layer.msg("编辑成功");
					 }
				 }else{
					 layer.alert(r.error);
				 } 
			 }
		 });
};
//控件校验   规则：表单字段name与rules对象保持一致
OrgTree.prototype.formvaliad = function(){
	var _self = this;
	$(_self._formId).validate({
		rules: {
			wordCode: {
				required:true
			},
			wordName: {
				required:true
			},
			attribute01:{
				required:true,
				maxlength: 5
			},
			attribute02: {
				required:true
			},
			wordType:{
				required: true
			},
			wordLockTime:{
				required:true,
				dateISO:true
			},
			attribute03Alias: {
				required:true
			},
			attribute04Alias: {
				required:true
			},
			wordLockUser: {
				number: true
			},
			wordState: {
				required: true,
			},
		}
	});
};
//删除节点
OrgTree.prototype.del=function(){
	  var _self = this;
	  var selectedNodes = _self.tree.getSelectedNodes();
	   if(selectedNodes[0]._parentId=== '-1'){
			layer.alert('不能删除根节点！');
			return;
	   }
	    if((selectedNodes[0].attributes && selectedNodes[0].attributes.count > 0) || selectedNodes[0].children.length > 0){
			 layer.alert('当前选中节点含有子节点，请先删除子节点！');
			 return;
		}
		var ids = [];
		ids.push(selectedNodes[0].id);
		layer.confirm('确定要删除该数据吗?', function(index){
		   if(index){	
			$.ajax({
				 url: _self.getUrl()+'/delete',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self.tree.removeNode(selectedNodes[0]);
						 layer.close(index);
						 layer.msg('删除成功！');
						 //删除当前节点，选择父节点
						 var node = selectedNodes[0].getParentNode();
						 if(node.attributes && node.attributes.count > 0){
							 node.attributes.count--;
						 }
						 _self.tree.selectNode(node);
						 $("#"+node.tId+"_span").click();
					}else{
						layer.alert(r.error);
					}
				 }
			 });
		   }
	  });   
};

//清除表单数据
OrgTree.prototype.clearData = function(form){
	clearFormData(form);
};

//编辑节点
OrgTree.prototype.edit = function(flag){
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if(flag=='1'){
		$('#parentId').val(selectedNodes[0].id);
	}else{
		$('#parentId').val(selectedNodes[0]._parentId);
	}
};
