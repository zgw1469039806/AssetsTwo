
function FlowComponent(componentDiv,type) {
	this.type = type;//1:未发布 2：已发布
    this.componentDiv = componentDiv;
    this.init.call(this);
}
//初始化操作
FlowComponent.prototype.init = function () {
    var _this = this;
    var templateStr;
    //
    if(_this.type=='2'){
    	templateStr = '<div class="eform-item" id="">'
            + '<div class="eform-item-title" title="" data-toggle="popover" data-container="body" data-placement="auto bottom">'
            + '<i class="iconfont icon-liucheng eform-item-deployed" data-toggle="popover" data-container="body" data-placement="auto bottom"></i>'
        + '</div>'
        + '<div class="eform-item-bottom">'
            + '<span class="eform-item-bottom-name" title="流程模板">流程模板</span>'
            + '<span class="eform-item-bottom-btn">'
                + '<i class="glyphicon glyphicon-option-vertical"></i>'
            + '</span>'
        + '</div>'
        + '<div class="eform-item-tools" style="display: none;">'
            + '<div class="deleteComponent"><i class="glyphicon glyphicon-trash"></i>删除</div>'
            + '<div class="startComponent"><i class="glyphicon glyphicon-play-circle"></i>启用模板</div>'
            + '<div class="suspendComponent"><i class="glyphicon glyphicon-pause"></i>停用模板</div>'
            + '<div class="changeCatalog"><i class="glyphicon glyphicon-transfer"></i>切换目录</div>'
            + '<div class="fileCopy"><i class="glyphicon glyphicon-copy"></i>复制</div>'
            + '<div class="fileDown"><i class="glyphicon glyphicon-download"></i>导出</div>'
            + '<div class="fileUpload"><i class="glyphicon glyphicon-upload"></i>导入覆盖</div>'
            + '<div class="setPermission"><i class="glyphicon glyphicon-user"></i>权限设置</div>'
            + '<div class="setOrder"><i class="glyphicon glyphicon-sort-by-attributes"></i>排序设置</div>'
            + '<div class="share"><i class="glyphicon glyphicon-share"></i>共享到其他组织</div>'
			+ '<div class="bpmSam"><i class="glyphicon glyphicon-adjust"></i>查看ARIS流程</div>'
            + '<div class="forbidManualStart"><i class="glyphicon glyphicon-ban-circle"></i>禁止手工发起流程</div>'
            + '<div class="permitManualStart"><i class="glyphicon glyphicon-ok-circle"></i>允许手工发起流程</div>'
        + '</div>';
//        + '<div class="eform-item-checkbox">'
//            + '<input type="checkbox">'
//        + '</div>'
    + '</div>';
    }else{
    	templateStr = '<div class="eform-item" id="">'
         +'<div class="eform-item-title" title="" data-toggle="popover" data-container="body" data-placement="auto bottom">'
            + '<i class="iconfont icon-liucheng eform-item-unDeployed" data-toggle="popover" data-container="body" data-placement="auto bottom"></i>'
        + '</div>'
        + '<div class="eform-item-bottom">'
            + '<span class="eform-item-bottom-name" title="流程模板">流程模板</span>'
            + '<span class="eform-item-bottom-btn">'
                + '<i class="glyphicon glyphicon-option-vertical"></i>'
            + '</span>'
        + '</div>'
        + '<div class="eform-item-tools" style="display: none;">'
            + '<div class="deployFlow"><i class="iconfont icon-fabu"></i>&nbsp;&nbsp;发布</div>'
            + '<div class="deleteComponent"><i class="glyphicon glyphicon-trash"></i>删除</div>'
            + '<div class="changeCatalog"><i class="glyphicon glyphicon-transfer"></i>切换目录</div>'
            + '<div class="fileCopy"><i class="glyphicon glyphicon-copy"></i>复制</div>'
            + '<div class="fileDown"><i class="glyphicon glyphicon-download"></i>导出</div>'
            + '<div class="fileUpload"><i class="glyphicon glyphicon-upload"></i>导入覆盖</div>'
            + '<div class="share"><i class="glyphicon glyphicon-share"></i>共享到其他组织</div>'
			+ '<div class="bpmSam"><i class="glyphicon glyphicon-adjust"></i>查看ARIS流程</div>'
        + '</div>';
//        + '<div class="eform-item-checkbox">'
//            + '<input type="checkbox">'
//        + '</div>'
    + '</div>';
    }

    var template = $(templateStr);

    this.template = template;
};
//页面新建一个FlowComponent
FlowComponent.prototype.setComponent = function (data) {
    var _this = this;

    var component = _this.template.clone();
    component.data = data;
    var stateName = '';
    var pdId = "";
    var deployId = "";
    var state = "";
    var deployer = "";
    var deployDate = "";
    var isUflow = "固定流程";
    var permission = "";
    if('active'==data.state){
    	stateName = '启用';
    	state = data.state;
    }else if('suspended'==data.state){
    	stateName = '停用';
    	state = data.state;
    }
    if(null!=data.pdId){
    	pdId = data.pdId;
    }
    if(null!=data.deployId){
    	deployId = data.deployId;
    }
    if(null!=data.deployer){
    	deployer = data.deployer;
    }
    if(null!=data.deployDate){
    	deployDate = data.deployDate;
    }
    if(data.isUflow != null && data.isUflow == "2"){
    	isUflow = "自由流程";
    }
    if(null!=data.permission){
    	permission = data.permission;
    }
    //唯一标识
    component.attr("id", data.id);

    component.attr("type", data.type);
    if('suspended'==data.state){
    	component.find(".eform-item-deployed").attr("class","icon iconfont icon-liucheng eform-item-deployed-suspended");
    }
    component.find(".eform-item-title").attr("title","");
    var _dataContent = '';
	if('2'==data.type){
		_dataContent = '<table width="180px" border="0" style="font-size:12px;"  align="center">'
				+'<tr><td width="40%" height="25"><lable>流程名称:</lable></td><td><span class="eform-item-popover" title="'+data.name+'">'+data.name+'</span></td></tr>'
				+'<tr><td width="40%" height="25">版&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本:</td><td>'+data.version+'</td></tr>'
				+'<tr><td width="40%" height="25" >流程类型:</td><td>'+isUflow+'</td></tr>'
				+'<tr><td width="40%" height="25" >流程状态:</td><td>'+stateName+'</td></tr>'
				+'<tr><td width="40%" height="25" >访问权限:</td><td ><span class="eform-item-popover" title="'+permission+'">'+permission+'</span></td></tr>'
				+'<tr><td width="40%" height="25">创&nbsp;&nbsp;建&nbsp;&nbsp;人:</td><td>'+data.designer+'</td></tr>'
				+'<tr><td width="40%" height="25">部&nbsp;&nbsp;署&nbsp;&nbsp;人:</td><td>'+deployer+'</td></tr>'
				+'<tr><td width="40%" height="25">所属组织:</td><td>'+data.orgName+'</td></tr>'
				+'<tr><td width="40%" height="25">部署日期:</td><td>'+deployDate+'</td></tr>'
				+'</table>';
	}else{
		_dataContent = '<table width="180px" border="0" style="font-size:12px;" align="center">'
				+'<tr><td width="40%" height="25"><lable>流程名称:</lable></td><td><span class="eform-item-popover" title="'+data.name+'">'+data.name+'</span></td></tr>'
				+'<tr><td width="40%" height="25" >流程类型:</td><td>'+isUflow+'</td></tr>'
				+'<tr><td width="40%" height="25">流程状态:</td><td>未发布</td></tr>'
				+'<tr><td width="40%" height="25">创&nbsp;&nbsp;建&nbsp;&nbsp;人:</td><td>'+data.designer+'</td></tr>'
                +'<tr><td width="40%" height="25">所属组织:</td><td>'+data.orgName+'</td></tr>'
				+'</table>';
	}

    component.find(".eform-item-title").find(".icon-liucheng").attr("data-content",_dataContent);

    //component.find("[data-toggle='popover']").popover({html:true,trigger:'hover'});
    component.find("[data-toggle='popover']").popover({ trigger: "manual" , html: true, animation:false})
    .on("mouseenter", function () {
        var _this = this;
        $(this).popover("show");
        $(".popover").on("mouseleave", function () {
            $(_this).popover('hide');
        });
    }).on("mouseleave", function () {
        var _this = this;
        setTimeout(function () {
            if (!$(".popover:hover").length) {
                $(_this).popover("hide");
            }
        }, 300);
    });


    //显示属性
    if(data.type == 2){
    	component.find(".eform-item-bottom-name").attr("title", data.name+"-V"+data.version);
        component.find(".eform-item-bottom-name").text(data.name+"-V"+data.version);
    }else{
    	component.find(".eform-item-bottom-name").attr("title", data.name);
        component.find(".eform-item-bottom-name").text(data.name);
    }

    //显隐工具栏按钮事件绑定
	 var arisURL="";
    component.find(".eform-item-bottom-btn").click(function () {
    	component.find("[data-toggle='popover']").popover('hide');
    	$(".eform-item-tools").hide();
		//判断是否是ARIS转换而来的流程模板add by lianch
    	if(data.type == "2"){
    		processId = data.pdId.substring(0,32);
    	}else{
    		processId = data.id;
    	}
    	$.ajax({
			  type:'POST',
			  async: false,
			  url: 'bpmSam/bpmn2jbpm/operation/getEpcId',
			  data :{
				  processId:processId
			  },
			  dataType:'text',
			  success: function(r){
				  if(null!=r&&r!=""){
					  var endURL = r.substring(16,r.length);
					  arisURL = "http://win7-pc2/#default/item/c"+endURL;
					  $(".bpmSam").show();
				  }else{
					  $(".bpmSam").hide();
				  }
			  },
			  error: function(){

			  }
		 });

    	component.find('.eform-item-tools').hide();
        component.find('.eform-item-tools').toggle(200);

        return false;
    });

	//工具栏流程梳理事件绑定
    component.find(".bpmSam").click(function () {
    	top.layer.open({
      	    type: 2,
      	    title: 'ARIS流程',
      	    skin: 'bs-modal',
      	    area: ['85%', '90%'],
              maxmin: false,
      	    content: arisURL
      	});
    });

    //工具栏事件绑定
    if('2'==data.type){
    	component.find(".deleteComponent").click(function () {
            _this.deleteDeployed(data.id,data.pdId,data.deployId,data.key);
            return false;
        });

    	component.find(".setPermission").click(function () {
            _this.setPermission(data.deployId, data.permissionId);
            return false;
        });
        component.find(".setOrder").click(function () {
            _this.setOrder(data.deployId, data.order);
            return false;
        });
    	if(data.forbidManualStart && data.forbidManualStart == "1"){
            component.find(".forbidManualStart").remove();
            component.find(".permitManualStart").click(function () {
                _this.permitManualStart(data.deployId);
                return false;
            });
        }else{
            component.find(".permitManualStart").remove();
            component.find(".forbidManualStart").click(function () {
                _this.forbidManualStart(data.deployId);
                return false;
            });
        }
    }else{
    	component.find(".deleteComponent").click(function () {
            _this.deleteUnDeployed(data.id,data.key,data.pdId,data.deployId);
            return false;
        });
    	component.find(".deployFlow").click(function () {
	        _this.deploy(data.id);
	        return false;
	    });
    }

    component.find(".eform-item-title").click(function () {
    	_this.edit(data.id,data.type,pdId,deployId,data.name);
        return false;
    });

    //模块点击事件绑定


    $('body').click( function() {
    	component.find('.eform-item-tools').hide();
    	//component.find("[data-toggle='popover']").popover('hide');
    	$(".popover").remove();
    });

    component.find(".startComponent").click(function () {
        _this.startProcessTemplate(data.deployId);
        return false;
    });

    component.find(".suspendComponent").click(function () {
        _this.suspendedTemplate(data.deployId);
        return false;
    });

    component.find(".changeCatalog").click(function () {

        _this.changeCatalog(data.id,data.key+"-1");
        return false;
    });

    component.find(".fileCopy").click(function () {
        _this.fileCopy(data.id,data.type, data.pdId, data.deployId);
        return false;
    });
    component.find(".fileDown").click(function () {
        _this.fileDown(data.id,data.type, data.pdId, data.deployId, data.name);
        return false;
    });
    component.find(".fileUpload").click(function () {
        _this.fileUpload(data.id,data.type);
        return false;
    });

    component.find(".share").click(function () {
        _this.share(data.key);
        return false;
    });

    if('active'==data.state){
    	component.find(".startComponent").remove();
    }else if('suspended'==data.state){
    	component.find(".suspendComponent").remove();
    }

    $('#' + _this.componentDiv).append(component);
};

//添加
FlowComponent.prototype.add = function () {
	  var _this = this;
	  if (flowTypeTree.selectedNodeId == null) {
		  flowUtils.warning('请选择流程分类！');
	      return;
	  }
	  if(!flowTypeTree.selectedNodePId){
		  flowUtils.warning('根目录不能创建流程！');
	      return;
	  }
	  addDialog = layer.open({
	      type: 2,
	      title: '新建流程',
	      skin: 'bs-modal',
	      area: ['40%', '60%'],
	      maxmin: false,
	      content: "bpm/deploy/addFlowModel?selectedNodeId="+flowTypeTree.selectedNodeId
	  });

};

//编辑
FlowComponent.prototype.edit = function (eformComponentId,type,pdId,deployId,name) {
    var _this = this;
    var path = "";

    var pId = flowTypeTree.selectedNodeId;
    while(pId){
    	var node = flowTypeTree.tree.getNodeByParam("id", pId);
    	if(path == ""){
    		path = node.name
    	}else{
    		path = node.name + "-" + path;
    	}
    	pId = node.pId;
    }
    this.doEdit(eformComponentId,type,pdId,deployId,path,name);

//    $.ajax({
//        url: "bpm/deploy/getLocationById",
//        data: {id:flowTypeTree.selectedNodeId},
//        type: "post",
//        async: false,
//        dataType: "json",
//        success : function(backData) {
//        	if (backData.result == "1"){
//        		_this.doEdit(eformComponentId,type,pdId,deployId,backData.location,name);
//        	}else{
//        		_this.doEdit(eformComponentId,type,pdId,deployId,"",name);
//        	}
//		   },
//		   error:function(backData){
//			 _this.doEdit(eformComponentId,type,pdId,deployId,"",name);
//
//		   }
//    });

};
FlowComponent.prototype.doEdit=function(eformComponentId,type,pdId,deployId,location,name){
	location = encodeURI(encodeURI(location));
	var tempName = encodeURI(encodeURI(name));
	var url = "bpm/designer/index?id=" + eformComponentId+"&type="+type+"&pdId="+pdId+"&deployId="+deployId+"&location="+location+"&name="+tempName;
	flowUtils.open(url, name + "_designer");
};
//发布流程
FlowComponent.prototype.deploy = function (id) {
  var _this = this;
  flowUtils.confirm('您确定要发布该流程吗？', function (index) {
	  avicAjax.ajax({
          url: "bpm/deploy/deployFlow",
          data: "id=" + id,
          type: "post",
          dataType: "json",
          success : function(r) {
				if (null==r.error || undefined == r.error) {
					layer.msg("发布成功");
					flowTypeTree.clickNode();
				} else {
					layer.msg('发布失败！'+r.error,{
                        icon: 2,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
				}
		  }
      });
  });
};
//删除已发布流程
FlowComponent.prototype.deleteDeployed = function (eformComponentId,processDefId,deploymentId,key) {
    var _this = this;
    avicAjax.ajax({
        url: "platform/bpm/bpmPublishAction/isDeleteProcessDefinitionById",
        data: "processDefId=" + processDefId+"&deploymentId="+deploymentId+"&key="+key,
        type: "post",
        dataType: "json",
        success: function (backData) {
        	if(backData.flag == "aaa"){
        		layer.confirm('提示1：该模板为共享模板，删除操作将只会删除本组织的共享信息，其他具有共享权限的组织可以继续使用该模板；<br/>提示2：共享模板不区分版本，即同一流程的各个版本、包括未发布的模板，共享信息将一并被删除。<br/>确定继续删除？', {
        			icon : 3,
        			title : "提示",
        			area : [ '400px', '' ]
        		}, function(index) {
            		avicAjax.ajax({
           			 url : "bpm/deploy/delBpm",
           			data : {
           				id : flowTypeTree.selectedNodeId,
           				key : key
           			},
           			type : 'post',
           			dataType : 'json',
           			success : function(r) {
       					if (r.flag == "success") {
       						layer.msg("删除共享成功")
       						flowTypeTree.clickNode();
       					} else {
       						layer.alert('删除共享失败！', {
       							icon : 7,
       							area : [ '400px', '' ],
       							closeBtn : 0,
       							btn : [ '关闭' ],
       							title : "提示"
       						});
       					}
       				}
           		 });
        		})
        	}else{
        		 _this.doDelete(eformComponentId, backData);
        	}
        }
    });
};

FlowComponent.prototype.doDelete = function(eformComponentId,backData){
	var _this = this;
	if (backData != null && backData.flag == true) {
		var deploymentId = backData.deploymentId;
		flowUtils.confirm('确定要删除该流程模板吗？', function (index) {
			avicAjax.ajax({
	            url: "platform/bpm/bpmPublishAction/deleteProcessDefinitionById",
	            data: "deploymentId=" + deploymentId,
	            type: "post",
	            dataType: "json",
	            success: function (backData) {
	            	if (backData != null && backData.success == true) {
	            		 layer.msg('删除成功');
	            		 //var component = $('#' + _this.componentDiv).find("#" + eformComponentId);
		                 //component.remove();
	            		 flowTypeTree.clickNode();
	            	} else {
	            		layer.msg('删除失败');
	            	}
	            }
	        });
	    });
	} else {
		layer.msg("请先删除该流程模板的流程实例后，再删除模板！");
	}

};
//删除未发布流程
FlowComponent.prototype.deleteUnDeployed = function (eformComponentId,key,processDefId,deploymentId){
    var _this = this;
    avicAjax.ajax({
        url: "platform/bpm/bpmPublishAction/isDeleteProcessDefinitionById",
        data: "processDefId=&deploymentId=&key="+key,
        type: "post",
        dataType: "json",
        success: function (backData) {
            if(backData.flag == "aaa"){
                layer.confirm('提示1：该模板为共享模板，删除操作将只会删除本组织的共享信息，其他具有共享权限的组织可以继续使用该模板；<br/>提示2：共享模板不区分版本，即同一流程的各个版本、包括未发布的模板，共享信息将一并被删除。<br/>确定继续删除？', {
                    icon : 3,
                    title : "提示",
                    area : [ '400px', '' ]
                }, function(index) {
                    avicAjax.ajax({
                        url : "bpm/deploy/delBpm",
                        data : {
                            id : flowTypeTree.selectedNodeId,
                            key : key
                        },
                        type : 'post',
                        dataType : 'json',
                        success : function(r) {
                            if (r.flag == "success") {
                                layer.msg("删除共享成功")
                                flowTypeTree.clickNode();
                            } else {
                                layer.alert('删除共享失败！', {
                                    icon : 7,
                                    area : [ '400px', '' ],
                                    closeBtn : 0,
                                    btn : [ '关闭' ],
                                    title : "提示"
                                });
                            }
                        }
                    });
                })
            }else{
                _this.doDeleteUnDeployed(eformComponentId, key);
            }
        }
    });
};
FlowComponent.prototype.doDeleteUnDeployed = function (eformComponentId,key){
    flowUtils.confirm('确定要删除该流程模板吗？', function (index) {
        avicAjax.ajax({
            url: "bpm/deploy/delUnDeployedFlowById",
            data: "id=" + key,
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    //var component = $('#' + _this.componentDiv).find("#" + eformComponentId);
                    //component.remove();
                    flowTypeTree.clickNode();
                    layer.msg('删除成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                }
                else {
                    layer.msg('删除失败！',{
                        icon: 2,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                }
            }
        });
    });
};
//表单验证
FlowComponent.prototype.formValidate = function (form) {
    var _this = this;

    form.validate({
        rules: {
        	flowName: {
                required: true,
                maxlength: 100
            }
        }
    });
};
//关闭弹出框
FlowComponent.prototype.closeDialog = function (type) {
    if (type == "add") {
        layer.close(addDialog);
    }
    if (type == "edit") {
        layer.close(editDialog);
    }

    if(type=="changeCatalog"){
    	layer.close(changeCatalogDialog);
    }
};
//获取电子表单模块列表
FlowComponent.prototype.getComponentList = function (selectedNodeId) {
    var _this = this;

    $('#' + _this.componentDiv).empty();
    $.ajax({
        url: "bpm/deploy/getPrcessPublishByPage",
        data: "selectedNodeId=" + selectedNodeId,
        type: "post",
        async: false,
        dataType: "json",
        success: function (backData) {
            var componentList = backData.data;

            for (var i = 0; i < componentList.length; i++) {
                _this.setComponent(componentList[i]);
            }
        }
    });
};

//启用流程模板
FlowComponent.prototype.startProcessTemplate = function (deploymentId){
	var _this = this;
	flowUtils.confirm('确定要启用该流程模板吗？', function (index) {
		avicAjax.ajax({
          url: "bpm/deploy/startOrSuspendedProcessTemplate",
          data: "deploymentId=" + deploymentId+"&isFlag=1",
          type: "post",
          dataType: "json",
          success: function (backData) {
          	if (backData.result == "1") {
                  layer.msg('操作成功！',{
                      icon: 1,
                      area: ['200px', ''],
                      closeBtn: 0
                  });
                  flowTypeTree.clickNode();
              }
              else {
                  layer.msg('操作失败！',{
                      icon: 2,
                      area: ['200px', ''],
                      closeBtn: 0
                  });
              }
          }
      });
  });
};
//停用流程模板
FlowComponent.prototype.suspendedTemplate = function (deploymentId){
	var _this = this;
	flowUtils.confirm('确定要停用该流程模板吗？', function (index) {
		avicAjax.ajax({
          url: "bpm/deploy/startOrSuspendedProcessTemplate",
          data: "deploymentId=" + deploymentId+"&isFlag=0",
          type: "post",
          dataType: "json",
          success: function (backData) {
          	if (backData.result == "1") {
                  layer.msg('操作成功！',{
                      icon: 1,
                      area: ['200px', ''],
                      closeBtn: 0
                  });
                  flowTypeTree.clickNode();
              }
              else {
                  layer.msg('操作失败！',{
                      icon: 2,
                      area: ['200px', ''],
                      closeBtn: 0
                  });
              }
          }
      });
  });
};

//切换流程目录
FlowComponent.prototype.changeCatalog = function (nodeId,processDefId) {
	var _this = this;
	changeCatalogDialog = layer.open({
        type: 2,
        title: '切换目录',
        skin: 'bs-modal',
        area: ['30%', '60%'],
        maxmin: false,
        content: "avicit/platform6/bpmreform/bpmdeploy/changeCatalog.jsp?processDefId="+processDefId+"&nodeId="+nodeId
    });
};
//复制
FlowComponent.prototype.fileCopy = function(id, type, pdId, deployId) {
	var _this = this;
    if (flowTypeTree.selectedNodeId == null) {
        flowUtils.warning('请选择流程分类！');
        return;
    }
    if(!flowTypeTree.selectedNodePId){
        flowUtils.warning('根目录下不能复制流程！');
        return;
    }
	layer.prompt({
		title : '请输入新的流程名称'
	}, function(value, index, elem) {
		layer.close(index);
		avicAjax.ajax({
			url : "platform/bpm/designer/fileCopy",
			data : {
				id : id,
				type : type,
				pdId : pdId,
				deployId : deployId,
				flowName : value,
				catalogId : flowTypeTree.selectedNodeId
			},
			type : "POST",
			dataType : "JSON",
			success : function(msg) {
				if (flowUtils.notNull(msg.error)) {
					flowUtils.error(msg.error);
				} else {
					flowUtils.success("复制成功");
					flowTypeTree.clickNode();
				}
			}
		});
	});
};
FlowComponent.prototype.fileDown = function(id, type, pdId, deployId, flowName) {
	var url = "platform/bpm/designer/downJpdl?id=" + id + "&type=" + type + "&flowName=" + flowName + "&pdId=" + pdId + "&deployId=" + deployId;
	var t = new FlowDownLoad4URL('iframe', 'form', null, url);
	t.downLoad();
};

//共享到其他组织
FlowComponent.prototype.share = function(key) {
    var _this = this;
    flowUtils.confirm("提示1：共享到其他组织后，其他组织对该模板具有同等支配权；<br/>提示2：共享模板不区分版本，即同一流程的各个版本、包括未发布的模板，将一并共享出去。<br/>确定继续共享？", function(){
        _this.doShare(key);
    });
};
//共享到其他组织
FlowComponent.prototype.doShare = function(key) {
    this.index = layer.open({
        type : 2,
        title : "共享模板",
        area : ['35%', '70%'],
        content : "avicit/platform6/bpmreform/bpmdeploy/sharePage.jsp",
        btn : ['确定','返回'],
        yes :function(index){
            //先获取所选的组织目录节点是否为根节点，是根节点则不能共享
            var isRoot = window["layui-layer-iframe" + index].iscallbackdataRoot();
            if(isRoot){
                layer.msg('不能选择根目录，请重新选择节点！', {icon: 7});
                return false;
            }
            var Id = window["layui-layer-iframe" + index].callbackdata();//流程ID
            if(Id == ""){
                layer.alert('请选择要共享到的流程目录！', {
                    icon : 7,
                    area : [ '400px', '' ], //宽高
                    closeBtn : 0,
                    btn : [ '关闭' ],
                    title : "提示"
                });
                return false;
            }
            avicAjax.ajax({
                url: "bpm/deploy/saveBpm",
                data: {
                    id : Id,
                    key : key
                },
                type: "post",
                dataType: "json",
                success : function(r) {
                    if (r.flag == "success") {
                        layer.msg('操作成功！');
                        layer.close(index);
                    }else if(r.flag == "exist"){
                        layer.msg('该模板在所选组织下已经存在，不可重复共享！');
                    } else {
                        layer.alert('操作失败！' + r.error, {
                            icon : 7,
                            area : [ '400px', '' ], //宽高
                            closeBtn : 0,
                            btn : [ '关闭' ],
                            title : "提示"
                        });
                    }
                }
            });
        }
    })
};
FlowComponent.prototype.fileUpload = function(id, type) {
    if (flowTypeTree.selectedNodeId == null) {
        flowUtils.warning('请选择流程分类！');
        return;
    }
    if(!flowTypeTree.selectedNodePId){
        flowUtils.warning('根目录下不能导入流程！');
        return;
    }
	layer.open({
		type : 2,
		title: "导入流程模板",
		area : [ "500px", "260px" ],
		content : "avicit/platform6/bpmreform/bpmdeploy/importFlowModel.jsp?id="+id+"&type="+type,
		btn : [ '导入', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			iframeWin.upload(index);
		}
	});
};
FlowComponent.prototype.uploadNewFlow = function(id) {
	if (flowTypeTree.selectedNodeId == null) {
		flowUtils.warning('请选择流程分类！');
		return;
	}
	if(!flowTypeTree.selectedNodePId){
		flowUtils.warning('根目录不能导入流程！');
		return;
	}
	layer.open({
		type : 2,
		title: "导入流程模板",
		area : [ "500px", "260px" ],
		content : "avicit/platform6/bpmreform/bpmdeploy/importFlowModel.jsp?id="+flowTypeTree.selectedNodeId+"&type=",
		btn : [ '导入', '取消' ],
		yes : function(index, layero) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			iframeWin.upload(index);
		}
	});
};
//权限设置
FlowComponent.prototype.setPermission = function(deploymentId, permissionId){
	var _this = this;
	var u1 = {
			type : 'roleSelect',
			selectModel:'multi',
			callBack: function(data) {
				if(data.roleids != null){
					data.roleids = data.roleids.replaceAll(";", ",");
				}
				_this.savePermission(deploymentId,data.roleids);
			},
			beferOpen : function(){
				if(flowUtils.notNull(permissionId)){
					permissionId = permissionId.replaceAll(",", ";");
				}else{
					permissionId = "";
				}
				return {ids:permissionId};
			},
			viewScope : 'currentOrg'
	};
	new H5CommonSelect(u1);
};
//排序设置
FlowComponent.prototype.setOrder = function(deploymentId, order){
    if("null"==order){
        order = "";
    }
    layer.prompt({
        formType: 2,
        value: order,
        title: '请输入排序值'
    }, function(value, index, elem){
        if($.trim(value) == ""){
            layer.msg("请输入排序值");
            return;
        }
        if(isNaN(value)){
            layer.msg("请输入正确的排序值");
            return;
        }
        avicAjax.ajax({
            url : "bpm/deploy/setFlowModelOrder",
            data : {
                deploymentId : deploymentId,
                order : $.trim(value)
            },
            type : "POST",
            dataType : "JSON",
            success: function (backData) {
                if (backData.result == "1") {
                    layer.msg('操作成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                    flowTypeTree.clickNode();
                } else {
                    layer.msg('操作失败！',{
                        icon: 2,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                }
            }
        });
        layer.close(index);
    });
};
//权限设置
FlowComponent.prototype.savePermission = function(deploymentId,permission){
	avicAjax.ajax({
		url : "bpm/deploy/setFlowModelPermission",
		data : {
			deploymentId : deploymentId,
			permission : permission
		},
		type : "POST",
		dataType : "JSON",
		success: function (backData) {
          	if (backData.result == "1") {
                  layer.msg('操作成功！',{
                      icon: 1,
                      area: ['200px', ''],
                      closeBtn: 0
                  });
                  flowTypeTree.clickNode();
              }
              else {
                  layer.msg('操作失败！',{
                      icon: 2,
                      area: ['200px', ''],
                      closeBtn: 0
                  });
              }
          }
	});
};

//禁止手工发起流程
FlowComponent.prototype.forbidManualStart = function (deploymentId){
    var _this = this;
    flowUtils.confirm('确定要禁止手工发起流程吗？', function (index) {
        avicAjax.ajax({
            url: "bpm/deploy/forbidOrPermitManualStart",
            data: "deploymentId=" + deploymentId+"&forbidManualStart=1",
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    layer.msg('操作成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                    flowTypeTree.clickNode();
                }
                else {
                    layer.msg('操作失败！',{
                        icon: 2,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                }
            }
        });
    });
};

//允许手工发起流程
FlowComponent.prototype.permitManualStart = function (deploymentId){
    var _this = this;
    flowUtils.confirm('确定要允许手工发起流程吗？', function (index) {
        avicAjax.ajax({
            url: "bpm/deploy/forbidOrPermitManualStart",
            data: "deploymentId=" + deploymentId+"&forbidManualStart=0",
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData.result == "1") {
                    layer.msg('操作成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                    flowTypeTree.clickNode();
                }
                else {
                    layer.msg('操作失败！',{
                        icon: 2,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                }
            }
        });
    });
};


