/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
var domainName;
var domainCode;
function MonitorOrganization(ztreeId, url, form, searchD, searchbtn){
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
MonitorOrganization.prototype.init=function(){

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
			async: {
				enable: true,
				url: _self.getUrl()+"/getDomainTree/2",
				autoParam:["id"],
				dataFilter: function(treeId, parentNode, childNodes){
					if (!childNodes)
			            return null;
			        childNodes = eval(childNodes);
			        return childNodes;
				}
			},
			callback: {
				onClick: function(event, treeId, treeNode){ //绑定左右联动事件
				
					var id = $("#id").val();
					var name = $("#name").val();
					 parent.$('#' + name).val(treeNode.text);
					 parent.$('#' + id).val(treeNode.attributes.organizationCode);
					 
					/* parent.$('#businessDomainValue').val(treeNode.text);
					 parent.$('#businessDomain').val(treeNode.attributes.organizationCode);
					 */
					/*avicAjax.ajax({
			               cache: true,
			               type: "post",
			               url: _self.getUrl() +"/operation/Edit/"+treeNode.id,
			               dataType:"json",
			               async: false,
			               success: function(data) {
			            	   _self.setForm($(_self._formId),data.monitorOrganizationDTO);
			               }
				   });*/
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
					//var node = _self.tree.getNodeByParam("id", $('#id').val());
					//_self.tree.selectNode(node);
					//_self.addRetIdFlag = null;  //初始化添加节点标记
				}
		    }
		};
	    _self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
	    
};



