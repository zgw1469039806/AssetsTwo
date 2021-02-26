String.prototype.replaceAll = function(FindText, RepText) {
	regExp = new RegExp(FindText, "g");
	return this.replace(regExp, RepText);
};

function H5KadsView(option) {
	this.id = option.id;
	this.selectModel = option.selectModel;
	this.template = option.template;
	this.beferRemove = option.beferRemove;
	this.afertRemove = option.afertRemove;

	this.remove = function(kardsid) {
		if (this.beferRemove) {
			this.beferRemove(kardsid);
		}
		$("#kads_" + kardsid).remove();
		if (this.afertRemove) {
			this.afertRemove();
		}
	};
	
	this.removeNOEvent = function(kardsid) {
		$("#kads_" + kardsid).remove();
	};

	this.removeAll = function() {
		if (this.beferRemove) {
			this.beferRemove("all");
		}
		$(this.id).empty();
		if (this.afertRemove) {
			this.afertRemove();
		}
	};
	this.removeAllNOEvent = function() {
		$(this.id).empty();
	};
	this.getKadsSize = function() {
		return $(".userviewkads").length;
	};
	this.getDataList = function() {
		var ret = [];
		$(".userviewkads").each(function() {
			var data = $.parseJSON($(this).attr("data"));
			
			ret.push(data);
		});

		return ret;
	};
	this.getextendDataList = function() {
		var ret = [];
		$(".userviewkads").each(function() {
			var data =$(this).attr("extendData");
			ret.push(data);
		});

		return ret;
	};
	this.add = function(kadsid, preamArray,extendJson, o) {
		// if ($("#kads_" + kadsid).length > 0) {
		// 	if (o == null || o) {
		// 		layer.msg("已添加！");
		// 	}
		// 	return false;
		// }
        //新加的单选添加不用手动移除
		if (this.selectModel != 'multi' && $(".userviewkads").length > 0) {
            var selectedkadsid=$(".userviewkads")[0].attributes["id"].value;
            $("#" + selectedkadsid).remove();
		}else{
			if ($("#kads_" + kadsid).length > 0) {
				if (o == null || o) {
					layer.msg("已添加！");
				}
				return false;
			}
		}
        // if (this.selectModel != 'multi' && $(".userviewkads").length > 0) {
        // 	if (o == null || o) {
        // 		layer.msg("单选只允许选择一条数据！");
        // 	}
        // 	return false;
        // }
		var temp = this.template();
		for ( var i = 0; i < preamArray.length; i++) {
			temp = temp.replaceAll("#" + i + "#", preamArray[i]);
		}
		
		temp = temp.replaceAll("&", JSON.stringify(extendJson));

		$(this.id).append(temp);
	};

	
	this.fastAdd = function(kadsid, preamArray,temp) {
		if ($("#kads_" + kadsid).length > 0) {
			return false;
		}
		if (this.selectModel != 'multi' && $(".userviewkads").length > 0) {
			return false;
		}
		for ( var i = 0; i < preamArray.length; i++) {
			temp = temp.replaceAll("#" + i + "#", preamArray[i]);
		}
		$(this.id).append(temp);
	};
	
	return this;
};

function H5CommonSelect(option) {
	// 用户参数
	this.viewScope = option.viewScope;//组织范围
	this.defaultOrgId = option.defaultOrgId;//默认组织id
	this.defaultDept = option.defaultDept ;//部门范围
	this.secretLevel = option.secretLevel;//密级等级
	this.type = option.type;
	this.idFiled = option.idFiled;
	this.textFiled = option.textFiled;
	this.orgIdentityFiled = option.orgIdentity;
	this.beferOpen = option.beferOpen;
	this.beferClose = option.beferClose;
	this.callBack = option.callBack;
	this.numLimit = 200;//关键字查询用户数限制
	if (option.selectModel == null) {
		this.selectModel = "single";
	} else if (option.selectModel == "single") {
		this.selectModel = "single";
	} else {
		this.selectModel = "multi";
	}
	if (this.type == "userSelect") {
		this.userSelectUrl = "avicit/platform6/h5component/common/userselect.jsp";
		this.deptidFiled = option.deptidFiled;
		this.deptNameFiled = option.deptNameFiled;
		this.isShowVoid = option.isShowVoid,
		this.hidTab =  option.hidTab;
		this.defaultLoadDeptId =  option.defaultLoadDeptId;
		this.defaultLoadGroupId =  option.defaultLoadGroupId;
		this.defaultLoadRoleId =  option.defaultLoadRoleId;
		this.defaultLoadPositionId =  option.defaultLoadPositionId;
		this.numLimit =  option.numLimit;
	} else if (this.type == "deptSelect") {
		this.isShowVoid = option.isShowVoid,
		this.defaultLoadDeptId =  option.defaultLoadDeptId;
		this.deptLevel =  option.deptLevel;
		this.deptSelectUrl = "avicit/platform6/h5component/common/deptselect.jsp";
	} else if (this.type == "positionSelect") {
		this.positionSelectUrl = "avicit/platform6/h5component/common/positionselect.jsp";
        this.defaultLoadPositionId =  option.defaultLoadPositionId;
	} else if (this.type == "roleSelect") {
		this.appSelectType = option.appSelectType;
		this.roleSelectUrl = "avicit/platform6/h5component/common/rolesselect.jsp";
        this.defaultLoadRoleId =  option.defaultLoadRoleId;
	} else if (this.type == "groupSelect") {
		this.appSelectType = option.appSelectType;
		this.groupSelectUrl = "avicit/platform6/h5component/common/groupselect.jsp";
        this.defaultLoadGroupId =  option.defaultLoadGroupId;
	} else if(this.type == "orgSelect"){
	    this.orgSelectUrl = "avicit/platform6/h5component/common/orgselect.jsp";
        this.defaultLoadOrgId =  option.defaultLoadOrgId;
	}

	this.init.call(this);
	return this;
};

H5CommonSelect.prototype.init = function() {
	var _self = this;
	if (_self.type == "userSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择用户",
			url : _self.userSelectUrl,
			width : "720px",
			height : "460px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var user = iframeWin.getUserList();
				$("#" + _self.idFiled).val(user.userids);
				$("#" + _self.textFiled).val(user.usernames);
				$("#" + _self.textFiled).blur();
				$("#" + _self.deptidFiled).val(user.userdeptids);
				$("#" + _self.orgIdentityFiled).val(user.orgIdentitys);
				$("#" + _self.deptNameFiled).val(user.userdeptnames);
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(user);
			 		}
				}
			},
			beferClose: function(index, layer){
				if(typeof(_self.beferClose) === 'function'){
		 			_self.beferClose(index, layer);
		 		}
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				if(typeof(_self.beferOpen) === 'function'){
					var initdata = _self.beferOpen();
					iframeWin.init({
						selectModel : _self.selectModel,
						userids : initdata.ids,
						userdeptids : initdata.deptids,
						defaultLoadDeptId:_self.defaultLoadDeptId,
						defaultLoadGroupId:_self.defaultLoadGroupId,
						defaultLoadRoleId:_self.defaultLoadRoleId,
						defaultLoadPositionId:_self.defaultLoadPositionId,
						hidTab:_self.hidTab,
						isShowVoid:_self.isShowVoid,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
						defaultDept : _self.defaultDept,
						secretLevel : _self.secretLevel,
						numLimit : _self.numLimit,
						setPropertys: function(user){
							$("#" + _self.idFiled).val(user.userids);
							$("#" + _self.textFiled).val(user.usernames);
							_self.orgIdentityFiled && $("#" + _self.orgIdentityFiled).val(user.orgIdentitys);
							_self.deptidFiled && $("#" + _self.deptidFiled).val(user.userdeptids);
							_self.deptNameFiled && $("#" + _self.deptNameFiled).val(user.userdeptnames);
							$("#" + _self.textFiled).blur();
						}
					});
				}else{
					var userdeptids = "";
					if ($("#" + _self.deptidFiled).length > 0) {
						userdeptids = $("#" + _self.deptidFiled).val();
					}
					
					iframeWin.init({
						selectModel : _self.selectModel,
						userids : $("#" + _self.idFiled).val(),
						userdeptids : userdeptids,
						defaultLoadDeptId:_self.defaultLoadDeptId,
						defaultLoadGroupId:_self.defaultLoadGroupId,
						defaultLoadRoleId:_self.defaultLoadRoleId,
						defaultLoadPositionId:_self.defaultLoadPositionId,
						hidTab:_self.hidTab,
						isShowVoid:_self.isShowVoid,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
						defaultDept : _self.defaultDept,
						secretLevel : _self.secretLevel,
						numLimit : _self.numLimit,
						setPropertys: function(user){
							$("#" + _self.idFiled).val(user.userids);
							$("#" + _self.textFiled).val(user.usernames);
							_self.orgIdentityFiled && $("#" + _self.orgIdentityFiled).val(user.orgIdentitys);
							_self.deptidFiled && $("#" + _self.deptidFiled).val(user.userdeptids);
							_self.deptNameFiled && $("#" + _self.deptNameFiled).val(user.userdeptnames);
							$("#" + _self.textFiled).blur();
						}
					});
				}
			}
		});
	} else if (_self.type == "deptSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择部门",
			url : _self.deptSelectUrl,
            width : "720px",
            height : "460px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var dept = iframeWin.getDeptList();
				$("#" + _self.idFiled).val(dept.deptids);
				$("#" + _self.orgIdentityFiled).val(dept.orgIdentitys);
				$("#" + _self.textFiled).val(dept.deptnames);
				$("#" + _self.textFiled).blur();
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(dept);
			 		}
				}
			},
			beferClose: function(index, layer){
				if(typeof(_self.beferClose) === 'function'){
		 			_self.beferClose(index, layer);
		 		}
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				if(typeof(_self.beferOpen) === 'function'){
					var initdata = _self.beferOpen();
					iframeWin.init({
						selectModel : _self.selectModel,
						defaultLoadDeptId: _self.defaultLoadDeptId,
						deptLevel: _self.deptLevel,
						deptids : initdata.ids,
						viewScope:_self.viewScope,
						isShowVoid:_self.isShowVoid,
						defaultOrgId:_self.defaultOrgId,
						setPropertys: function(dept){
							$("#" + _self.idFiled).val(dept.deptids);
							$("#" + _self.textFiled).val(dept.deptnames);
							_self.orgIdentityFiled && $("#" + _self.orgIdentityFiled).val(dept.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}else{
					iframeWin.init({
						selectModel : _self.selectModel,
						defaultLoadDeptId: _self.defaultLoadDeptId,
						deptLevel: _self.deptLevel,
						deptids : $("#" + _self.idFiled).val(),
						viewScope:_self.viewScope,
						isShowVoid:_self.isShowVoid,
						defaultOrgId:_self.defaultOrgId,
						setPropertys: function(dept){
							$("#" + _self.idFiled).val(dept.deptids);
							$("#" + _self.textFiled).val(dept.deptnames);
							_self.orgIdentityFiled && $("#" + _self.orgIdentityFiled).val(dept.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}
			}
		});
	 } else if (_self.type == "orgSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择组织",
			url : _self.orgSelectUrl,
			width : "720px",
			height : "460px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var org = iframeWin.getOrgList();
				$("#" + _self.idFiled).val(org.orgids);
				$("#" + _self.orgIdentityFiled).val(org.orgIdentitys);
				$("#" + _self.textFiled).val(org.orgnames);
				$("#" + _self.textFiled).blur();
				$("#" + _self.idFiled).change();
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(org);
			 		}
				}
			},
			beferClose: function(index, layer){
				if(typeof(_self.beferClose) === 'function'){
		 			_self.beferClose(index, layer);
		 		}
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				if(typeof(_self.beferOpen) === 'function'){
					var initdata = _self.beferOpen();
					iframeWin.init({
						selectModel : _self.selectModel,
						orgids : initdata.ids,
						viewScope:_self.viewScope,
                        defaultLoadOrgId:_self.defaultLoadOrgId,
						defaultOrgId:_self.defaultOrgId,
						setPropertys: function(org){
							$("#" + _self.idFiled).val(org.orgids);
							$("#" + _self.textFiled).val(org.orgnames);
							_self.orgIdentityFiled && $("#" + _self.orgIdentityFiled).val(org.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}else{
					iframeWin.init({
						selectModel : _self.selectModel,
						orgids : $("#" + _self.idFiled).val(),
						viewScope:_self.viewScope,
                        defaultLoadOrgId:_self.defaultLoadOrgId,
						defaultOrgId:_self.defaultOrgId,
						setPropertys: function(org){
							$("#" + _self.idFiled).val(org.orgids);
							$("#" + _self.textFiled).val(org.orgnames);
							_self.orgIdentityFiled && $("#" + _self.orgIdentityFiled).val(org.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}
			}
		});
	} else if (_self.type == "positionSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择岗位",
			url : _self.positionSelectUrl,
			width : "720px",
			height : "460px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var position = iframeWin.getPositionList();
				$("#" + _self.idFiled).val(position.positionids);
				$("#" + _self.textFiled).val(position.positionNames);
				$("#" + _self.orgIdentityFiled).val(position.orgIdentitys);
				$("#" + _self.textFiled).blur();
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(position);
			 		}
				}
			},
			beferClose: function(index, layer){
				if(typeof(_self.beferClose) === 'function'){
		 			_self.beferClose(index, layer);
		 		}
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				if(typeof(_self.beferOpen) === 'function'){
					var initdata = _self.beferOpen();
					iframeWin.init({
						selectModel : _self.selectModel,
						positionids : initdata.ids,
						prositionid : _self.idFiled,
						prositionName : _self.textFiled,
						orgIdentity: _self.orgIdentityFiled,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
                        defaultLoadPositionId:_self.defaultLoadPositionId,
						setPropertys: function(position){
							$("#" + _self.idFiled).val(position.positionids);
							$("#" + _self.textFiled).val(position.positionNames);
							$("#" + _self.orgIdentityFiled).val(position.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}else{
					iframeWin.init({
						selectModel : _self.selectModel,
						positionids : $("#" + _self.idFiled).val(),
						prositionid : _self.idFiled,
						prositionName : _self.textFiled,
						orgIdentity: _self.orgIdentityFiled,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
                        defaultLoadPositionId:_self.defaultLoadPositionId,
						setPropertys: function(position){
							$("#" + _self.idFiled).val(position.positionids);
							$("#" + _self.textFiled).val(position.positionNames);
							$("#" + _self.orgIdentityFiled).val(position.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}
			}
		});

	} else if (_self.type == "roleSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择角色",
			url : _self.roleSelectUrl,
			width : "720px",
			height : "460px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var role = iframeWin.getRoleList();
				$("#" + _self.idFiled).val(role.roleids);
				$("#" + _self.textFiled).val(role.roleNames);
				$("#" + _self.orgIdentityFiled).val(role.orgIdentitys);
				$("#" + _self.textFiled).blur();
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(role);
			 		}
				}
			},
			beferClose: function(index, layer){
				if(typeof(_self.beferClose) === 'function'){
		 			_self.beferClose(index, layer);
		 		}
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				if(typeof(_self.beferOpen) === 'function'){
					var initdata = _self.beferOpen();
					iframeWin.init({
						selectModel : _self.selectModel,
						roleids : initdata.ids,
						roleid : _self.idFiled,
						roleName : _self.textFiled,
						orgIdentity: _self.orgIdentityFiled,
						callBack:_self.callBack,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
                        defaultLoadRoleId: _self.defaultLoadRoleId,
						appSelectType:_self.appSelectType,
						setPropertys: function(role){
							$("#" + _self.idFiled).val(role.roleids);
							$("#" + _self.textFiled).val(role.roleNames);
							$("#" + _self.orgIdentityFiled).val(role.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}else{
					iframeWin.init({
						selectModel : _self.selectModel,
						roleids : $("#" + _self.idFiled).val(),
						roleid : _self.idFiled,
						roleName : _self.textFiled,
						orgIdentity: _self.orgIdentityFiled,
						callBack:_self.callBack,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
                        defaultLoadRoleId: _self.defaultLoadRoleId,
						appSelectType:_self.appSelectType,
						setPropertys: function(role){
							$("#" + _self.idFiled).val(role.roleids);
							$("#" + _self.textFiled).val(role.roleNames);
							$("#" + _self.orgIdentityFiled).val(role.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}
			}
		});
	} else if (_self.type == "groupSelect") {
		var selectDialog = openDialog({
			type : 'selectWindow',
			title : "请选择群组",
			url : _self.groupSelectUrl,
			width : "720px",
			height : "460px",
			opentype : 2,
			shade : true,
			submit : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				var group = iframeWin.getGroupList();
				$("#" + _self.idFiled).val(group.groupids);
				$("#" + _self.textFiled).val(group.groupNames);
				$("#" + _self.orgIdentityFiled).val(group.orgIdentitys);
				$("#" + _self.textFiled).blur();
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(group);
			 		}
				}
			},
			beferClose: function(index, layer){
				if(typeof(_self.beferClose) === 'function'){
		 			_self.beferClose(index, layer);
		 		}
			},
			init : function(index, layer) {
				var iframeWin = layer.find('iframe')[0].contentWindow;
				if(typeof(_self.beferOpen) === 'function'){
					var initdata = _self.beferOpen();
					iframeWin.init({
						selectModel : _self.selectModel,
						groupids : initdata.ids,
						groupid : _self.idFiled,
						groupName : _self.textFiled,
						orgIdentity: _self.orgIdentityFiled,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
                        defaultLoadGroupId: _self.defaultLoadGroupId,
						appSelectType:_self.appSelectType,
						setPropertys: function(group){
							$("#" + _self.idFiled).val(group.groupids);
							$("#" + _self.textFiled).val(group.groupNames);
							$("#" + _self.orgIdentityFiled).val(group.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}else{
					iframeWin.init({
						selectModel : _self.selectModel,
						groupids : $("#" + _self.idFiled).val(),
						groupid : _self.idFiled,
						groupName : _self.textFiled,
						orgIdentity: _self.orgIdentityFiled,
						viewScope:_self.viewScope,
						defaultOrgId:_self.defaultOrgId,
                        defaultLoadGroupId: _self.defaultLoadGroupId,
						appSelectType:_self.appSelectType,
						setPropertys: function(group){
							$("#" + _self.idFiled).val(group.groupids);
							$("#" + _self.textFiled).val(group.groupNames);
							$("#" + _self.orgIdentityFiled).val(group.orgIdentitys);
							$("#" + _self.textFiled).blur();
						}
					});
				}
			}
		});
	}
};

function H5PopupSelect(option) {
	this.type = option.type;
	this.idFiled = option.idFiled;
	this.textFiled = option.textFiled;
	this.divid = option.divid;
	this.callBack = option.callBack;
	if (option.selectModel == null) {
		this.selectModel = "single";
	} else if (option.selectModel == "single") {
		this.selectModel = "single";
	} else {
		this.selectModel = "multi";
	}
	this.url = option.url;
	this.init.call(this);
	return this;
};

H5PopupSelect.prototype.init = function() {
	var _self = this;
	var contentWidth = $("#"+_self.divid).width();
	var top =  $("#"+_self.divid).offset().top + $("#"+_self.divid).outerHeight(true);
	var left = $("#"+_self.divid).offset().left + $("#"+_self.divid).outerWidth() - contentWidth;
	var width = $("#"+_self.divid).innerWidth();
	layer.config({
		  extend: 'skin/layer-bootstrap.css'
	});
	if(_self.selectModel == "single"){
		lay_select_icon = layer.open({
			type: 2,
			shift: 5,
			title: false,
			scrollbar: false,
			move : false,
			area: [contentWidth + 'px', '200px'],
			offset: [top + 'px', left + 'px'],
			closeBtn: 0,
			shade: 0.1,
			shadeClose:true,
			content: _self.url,
			success : function(layero, index) {
				var iframeWin = layero.find('iframe')[0].contentWindow;
				iframeWin.init({
					selectModel : _self.selectModel,
					ids : $("#" + _self.idFiled).val(),
					idFiled :_self.idFiled,
					textFiled :_self.textFiled,
					callBack :_self.callBack,
					setPropertys: function(position){
						$("#" + _self.idFiled).val(position.positionids);
						$("#" + _self.textFiled).val(position.positionNames);
					}
				});
			}
		});
	}else{
		lay_select_icon = layer.open({
			type: 2,
			shift: 5,
			title: false,
			scrollbar: false,
			move : false,
			area: [contentWidth + 'px', '200px'],
			offset: [top + 'px', left + 'px'],
			closeBtn: 0,
			shade: 0.1,
			shadeClose:true,
			btn: ['确认'],
			content: _self.url,
			success : function(layero, index) {
				var iframeWin = layero.find('iframe')[0].contentWindow;
				iframeWin.init({
					selectModel : _self.selectModel,
					ids : $("#" + _self.idFiled).val(),
					idFiled :_self.idFiled,
					textFiled :_self.textFiled,
					callBack :_self.callBack
				});
			},yes: function(index, layero){
				var data = iframeWin.getSelect();
				if(_self.callBack!=null && _self.callBack!='undefined'){
					if(typeof(_self.callBack) === 'function'){
			 			_self.callBack(data);
			 		}
				}
				$("#"+_self.idFiled).val(data.ids);
				$("#"+_self.textFiled).val(data.texts);
				$("#"+_self.textFiled).blur();
				layer.close(index);
			}
		});
	}	
};
//选群组  选岗位  选角色 新增组织弹窗
function H5CommonPopSelect(option) {
	// 用户参数

	this.type = option.type;
	this.idFiled = option.idFiled;
	this.textFiled = option.textFiled;
	this.divid = option.divid;
	this.callBack = option.callBack;
	this.contentWidth = option.contentWidth;
	this.contentHeight = option.contentHeight;
	this.placeStyle = option.placeStyle;

	if (this.type == "orgSelect") {
		this.viewScope = option.viewScope;//组织范围
		this.defaultOrgId = option.defaultOrgId;//默认组织id
		this.url = "avicit/platform6/h5component/common/h5OrgSelect.jsp";
	} else if (this.type == "appSelect") {
		this.appSelectType = option.appSelectType;
		this.url = "avicit/platform6/h5component/common/h5AppSelect.jsp";
	}
	this.init.call(this);
	return this;
};


H5CommonPopSelect.prototype.init = function() {
	var _self = this;
	var contentWidth = _self.contentWidth;
	var top =  $("#"+_self.divid).offset().top + $("#"+_self.divid).outerHeight(true);
	var left;
	if(_self.placeStyle == "left"){
		left = $("#"+_self.divid).offset().left;
	}else if(_self.placeStyle == "right"){
		left = $("#"+_self.divid).offset().left + $("#"+_self.divid).outerWidth() - contentWidth;
	}else{
		left = $("#"+_self.divid).offset().left;
	}
	
	layer.config({
		  extend: 'skin/layer-bootstrap.css'
	});

	lay_select_icon = layer.open({
		type: 2,
		shift: 5,
		title: false,
		scrollbar: false,
		move : false,
		area: [_self.contentWidth + 'px', _self.contentHeight+'px'],
		offset: [top + 'px', left + 'px'],
		closeBtn: 0,
		shade: 0.1,
		shadeClose:true,
		content: _self.url,
		success : function(layero, index) {
			var iframeWin = layero.find('iframe')[0].contentWindow;
			if (_self.type == "orgSelect") {
				iframeWin.init({
					viewScope:_self.viewScope,
					defaultOrgId:_self.defaultOrgId,
					setSelectedInfo : function(data){
						if(_self.callBack!=null && _self.callBack!='undefined'){
							if(typeof(_self.callBack) === 'function'){
					 			_self.callBack(data);
					 		}
						}
						$("#"+_self.idFiled).val(data.id);
						$("#"+_self.textFiled).val(data.text);
						layer.close(lay_select_icon);
					}
				});
			} else if (_self.type == "appSelect") {
				iframeWin.init({
					idFiled :_self.idFiled,
					textFiled :_self.textFiled,
					setSelectedInfo : function(data){
						if(_self.callBack!=null && _self.callBack!='undefined'){
							if(typeof(_self.callBack) === 'function'){
					 			_self.callBack(data);
					 		}
						}
						$("#"+_self.idFiled).val(data.id);
						$("#"+_self.textFiled).val(data.text);
						layer.close(lay_select_icon);
					},
					appSelectType:_self.appSelectType
				});
			}
		}
	});
};