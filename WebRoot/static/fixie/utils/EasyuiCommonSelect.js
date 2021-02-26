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
        if ($("#kads_" + kadsid).length > 0) {
            if (o == null || o) {
                layer.msg("已添加！");
            }
            return false;
        }
        if (this.selectModel != 'multi' && $(".userviewkads").length > 0) {
            if (o == null || o) {
                layer.msg("单选只允许选择一条数据！");
            }
            return false;
        }

        var temp = this.template().concat();
        for ( var i = 0; i < preamArray.length; i++) {
            temp = temp.replaceAll("#" + i + "#", preamArray[i]);
        }

        temp = temp.replaceAll("&", JSON.stringify(extendJson));

        $(this.id).append(temp);
        $(this.id).find('.thumbnail').off().on('mouseenter',function(){
            $(this).addClass("on");
        }).on('mouseleave',function(){
            $(this).removeClass("on");
        });
    };

    return this;
};


/**
 * easyui 版公共选择框
 */
function EasyuiCommonSelect(option) {
    // 用户参数
    if(option.idFieldVal == undefined){
        this.idFieldVal = $("#" + option.idFiled).val();
    }else{
        this.idFieldVal = option.idFieldVal;
    }
    this.rowIndex = option.rowIndex;
    this.viewScope = option.viewScope;//组织范围
    this.defaultOrgId = option.defaultOrgId;//默认组织id
    this.secretLevel = option.secretLevel;//密级等级
    this.type = option.type;
    this.idFiled = option.idFiled;
    this.textFiled = option.textFiled;
    this.orgIdentityFiled = option.orgIdentity;
    this.beferOpen = option.beferOpen;
    this.beferClose = option.beferClose;
    this.callBack = option.callBack;
    this.isEditorTable = option.isEditorTable;//是否为可编辑列表
    if (option.selectModel == null) {
        this.selectModel = "single";
    } else if (option.selectModel == "single") {
        this.selectModel = "single";
    } else {
        this.selectModel = "multi";
    }
    if (this.type == "userSelect") {
        this.userSelectUrl = "avicit/platform6/commonie/include/userselect.jsp";
        this.deptidFiled = option.deptidFiled;
        this.deptNameFiled = option.deptNameFiled;
        this.isShowVoid = option.isShowVoid,
            this.hidTab =  option.hidTab;
        this.defaultLoadDeptId =  option.defaultLoadDeptId;
        this.fileSecretLevel =  option.fileSecretLevel;
    } else if (this.type == "deptSelect") {
        this.isShowVoid = option.isShowVoid,
            this.defaultLoadDeptId =  option.defaultLoadDeptId;
        this.deptLevel =  option.deptLevel;
        this.deptSelectUrl = "avicit/platform6/commonie/include/deptselect.jsp";
    } else if (this.type == "positionSelect") {
        this.positionSelectUrl = "avicit/platform6/commonie/include/positionselect.jsp";
    } else if (this.type == "roleSelect") {
        this.appSelectType = option.appSelectType;
        this.roleSelectUrl = "avicit/platform6/commonie/include/rolesselect.jsp";
    } else if (this.type == "groupSelect") {
        this.appSelectType = option.appSelectType;
        this.groupSelectUrl = "avicit/platform6/commonie/include/groupselect.jsp";
    }

    this.init.call(this);
    return this;
};

EasyuiCommonSelect.prototype.init = function() {
    var _self = this;
    if (_self.type == "userSelect") {
        var selectDialog = openDialog({
            type : 'selectWindow',
            title : "请选择用户",
            url : _self.userSelectUrl,
            width : "800px",
            height : "450px",
            opentype : 2,
            shade : true,
            submit : function(index, layer) {
                var iframeWin = layer.find('iframe')[0].contentWindow;
                var user = iframeWin.getUserList();
                if(!_self.isEditorTable){//单表列表不在这里回填
                    $("#" + _self.idFiled).val(user.userids);
                    $("#" + _self.textFiled).val(user.usernames);
                    $("#" + _self.textFiled).blur();
                    $("#" + _self.deptidFiled).val(user.userdeptids);
                    $("#" + _self.orgIdentityFiled).val(user.orgIdentitys);
                    $("#" + _self.deptNameFiled).val(user.userdeptnames);
                }
                if(_self.callBack!=null && _self.callBack!='undefined'){
                    if(typeof(_self.callBack) === 'function'){
                        _self.callBack(user,_self.rowIndex);
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
                        fileSecretLevel : _self.fileSecretLevel,
                        hidTab:_self.hidTab,
                        isShowVoid:_self.isShowVoid,
                        viewScope:_self.viewScope,
                        secretLevel : _self.secretLevel,
                        defaultOrgId:_self.defaultOrgId
                    });
                }else{
                    var userdeptids = "";
                    if ($("#" + _self.deptidFiled).length > 0) {
                        userdeptids = $("#" + _self.deptidFiled).val();
                    }

                    iframeWin.init({
                        selectModel : _self.selectModel,
                        userids : _self.idFieldVal,//$("#" + _self.idFiled).val(),
                        userdeptids : userdeptids,
                        defaultLoadDeptId:_self.defaultLoadDeptId,
                        fileSecretLevel : _self.fileSecretLevel,
                        hidTab:_self.hidTab,
                        isShowVoid:_self.isShowVoid,
                        viewScope:_self.viewScope,
                        secretLevel : _self.secretLevel,
                        defaultOrgId:_self.defaultOrgId
                    });
                }
            }
        });
    } else if (_self.type == "deptSelect") {
        var selectDialog = openDialog({
            type : 'selectWindow',
            title : "请选择部门",
            url : _self.deptSelectUrl,
            width : "800px",
            height : "450px",
            opentype : 2,
            shade : true,
            submit : function(index, layer) {
                var iframeWin = layer.find('iframe')[0].contentWindow;
                var dept = iframeWin.getDeptList();
                if(!_self.isEditorTable){//单表列表不在这里回填
                    $("#" + _self.idFiled).val(dept.deptids);
                    $("#" + _self.orgIdentityFiled).val(dept.orgIdentitys);
                    $("#" + _self.textFiled).val(dept.deptnames);
                    $("#" + _self.textFiled).blur();
                }
                if(_self.callBack!=null && _self.callBack!='undefined'){
                    if(typeof(_self.callBack) === 'function'){
                        _self.callBack(dept,_self.rowIndex);
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
                        defaultOrgId:_self.defaultOrgId
                    });
                }else{
                    iframeWin.init({
                        selectModel : _self.selectModel,
                        defaultLoadDeptId: _self.defaultLoadDeptId,
                        deptLevel: _self.deptLevel,
                        deptids : _self.idFieldVal,//$("#" + _self.idFiled).val(),
                        viewScope:_self.viewScope,
                        isShowVoid:_self.isShowVoid,
                        defaultOrgId:_self.defaultOrgId
                    });
                }
            }
        });
    } else if (_self.type == "positionSelect") {
        var selectDialog = openDialog({
            type : 'selectWindow',
            title : "请选择岗位",
            url : _self.positionSelectUrl+"?rowIndex="+_self.rowIndex,
            width : "800px",
            height : "450px",
            opentype : 2,
            shade : true,
            submit : function(index, layer) {
                var iframeWin = layer.find('iframe')[0].contentWindow;
                var position = iframeWin.getPositionList();
                if(!_self.isEditorTable){//单表列表不在这里回填
                    $("#" + _self.idFiled).val(position.positionids);
                    $("#" + _self.textFiled).val(position.positionNames);
                    $("#" + _self.orgIdentityFiled).val(position.orgIdentitys);
                    $("#" + _self.textFiled).blur();
                }
                if(_self.callBack!=null && _self.callBack!='undefined'){
                    if(typeof(_self.callBack) === 'function'){
                        _self.callBack(position,_self.rowIndex);
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
                        callBack:_self.callBack,
                        viewScope:_self.viewScope,
                        defaultOrgId:_self.defaultOrgId,
                        setPropertys: function(position){
                            if(!_self.isEditorTable){//单表列表不在这里回填
                                $("#" + _self.idFiled).val(position.positionids);
                                $("#" + _self.textFiled).val(position.positionNames);
                                $("#" + _self.orgIdentityFiled).val(position.orgIdentitys);
                            }
                        }
                    });
                }else{
                    iframeWin.init({
                        selectModel : _self.selectModel,
                        positionids : _self.idFieldVal,//$("#" + _self.idFiled).val(),
                        prositionid : _self.idFiled,
                        prositionName : _self.textFiled,
                        orgIdentity: _self.orgIdentityFiled,
                        callBack:_self.callBack,
                        viewScope:_self.viewScope,
                        defaultOrgId:_self.defaultOrgId,
                        setPropertys: function(position){
                            if(!_self.isEditorTable){//单表列表不在这里回填
                                $("#" + _self.idFiled).val(position.positionids);
                                $("#" + _self.textFiled).val(position.positionNames);
                                $("#" + _self.orgIdentityFiled).val(position.orgIdentitys);
                            }
                        }
                    });
                }
            }
        });

    } else if (_self.type == "roleSelect") {
        var selectDialog = openDialog({
            type : 'selectWindow',
            title : "请选择角色",
            url : _self.roleSelectUrl+"?rowIndex="+_self.rowIndex,
            width : "800px",
            height : "450px",
            opentype : 2,
            shade : true,
            submit : function(index, layer) {
                var iframeWin = layer.find('iframe')[0].contentWindow;
                var role = iframeWin.getRoleList();
                if(!_self.isEditorTable){//单表列表不在这里回填
                    $("#" + _self.idFiled).val(role.roleids);
                    $("#" + _self.textFiled).val(role.roleNames);
                    $("#" + _self.orgIdentityFiled).val(role.orgIdentitys);
                    $("#" + _self.textFiled).blur();
                }
                if(_self.callBack!=null && _self.callBack!='undefined'){
                    if(typeof(_self.callBack) === 'function'){
                        _self.callBack(role,_self.rowIndex);
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
                        appSelectType:_self.appSelectType,
                        setPropertys: function(role){
                            if(!_self.isEditorTable){//单表列表不在这里回填
                                $("#" + _self.idFiled).val(role.roleids);
                                $("#" + _self.textFiled).val(role.roleNames);
                                $("#" + _self.orgIdentityFiled).val(role.orgIdentitys);
                            }
                        }
                    });
                }else{
                    iframeWin.init({
                        selectModel : _self.selectModel,
                        roleids : _self.idFieldVal,//$("#" + _self.idFiled).val(),
                        roleid : _self.idFiled,
                        roleName : _self.textFiled,
                        orgIdentity: _self.orgIdentityFiled,
                        callBack:_self.callBack,
                        viewScope:_self.viewScope,
                        defaultOrgId:_self.defaultOrgId,
                        appSelectType:_self.appSelectType,
                        setPropertys: function(role){
                            if(!_self.isEditorTable){//单表列表不在这里回填
                                $("#" + _self.idFiled).val(role.roleids);
                                $("#" + _self.textFiled).val(role.roleNames);
                                $("#" + _self.orgIdentityFiled).val(role.orgIdentitys);
                            }
                        }
                    });
                }
            }
        });
    } else if (_self.type == "groupSelect") {
        var selectDialog = openDialog({
            type : 'selectWindow',
            title : "请选择群组",
            url : _self.groupSelectUrl+"?rowIndex="+_self.rowIndex,
            width : "800px",
            height : "450px",
            opentype : 2,
            shade : true,
            submit : function(index, layer) {
                var iframeWin = layer.find('iframe')[0].contentWindow;
                var group = iframeWin.getGroupList();
                if(!_self.isEditorTable){//单表列表不在这里回填
                    $("#" + _self.idFiled).val(group.groupids);
                    $("#" + _self.textFiled).val(group.groupNames);
                    $("#" + _self.orgIdentityFiled).val(group.orgIdentitys);
                    $("#" + _self.textFiled).blur();
                }
                if(_self.callBack!=null && _self.callBack!='undefined'){
                    if(typeof(_self.callBack) === 'function'){
                        _self.callBack(group,_self.rowIndex);
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
                        callBack:_self.callBack,
                        viewScope:_self.viewScope,
                        defaultOrgId:_self.defaultOrgId,
                        appSelectType:_self.appSelectType,
                        setPropertys: function(group){
                            if(!_self.isEditorTable){//单表列表不在这里回填
                                $("#" + _self.idFiled).val(group.groupids);
                                $("#" + _self.textFiled).val(group.groupNames);
                                $("#" + _self.orgIdentityFiled).val(group.orgIdentitys);
                            }
                        }
                    });
                }else{
                    iframeWin.init({
                        selectModel : _self.selectModel,
                        groupids : _self.idFieldVal,//$("#" + _self.idFiled).val(),
                        groupid : _self.idFiled,
                        groupName : _self.textFiled,
                        orgIdentity: _self.orgIdentityFiled,
                        callBack:_self.callBack,
                        viewScope:_self.viewScope,
                        defaultOrgId:_self.defaultOrgId,
                        appSelectType:_self.appSelectType,
                        setPropertys: function(group){
                            if(!_self.isEditorTable){//单表列表不在这里回填
                                $("#" + _self.idFiled).val(group.groupids);
                                $("#" + _self.textFiled).val(group.groupNames);
                                $("#" + _self.orgIdentityFiled).val(group.orgIdentitys);
                            }
                        }
                    });
                }
            }
        });
    }
};

//选群组  选岗位  选角色 新增组织弹窗
function EasyuiCommonPopSelect(option) {
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
        this.url = "avicit/platform6/commonie/include/h5OrgSelect.jsp";
    } else if (this.type == "appSelect") {
        this.appSelectType = option.appSelectType;
        this.url = "avicit/platform6/commonie/include/h5AppSelect.jsp";
    }
    this.init.call(this);
    return this;
};


EasyuiCommonPopSelect.prototype.init = function() {
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