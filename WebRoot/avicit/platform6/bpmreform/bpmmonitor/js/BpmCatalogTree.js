/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @param afterInit
 * @param clickRowLoad
 * @returns
 */
function BpmCatalogTree(ztreeId, url, form, searchD, searchbtn,afterInit, clickRowLoad){
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
	this.afterInit = afterInit;
	this.clickRowLoad = clickRowLoad;
	this._rootId="-1";
	this.selectedNodeId = null;//tree点击选中的节点
	this.init.call(this);
}
//初始化操作
var issubinit = false;
BpmCatalogTree.prototype.init=function(){
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
					name: "name",
					children: "children"
				},
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "parentId",
					rootPId: "-1"
				}
			},
			async: {
				enable: true,
				url: _self.getUrl(),
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
					_self.selectedNodeId = treeNode.id;
					if(issubinit == false){
				        if(treeNode != null && treeNode != ""){
				        	if(treeNode.attributes){
				        		_self.afterInit(treeNode.id,treeNode.nodeType,treeNode.attributes.pdId);
				        	}else{
				        		_self.afterInit(treeNode.id,treeNode.nodeType,'');
				        	}	        	
				            
				            issubinit = true;
			        	}else{
			        		_self.afterInit("-1","catalog",'');
			        		issubinit = true;
			        	}
			        }else{
			        	if(treeNode != null && treeNode != ""){
			        		if(treeNode.attributes){
			        			_self.clickRowLoad(treeNode.id,treeNode.nodeType,treeNode.attributes.pdId);
			        		}else{
			        			_self.clickRowLoad(treeNode.id,treeNode.nodeType,'');
			        		}
				            

			        	}else{
			        		_self.clickRowLoad("-1","catalog",'');
			        	}
		        	}
			    },
			    onRightClick : function OnRightClick(event, treeId, treeNode) {
			    	//在ztree上的右击事件  
			        if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {  
			        	_self.tree.selectNode(treeNode);
			            showRMenu("root", event.clientX, event.clientY);  
			        } else if (treeNode && !treeNode.noR) { 
			        	_self.tree.selectNode(treeNode);
			            showRMenu("node", event.clientX, event.clientY);  
			        }  
			    },
				onAsyncError:  function(){
				            layer.alert('加载失败！',{
								  icon: 7,
								  area: ['400px', ''],
								  closeBtn: 0
								}
							);
				},
				onAsyncSuccess:  function(event, treeId, msg){
					 if (_self.firstAsyncSuccessFlag == 0) {
		                 var nodes = _self.tree.getNodes(); 
		                 var __node = nodes[0];
		                 if(nodes[0]._parentId ==="-1"){
     						_self._rootId = nodes[0].id;
     					 }
		                 _self.tree.expandNode(nodes[0], true);  
		                 $("#"+nodes[0].tId+"_span").click();
		                 _self.firstAsyncSuccessFlag = 1;   
		                 _self.addRetIdFlag = null;  //初始化添加节点标记
					 }				
					
				}
		    }
		};
	    _self.tree = $.fn.zTree.init($(_self._ztreeId),_self.setting, []);
	    //手动请求根节点数据
	    /**
	    $.ajax({
	        url: _self.getUrl(),
	        data: "id=root",
	        type: "post",
	        async: false,
	        dataType: "json",
	        success: function (backData) {
	            var zNodes = backData;
	            _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);

	            _this.clickFirstRootNode();
	        }
	    });*/
};
//模拟点击第一个根节点
BpmCatalogTree.prototype.clickFirstRootNode = function () {
  var _this = this;
  //var spanId = _this.tree.getNodeByParam("pId", null, null).tId + "_span";
  var treeObj = $.fn.zTree.getZTreeObj(_this.ztreeId);
  var node = treeObj.getNodes();
  var nodes = treeObj.transformToArray(node);
  var spanId = nodes[1].tId + "_span";
  $("#" + spanId + "").click();
};

BpmCatalogTree.prototype.clickNode = function () {
	  var _this = this;
	  var node = _this.tree.getNodeByParam("id", _this.selectedNodeId);
	  $("#"+node.tId+"_span").click();
};
//显示右键菜单  
function showRMenu(type, x, y) {  
    $("#rMenu ul").show();  
    $("#rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"}); //设置右键菜单的位置、可见  
    $("body").bind("mousedown", onBodyMouseDown);  
}  
//隐藏右键菜单  
function hideRMenu() {  
    if ($("#rMenu")) $("#rMenu").css({"visibility": "hidden"}); //设置右键菜单不可见  
    $("body").unbind("mousedown", onBodyMouseDown);  
}  
//鼠标按下事件  
function onBodyMouseDown(event){  
    if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {  
    	$("#rMenu").css({"visibility" : "hidden"});  
    }  
}  
//查询框查询
BpmCatalogTree.prototype.onseach = function(ecode, value){
	var _self = this;
	if(ecode == 13){
		if(value == null||value == ""){
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
           					name: "name",
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
           					if(issubinit == false){
        				        if(treeNode != null && treeNode != ""){
        				            _self.afterInit(treeNode.id);
        				            issubinit = true;
        			        	}else{
        			        		_self.afterInit("-1");
        			        		issubinit = true;
        			        	}
        			        }else{
        			        	if(treeNode != null && treeNode != ""){
        				            _self.clickRowLoad(treeNode.id);

        			        	}else{
        			        		_self.clickRowLoad("");
        			        	}
        		        	}
           			    },
           			    onRightClick : function OnRightClick(event, treeId, treeNode) {
	     			    	//在ztree上的右击事件  
	     			        if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {  
	     			        	_self.tree.selectNode(treeNode);
	     			            showRMenu("root", event.clientX, event.clientY);  
	     			        } else if (treeNode && !treeNode.noR) { 
	     			        	_self.tree.selectNode(treeNode);
	     			            showRMenu("node", event.clientX, event.clientY);  
	     			        }  
     			        }
	           		  }
             }, data);
               var node = _self.tree.getNodeByParam("id", data[0].id);
               _self.tree.selectNode(node);
               _self.setting.callback.onClick(null, _self.tree.setting.treeId, node);//调用点击事件 ;
           }
       });	
	}
};


//关闭对话框
BpmCatalogTree.prototype.closeDialog=function(id){
	hideRMenu();
	if(id == "insert"){
		layer.close(this.insertIndex);
	}else{
		layer.close(this.eidtIndex);
	}
};


