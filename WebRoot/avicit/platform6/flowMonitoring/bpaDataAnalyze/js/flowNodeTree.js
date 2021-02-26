function flowNodeTree(treeUL,orgId,flowID) {
    this.treeUL = treeUL;//tree位置
    this.orgId = orgId;
    this.tree = null;//tree对象
    this.selectedNodeId = null;//tree点击选中的节点
    this.init.call(this);
};
var retdata = '';
//初始化操作
flowNodeTree.prototype.init = function () {
	var data = '';
    var _this = this;
    
    var setting = {
        
        async: {
            enable: true,
            url: "bpm/bpmconsole/ideaStyleManagerAction/getActivityList.json",//异步请求树子节点url
            autoParam: ["pdId"]//父节点id
        },
        data: {
        	key: {
				id: "activityName",
				name: "activityAlias",
				children: "children"
			},
            simpleData: {
                enable: true,
                idKey: "id",
                pIdkey: "pId"
            }
        },
        check: {
 			  enable: true,
 			  chkStyle: "checkbox",
			  chkboxType: { "Y": "s", "N": "ps" }
        },
        callback: {
        	onCheck:onCheck1
        }
    };
   var pdIdList = null;
   if(!flowID || flowID=="null"){}
   else{ pdIdList = flowID.split(","); 
   for(var i = 0; i < pdIdList.length; i++){
	   //手动请求根节点数据
	    $.ajax({
	        url: "bpm/bpmconsole/ideaStyleManagerAction/getActivityList.json",
	        data: {
	        	pdId : pdIdList[i]
	        },
	        type: "post",
	        async: false,
	        dataType: "json",
	        success: function (backData) {
	            var zNodes = backData.rows;
	            var ful = "<div style=\"font-size: 16px;border-bottom: solid #5bc0de 1px;margin: 10px;\">"+zNodes[0].processName+"";
	            var temp = $("#" + _this.treeUL);
	            $("#" + _this.treeUL).append(ful);
	    		var ul = "<ul id=\"flowNodeTree"+i+"\" class=\"ztree\" style=\"height: 100%;\"></ul>";
	            $("#" + _this.treeUL).append(ul);
	            _this.tree = $.fn.zTree.init($("#" + _this.treeUL+i+''), setting, zNodes);
	            $("#" + _this.treeUL).append("</div>"); 
	        }
	    });
   }
   }
  
};

var callbackdata = function () {
    return retdata;
}