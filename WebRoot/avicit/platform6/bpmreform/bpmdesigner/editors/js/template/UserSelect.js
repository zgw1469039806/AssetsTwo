function UserSelect(option) {
	// 用户参数
	this.topId = option.topId; // 当前节点id
	this.processId = option.processId;
	
	this.container = $((this.topId ? "#"+this.topId:"" ) + (option.userSelectContainer ? "  #" +option.userSelectContainer :""));  // 选人容器
	this.dataField = this.container.find("#" +option.dataField);	// 选人数据
	this.textField = this.container.find("#" +option.textField); 	// 选人显示框
	this.template = option.template || "avicit/platform6/bpmreform/bpmdesigner/editors/js/template/UserSelect.jsp?processId="+this.processId;
	this.callback = option.callback;
	this.init.call(this);
	return this;
};

UserSelect.prototype.init = function() {
	var _self = this;
	if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端，就使用自适应大小弹窗
		width='auto';
		height='auto';
	}
	layer.config({
	  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});
	var box = layer.open({
	    type:  2,
	    area: [ "800px",  "450px"],
	    title: "请选择用户",
	    skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
	    shade:   0.3,
        maxmin: false, //开启最大化最小化按钮
	    content: _self.template ,
	    btn: ['确定', '关闭'],
	    yes: function(index, layero){
	    	var iframeWin = layero.find('iframe')[0].contentWindow;
	         var user = iframeWin.getUserList(); // 此方法在UserSelectView中？？
		       _self.dataField.val(user.userList);
		       if(user.userList.length==0 || user.userList == "[]"){
		    	   _self.dataField.attr("actorsId","");
		       }else{
		    	   _self.dataField.attr("actorsId",_self.guid());
		       }
		       _self.textField.val(user.showUserList);
		       _self.textField.attr("title",user.showUserList);
		       if(typeof _self.callback != 'undefined') {
                   _self.callback(_self.getXML(user.userList));
			   }

	    	layer.close(index);
		 },
		 cancel: function(index){
			layer.close(index);
			$('html').addClass('fix-ie-font-face');
			setTimeout(function() {
				$('html').removeClass('fix-ie-font-face');
			}, 10);
	     },
	     success: function(layero, index){
	    	  var iframeWin = layero.find('iframe')[0].contentWindow;
	    	  iframeWin.initUserSelectView(_self.dataField.val()); // 此方法UserSelect.jsp中？？
	     }
	});
}

UserSelect.prototype.getPrimaryId = function (treeId, id, type, name, deptlevelId, deptlevelName, positionId, positionName) {
	return treeId+"_"+type+"_"+id+(deptlevelId?"_"+deptlevelId:"") +(positionId?"_"+positionId:"");
}

UserSelect.prototype.guid = function() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		return v.toString(16);
	});
}

UserSelect.prototype.getXML = function(actorDataValue) {
    if (actorDataValue == undefined || actorDataValue.length == 0) {
        return;
    }

    var node = flowUtils.createElement('actors'); // 创建一个人员xml节点
    // node.setAttribute("id", actorsId);
    // 开始封装人员xml信息
    var actorJSONArray = JSON.parse(actorDataValue);
    for(var i=0 ; i < actorJSONArray.length ; i++) {
        var actorNode = flowUtils.createElement('actor');
        var	aActorJson = actorJSONArray[i];
        actorNode.setAttribute("type", aActorJson.type);
        var idNode = flowUtils.createElement('id');
        idNode.appendChild(flowUtils.createTextNode(aActorJson.id));
        var nameNode = flowUtils.createElement('name');
        nameNode.appendChild(flowUtils.createTextNode(aActorJson.name));
        actorNode.appendChild(idNode);
        actorNode.appendChild(nameNode);
        if (aActorJson.type == "dept") {
        	if(aActorJson.position){
        		var positionNode = flowUtils.createElement('position');
                var positionIdNode = flowUtils.createElement('id');
                positionIdNode.appendChild(flowUtils.createTextNode(aActorJson.position.positionId));
                var positionNameNode = flowUtils.createElement('name');
                positionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.position.positionName + "]]>"));
                positionNode.appendChild(positionIdNode);
                positionNode.appendChild(positionNameNode);
                actorNode.appendChild(positionNode);
        	}
            
        } else if (aActorJson.type == "relation") {
            if(aActorJson.position) {
                var positionNode = flowUtils.createElement('position');
                var positionIdNode = flowUtils.createElement('id');
                positionIdNode.appendChild(flowUtils.createTextNode(aActorJson.position.positionId));
                var positionNameNode = flowUtils.createElement('name');
                positionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.position.positionName + "]]>"));
                positionNode.appendChild(positionIdNode);
                positionNode.appendChild(positionNameNode);
                actorNode.appendChild(positionNode);
            }
            if(aActorJson.deptlevel) {
                var deptlevelNode = flowUtils.createElement('deptlevel');
                var deptlevelIdNode = flowUtils.createElement('id');
                deptlevelIdNode.appendChild(flowUtils.createTextNode(aActorJson.deptlevel.deptlevelId));
                var deptlevelNameNode = flowUtils.createElement('name');
                deptlevelNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.deptlevel.deptlevelName + "]]>"));
                deptlevelNode.appendChild(deptlevelIdNode);
                deptlevelNode.appendChild(deptlevelNameNode);
                actorNode.appendChild(deptlevelNode);
            }
            if(aActorJson.step) {
                var stepNode = flowUtils.createElement('step');
                var stepIdNode = flowUtils.createElement('id');
                stepIdNode.appendChild(flowUtils.createTextNode(aActorJson.step.stepId));
                var stepNameNode = flowUtils.createElement('name');
                stepNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.step.stepName + "]]>"));
                stepNode.appendChild(stepIdNode);
                stepNode.appendChild(stepNameNode);
                actorNode.appendChild(stepNode);
            }
            if(aActorJson.customfunction) {
                var customfunctionNode = flowUtils.createElement('customfunction');
                var customfunctionIdNode = flowUtils.createElement('id');
                // customfunctionIdNode.appendChild(flowUtils.createTextNode(aActorJson.customfunction.customfunctionId));
                customfunctionIdNode.appendChild(flowUtils.createTextNode(aActorJson.customfunction.customfunctionName));
                var customfunctionNameNode = flowUtils.createElement('name');
                customfunctionNameNode.appendChild(flowUtils.createTextNode("<![CDATA[" + aActorJson.customfunction.customfunctionName + "]]>"));
                customfunctionNode.appendChild(customfunctionIdNode);
                customfunctionNode.appendChild(customfunctionNameNode);
                actorNode.appendChild(customfunctionNode);
            }
            if(aActorJson.variable){
            	var variableNode = flowUtils.createElement("variable");
            	var variableIdNode = flowUtils.createElement("id");
            	variableIdNode.appendChild(flowUtils.createTextNode("#{"+aActorJson.variable.variableAlias+"}"));
            	var variableNameNode = flowUtils.createElement("name");
            	variableNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.variable.variableAlias+"]]>"));
            	variableNode.appendChild(variableIdNode);
            	variableNode.appendChild(variableNameNode);
            	actorNode.appendChild(variableNode);
            }
            if(aActorJson.intersection){
            	var intersectionNode = flowUtils.createElement("intersection");
            	var intersectionIdNode = flowUtils.createElement("id");
            	intersectionIdNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.intersection.intersectionValue+"]]>"));
            	var intersectionNameNode = flowUtils.createElement("name");
            	intersectionNameNode.appendChild(flowUtils.createTextNode("<![CDATA["+aActorJson.intersection.intersectionAlias+"]]>"));
            	intersectionNode.appendChild(intersectionIdNode);
            	intersectionNode.appendChild(intersectionNameNode);
            	actorNode.appendChild(intersectionNode);
            }
        }
        node.appendChild(actorNode);
    }
    return node;
}

$(function(){
      $('.tabbable>ul>li')
      .on(
              'click',
              function() {
                  var that = $(this);
                  //切换标签
                  that.addClass('active').siblings('li').removeClass(
                          'active').parent().siblings('.tab-content')
                          .find('>div:eq(' + that.index() + ')')
                          .addClass('active').siblings('div')
                          .removeClass('active');
                  // 设置高度
                  // setHeight1($(this));
              });
});

