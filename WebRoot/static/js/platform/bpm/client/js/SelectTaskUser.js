var SelectTaskUser = function (option) {
    this.activityName = option.activityName || "";
    this.processInstanceId = option.processInstanceId || "";
    this.processInstanceIds = option.processInstanceIds || "";
    this.executionId = option.executionId || "";
    this.processDefId = option.processDefId || "";
    this.callback = option.callback;
    this.open = function () {
        var that = this;
        if (this.processInstanceId) {
            $.ajax({
                type: "POST",
                data: {
                    processInstanceId: this.processInstanceId,
                    activityName: this.activityName,
                    type: "search"
                },
                url: "platform/bpm/clientbpmoperateaction/douserdefined",
                dataType: "json",
                success: function (result) {
                    that.back(result);
                }
            });
        } else {
            that.back({
                selectUser: ""
            });
        }
    };
    this.back = function (obj) {
        if (obj != null) {
            var mySelectUser = obj.selectUser;
            if (!mySelectUser || mySelectUser == 'undefined' || mySelectUser == 'null') {
                mySelectUser = "";
            }
            this.douserdefined(mySelectUser);
        }
    };
    /**
     * 自定义流程审批人选择目标节点后
     */
    this.douserdefined = function (mySelectUser) {
        var para = "procinstDbid=" + (this.processInstanceId || this.processDefId) + "&executionId=" + this.executionId + "&taskId=&outcome=&targetActivityName=" + this.activityName + "&mySelectUser=" + mySelectUser + "&type=dostepuserdefined&doSubmitUrl=" + escape("platform/bpm/clientbpmoperateaction/douserdefined") + "&doSubmitCallEvent=backFinished&random=" + Math.random();
        this.usd = new UserSelectDialog("doadduserdialog", "650", "500", getPath2() + "/platform/user/bpmSelectUserAction/main?" + encodeURI(para), "流程自定义审批选人窗口");
        var that = this;
        var buttons = [{
            text: '提交',
            id: 'processSubimt',
            handler: function () {
                var frmId = $('#doadduserdialog iframe').attr('id');
                var frm = document.getElementById(frmId).contentWindow;
                var seleUserJson = frm.getSelectedResultDataJson();
                if (typeof (seleUserJson) != 'undefined') {
                    if (that.processInstanceId) {
                        $.ajax({
                            type: "POST",
                            data: {
                                processInstanceId: that.processInstanceId,
                                processInstanceIds: that.processInstanceIds,
                                activityName: that.activityName,
                                targetActivityName: that.activityName,
                                selectUserIds: seleUserJson
                            },
                            url: "platform/bpm/clientbpmoperateaction/douserdefined",
                            dataType: "json",
                            success: function (result) {
                                that.doCallBack(seleUserJson);
                            }
                        });
                    } else {
                        that.doCallBack(seleUserJson);
                    }
                }
            }
        }];
        this.usd.createButtonsInDialog(buttons);
        this.usd.show();
    };
    this.doCallBack = function (seleUserJson) {
        if (typeof this.callback == "function") {
            var userJson = JSON.parse(seleUserJson);
            var str = "";
            for (var i = 0; i < userJson.users[0].selectedUsers.length; i++) {
                var userName = userJson.users[0].selectedUsers[i].userName;
                str += userName + ",";
            }
            this.callback(seleUserJson, str);
        }
        this.usd.close();
    };
};