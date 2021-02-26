
function uuid() {
  var s = [];
  var hexDigits = "0123456789abcdef";
  for (var i = 0; i < 36; i++) {
    s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
  }
  s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
  s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
  //s[8] = s[13] = s[18] = s[23] = "-";
 
  var uuid = s.join("");
  return uuid;
}

function eventEdit(_this, title) {
	layer.open({
		type: 2,
		title: title,
		skin: 'layui-layer-rim',
		area: ['70%', '80%'],
		content: 'avicit/platform6/eform/common/jseditor.html',
		btn: ['确认', '取消'],
		success: function (layero, index) {
			//传入参数，并赋值给iframe的元素
			var iframeWin = layero.find('iframe')[0].contentWindow;
			iframeWin.setEditorValue(_this.value);
		},
		yes: function (index,layero) {
			var frm = layero.find('iframe')[0].contentWindow;
			$(_this).val(frm.getEditorValue()).trigger("keyup");
			layer.close(index);
		}
	});
}

String.prototype.startWith=function(str){     
	  var reg=new RegExp("^"+str);     
	  return reg.test(this);        
};

function ViewEngine(){
	this.viewTree = null;
	
	this.clickedNode = null;
	
	this.InitEngine = function (option){
		this.viewTree = option.viewTree;
	};

	this.treeNodes = null;

	this.layout = null;
	
	var menuItems = {
		"view":  [{"type":"treeConfig", "name":"添加树","only":false,"icon":"fa fa-tree"},{"type":"tableConfig", "name":"添加表格","only":false,"icon":"fa fa-table"},{"type":"dataList", "name":"添加自定义列表","only":false,"icon":"fa fa-list-alt"},{"type":"treeGridConfig", "name":"添加树形表格","only":false,"icon":"fa fa-table"},{"type":"compRef", "name":"创建组件联动","only":false,"icon":"fa fa-link"},{"type":"form", "name":"添加表单","only":false,"icon":"fa fa-plus-square-o"},{"type":"iframe", "name":"添加iframe","only":false,"icon":"fa fa-object-group"}],
		"treeGrid": [{"type":"tableColModel", "name":"添加列模型","only":true,"icon":"fa fa-columns"},{"type":"parameterArea", "name":"添加参数域","only":true,"icon":"fa fa-paperclip"},{"type":"dataFilter", "name":"添加数据过滤","only":true,"icon":"fa fa-filter"},{"type":"treeGridToolbar", "name":"添加工具栏","only":true,"icon":"fa fa-wrench"},{"type":"tableLink", "name":"添加关联存储","only":true,"icon":"fa fa-pagelines"}],
		"table": [{"type":"tableColModel", "name":"添加列模型","only":true,"icon":"fa fa-columns"},{"type":"parameterArea", "name":"添加参数域","only":true,"icon":"fa fa-paperclip"},{"type":"dataFilter", "name":"添加数据过滤","only":true,"icon":"fa fa-filter"},{"type":"tableToolbar", "name":"添加工具栏","only":true,"icon":"fa fa-wrench"},{"type":"tablePagingbar", "name":"添加分页栏","only":true,"icon":"fa fa-pagelines"},{"type":"tableHeader", "name":"添加多级表头","only":true,"icon":"fa fa-pagelines"},{"type":"tableLink", "name":"添加关联存储","only":true,"icon":"fa fa-pagelines"}],
		"dataList": [{"type":"dataListColModel", "name":"添加列模型","only":true,"icon":"fa fa-columns"},{"type":"parameterArea", "name":"添加参数域","only":true,"icon":"fa fa-paperclip"},{"type":"dataFilter", "name":"添加数据过滤","only":true,"icon":"fa fa-filter"},{"type":"dataListToolbar", "name":"添加工具栏","only":true,"icon":"fa fa-wrench"},{"type":"dataListPagingbar", "name":"添加分页栏","only":true,"icon":"fa fa-pagelines"},{"type":"tableLink", "name":"添加关联存储","only":true,"icon":"fa fa-pagelines"}],
		"form": [{"type":"parameterArea", "name":"添加参数域","only":true,"icon":"fa fa-paperclip"},{"type":"formToolbarButtonArea", "name":"添加按钮区","only":true,"icon":"fa fa-caret-square-o-right"}],
		"iframe": [{"type":"parameterArea", "name":"添加参数域","only":true,"icon":"fa fa-paperclip"}],
		"formToolbarButtonArea": [{"type":"formToolbarButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"}],
		"tableColModel": [{"type":"tableColumn", "name":"添加列","only":false,"icon":"fa fa-columns"},{"type":"tableVirColumn", "name":"添加虚拟列","only":false,"icon":"fa fa-minus-square-o"}],
		"dataListColModel": [{"type":"dataListColumn", "name":"添加列","only":false,"icon":"fa fa-columns"},{"type":"tableVirColumn", "name":"添加虚拟列","only":false,"icon":"fa fa-minus-square-o"}],
		"tableColumn": [{"type":"tableColRenderer", "name":"添加列控件","only":true,"icon":"fa fa-columns"}],
		"tableToolbar": [{"type":"tableToolbarButtonArea", "name":"添加按钮区","only":true,"icon":"fa fa-caret-square-o-right"},{"type":"tableSearchbarArea", "name":"添加查询区","only":true,"icon":"fa fa-caret-square-o-left"}],
		"dataListToolbar": [{"type":"dataListToolbarButtonArea", "name":"添加按钮区","only":true,"icon":"fa fa-caret-square-o-right"},{"type":"dataListSearchbarArea", "name":"添加查询区","only":true,"icon":"fa fa-caret-square-o-left"}],
		"tableToolbarButtonArea": [{"type":"tableToolbarButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"tableToolbarButtonGroup", "name":"添加按钮组","only":false,"icon":"fa fa-caret-square-o-right"}],
		"dataListToolbarButtonArea": [{"type":"dataListToolbarButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"dataListToolbarButtonGroup", "name":"添加按钮组","only":false,"icon":"fa fa-caret-square-o-right"}],
		"treeGridToolbar": [{"type":"treeGridToolbarButtonArea", "name":"添加按钮区","only":true,"icon":"fa fa-caret-square-o-right"},{"type":"treeGridSearchbarArea", "name":"添加查询区","only":true,"icon":"fa fa-caret-square-o-left"}],
		"treeGridToolbarButtonArea": [{"type":"treeGridToolbarButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"tableToolbarButtonGroup", "name":"添加按钮组","only":false,"icon":"fa fa-caret-square-o-right"}],
		"treeGridSearchbarArea": [{"type":"treeGridKeyWordSearch", "name":"添加基本查询","only":true,"icon":"fa fa-search"},{"type":"treeGridFormSearch", "name":"添加高级查询","only":true,"icon":"fa fa-search-plus"},{"type":"tableWorkflowSearch", "name":"添加流程查询","only":true,"icon":"fa fa-search-minus"},{"type":"treeLevelSearch", "name":"添加层级查询","only":true,"icon":"fa fa-search-minus"}],
		"treeGridFormSearch":[{"type":"formSearchFiled", "name":"添加查询字段","only":false,"icon":"glyphicon glyphicon-plus"}],
		"treeGridKeyWordSearch":[{"type":"keyWordFiled", "name":"添加关键字列","only":false,"icon":"fa fa-columns"}],
		"treeGridColModel": [{"type":"treeGridColumn", "name":"添加列","only":false,"icon":"fa fa-columns"},{"type":"tableVirColumn", "name":"添加虚拟列","only":false,"icon":"fa fa-minus-square-o"}],
		"tableToolbarButtonGroup": [{"type":"tableToolbarButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"}],
		"dataListToolbarButtonGroup": [{"type":"dataListToolbarButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"}],
		"tableSearchbarArea": [{"type":"tableKeyWordSearch", "name":"添加基本查询","only":true,"icon":"fa fa-search"},{"type":"formSearch", "name":"添加高级查询","only":true,"icon":"fa fa-search-plus"},{"type":"tableWorkflowSearch", "name":"添加流程查询","only":true,"icon":"fa fa-search-minus"}],
		"dataListSearchbarArea": [{"type":"dataListKeyWordSearch", "name":"添加基本查询","only":true,"icon":"fa fa-search"},{"type":"dataListFormSearch", "name":"添加高级查询","only":true,"icon":"fa fa-search-plus"},{"type":"dataListWorkflowSearch", "name":"添加流程查询","only":true,"icon":"fa fa-search-minus"},{"type":"dataListSortSearch", "name":"添加排序查询","only":true,"icon":"fa fa-search-minus"}],
		"dataListSortSearch":[{"type":"dataListSortGroup", "name":"添加排序分组","only":false,"icon":"fa fa-columns"}],
		"dataListSortGroup":[{"type":"dataListSortCol", "name":"添加排序字段","only":false,"icon":"fa fa-columns"}],
		"formSearch":[{"type":"formSearchFiled", "name":"添加查询字段","only":false,"icon":"glyphicon glyphicon-plus"}],
		"tableKeyWordSearch":[{"type":"keyWordFiled", "name":"添加关键字列","only":false,"icon":"fa fa-columns"}],
		"dataListKeyWordSearch":[{"type":"keyWordFiled", "name":"添加关键字列","only":false,"icon":"fa fa-columns"}],
		"dataListFormSearch":[{"type":"formSearchFiled", "name":"添加查询字段","only":false,"icon":"glyphicon glyphicon-plus"}],
		"tree": [{"type":"treeTool", "name":"右键菜单区域","only":true,"icon":"fa fa-bars"},{"type":"treeOrder", "name":"树排序","only":true,"icon":"fa fa-sort"},{"type":"treeIcon", "name":"节点图标","only":true,"icon":"fa fa-flag"},{"type":"parameterArea", "name":"添加参数域","only":true,"icon":"fa fa-paperclip"},{"type":"dataFilter", "name":"添加数据过滤","only":true,"icon":"fa fa-filter"}],
		"treeTool": [{"type":"treeButton", "name":"添加按钮","only":false,"icon":"fa fa-caret-square-o-right"}],
        "treeOrder": [{"type":"treeColOrder", "name":"添加列","only":false,"icon":"fa fa-caret-square-o-right"}],
		"treeIcon": [{"type":"treeColIcon", "name":"添加图标","only":false,"icon":"fa fa-caret-square-o-right"}],
		"parameterArea":[{"type":"parameter", "name":"添加参数","only":false,"icon":"fa fa-caret-square-o-right"}],
		"tableHeader":[{"type":"tableHeaderLevel", "name":"添加层级","only":false,"icon":"fa fa-caret-square-o-right"}],
		"tableHeaderLevel":[{"type":"tableHeaderCol", "name":"添加表头合并列","only":false,"icon":"fa fa-caret-square-o-right"}],
		"dataFilter":[{"type":"filter", "name":"添加过滤项","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"filterOr", "name":"添加or","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"filterGroup", "name":"添加分组","only":false,"icon":"fa fa-caret-square-o-right"}],
		"filterGroup":[{"type":"filter", "name":"添加过滤项","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"filterOr", "name":"添加or","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"filterGroup", "name":"添加分组","only":false,"icon":"fa fa-caret-square-o-right"}],
		"tableLink":[{"type":"tableLinkDb", "name":"添加存储","only":false,"icon":"fa fa-caret-square-o-right"}],
		"tableLinkDb":[{"type":"outerTableFilter", "name":"添加过滤项","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"outerTableFilterOr", "name":"添加or","only":false,"icon":"fa fa-caret-square-o-right"},{"type":"outerTableFilterGroup", "name":"添加分组","only":false,"icon":"fa fa-caret-square-o-right"}]
    };
	
	this.DeleteNode = function(treeId, nodeid){
		var _this = this;
		layer.confirm("确认要移除该节点吗？", {icon: 3, title: '提示', area: ['400px', '']}, function (index) {
            self.validateForm = null;
            self.propertyPageInit = null;
			var treeObj = $.fn.zTree.getZTreeObj(treeId);
			var node = treeObj.getNodeByTId(nodeid);
			treeObj.removeNode(node);
			_this.hideRMenu();
			$("#PropertyCard").empty();
			layer.close(index);
        });
		
	};

	this.DeleteNodeBatch = function(){
		var _this = this;
		layer.confirm("确认要移除该节点吗？", {icon: 3, title: '提示', area: ['400px', '']}, function (index) {
			self.validateForm = null;
			self.propertyPageInit = null;
			var nodes = _this.viewTree.getSelectedNodes();
			for (var i=0;i<nodes.length;i++){
				_this.viewTree.removeNode(nodes[i]);
			}
			_this.hideRMenu();
			$("#PropertyCard").empty();
			layer.close(index);
		});

	};
	
	this.getCompList = function(){
		return this.viewTree.getNodes()[0].children;
	};

	this.getNode = function(id){
		return this.viewTree.getNodeByParam("id",id);
	};
	
	this.creatTable = function(treeId, nodeid){
        self.selectDbCallBack = function(id, name){
        	avicAjax.ajax({
   			 url: './eform/eformViewInfoController/creatTable/' + id,
   			 contentType: "application/xml; charset=utf-8",
   			 type : 'post',
   			 dataType : 'json',
   			 async:true, 
   			 success : function(r){
   				 if (r != null) {
   					var treeObj = $.fn.zTree.getZTreeObj(treeId);
   					var node = treeObj.getNodeByTId(nodeid);
   					treeObj.addNodes(node,  $.parseJSON(r.data));
   				}
   			 }
	   		});
        };
		
       layer.open({
            type: 2,
            title: '请选择',
            area: ['60%', '60%'],
            maxmin: false,
            content: "avicit/platform6/db/dbselect/selectCreatedDbTable/selectCreatedDbTable.jsp"
        });
	};
	
	this.AddNode = function(treeId, nodeid, type, name, only){
		var _self = this;
        if (!_self.doValidate()){
            return false;
        }
        self.validateForm = null;
        self.propertyPageInit = null;
		var treeObj = $.fn.zTree.getZTreeObj(treeId);
		var node = treeObj.getNodeByTId(nodeid);
		var nodeId = "";

		if(type == "creatTable"){
			this.creatTable(treeId, nodeid);
			this.hideRMenu();
			return;
		}else if(type == "treeConfig"||type == "tableConfig"||type == "treeGridConfig"){
			this.hideRMenu();
			layer.open({
				type: 2,
				area: ['100%', '100%'],
				title: '快速'+name,
				skin: 'bs-modal', 
				maxmin: false,
				content: 'avicit/platform6/eform/bpmsviewdesign/js/property/fastconfigpage/' + type + '.jsp',
				btn: ['保存', '取消'],
				yes: function (index,layero) {
					var iframeWin = layero.find('iframe')[0].contentWindow;
					if(iframeWin.isValidate()) {
						var nodes = iframeWin.getNodes();
						for (var i = 0; i < nodes.length; i++) {
							var addNode = nodes[i];
							var parentNode = node;
							if (addNode.parentId != "root") {
								parentNode = treeObj.getNodeByParam("id", addNode.parentId, null);
							}
							treeObj.addNodes(parentNode, {
								id: addNode.id,
								type: addNode.type,
								name: addNode.name,
								attribute: addNode.attribute
							});
						}
						layer.close(index);
					}
				}
			});
			return;
		}
		
		if(!only){
			var id = uuid();
			nodeId = type + id;
			treeObj.addNodes(node, {
				id : nodeId,
				type : type,
				name : name,
				attribute: {id : nodeId}
			});
		}else{
			nodeId = node.id + type;
			var tablenode = treeObj.getNodesByParam("id", nodeId, node);
			if(tablenode.length == 0 ){
				treeObj.addNodes(node, {
					id : nodeId,
					type : type,
					name : name.replace("添加", ""),
					attribute: {id : nodeId, name : name.replace("添加", "")}
				});
			}
		}
		
		this.hideRMenu();
		this.loadProperty({type:type, nodeId:nodeId, after: function(){
			if(_self.clickedNode.attribute){
				_self.setProperty($("#property_" + _self.clickedNode.id +" form"), _self.clickedNode.attribute);
			}
		}});
		
        var c_node = treeObj.getNodeByParam("id", nodeId);
        treeObj.selectNode(c_node);
        this.clickedNode = c_node;
	};

	this.getParent=function(parentnode,nodetype){
		var typearray = nodetype.split(",");
		for (var i=0;i<typearray.length;i++){
			if (parentnode.type === typearray[i]){
				return parentnode;
			}
		}
		var node = parentnode.getParentNode();
		if (node != null && node != "undefined"){
			return this.getParent(node,nodetype);
		}else{
			return null;
		}

	};

	this.getPara = function(nodetype){
		var nodes = null;
		var selectNode = this.clickedNode;
		var parentnode = this.getParent(selectNode,nodetype);
		if (parentnode != null) {
			nodes = parentnode.children;
		}

		if(nodes == null || nodes.length == 0){
			return [];
		}else{
			var tableColModelnode = null;
			for(var i = 0; i < nodes.length; i++){
				if(nodes[i].type == "parameterArea"){
					tableColModelnode = nodes[i];
					break;
				}
			}
			if(tableColModelnode != null && tableColModelnode.children != null && tableColModelnode.children.length > 0){
				var retArray = [];
				for(var t = 0 ; t < tableColModelnode.children.length; t++ ){
					retArray.push({_key:tableColModelnode.children[t].name, _value:tableColModelnode.children[t].name,_attribute:tableColModelnode.children[t].attribute});
				}
				return retArray;
			}else{
				return [];
			}
		}
	};


	this.getCol = function(id){
		var selectNode = this.clickedNode;
		// var selectNode = this.viewTree.getNodeByParam("id", id) || this.clickedNode;
		if (typeof id != 'undefined'){
			selectNode = this.viewTree.getNodeByParam("id", id)
		}
		
		var type = selectNode.type;
		var nodes = null;
		if(type == "formSearchFiled"){
			nodes = selectNode.getParentNode().getParentNode().getParentNode().getParentNode().children;
		}
		if (type == "table" || type == "treeGrid"|| type=="dataList"){
			nodes = selectNode.children;
		}

		if(nodes == null || nodes.length == 0){
			return [];
		}else{
			var tableColModelnode = null;
			for(var i = 0; i < nodes.length; i++){
				if(nodes[i].type == "tableColModel" || nodes[i].type == "dataListColModel"){
					tableColModelnode = nodes[i];
					break;
				}
			}
			if(tableColModelnode != null && tableColModelnode.children != null && tableColModelnode.children.length > 0){
				var retArray = [];
				for(var t = 0 ; t < tableColModelnode.children.length; t++ ){
					retArray.push({_key:tableColModelnode.children[t].id, _value:tableColModelnode.children[t].name,_attribute:tableColModelnode.children[t].attribute});
				}
				return retArray;
			}else{
				return [];
			}
		}
	};
	
	this.getColForKeyWord = function(){
		var type = this.clickedNode.type;
		var nodes = null;
		if(type == "keyWordFiled"){
			nodes = this.clickedNode.getParentNode().getParentNode().getParentNode().getParentNode().children;
		}

		if(nodes == null || nodes.length == 0){
			return [];
		}else{
			var tableColModelnode = null;
			for(var i = 0; i < nodes.length; i++){
				if(nodes[i].type == "tableColModel" || nodes[i].type == "dataListColModel"){
					tableColModelnode = nodes[i];
					break;
				}
			}
			if(tableColModelnode != null && tableColModelnode.children != null && tableColModelnode.children.length > 0){
				var retArray = [];
				for(var t = 0 ; t < tableColModelnode.children.length; t++ ){
					if(tableColModelnode.children[t].attribute.db_filed_type == "VARCHAR2"){
						retArray.push({_key:tableColModelnode.children[t].id, _value:tableColModelnode.children[t].name});
					}
				}
				return retArray;
			}else{
				return [];
			}
		}
	};
	
	this.loadProperty = function(option){
		$("#PropertyCard").empty();
		try {
			$.ajax({
				url: option.url || 'avicit/platform6/eform/bpmsviewdesign/js/property/' + option.type + '.html',
				async: true,
				cache: false,
				success: function (r) {
					if (r != null) {
						var html = '<div id="property_' + option.nodeId + '" style="padding-left: 30px; padding-top: 10px; width: 80%"> ' + r + '</div>';
						$("#PropertyCard").append(html);
						$('[data-trigger="spinner"]').spinner();
						if (option.after && typeof option.after == 'function') {
							option.after();
						}
					}
				}, error: function () {
					return false;
				}
			});
		}catch (e) {
			
		}
	};
	
	this.setProperty = function (formObj, jsonValue) {
        var obj = formObj;
        obj.find("input").on('keyup',function(){
        	engine.changSave();
        });
        obj.find("textarea").on('keyup',function(){
        	engine.changSave();
        });
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
            }else if ($(oinput).attr('class') == "form-control date-picker hasDatepicker"){
         	   obj.find("[name=" + name + "]").datepicker("setDate", new Date(ival));
         	   
            }else if ($(oinput).attr('class') == "form-control time-picker hasDatepicker"){
         	   obj.find("[name=" + name + "]").val(ival);
            }else {
                obj.find("[name=" + name + "]").val(ival);
            }
        })
    };
	
	//显示右键菜单  
	this.showRMenu = function (type, x, y) {
	    $(".rMenu ul").show();  
	    $(".rMenu").css({"top":y+"px", "left":x+"px", "visibility":"visible"}); //设置右键菜单的位置、可见  
	    $("body").bind("mousedown", this.onBodyMouseDown);  
	};  
	//隐藏右键菜单  
	this.hideRMenu = function () {  
	    if ($(".rMenu")) $(".rMenu").css({"visibility": "hidden"}); //设置右键菜单不可见  
	    $("body").unbind("mousedown", this.onBodyMouseDown);  
	};  
	//鼠标按下事件  
	this.onBodyMouseDown = function (event){  
	    if (!(event.target.id == "rMenu" || $(event.target).parents(".rMenu").length>0)) {  
	    	$(".rMenu").css({"visibility" : "hidden"});  
	    }  
	};

	this.ShowMenu = function(event, treeId, treeNode,isbatch){
		$(".rMenu").empty();
		var menuTotal = 0;
		var menuitems = "";
		if (isbatch){
			if (treeNode.type != "view") {
				menuitems = menuitems + '<a href="javascript:void(0)" class="list-group-item" onclick="engine.DeleteNodeBatch();"><i class="glyphicon glyphicon-trash"style="margin-left: -35px; margin-right: 20px;width:14px"></i>删除</a>';
				menuTotal++;
			}
		}else {
			if (typeof (treeNode.name) != "undefined" && treeNode.name == "查询区") {
				var isBpm = treeNode.getParentNode().getParentNode().attribute.isbpm;
				if (isBpm == "N") {//表格的关联流程选择“否”，右键添加工具栏查询区时，流程查询不可选择；
					menuItems.tableSearchbarArea = [{
						"type": "tableKeyWordSearch",
						"name": "添加基本查询",
						"only": true,
						"icon": "fa fa-search"
					}, {"type": "formSearch", "name": "添加高级查询", "only": true, "icon": "fa fa-search-plus"}];
				} else if (isBpm == "Y") {//表格的关联流程选择“是”，右键添加工具栏查询区时，流程查询可以选择；
					menuItems.tableSearchbarArea = [{
						"type": "tableKeyWordSearch",
						"name": "添加基本查询",
						"only": true,
						"icon": "fa fa-search"
					}, {
						"type": "formSearch",
						"name": "添加高级查询",
						"only": true,
						"icon": "fa fa-search-plus"
					}, {"type": "tableWorkflowSearch", "name": "添加流程查询", "only": true, "icon": "fa fa-search-minus"}];
				}
			}

			if (menuItems[treeNode.type] == null || menuItems[treeNode.type].length == 0) {
				if (treeNode.type != "view") {
					menuitems = menuitems + '<a href="javascript:void(0)" class="list-group-item" onclick="engine.DeleteNode(\'' + treeId + '\',\'' + treeNode.tId + '\');"><i class="glyphicon glyphicon-trash"style="margin-left: -35px; margin-right: 20px;width:14px"></i>删除</a>';
					menuTotal++;
				}
			} else {
				for (var i = 0; i < menuItems[treeNode.type].length; i++) {
					menuitems = menuitems + '<a href="javascript:void(0)" class="list-group-item" onclick="engine.AddNode(\'' + treeId + '\',\'' + treeNode.tId + '\',\'' + menuItems[treeNode.type][i].type + '\',\'' + menuItems[treeNode.type][i].name + '\',' + menuItems[treeNode.type][i].only + ');"><i class="' + menuItems[treeNode.type][i].icon + '"style="margin-left: -35px; margin-right: 20px;width:14px"></i>' + menuItems[treeNode.type][i].name + '</a>';
					menuTotal++;

				}
				if (treeNode.type != "view") {
					menuitems = menuitems + '<a href="javascript:void(0)" class="list-group-item" onclick="engine.DeleteNode(\'' + treeId + '\',\'' + treeNode.tId + '\');"><i class="glyphicon glyphicon-trash"style="margin-left: -35px; margin-right: 20px;width:14px"></i>删除</a>';
					menuTotal++;
				}
			}
		}
		$(".rMenu").append(menuitems);
		var clientY = event.clientY;
		var posHeight = menuTotal * 34;
		if( posHeight + event.clientY > $(window).height()){
            clientY = $(window).height() - posHeight;
		}
		this.showRMenu("root", event.clientX,clientY);
	};

	this.doValidate = function(){
        var _self = this;
        if (_self.clickedNode !=null) {
            var form = serializeObject($("#property_" + this.clickedNode.id + " form"));
            /*if (form){
                if (typeof form.name == "undefined" || form.name == null || form.name == ""){
                    layer.msg('节点名称不能为空！', {icon: 7});
                    return false;
                }
            }*/
            if (self.validateForm != null && typeof(self.validateForm) == "function") {
                if (!self.validateForm(form,_self.clickedNode)) {
                    return false;
                }
            }
        }
        return true;
	};
	
	/**
	 * 节点点击监听
	 */
	this.listenNode = function(treeid, treeNode,clickFlag){
		var _self = this;
		if (_self.clickedNode == treeNode){
		    return false;
        }
        if (!_self.doValidate()){
        	return false;
		}

		self.validateForm = null;
		self.propertyPageInit = null;
		_self.clickedNode = treeNode;

		var treeObj = $.fn.zTree.getZTreeObj(treeid);
		var nodes = treeObj.getSelectedNodes();
		if (clickFlag == 2 && nodes != null && nodes.length>0){
			var type = nodes[0].type;
			if (type != treeNode.type){
				treeObj.selectNode(treeNode);
			}else if (nodes.length == 1){
				_self.loadProperty({
					url:'avicit/platform6/eform/bpmsviewdesign/js/property/'+ type + '-batch.html',
					nodeId:'batchform'
				});
			}

		}else {
			//加载配置页
			_self.loadProperty({
				type: treeNode.type, nodeId: treeNode.id, after: function () {
					if (_self.clickedNode.attribute) {


						if (self.propertyPageInit != null && typeof (self.propertyPageInit) == "function") {
							self.propertyPageInit(treeNode);
						}
						// 初始化数据
						_self.setProperty($("#property_" + _self.clickedNode.id + " form"), _self.clickedNode.attribute);

						//单独处理页面中有多选框Multiple，上个初始化数据函数将多选框值丢失
						if (typeof (dealMultiple) == "function" && dealMultiple != null) {
							dealMultiple(treeNode);
						}
					}
				}
			});
		}

		return true;
	};
	
	this.changSave = function(){
		var form = serializeObject($("#property_" + this.clickedNode.id +" form"));
		if(form.hasOwnProperty("name")&&form.name.replace(/[\u0391-\uFFE5]/g,"aa").length > 200){
            layer.msg('最多可以输入 200 个字符！', {icon: 2});
			return;
		}
		this.clickedNode.attribute = form;
		if (typeof(form.name) != "undefined") { 
			this.clickedNode.name = serializeObject($("#property_" + this.clickedNode.id +" form")).name;
			this.viewTree.updateNode(this.clickedNode);
		}  
	};

	this.changSaveBatch = function(){
		var form = serializeObject($("#property_batchform form"));
		for ( var key in form ){
			if ( form[key] === '' ){
				delete form[key]
			}
		}
		var nodes = this.viewTree.getSelectedNodes();
		for (var i=0;i<nodes.length;i++){
			var attribute = nodes[i].attribute;
			$.extend(attribute,form);
			this.viewTree.updateNode(nodes[i]);
		}
	};
	
	this.ConvertToXML = function(){
		/**校验table中是否包含主键字段**/

		var tableNodes = this.viewTree.getNodesByParam("type", "table");
		for (var i=0;i<tableNodes.length;i++){
            var hasPk = false;
            var hasBlob = false;
            var msg = "";
			var tablecol = this.viewTree.getNodeByParam("type", "tableColModel",tableNodes[i]);
			if (tablecol) {
                var cols = this.viewTree.getNodesByParam("type", "tableColumn",tablecol);
                for (var j=0;j<cols.length;j++){
                	if (cols[j].attribute.ispkfiled === "Y"){
                        hasPk = true;
                        break;
					}

                    // if (cols[j].attribute.db_filed_type === "BLOB" && cols[j].attribute.hidden == "false"){
                    //     hasBlob = true;
                    //     msg = cols[j].attribute.name+"["+cols[j].attribute.id+"]为BLOB类型，无法展示";
                    //     break;
                    // }
				}
			}
			if (!hasPk){
				var title = "表格控件";
				if (tableNodes[i].attribute.name){
                    title = tableNodes[i].attribute.name;
				}
                layer.msg(title+'没有主键字段，请检查！', {icon: 7});
                return false;
			}

            /*if (hasBlob){
                var title = "表格控件";
                if (tableNodes[i].attribute.name){
                    title = tableNodes[i].attribute.name;
                }
                layer.msg(title+"中的"+msg+'，请删除或置为隐藏！', {icon: 7});
                return false;
            }*/
		}
        var rootNode = this.viewTree.getNodeByParam("type", "view");
        if(rootNode){
        	return '<?xml version="1.0" encoding="UTF-8"?>'+ getNodeXml(rootNode);
        }
	};
	
	function getNodeXml(Node){
		var ret = "<" + Node.type; 
			for(var arr in  Node.attribute){
				if(!arr.startWith("event_")&& !arr.startWith("url")){
					ret = ret + " " + arr + "=\"" + Node.attribute[arr] + "\"";
				}else if(arr.startWith("url")){
                    var ss = $('<div/>').text(Node.attribute[arr]).html();
                    ret = ret + " " + arr + "=\"" + ss + "\"";
                }
			}
			ret = ret + ">";
			ret = ret + "<events>";
			for(var arr in  Node.attribute){
				if(arr.startWith("event_") ){
					ret = ret + "<event name=\"" + arr + "\"><![CDATA[" + Node.attribute[arr] + "]]></event>";
				}
			}
			ret = ret + "</events>";
			
			if(!(Node.children == null || Node.children.length == 0)){
				  for(var t =0; t <  Node.children.length; t++){
					  ret = ret + getNodeXml(Node.children[t]);
				  }
			}
		  ret = ret + "</" + Node.type  +  ">" ;
		  return ret;
    }
}

ViewEngine.prototype.initButtonArea = function () {
	var html = "<span style=\"color: #58a9ff;\">\n" +
		"\t\t                    <i class=\"icon iconfont icon-Preservation\" title=\"保存视图\" onclick=\"viewDesignPage.save('0');\"></i>\n" +
		"\t\t                </span>\n";
	if(viewPublishStatus==1){
		html = html +
			"\t\t                <span style=\"color: #58a9ff;\">\n" +
			"\t\t                    <i class=\"icon iconfont icon-baocunfabu\" title=\"新建版本\" \n" +
			"\t\t                    \tonclick=\"viewDesignPage.saveNewVersion()\"></i>\n" +
			"\t\t                </span>\n";
	}else{
		html = html +
			"\t\t                <span style=\"color: #58a9ff;\">\n" +
			"\t\t                    <i class=\"icon iconfont icon-baocunfabu\" title=\"保存并发布视图\" \n" +
			"\t\t                    \tonclick=\"viewDesignPage.saveAndPublish(viewId,viewName,viewCode,viewStyle)\"></i>\n" +
			"\t\t                </span>\n";
	}
		html = html +
		"\t\t                <span style=\"border-left: 1px solid #B5B5B5;padding-bottom: 0px;padding-top: 7px;\">\n" +
		"\t\t                </span>\n" +
		"\t\t                <span style=\"color: #B5B5B5;\">\n" +
		"\t\t                    <i class=\"icon iconfont icon-js\" title=\"JS文件扩展\" onclick=\"viewDesignPage.applyJs()\"></i>\n" +
		"\t\t                </span>\n" +
		"\t\t                <span style=\"color: #B5B5B5;\">\n" +
		"\t\t                    <i class=\"icon iconfont icon-changyong\" title=\"css文件扩展\" onclick=\"viewDesignPage.applyCss()\"></i>\n" +
		"\t\t                </span>\n" +
		"\t\t                <span style=\"color: #B5B5B5;\">\n" +
		"\t\t                    <i class=\"icon iconfont icon-preview\" title=\"预览\" onclick=\"viewDesignPage.view()\"></i>\n" +
		"\t\t                </span>\n" +
		"\t\t               <span id=\"layoutButton\" style=\"color: #B5B5B5;\">\n" +
		"\t\t                    <i  class=\"icon iconfont icon-style\" title=\"布局模板\"></i>\n" +
		"\t\t                </span>\n" +
		"\t\t               <span id=\"layoutButton\" style=\"color: #B5B5B5;\">\n" +
		"                    \t\t<i  class=\"icon iconfont icon-file\" title=\"帮助\" onclick=\"viewDesignPage.helpDoc()\"></i>\n" +
		"              \t\t\t</span>";
    $("#buttonArea").html(html);
};

ViewEngine.prototype.setLayout = function(){

};

ViewEngine.prototype.setTreeNode = function(){

};

