function WorkHandTaskList(datagrid, pager, userId) {
    this.datagrid = datagrid;
    this.pager = pager;
    this.userId = userId;
    this.init.call(this);
}

WorkHandTaskList.prototype.dataGridColModel = [
    {
        name: 'dbid',
        key: true,
        hidden: true
    }, {
        label: '任务标题',
        name: 'taskTitle',
        align: 'left',
        sortable: false
    }, {
        label: '流程模板',
        name: 'processDefName',
        align: 'center',
        sortable: false
    }, {
        label: '申请日期',
        name: 'processStartTime',
        width: 140,
        fixed: true,
        align: 'center',
        sortable: false,
        formatter: function (value, rec) {
            return value ? new Date(value).format("yyyy-MM-dd hh:mm:ss") : '';
        }
    }, {
        label: '接收时间',
        name: 'createTime',
        width: 140,
        fixed: true,
        align: 'center',
        sortable: false,
        formatter: function (value, rec) {
            return value ? new Date(value).format("yyyy-MM-dd hh:mm:ss") : '';
        }
    }, {
        label: '当前节点',
        name: 'curActName',
        align: 'center',
        width: 100,
        fixed: true,
        sortable: false
    }, {
        label: '应完时间',
        name: 'reasonableFinishTime',
        width: 140,
        fixed: true,
        align: 'center',
        sortable: false,
        formatter: function (value, rec) {
            return value ? new Date(value).format("yyyy-MM-dd hh:mm:ss") : '';
        }
    }, {
        label: '发送人',
        name: 'taskSendUser',
        width: 80,
        fixed: true,
        align: 'center',
        sortable: false
    }
];
//初始化操作
WorkHandTaskList.prototype.init = function () {
    var _self = this;
    $(this.datagrid).jqGrid({
        url: 'platform/bpm/clientbpmWorkHandAction/getTodoList',
        postData: {
            userId: this.userId
        },
        mtype: 'POST',
        datatype: "json",
        // toolbar: [true, 'top'],
        colModel: this.dataGridColModel,
        // scrollOffset: 10, //设置垂直滚动条宽度
        rowNum: 10,
        rowList: [200, 100, 50, 30, 20, 10],
        altRows: true,
        pagerpos: 'left',
        styleUI: 'Bootstrap',
        viewrecords: true, //
        multiselect: true,
        autowidth: true,
        shrinkToFit: true,
        hasColSet: false,
        hasTabExport: false,
        responsive: true,//开启自适应
        pager: this.pager
    });
};
WorkHandTaskList.prototype.getSelected = function () {
    return $(this.datagrid).jqGrid('getGridParam', 'selarrrow') || [];
};
WorkHandTaskList.prototype.reLoad = function () {
    $(this.datagrid).jqGrid('setGridParam', {
        postData: {
            userId: this.userId,
            pdKeys: $("#flowId").val()
        }
    }).trigger("reloadGrid");
};
