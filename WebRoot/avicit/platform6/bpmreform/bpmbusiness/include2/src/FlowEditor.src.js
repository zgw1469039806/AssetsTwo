/**
 * 流程操作
 */
function FlowEditor(defaultForm) {
    this.simulation = _bpm_simulation;
    this.flowModel = new FlowModel(_bpm_defineId, _bpm_deploymentId, _bpm_entryId, _bpm_executionId, _bpm_taskId);
    this.defaultForm = defaultForm;
    this.defaultForm.flowEditor = this;
    this.flowForm = new FlowForm(this);
    //流程意见扩展，使用名称FlowIdeaBySelf的function
    if(typeof FlowIdeaBySelf == "function"){
        this.flowIdea = eval("new FlowIdeaBySelf(this)");
    }else{
        this.flowIdea = new FlowIdea(this);
    }
    _flow_editor = this;
    return this;
};
FlowEditor.prototype.setFlowIdea = function(flowIdea){
    this.flowIdea = flowIdea;
};
FlowEditor.prototype.init = function(){
    // 初始化参数
    if (flowUtils.notNull(_bpm_defineId)) {
        this.isStart = true;
        this.isStartPage = true;
        this.flowModel.setActivityname(_bpm_firstTaskName);
        this.flowModel.setActivitylabel(_bpm_firstTaskAlias);
        this.flowModel.setUserIdentityKey("6");
        this.flowModel.setUserIdentity("拟稿人");
        // 权限按钮
        this.createButtons();
    } else if (flowUtils.notNull(_bpm_entryId, _bpm_executionId, _bpm_taskId, _bpm_formId)) {
        this.defaultForm.setId(_bpm_formId);

        //当检查到checkUserSecretLevel方法返回true，或存在checkUserSecretLevel的全局变量为true时，执行密级校验
        //管理员也需要符合密级要求
        if(this.defaultForm.checkUserSecretLevel()){
            var that = this;
            avicAjax.ajax({
                type : "POST",
                data : {
                    processInstanceId: _bpm_entryId,
                    secretLevelCode: that.defaultForm.secretLevelCode()
                },
                url : "platform/bpm/clientbpmdisplayaction/isUserSecretLevel",
                dataType : "json",
                success : function(r) {
                    var b = r.result;
                    if (b) {
                        that.defaultForm.initFormData();
                        that.flowModel.defineId = that.getDefineIdByEntryId(_bpm_entryId);
                        // 权限按钮
                        that.createButtons();
                    } else {
                        that.hideBody();
                        flowUtils.error("人员密级不符合要求", function () {
                            flowUtils.closeWindowOnDialog();
                        });
                        return false;
                    }
                }
            });
        }else {
            this.defaultForm.initFormData();
            this.flowModel.defineId = this.getDefineIdByEntryId(_bpm_entryId);
            // 权限按钮
            this.createButtons();
        }
    } else {
        this.hideBody();
        flowUtils.error("流程参数错误！无法初始化权限按钮！您可能是通过非法的途径进入了当前页面，例如重复刷新页面，拷贝链接到浏览器地址栏等操作。点击确定关闭表单", function () {
            flowUtils.closeWindowOnDialog();
        });
        return false;
    }
    var title = flowUtils.getUrlQuery("title");
    if (flowUtils.notNull(title)) {
        document.title = unescape(title);
    }
};
/**
 * 表单对象
 */
FlowEditor.prototype.defaultForm = null;
/**
 * 数据模板
 */
FlowEditor.prototype.flowModel = null;
/**
 * 是否新建
 */
FlowEditor.prototype.isStart = false;
/**
 * 是否是发起页面
 * @type {boolean}
 */
FlowEditor.prototype.isStartPage = false;
/**
 * 是否是模拟状态
 */
FlowEditor.prototype.simulation = "0";
/**
 * 自定义的加载后事件是否已经执行
 */
FlowEditor.prototype.afterInit = false;
/**
 * 隐藏页面，关闭页面
 */
FlowEditor.prototype.hideBody = function () {
    this.hideButtons();
    $("#main").hide();
};
/**
 * 隐藏按钮
 */
FlowEditor.prototype.hideButtons = function () {
    $(".bpmhide").hide();
    $(".bpmhide").removeClass("but_lead");
};
/**
 * 显示按钮
 */
FlowEditor.prototype.showButtons = function (domId) {
    /*if(this.leadButCodeList.indexOf(domId) != -1 &&  !$("#" + domId).hasClass("sub-list-li")){
        $("#" + domId).addClass("but_lead");
    }
    if($("#" + domId).hasClass("sub-list-li")){
        $(".more-list").show();
    }
    $("#" + domId).show();*/
    if(this.leadButCodeList.indexOf(domId) != -1){
        $("#" + domId).addClass("but_lead");
    }
    $("#" + domId).show();
};

/**
 * 引导按钮
 * @type {Array}
 */
FlowEditor.prototype.leadButCodeList = [];
/**
 * 权限按钮重置
 */
FlowEditor.prototype.createButtons = function (flg, outcome) {
    var _self = this;
    this.leadButCodeList = this.defaultForm.getLeadButCodeList();
    // 隐藏所有按钮
    this.hideButtons();
    if (this.simulation == "1") {
        //模拟状态
        this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
        // 默认保存
        this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
        // 帮助
        this.bpmButHelp = new BpmButHelp(this, this.defaultForm, new Object());
        //引用文档
        this.bpmButFile = new BpmButFile(this, this.defaultForm, new Object());
        //流程跟踪
        this.bpmButTrack = new BpmButTrack(this, this.defaultForm, new Object());

        this.bpmSubmit.execute = function () {
            flowUtils.success("模拟提交");
        };

        this.bpmSave.execute = function () {
            flowUtils.success("模拟保存");
        };

        this.setRoles();
        //当前节点描述
        this.hoverRemark();
        // 控制表单元素
        this.flowForm.controlFormInput();
        // 流程图
        this.refreshPic();
        // 流程意见
        this.refreshIdea();
        //刷新权限按钮后事件
        this.defaultForm.afterCreateButtons();

        $(window).resize();

        //自定义的加载事件
        if (!this.afterInit) {
            this.defaultForm.afterInit();
            this.afterInit = true;
        }
    } else {
        if (this.isStart) {
            // 默认提交
            this.bpmSubmit = new BpmSubmit(this, this.defaultForm, new Object());
            // 默认保存
            this.bpmSave = new BpmSave(this, this.defaultForm, new Object());
            // 帮助
            this.bpmButHelp = new BpmButHelp(this, this.defaultForm, new Object());
            //引用文档
            this.bpmButFile = new BpmButFile(this, this.defaultForm, new Object());
            //流程跟踪
            this.bpmButTrack = new BpmButTrack(this, this.defaultForm, new Object());

            this.setRoles();
            //当前节点描述
            this.hoverRemark();
            // 控制表单元素
            this.flowForm.controlFormInput();
            // 流程图
            this.refreshPic();
            // 流程意见
            this.refreshIdea();
            //刷新权限按钮后事件
            this.defaultForm.afterCreateButtons();

            $(window).resize();

            //自定义的加载事件
            if (!this.afterInit) {
                this.defaultForm.afterInit();
                this.afterInit = true;
            }
        } else {
            // 流程图
            this.refreshPic();
            // 流程意见
            this.refreshIdea();
            avicAjax.ajax({
                type: "POST",
                data: {
                    processInstanceId: _self.flowModel.entryId,
                    executionId: _self.flowModel.executionId,
                    taskId: _self.flowModel.taskId
                },
                url: "platform/bpm/business/getoperateright",
                dataType: "JSON",
                success: function (msg) {
                    if (flowUtils.notNull(msg.error)) {
                        flowUtils.error(msg.error);
                    } else {
                        _self.drawButtons(msg);
                        //调用正文模板的方法
                        if (typeof word_oa_refresh != 'undefined' && flowUtils.notNull(word_oa_refresh)) {
                            word_oa_refresh(_self);
                        }
                        // 默认点击提交
                        if (flg) {
                            _self.bpmSubmit.clickBut(outcome);
                        }
                        //刷新权限按钮后事件
                        _self.defaultForm.afterCreateButtons();

                        $(window).resize();

                        //自定义的加载事件
                        if (!_self.afterInit) {
                            _self.defaultForm.afterInit();
                            _self.afterInit = true;
                        }
                    }
                }
            });
        }
    }
};
/**
 * 画按钮
 *
 * @param json
 */
FlowEditor.prototype.drawButtons = function (json) {
    var bpmContent = json.bpmContent;

    //如果曾经在当前节点办理过，提示用户
    if(flowUtils.notNull(bpmContent.messageForEver)){
        layer.alert(bpmContent.messageForEver);
    }

    this.flowModel.setActivityname(bpmContent.processActivityName);
    this.flowModel.setActivitylabel(bpmContent.processActivityLabel);
    this.flowModel.setUserIdentityKey(bpmContent.userIdentityKey);
    this.flowModel.setUserIdentity(bpmContent.userIdentity);
    this.flowModel.setIdeasBySelf(bpmContent.ideasBySelf);
    this.setRoles();
    //当前节点描述
    this.hoverRemark();

    var buttonArray = json.operateRight;
    if (buttonArray == null) {
        return;
    }
    var buttonData = {};
    $.each(buttonArray, function (i, button) {
        if (button.event == "dosubmit") {
            if (buttonData.dosubmit == null) {
                buttonData.dosubmit = [];
            }
            buttonData.dosubmit.push(button);
        } else {
            eval("buttonData." + button.event + "= button");
        }
    });

    this.bpmSave = new BpmSave(this, this.defaultForm, buttonData);
    this.bpmRetreat = new BpmRetreat(this, this.defaultForm, buttonData);
    this.bpmSubmit = new BpmSubmit(this, this.defaultForm, buttonData);
    this.bpmWithdraw = new BpmWithdraw(this, this.defaultForm, buttonData);
    this.bpmSupplement = new BpmSupplement(this, this.defaultForm, buttonData);
    this.bpmAdduser = new BpmAdduser(this, this.defaultForm, buttonData);
    this.bpmSupersede = new BpmSupersede(this, this.defaultForm, buttonData);
    this.bpmTransmit = new BpmTransmit(this, this.defaultForm, buttonData);
    this.bpmWithdrawassignee = new BpmWithdrawassignee(this, this.defaultForm, buttonData);
    this.bpmFocus = new BpmFocus(this, this.defaultForm, buttonData);
    this.bpmGlobalend = new BpmGlobalend(this, this.defaultForm, buttonData);
    this.bpmGlobalidea = new BpmGlobalidea(this, this.defaultForm, buttonData);
    this.bpmGlobaljump = new BpmGlobaljump(this, this.defaultForm, buttonData);
    this.bpmGlobalresume = new BpmGlobalresume(this, this.defaultForm, buttonData);
    this.bpmGlobalsuspend = new BpmGlobalsuspend(this, this.defaultForm, buttonData);
    this.bpmStepuserdefined = new BpmStepuserdefined(this, this.defaultForm, buttonData);
    this.bpmTaskreader = new BpmTaskreader(this, this.defaultForm, buttonData);
    this.bpmPresstodo = new BpmPresstodo(this, this.defaultForm, buttonData);
    this.bpmStartsubflow = new BpmStartsubflow(this, this.defaultForm, buttonData);
    this.bpmRelationparentflow = new BpmRelationparentflow(this, this.defaultForm, buttonData);
    this.bpmRelationflow = new BpmRelationflow(this, this.defaultForm, buttonData);
    this.bpmButFile = new BpmButFile(this, this.defaultForm, buttonData);
    this.bpmButTrack = new BpmButTrack(this, this.defaultForm, buttonData);
    this.bpmButRelation = new BpmButRelation(this, this.defaultForm, buttonData);
    this.bpmButHelp = new BpmButHelp(this, this.defaultForm, buttonData);
    this.bpmAttribute = new BpmAttribute(this, this.defaultForm, buttonData);
    // 控制表单元素
    this.flowForm.controlFormInput();
};



/**
 * 流程启动后
 *
 * @param result
 */
FlowEditor.prototype.afterStart = function (result) {
    this.isStart = false;
    this.flowModel.setDefineId(result.defineId);
    this.flowModel.setEntryId(result.entryId);
    this.flowModel.setExecutionId(result.executionId);
    this.flowModel.setTaskId(result.taskId);
    this.defaultForm.setId(result.formId);
};
/**
 * 刷新是否被挂起
 * @type {boolean}
 */
FlowEditor.prototype.needRefreshPic = false;
/**
 * 刷新流程图
 */
FlowEditor.prototype.refreshPic = function () {
    this.needRefreshPic = true;
    if($("#bpm_pic_tab").is(':hidden')){
        return;
    }
    this.needRefreshPic = false;
    if(this.designerEditor == null){
        var _self = this;
        if($("#graph").length == 0){
            return;
        }
        // 初始化流程图画布
        initFlowPic(this.flowModel.entryId, this.flowModel.deploymentId, function(designerEditor) {
            _self.designerEditor = designerEditor;
            _self.designerEditor.init(_self.flowModel.entryId, _self.flowModel.deploymentId);
            //IE8下把决定定位去掉，不然样式有问题
            if(flowUtils.isIE8()){
                $("#graph").children("div").css("position","");
            }
        });
    }else{
        this.designerEditor.init(this.flowModel.entryId, this.flowModel.deploymentId);
        if(flowUtils.isIE8()) {
            $("#graph").children("div").css("position", "");
        }
    }
};
/**
 * 刷新是否被挂起
 * @type {boolean}
 */
FlowEditor.prototype.needRefreshIdea = false;
/**
 * 刷新流程意见
 */
FlowEditor.prototype.refreshIdea = function () {
    this.needRefreshIdea = true;
    if($("#bpm_idea_tab").is(':hidden')){
        return;
    }
    this.needRefreshIdea = false;
    this.flowIdea.refresh();
};

/**
 * 需要获取定义文件id
 *
 * @param entryId
 */
FlowEditor.prototype.getDefineIdByEntryId = function (entryId) {
    var defineId = null;
    $.ajax({
        type: "POST",
        async: false,// 同步请求
        data: {
            entryId: entryId
        },
        url: "platform/bpm/business/getDefineIdByEntryId",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error);
            } else {
                defineId = msg.defineId;
            }
        }
    });
    return defineId;
};

/**
 * 初始化节点描述
 */
FlowEditor.prototype.hoverRemark = function () {
    if ($("#help-panel").attr("isload") == "true") {
        return;
    }
    $("#help-panel").attr("isload", "true");
    $.ajax({
        type: "POST",
        data: {
            defineId: this.flowModel.defineId,
            activityname: this.flowModel.activityname
        },
        url: "platform/bpm/business/getTaskRemark",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error);
            } else {
                var html = "";
                if (flowUtils.notNull(msg.result)) {
                    html = "<p>" + msg.result + "</p>";
                } else {
                    html = "<p>当前节点无描述</p>";
                }
                $("#help-panel").html(html);
            }
        }
    });
};
FlowEditor.prototype.setRoles = function () {
    $(".nav-role").find("p").text("角色：" + this.flowModel.activitylabel + "节点" + this.flowModel.userIdentity);
};
// 暴漏的全局属性
var _flow_editor = null;
$(function () {
    $("#formTabParent").append($("#formTab"));
    $("#formTab").show();
    $("#formBut").children().each(function (i, n) {
        var order = $(n).attr("order");
        if(order == null || order == ""){
            order = "99";
        }
        var orderNumber = Number(order);
        if(orderNumber < $(".top-btns").children("ul").children().length && orderNumber >= 0){
            $(".top-btns").children("ul").children().eq(Number(order)).before($(n));
        }else {
            $(".top-btns").children("ul").append($(n));
        }
    });
});
