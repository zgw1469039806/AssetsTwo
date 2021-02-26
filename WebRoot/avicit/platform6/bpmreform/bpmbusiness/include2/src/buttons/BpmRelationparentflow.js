/**
 * 关联父流程
 */
function BpmRelationparentflow(flowEditor, defaultForm, buttonData, isEvent) {
    BpmButton.call(this, flowEditor, defaultForm, buttonData.dorelationparentprocess, isEvent);
    this.domeId = "dorelationparentprocess";
    this.getHtml();
};
BpmRelationparentflow.prototype = new BpmButton();

BpmRelationparentflow.prototype.showDialog = function (procinstDbid, hasParent) {
    var _self = this;
    layer.open({
        type: 2,
        area: ['100%', '100%'],
        title: '添加页',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        btn: ['保存', '取消已关联的父流程', '返回'],
        content: 'avicit/platform6/bpmreform/bpmbusiness/include/SubprocessAdd.jsp',
        yes: function (index1, layero) {
            var body = layer.getChildFrame('body', index1);
            var selectedRowIds = body.find("#firstjqGrid").getGridParam("selarrrow");//行数据
            var len = selectedRowIds.length;
            if (len == 0) {
                flowUtils.warning("请选择要关联的父流程！");
            } else if (len > 1) {
                flowUtils.warning("只允许关联一条父流程！");
            } else {
                var rowData = body.find("#firstjqGrid").getRowData(selectedRowIds[0]);
                avicAjax.ajax({
                    url: 'bpm/business/related/subProcessSaveData',
                    data: {
                        dbid1: procinstDbid,
                        task: '',
                        dbid2: rowData["dbId"]
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (r) {
                        if (r.flag == "success") {
                            flowUtils.success("关联成功！");
                            layer.close(index1);
                        } else if (r.flag == 'same') {
                            flowUtils.warning("父流程不能与当前流程相同！");
                        } else if (r.flag == 'parentOrSub') {
                            flowUtils.warning("已经存在父子流程关系！");
                        } else {
                            flowUtils.warning("关联失败！");
                        }
                    }
                });
            }
            return false;
        },
        end: function () {
            _self.flowEditor.createButtons();
        },
        btn2: function (index1, layero) {
            if(!hasParent){
                flowUtils.warning("当前无已关联的父流程！");
                return false;;
            }
            flowUtils.confirm('确定取消已关联的父流程吗?', function () {
                avicAjax.ajax({
                    url: 'bpm/business/related/subDelData',
                    data: {
                        id: procinstDbid
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (r) {
                        if (r.flag == "success") {
                            flowUtils.success("取消成功！");
                            layer.close(index1);
                        } else {
                            flowUtils.warning("取消失败！");
                        }
                    }
                });
            });
            return false;
        }
    });
};
/**
 * 执行
 */
BpmRelationparentflow.prototype.execute = function () {
    var _self = this;
    var procinstDbid = this.data.procinstDbid;//主流程实例ID
    avicAjax.ajax({
        url: 'bpm/business/related/findSubProcessById',
        data: {
            data: procinstDbid
        },
        type: 'post',
        dataType: 'json',
        success: function (r) {
            if (r.flag == "success") {
                _self.showDialog(procinstDbid, false);
            } else if (r.flag == "exist") {
                flowUtils.confirm('已关联父流程，确认要重新关联吗?', function () {
                    _self.showDialog(procinstDbid, true);
                });
            }else if(r.flag == "existAndNoEdit"){
                flowUtils.warning("该流程为父流程自动发起，不允许手动关联父流程！");
            }else if(r.flag == "failure"){
                flowUtils.warning("查询数据异常！");
            }
        }
    });
};
