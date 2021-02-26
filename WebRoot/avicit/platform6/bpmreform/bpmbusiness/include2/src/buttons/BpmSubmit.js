/**
 * 提交，多个提交合成一个
 */
function BpmSubmit(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, null, isEvent);
    this.data = buttonData.dosubmit;
    this.transmitData = buttonData.dotransmitsubmit;
    if (this.flowEditor.isStart || flowUtils.notNull(this.data) || flowUtils.notNull(this.transmitData)) {
        this.enable = true;
    }
    this.domeId = "dosubmit";
    this.meshDomeId = "dosubmit_mesh";
    this.startDomeId = "dostart";
    this.transmitsubmitDomeId = "dotransmitsubmit";
    this.getHtml();
    //是否是启动流程后的自动点击事件
    this.isAutoClickAfterStart = false;
};
BpmSubmit.prototype = new BpmButton();

/**
 * 禁用标志
 * @type {boolean}
 */
BpmSubmit.prototype.disabled = false;
/**
 * 执行
 */
BpmSubmit.prototype.execute = function (data) {
    var _self = this;
    if (this.disabled) {
        return;
    }
    this.disabled = true;
    setTimeout(function () {
        _self.disabled = false;
    }, 2000);

    if (this.flowEditor.isStart) {
        this.defaultForm.start(this.flowEditor.flowModel.defineId, function (startResult) {
            _self.flowEditor.afterStart(startResult);
            _self.flowEditor.createButtons(true);
            flowUtils.refreshBack();
        });
    } else {
        if (!this.flowEditor.defaultForm.beforeSubmit(data)) {
            return;
        }
        // 自动保存
        if (!this.isAutoClickAfterStart && !this.isEvent && this.flowEditor.defaultForm.isAutoSave && this.flowEditor.bpmSave.isEnable()) {
            this.flowEditor.defaultForm.save(function () {
                _self.flowEditor.createButtons(true, data.name);
            });
        } else {
            this.validIdeasBySelf("1", function () {
                new BpmActor(data, _self).open();
            });
        }
    }
};
/**
 * 提交
 */
BpmSubmit.prototype.submit = function (data, users, idea, compelManner, uflowDealType, isUflow) {
    //重新组织意见
    idea = this.flowEditor.defaultForm.reGetidea(idea, users);

    if(flowUtils.notNull(this.ideas_text)){
        idea = this.ideas_text + " " + idea;
    }

    //如果是已阅按钮，转到已阅方法上
    if(this.transmitData != null){
        this.submitTransmit(idea);
        return;
    }

    var userJson = {
        users: users,
        idea: idea,
        compelManner: compelManner,
        outcome: data.name
    };
    var _self = this;
    avicAjax.ajax({
        url: "platform/bpm/business/dosubmit",
        data: {
            instanceId: data.procinstDbid,
            taskId: data.taskId,
            userJson: JSON.stringify(userJson),
            outcome: data.name,
            formJson: null,
            uflowDealType: uflowDealType,
            isUflow: isUflow
        },
        type: "POST",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error,msg.errorDetail);
            } else {
                if (_self.isEvent) {
                    flowUtils.success("提交成功！", function () {
                        flowUtils.refreshCurrentBack();
                    }, true);
                } else {
                    flowUtils.success("提交成功！表单将自动关闭", function () {
                        flowUtils.refreshBack();
                        flowUtils.closeWindowOnDialog();
                        setTimeout(function () {
                            _self.flowEditor.createButtons();
                        }, 500);
                    }, true);
                }
                try {
                    _self.flowEditor.defaultForm.afterSubmit(data);
                } catch (e) {

                }
            }
        }
    });
};
BpmSubmit.prototype.getHtml = function () {
    $("#" + this.meshDomeId).children("ul").empty();
    $("#" + this.domeId).children("a").off("click");
    $("#" + this.startDomeId).children("a").off("click");
    $("#" + this.transmitsubmitDomeId).children("a").off("click");
    if (this.isEnable() && !this.isEvent) {
        var _self = this;
        if (this.data != null && this.data.length > 1) {
            //多条分支
            $.each(this.data, function (n, value) {
                var li = $('<li class="sub-list-li"><a href="javascript:void(0);" title="'+value.lable+'">' + value.lable + '</a></li>');
                li.children("a").attr("title", value.description);
                li.children("a").on("click", function () {
                    _self.execute(value);
                });
                $("#" + _self.meshDomeId).children("ul").append(li);
            });
            this.flowEditor.showButtons(this.meshDomeId);
        } else if (this.data != null) {
            //只有一个提交
            var data = this.data[0];
            $("#" + this.domeId).attr("title", data.description);
            $("#" + this.domeId).find("span").text(data.lable);
            $("#" + this.domeId).children("a").on("click", function () {
                _self.execute(data);
            });
            this.flowEditor.showButtons(this.domeId);
        } else if (this.transmitData != null) {
            //完成传阅
            $("#" + this.transmitsubmitDomeId).children("a").on("click", function () {
                _self.executeTransmit();
            });
            this.flowEditor.showButtons(this.transmitsubmitDomeId);
        } else {
            //启动流程
            $("#" + this.startDomeId).children("a").on("click", function () {
                _self.execute();
            });
            this.flowEditor.showButtons(this.startDomeId);
        }
    }
};
/**
 * 完成传阅
 */
BpmSubmit.prototype.executeTransmit = function () {
    var _self = this;
    // flowUtils.confirm("确定提交吗？", function () {
        // _self.submitTransmit();
        new BpmActor(_self.transmitData, _self).open();
    // });
};
BpmSubmit.prototype.submitTransmit = function (idea) {
    var _self = this;
    avicAjax.ajax({
        url: "platform/bpm/business/dosubmitTransmit",
        data: {
            instanceId: this.transmitData.procinstDbid,
            message: idea || "已阅",
            taskId: this.transmitData.taskId
        },
        type: "POST",
        dataType: "JSON",
        success: function (msg) {
            if (flowUtils.notNull(msg.error)) {
                flowUtils.error(msg.error,msg.errorDetail);
            } else {
                flowUtils.success("提交成功！表单将自动关闭", function () {
                    flowUtils.refreshBack();
                    flowUtils.closeWindowOnDialog();
                    setTimeout(function () {
                        _self.flowEditor.createButtons();
                    }, 500);
                }, true);
            }
        }
    });
};
/**
 * 流程启动之后自动点击一次提交按钮,或者触发保存之后再来调用提交
 */
BpmSubmit.prototype.clickBut = function (outcome) {
    var _self = this;
    if (this.isEnable()) {
        if(flowUtils.notNull(outcome)){
            if (this.data != null && this.data.length > 0) {
                for(var i = 0; i < this.data.length; i++){
                    if(this.data[i].name == outcome){
                        this.validIdeasBySelf("1", function () {
                            new BpmActor(_self.data[i], _self).open();
                        });
                        return;
                    }
                }
            }
            layer.msg("路由条件可能已经发生变化，请重新进行提交");
        }else {
            if (this.data != null && this.data.length > 1) {
                layer.msg("流程已创建，请选择一个分支进行提交");
            } else if (this.data != null) {
                this.isAutoClickAfterStart = true;
                try {
                    $("#" + this.domeId).find("a").click();
                } catch (e) {
                    this.isAutoClickAfterStart = false;
                }
                this.isAutoClickAfterStart = false;
            }
        }
    }
};
