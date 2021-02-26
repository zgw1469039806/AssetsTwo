/**
*Created by rx on 2017/9/13.
*/
function ConnectTypeTree(treeUL) {
    this.treeUL = treeUL;//tree位置
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
}

//初始化操作
ConnectTypeTree.prototype.init = function () {
    var _this = this;

    var setting = {
        async: {
            enable: true,
            url: "platform/connectcenter/connectCenterController/getConnectTypeTree",//异步请求树子节点url
            autoParam: ["id"]//父节点id
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        view:{
            selectedMulti: false//进制按住ctrl多选
        },
        callback: {
            //节点点击事件
            onClick: function (event, treeId, treeNode) {
            	moduleType = "1";
                _this.selectedNodeId = treeNode.id;
                //$("." + dataBase.dataBaseArea).css("display", "");
                //获取该分类下电子表单模块列表
                //判断节点类型
                var TypeId = "";
                $.ajax({
    				url : 'platform/connectcenter/connectCenterController/operation/judgeNodeType',
    				data : {id:_this.selectedNodeId},
    				contentType : 'application/json',
    				async: false,
    				type : 'get',
    				dataType : 'json',
    				success : function(r) {
    					if (r!= "9999") {
    						TypeId = r;
    					} else {
    						layer.alert('获取节点分类失败！' + r.error, {
    							icon : 7,
    							area : [ '400px', '' ],
    							closeBtn : 0
    						});
    					}
    				}
    			});
                if(_this.selectedNodeId=="8"||TypeId=="8"){
                	if(soapwebservice==null || soapwebservice==undefined){
                		$('#lb').hide();
                		$("#rest").hide();
                		$('#ws').show();
                		$('#servlet').hide();
                		var searchSubNames = new Array();
                		searchSubNames.push("name");
                		soapwebservice = new SoapWebservice('formSubWs',searchSubNames,'WSModel_keyWord','searchDialogSubWS','soapWebservicejqGrid', 'platform/soapwebservice/soapWebserviceController/operation/','form',_this.selectedNodeId);
                		$('#t_soapWebservicejqGrid').hide();
                	}else{
                		$('#lb').hide();
                		$("#rest").hide();
                		$('#ws').show();
                		$('#servlet').hide();
                		soapwebservice.reLoad(_this.selectedNodeId);
                	}
                }else if(_this.selectedNodeId=="1"||TypeId=="1"){
                	if(dataBase==null||dataBase==undefined){
                		$('#ws').hide();
                		$("#rest").hide();
                    	$('#lb').show();
                    	$('#servlet').hide();
                    	dataBase = new DataBase("dataBaseArea","DataBaseDiv");
                    	dataBase.getDataBaseList(_this.selectedNodeId);
                	}else{
                		$('#ws').hide();
                		$("#rest").hide();
                    	$('#lb').show();
                    	$('#servlet').hide();
                    	dataBaseModel.reLoad(_this.selectedNodeId);
                	}                	
                }else if(_this.selectedNodeId=="7"||TypeId=="7"){
                	if(restful==null || restful==undefined){
                		$('#lb').hide();
                		$("#ws").hide();
                		$('#rest').show();
                		$('#servlet').hide();
                		var searchSubNames = new Array();
            			var searchSubTips = new Array();
            			searchSubNames.push("name");
            			searchSubTips.push("名称");
            			$('#RestModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
                		restful = new RestFul('formSubRest',searchSubNames,'RestModel_keyWord','searchDialogSubRest','restjqGrid', 'platform/restful/restFulController/operation/','form',_this.selectedNodeId);
                		restful.reLoad(_this.selectedNodeId);
                	}else{
                		$('#lb').hide();
                		$("#ws").hide();
                		$('#rest').show();
                		$('#servlet').hide();
                		restful.reLoad(_this.selectedNodeId);
                	}              	
                }else if(_this.selectedNodeId=="6"||TypeId=="6"){
                	if(servlet==null || servlet==undefined){
                		$('#lb').hide();
                		$("#ws").hide();
                		$('#rest').hide();
                		$('#servlet').show();
                		var searchSubNames = new Array();
            			var searchSubTips = new Array();
            			searchSubNames.push("name");
            			searchSubTips.push("名称");
            			$('#ServletModel_keyWord').attr('placeholder', '请输入' + searchSubTips[0]);
                		servlet = new Servlet('formSubServlet',searchSubNames,'ServletModel_keyWord','searchDialogSubServlet','servletjqGrid', 'platform/servlet/servletController/operation/','form',_this.selectedNodeId);
                		servlet.reLoad(_this.selectedNodeId);
                	}else{
                		$('#lb').hide();
                		$("#ws").hide();
                		$('#rest').hide();
                		$('#servlet').show();
                		servlet.reLoad(_this.selectedNodeId);
                	}              	
                }
                $(window).resize();
            }
        }
    };

    //手动请求根节点数据
    $.ajax({
        url: "platform/connectcenter/connectCenterController/getConnectTypeTree",
        data: "id=-1",
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var zNodes = backData;
            _this.tree = $.fn.zTree.init($("#" + _this.treeUL), setting, zNodes);

            _this.clickFirstSubNodeOfFirstRootNode();
        }
    });
};

//模拟点击第一个根节点的第一个子节点
ConnectTypeTree.prototype.clickFirstSubNodeOfFirstRootNode = function () {
    var _this = this;
    moduleType = "1";
    var firstRootNode = _this.tree.getNodeByParam("pId", null, null);
    var firstSubNodeOfFirstRootNode = _this.tree.getNodeByParam("pId", firstRootNode.id, null);
    if (firstSubNodeOfFirstRootNode) {
        var spanId = firstSubNodeOfFirstRootNode.tId + "_span";
        $("#" + spanId).click();
    }
};

ConnectTypeTree.prototype.clickNode = function () {
	  var _this = this;
	  moduleType = "1";
	  var node = _this.tree.getNodeByParam("id", _this.selectedNodeId);
	  $("#"+node.tId+"_span").click();
};
//重新加载pId父节点的子节点
ConnectTypeTree.prototype.reAsyncChildNodes = function (pId) {
    var _this = this;

    var n = _this.tree.getNodeByParam("id", pId, null);
    if (!n.isParent)
        n.isParent = "true";
    _this.tree.reAsyncChildNodes(n, "refresh");
};
//删除id节点及其子节点
ConnectTypeTree.prototype.removeNode = function (id) {
    var _this = this;

    _this.tree.removeNode(_this.tree.getNodeByParam("id", id, null));
};
//更新id节点
ConnectTypeTree.prototype.updateNode = function (id) {
    var _this = this;

    var node = _this.tree.getNodeByParam("id", id, null);
    _this.reAsyncChildNodes(node.pId);

    var spanId = _this.tree.getNodeByParam("id", node.pId, null).tId + "_span";
    $("#" + spanId + "").click();
};