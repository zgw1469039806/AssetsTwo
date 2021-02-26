

function ViewDesignPage(){
	this.save = function(publish){
		_this = this;
		var xml = engine.ConvertToXML();
		if (xml == false){
			return false;
		}
        if (!engine.doValidate()){
            return false;
        }
		var html = viewEditor.getLayoutHtml();
		if (xml == null || xml ==""){
			top.layer.alert('保存失败！请确保组件设计的完整性', {
            					icon: 2,
            					area: ['400px', ''],
            					closeBtn: 0
            				});
			return false;
		}

		if (html == null || html ==""){
			top.layer.alert('保存失败！请确保布局设计的完整性', {
            					icon: 2,
            					area: ['400px', ''],
            					closeBtn: 0
            				});
			return false;
		}
		var confirmMsg = "";
		if (publish == "1"){
			confirmMsg = "确定要更新并发布当前视图吗？";
		}else if (publish == "2"){
			confirmMsg = "确定要保存为新版本吗？";
		}else{
			confirmMsg = "确定要更新当前视图吗？";
		}
		layer.confirm(confirmMsg,
			{
				icon: 3,
				title: '提示',
				area: ['400px', ''],
				closeBtn: 0
			},
			function (index) {
				layer.close(index);
				var saveUrl = "";
				if (publish == "2"){
					saveUrl = './eform/eformViewInfoController/saveNewVersion/' + viewId +"/"+viewCode;
				}else {
					saveUrl = './eform/eformViewInfoController/saveXml/' + viewId +"/"+version;
				}
				avicAjax.ajax({
					url: saveUrl,
					contentType: "application/xml; charset=utf-8",
					data:  xml   + "#!#@#textsplit#!#@#" +  html   + "#!#@#textsplit#!#@#" +  viewJs   + "#!#@#textsplit#!#@#" +  viewCss,
					type : 'post',
					dataType : 'json',
					async:true,
					success : function(r){
						if (r.flag == "success") {
							if(publish == "2"){
								//layer.msg('保存新版本成功！', {icon: 1});
								version = r.newVersion;
								_this.dopublish(viewId,r.menuId,'保存新版本成功！');
							}else if(publish == "1"){
								_this.publish(viewId,viewName,viewCode,viewStyle);
							}else{
								layer.msg('操作成功！', {icon: 1});
							}
						}else{
							top.layer.alert('保存失败！'+r.error, {
								title: '提示',
								icon: 2,
								area: ['400px', ''],
								closeBtn: 0
							});
						}
					}
				});
			}
		);
	};




    /**
     * 应用JS文件
     */
    this.applyJs = function () {
        var _this = this;
        layer.open({
            type: 2,
            title: 'JS文件扩展',
            skin: 'bs-modal',
            area: ['50%', '50%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsviewdesign/applyJs.jsp"
        });
    };

    /**
     * 应用CSS文件
     */
    this.applyCss= function () {
        var _this = this;
        layer.open({
            type: 2,
            title: 'CSS文件扩展',
            skin: 'bs-modal',
            area: ['50%', '50%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsviewdesign/applyCss.jsp"
        });
    };

    this.view = function(){
        if (!engine.doValidate()){
            return false;
        }
		var xml = engine.ConvertToXML();
		if (xml == false){
			return false;
		}
		var html = viewEditor.getLayoutHtml();
		if (xml == null || xml ==""){
			top.layer.alert('请确保组件设计的完整性！', {
				icon: 2,
				area: ['400px', ''],
				closeBtn: 0
			});
			return false;
		}

		if (html == null || html ==""){
			top.layer.alert('请确保布局设计的完整性！', {
				icon: 2,
				area: ['400px', ''],
				closeBtn: 0
			});
			return false;
		}
		avicAjax.ajax({
			url: './eform/eformViewInfoController/saveXml/' + viewId +"/"+version,
			contentType: "application/xml; charset=utf-8",
			data:  xml   + "#!#@#textsplit#!#@#" +  html   + "#!#@#textsplit#!#@#" +  viewJs   + "#!#@#textsplit#!#@#" +  viewCss,
			type : 'post',
			dataType : 'json',
			async:true,
			success : function(r){
				if (r.flag == "success") {
					var dialog = layer.open({
						type: 2,
						title: '预览视图',
						skin: 'bs-modal',
						area: ['100%', '100%'],
						maxmin: false,
						content: "avicit/platform6/eform/bpmsviewdesign/designView.jsp?id=" + viewId
					});
				}else{
					top.layer.alert('保存失败！'+r.error, {
						title: '提示',
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0
					});
				}
			}
		});

	};


    /**
     * 视图帮助
     */
    this.helpDoc = function () {
        var helpDocDialog = layer.open({
            type: 2,
            title: '视图帮助',
            skin: 'bs-modal',
            area: ['70%', '80%'],
            maxmin: false,
            content: "avicit/platform6/eform/bpmsviewdesign/help.jsp"
        });
    };
	
	this.saveAndPublish = function(id,viewName,viewCode,viewStyle){
        if (!engine.doValidate()){
            return false;
        }
		if (this.save('1') == false){
			return false;
		}
		//this.publish(id,viewName,viewCode,viewStyle);
	};
	
	this.publish = function (id,viewName,viewCode,viewStyle){
		_this = this;
		publishDialog = top.layer.open({
            type: 2,
            title: '快速发布',
            skin: 'bs-modal',
            area: ['50%', '50%'],
            maxmin: false,
            content: "platform/eform/eformViewInfoController/publishViewMenu?id=" + id + "&viewName=" + encodeURIComponent(viewName) + "&viewCode=" + viewCode + "&type=both",
            btn: ['确定', '取消'],
            yes: function(index, layero){
            	var iframeWin = layero.find('iframe')[0].contentWindow;
                var publicType = iframeWin.getPublicType();
                if("1"==publicType) {
                    var arg = {
                        parentId: iframeWin.getSelectMenu(),
                        menuName: iframeWin.getViewName(),
                        menuCode: iframeWin.getViewCode(),
                        menuUrl: iframeWin.getUrl(),
                        openType: iframeWin.getOpenType(),
                        menuView: "avicit/eformmodule/view/" + viewCode + "/"+version+"/" + viewStyle + "/view.jsp",
                        menuOrder: "1",
                        menuStatus: "1",
                        isShow: "0"
                    };
                    var currentApplicationAndOrg = iframeWin.getCurrentApplicationAndOrg();
                    avicAjax.ajax({
                        url: "console/menu/console/" + currentApplicationAndOrg + "/save/insert",
                        data: {data: JSON.stringify(arg)},
                        type: 'post',
                        dataType: 'json',
                        success: function (msg) {
                            if (msg.flag == "success") {
                                top.layer.close(index);
                                _this.dopublish(id, msg.id, "发布成功！");
                            } else {
                                top.layer.alert('发布失败！' + msg.e, {
                                    icon: 2,
                                    area: ['400px', ''],
                                    closeBtn: 0
                                });
                            }
//            			top.layer.msg("发布成功！");
//            			setViewInfo
                        }
                    });
                }else{
                    top.layer.close(index);
                    _this.dopublish(id, "", "发布成功！");
				}
            	
            },
            no: function(index, layero){
            	layero.close(index);
            }
        });
	};

	this.dopublish = function(viewid,menuid,msg){

		avicAjax.ajax({
			url : "platform/eform/eformViewInfoController/publishViewInfo?id="+viewid+"&menuid="+menuid+"&version="+version,
			dataType : "JSON",
			type : "GET",
			success : function(r) {
				if (r.flag=="success"){
					// var viewInfo = window.opener.$('#' + window.opener.eformFormView.formViewDiv).find("#" + viewid);
					// viewInfo.remove();
					// window.opener.eformFormView.setViewInfo(r.data);
                    window.opener.eformComponent.clickTitle(window.opener.eformComponent.selectedEformComponentId);
					// if (window.opener.eformFormViewModel!=null && typeof(window.opener.eformFormViewModel)!="undefined")
					// 	window.opener.eformFormViewModel.reLoad(window.opener.eformComponent.selectedEformComponentId);
                    if(menuid==''){
                        top.layer.alert(msg+'菜单配置被修改过，请自行变更菜单',{
                            icon: 1,
                            area: ['200px', ''],
                            closeBtn: 0
                        }, function(index){
                            window.close();
                            layer.close(index);
                        });
                    }else{
                        top.layer.msg(msg, {icon: 1});
                        setTimeout(function () {
                            window.close();
                        }, 1000);
					}
				}else{
					layer.alert('发布失败！' + r.error, {
						icon: 2,
						area: ['400px', ''],
						closeBtn: 0
					});
				}
			},
			error : function(msg){
				layer.msg("发布失败！",{icon: 2});
			}
		});
	};
	
	this.open = function(){
		
	};

	this.saveNewVersion = function () {
		_this = this;
		_this.save("2");
	};
}