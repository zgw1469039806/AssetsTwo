/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function BusnessDomainTree(ztreeId, url, form, searchD, searchbtn){
	if(!ztreeId || typeof(ztreeId)!=='string'&&ztreeId.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url = url;
    this.getUrl = function(){
    	return _url;
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
};
//初始化操作
BusnessDomainTree.prototype.init=function(){
	debugger;
	var _self = this;
	$(_self._searchId).on('keyup',function(e){
		if(e.keyCode == 13){
			 _self.onseach(13,$(_self._searchId).val());
		}
	});
	$(_self._searchbtnId).on('click',function(e){
		var value = $(_self._searchId).val()==$(_self._searchId).attr("placeholder") ? "" :  $(_self._searchId).val();
		_self.onseach(13,value);
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
					rootPId: "0"
				}
			},
			/*async: {
				enable: true,
				url: _self.getUrl()+"/gettree/2",
				autoParam:["id"],
				dataFilter: function(treeId, parentNode, childNodes){
					if (!childNodes)
			            return null;
			        childNodes = eval(childNodes);
			        return childNodes;
				}
			},*/
			callback: {
				onClick: function(event, treeId, treeNode){ //绑定左右联动事件
					debugger;
					$("#businessDomainValue").val(treeNode.text);
					$("#businessDomain").val(treeNode.attributes.organizationCode);
					
			    },
				onAsyncError:  function(){
				            layer.alert('加载失败！',{
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0,
								  btn: ['关闭'],
						          title:"提示"
								}
							);
				},
				onAsyncSuccess:  function(event, treeId, msg){
					 if (_self.firstAsyncSuccessFlag == 0) {
						 debugger;
		                 var nodes = _self.tree.getNodes();
		                 if(nodes.length > 0){
		                	 _self.tree.expandNode(nodes[0], true);  
				             $("#"+nodes[0].tId+"_span").click(); 
				             _self.firstAsyncSuccessFlag = 1; 
				             $(_self._rootNodeId).hide();
		                 }else{
		                	 layer.confirm('未找到根节点,确定要初始化根节点吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
		              		   if(index){	
		              			 _self.insertRoot();
		              		   }
		                	 });
		                 }  
					 } 
					var node = _self.tree.getNodeByParam("id", $('#id').val());
					_self.tree.selectNode(node);
					_self.addRetIdFlag = null;  //初始化添加节点标记
				}
		    }
		};
	
	    $.get(_self.getUrl()+"/getDomainTree/2",{},function(r){
	    	_self.tree = $.fn.zTree.init($("#consumerOrgTree"),_self.setting,r);
	    	if(r && r.length > 0){
	    		var rootNode = r[0];
	    		var node = _self.tree.getNodeByParam("id", rootNode.id);
				_self.tree.selectNode(node);
	    	}
	    });
	  
};
//查询框查询
BusnessDomainTree.prototype.onseach = function(ecode, value){
	var _self = this;
	if(ecode == 13){
		if(value == null||value == ""||_self.tree.getNodes().length == 0){
			_self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
   		   return;
   		   
   	}
   	avicAjax.ajax({
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
           					avicAjax.ajax({
       			               cache: true,
       			               type: "post",
       			               url: _self.getUrl()+"/operation/Edit/"+treeNode.id,
       			               dataType:"json",
       			               async: false,
       			               success: function(data) {
       			            	   _self.setForm($(_self._formId),data.monitorOrganizationDTO);
       			               }
           				   });
           			    }
	           		  }
             }, data);
               var node = _self.tree.getNodeByParam("id", data[0].id);
               _self.tree.selectNode(node);
               _self.setting.callback.onClick(null, _self.tree.setting.treeId, node);//调用点击事件 ;
           }
       });	
	}
}

//表单加载json对象数据
BusnessDomainTree.prototype.setForm = function (formObj, jsonValue) {
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
                         	   $(checkboxObj[i]).parent().parent().find('div.errDom').remove();
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
                     	   $(radioObj[i]).parent().parent().find('div.errDom').remove();
                        }
                    }
                });
            }else if (oinput.attr("type") == "textarea") {
                obj.find("[name=" + name + "]").html(ival);
                obj.find("[name=" + name + "]").blur();
            }else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker" || $(oinput).attr('class') == "form-control date-picker hasDatepicker error"){
         	   if(ival != null && ival != "" && ival != undefined){
         		   obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
         	   }
         	   obj.find("[name=" + name + "]").blur();
            }else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker"){
         	   obj.find("[name=" + name + "]").val(ival);
         	   obj.find("[name=" + name + "]").blur();
            }else {
                obj.find("[name=" + name + "]").val(ival);
                obj.find("[name=" + name + "]").blur();
            }
        })
    }
//添加平级节点
BusnessDomainTree.prototype.insert = function(){
	    var _self = this;
	    _self.addRetIdFlag = 'parallel';
		var selectedNodes = _self.tree.getSelectedNodes();
		if(null == selectedNodes[0] || undefined == selectedNodes[0]){
			layer.alert('请选择节点后进行操作', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
			);
			return;
		}
		if(selectedNodes[0]._parentId=== '-1'){
		    layer.alert('不能添加与'+selectedNodes[0].text+'平级的节点！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
			);
			return;
		}
		_self.clearData(_self._formId);
		_self.edit();
}
//添加子节点
BusnessDomainTree.prototype.insertSub = function(){
	var _self = this;
	_self.addRetIdFlag = 'sub';
	var selectedNodes = _self.tree.getSelectedNodes();
	if(null == selectedNodes[0]){
	    layer.alert('请选择节点后进行操作', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
		);
		return;
	}
	_self.clearData(_self._formId);
	_self.edit(1);
}

//编辑节点
BusnessDomainTree.prototype.edit = function(flag){
	var _self = this;
	var selectedNodes = _self.tree.getSelectedNodes();
	if(flag=='1'){
		$('#parentId').val(selectedNodes[0].id);
	}else{
		$('#parentId').val(selectedNodes[0]._parentId);
	}
}

//保存表单
BusnessDomainTree.prototype.save = function(){
	    var _self = this;
		var selectedNodes = _self.tree.getSelectedNodes();
		if(null == selectedNodes[0] || undefined == selectedNodes[0]){
			layer.alert('请选择节点后进行操作', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
		    );
			return;
		}
		var isValidate = $(_self._formId).validate();//校验表单
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            return false;
        }
		avicAjax.ajax({
			 url:_self.getUrl()+'/saveMonitorOrganization',
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
						    if(($(_self._searchId).val()==$(_self._searchId).attr("placeholder") ? "" :  $(_self._searchId).val()) != ""){
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
							 _self.setting.callback.onClick(null, _self.tree.setting.treeId, selectedNodes[0]);//调用点击事件 ;
						 }
						 layer.msg("编辑成功");
					 }
				 }else{
				       layer.alert(r.error, {
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0,
								  btn: ['关闭'],
						          title:"提示"
								}
					   );
				 } 
			 }
		 });
}

//删除节点
BusnessDomainTree.prototype.del=function(){
	  var _self = this;
	  var selectedNodes = _self.tree.getSelectedNodes();
	   if(selectedNodes[0]._parentId=== '-1'){
	        layer.alert('不能删除根节点！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
		    );
			return;
	   }
	    if((selectedNodes[0].attributes && selectedNodes[0].attributes.count > 0) || selectedNodes[0].children.length > 0){
			 layer.alert('当前选中节点含有子节点，请先删除子节点！', {
				  icon: 7,
				  area: ['400px', ''], //宽高
				  closeBtn: 0,
				  btn: ['关闭'],
				  title:"提示"
				}
		     );
			 return;
		}
		var ids = [];
		ids.push(selectedNodes[0].id);
		layer.confirm('确认要删除选中的节点吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
		   if(index){	
			avicAjax.ajax({
				 url: _self.getUrl()+'/delete',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self.tree.removeNode(selectedNodes[0]);
						 layer.close(index);
						 //删除当前节点，选择父节点
						 var node = selectedNodes[0].getParentNode();
						 if(node.attributes && node.attributes.count > 0){
							 node.attributes.count--;
						 }
						 _self.tree.selectNode(node);
						 $("#"+node.tId+"_span").click();
					}else{
						layer.alert('删除失败！' + r.error, {
						  icon: 7,
						  area: ['400px', ''],
						  closeBtn: 0,
						  btn: ['关闭'],
						  title:"提示"
						}
				);
					}
				 }
			 });
		   }
	  });   
}
//清除表单数据
BusnessDomainTree.prototype.clearData = function(form){
	clearFormData(form);
}

//添加根节点(如果需要修改根节点数据通过前台页面设置)
BusnessDomainTree.prototype.insertRoot = function() {
	var _self = this; 
	avicAjax.ajax({
		url : _self.getUrl() + '/insertRoot',
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.flag == "success"){
				_self.init();
				layer.msg('初始化根节点成功！');
			}else{
				layer.alert('初始化根节点失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0,
					btn : [ '关闭' ],
					title : "提示"
				});
			}
		}
	})
}

//控件校验   规则：表单字段name与rules对象保持一致
BusnessDomainTree.prototype.formvaliad = function(){
    var _self = this;
	$(_self._formId).validate({
		rules: {
						  		     			 		  				  		     			    				   					applicationCode:{
						maxlength: 100
				    },
				    							 		  				  		     			    				   					applicationName:{
						maxlength: 200
				    },
				    							 		  				  		     			    				   					organization:{
						maxlength: 200
				    },
				    							 		  				  				  				  				  				  				  				  		     			    				   				   orderIndex:{
							number:true
				   },
				   							 		  				  		     			    				   					organizationCode:{
						maxlength: 100
				    },
				    							 		  				  		     			    				   					organizationName:{
						maxlength: 200
				    },
				    							 		  				  		     			    				   					parentId:{
						maxlength: 32
				    },
				    							 		  			  }
	});
}
