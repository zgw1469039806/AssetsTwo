/**
 * 
 */
function MdaClassify(tree,url,form,searchId){
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
	this._formId="#"+form; //formId
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
/*		var _self = this;
		$.ajax({
            cache: true,
            type: "post",
            url: this.getUrl()+'/operation/Edit/'+this._selectNode.id,
            dataType:"json",
            async: false,
            success: function(data) {
            	_self.setForm($(_self._formId),data.mdaClassifyDTO);
            }
	   });*/
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
			$.ajax({
	            cache: true,
	            type: "post",
	            url: _self.getUrl()+'/operation/Edit/'+_self._selectNode.id,
	            dataType:"json",
	            async: false,
	            success: function(data) {
	            	_self.setForm($(_self._formId),data.mdaClassifyDTO);
	            	
	            }
		   });
			},
		onClick:function(node){
			_self.getOnClick()(_self,node);
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

//编辑子节点
MdaClassify.prototype.modify=function(){
	this._eDg=new CommonDialog("modify","850","400",this.getUrl()+'/operation/Edit/'+this._selectNode.id,"编辑",false,true,false);
	this._eDg.show();
};

MdaClassify.prototype.save=function(form,url,dialog,id){
	var _self = this;
	$.ajax({
		 url:url+'/saveMdaClassify/'+id,
		 data : JSON.stringify(form),
		 type : 'post',
		 contentType : 'application/json',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 if(r.type =='1'){//新建成功
					 var selected = _self._tree.tree('find',r.pid);
					if(selected.state =="closed"){
						 _self._tree.tree('reload',selected.target);
						 
					 }else{
						 _self._tree.tree('append', {
							 	parent: selected.target,
							 	data: [r.data]
							 });
					 }
					 
				 }else if(r.type =='2'){//编辑成功
					 $(_self._formId).form('load',form);
					 _self._tree.tree('update',{
						 				target:_self._selectNode.target,
						 				//text:form.${tableInfo.uppertreeDisplayField.fieldName}
						 				text:r.data.text
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
MdaClassify.prototype.del=function(){
    var _self = this;
    if(this._selectNode._parentId=== '-1'){
		 $.messager.show({
			 title : '提示',
			 msg : '不能删除根节点！'
		});
		return;
	}
	if((this._selectNode.attributes && this._selectNode.attributes.count > 0) || _self._tree.tree('getChildren', _self._selectNode.target).length > 0){
		 $.messager.show({
			 title : '提示',
			 msg : '当前选中节点含有子节点，请先删除子节点！'
		});
		 return;
	}
	var ids = [];
	ids.push(this._selectNode.id);
	  $.messager.confirm('请确认','您确定要删除当前节点？',function(b){
		 if(b){
			 $.ajax({
				 url:_self.getUrl()+'/delete',
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
						 if(node.attributes && node.attributes.count>0){
						 	node.attributes.count--;
						 }
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
MdaClassify.prototype.closeDialog=function(id){
	$(id).dialog('close');
};
//表单加载json对象数据
MdaClassify.prototype.setForm = function (formObj, jsonValue) {
        var obj = formObj;
        $.each(jsonValue, function (name, ival) {
            var oinput = obj.find("input[name=" + name + "]");
            if (oinput.attr("type") == "checkbox") {
                if (ival !== null) {
                    var checkboxObj = $("[name=" + name + "]");
                    var checkArray = ival.length > 0 ?ival.split(",") : ival;
                    for (var i = 0; i < checkboxObj.length; i++) {
                 	    checkboxObj[i].checked = false;
                        for (var j = 0; j < checkArray.length; j++) {
                            if (checkboxObj[i].value == checkArray[j]) {
                         	   checkboxObj[i].checked=true;
                            }
                        }
                    } 
                }
            }else if (oinput.attr("type") == "radio") {
                oinput.each(function () {
                    var radioObj = $("[name=" + name + "]");
                    for (var i = 0; i < radioObj.length; i++) {
                        if (radioObj[i].value == ival) {
                     	   radioObj[i].checked=true;
                        }
                    }
                });
            }else if (oinput.attr("type") == "textarea") {
                obj.find("[name=" + name + "]").html(ival);
            }else if ($(oinput).attr('name') == "time"){
            	var time = new Date(ival);
            	var t =time.Format("yyyy-MM-dd");
            	$('#time').datebox("setValue", t);
            }else if ($(oinput).attr('name') == "status"){
            	$("#status").combobox('select',ival);  
            }else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker"){
         	   obj.find("[name=" + name + "]").val(ival);
            }else {
                obj.find("[name=" + name + "]").val(ival);
            }
        })
    }
//添加平级节点
MdaClassify.prototype.insert = function(){
	    var _self = this;
		var selectedNode = _self._selectNode;
		if(selectedNode._parentId=== '-1'){
		    $.messager.alert('提示','不能添加与'+selectedNode.text+'平级的节点！','warning');
			return;
		}
		_self.clearData(_self._formId);
		_self.edit();
}
//添加子节点
MdaClassify.prototype.insertSub = function(){
	var _self = this;
	_self.addRetIdFlag = 'sub';
	var selectedNode = _self._selectNode;
	if(null == selectedNode){
	    $.messager.alert('提示','请选择节点后进行操作','warning');
		return;
	}
	_self.clearData(_self._formId);
	$("#status").prop("defaultValue","1");
	_self.edit(1);
}
//清除表单数据
MdaClassify.prototype.clearData = function(form){
	$(form).form('clear');
}
//编辑节点
MdaClassify.prototype.edit = function(flag){
	var _self = this;
	var selectedNode = _self._selectNode;
	if(flag=='1'){
		$('#parentId').val(selectedNode.id);
	}else{
		$('#parentId').val(selectedNode._parentId);
	}
}
