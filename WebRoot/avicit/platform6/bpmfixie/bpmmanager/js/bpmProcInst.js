/**
 * sysLookUpType的子表操作
 * @author zhanglei
 */
function BpmProcInst(datagrid,url){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._doc = document;
	this.conditions={};
}
//初始化操作
BpmProcInst.prototype.init=function(data){
    this.conditions=data;
    this._datagrid = $(this._datagridId).datagrid({
        url: this.getUrl(),
        queryParams:data
    })
	
};
//重载数据
BpmProcInst.prototype.reLoad=function(data){
    this.conditions=data;
	this._datagrid.datagrid('load',data).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
};
BpmProcInst.prototype.searchByKey=function(data){
    this.conditions.keyWord=data;
    this._datagrid.datagrid('load',this.conditions).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    delete this.conditions.keyWord;
};

BpmProcInst.prototype.searchData=function(){
    this.conditions.searchParam=JSON.stringify(serializeObject($('#formSub')));
    this._datagrid.datagrid('load',this.conditions).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
    delete this.conditions.searchParam;
};
//打开高级查询框
BpmProcInst.prototype.openSearchForm = function(searchDiv){
    var _self = this;
    var contentWidth = 800;
    var top =  $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
    var text = $(searchDiv).text();
    var width = $(searchDiv).innerWidth();


    layer.config({
        extend: 'skin/layer-bootstrap.css'
    });

    layer.open({
        type: 1,
        shift: 5,
        title: false,
        scrollbar: false,
        move : false,
        area: [contentWidth + 'px', '400px'],
        offset: [top + 'px', left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $('#searchDialogSub'),
        success : function(layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>'+ text +'</span><span class="caret"></span></div>').appendTo(layero);
            serachLabel.bind('click', function(){
                layer.close(index);
            });
            serachLabel.css('width', width);

            $(layero).css({
                height:400
            }).find('.layui-layer-content').css({
                height:378
            });
            $(layero).find('.layui-layer-btn').css({
                backgroundColor:'white'
            });
        },
        yes: function(index, layero){
            _self.searchData();
            layer.close(index);//查询框关闭
        },
        btn2: function(index, layero){
            _self.clearData();
            return false;
        },
        btn3: function(index, layero){

        }
    });
};
//隐藏查询框
BpmProcInst.prototype.hideSearchForm =function(){
    layer.close(searchDialogindex);
};
/*清空查询条件*/
BpmProcInst.prototype.clearData =function(){
    clearFormData('#formSub');
    this.searchData();
};
BpmProcInst.prototype.del = function(){
    var _self = this;
    var rows = this._datagrid.datagrid('getChecked');
    var l =rows.length;
    if (l===0) {
        layer.alert('请选择要删除的记录！', {
            icon : 7,
            area : [ '400px', '' ],
            closeBtn : 0
        });
        return;
    }
    var entryIds = '';
    var ids = '';
    for ( var i = 0; i < l; i++) {
        var rowData =rows[i];
        entryIds += rowData.dbId + ',';
        ids += rowData.executionId + ',';
    }

    flowUtils.confirm('您确认要删除流程实例吗?', function (index) {
        avicAjax.ajax({
            url: "platform/bpm/bpmConsoleAction/deleteProcessEntry",
            data: "processInstanceId=" + ids+"&entryId=" + entryIds,
            type: "post",
            dataType: "json",
            success: function (backData) {
                if (backData != null && backData.success == true) {
                    layer.msg('操作成功');
                    _self.reLoad(_self.nodeId,_self.nodeType,_self.pdId);
                } else {
                    layer.msg('操作失败');
                }
            }
        });2
    });
};

BpmProcInst.prototype.update = function(){
    var rows = this._datagrid.datagrid('getChecked');
    var l =rows.length;
    if (l!==1) {
        layer.alert('请选择一条要修改的记录！', {
            icon : 7,
            area : [ '400px', '' ],
            closeBtn : 0
        });
        return;
    }
    var rowData =rows[0];
    flowUtils.detailByManager(rowData.dbId);
};
