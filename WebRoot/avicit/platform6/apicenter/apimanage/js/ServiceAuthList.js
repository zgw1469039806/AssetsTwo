function ServiceAuthList(datagrid, url, param, searchKeyword, searchDialog, formId, dataGridColModel){
    if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
        throw new Error("datagrid不能为空！");
    }
    var	_url=url;
    this.getUrl = function(){
        return _url;
    }

    this._datagridId="#"+datagrid;
    this._jqgridToolbar="#t_"+datagrid;
    this._doc = document;
    this._searchKeyword ="#"+searchKeyword;
    this._searchDialogId ="#"+searchDialog;
    this._formId = "#"+formId;
    this.param = param;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};

//初始化操作
ServiceAuthList.prototype.init=function(){
    var _self = this;
    $(_self._datagridId).jqGrid({
        url: _self.getUrl()+"/getAuthorizationList",
        mtype: 'POST',
        postData:{
            param: JSON.stringify(_self.param)
        },
        datatype: "json",
        toolbar: [true,'top'],
        colModel: _self.dataGridColModel,
        height: _self._doc.documentElement.clientHeight-120,
        scrollOffset: 10, //设置垂直滚动条宽度
        rowNum: 12,
        rowList:[100,50,30,20,12],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
        viewrecords: true, //
        autowidth: true,
        hasColSet:false,
        hasTabExport:false,
        responsive:true,//开启自适应
        rownumbers:true,
        multiselect:true,
//		multiboxonly:true,
//		forceFit:true,
        pager:'#jqGridPager',
        loadComplete: function() {
            if(_self.param.applicationCode=="") {
                $("#buttonAdd").attr("disabled", true);
                $("#buttonAuthorization").attr("disabled", true);
                $("#buttonDisable").attr("disabled", true);
                $("#buttonDelete").attr("disabled", true);
            }else{
                $("#buttonAdd").removeAttr("disabled");
                $("#buttonAuthorization").removeAttr("disabled");
                $("#buttonDisable").removeAttr("disabled");
                $("#buttonDelete").removeAttr("disabled");
            }
        }
    });

    $(this._jqgridToolbar).append($("#tableToolbar"));
    return this;
};

ServiceAuthList.prototype.clearData =function(){
    clearFormData(this._formId);
    this.searchData();
};

/*弹出添加应用页面 */
ServiceAuthList.prototype.add = function(){
    var _self = this;
    var _tree=ServiceAuthTree;
    this.addapp=layer.open({
        type: 2,
        area: ['30%', '80%'],
        title: '添加应用',
        skin: 'bs-modal',
        maxmin: false,
        scrollbar: false,
        content: _self.getUrl()+"/toAddApp?code="+_tree._selectNode.applicationCode+"&name="+_tree._selectNode.applicationName,
    });
}

/*添加应用*/
ServiceAuthList.prototype.saveApp = function(param,index){
    var _self=this;
    var node=ServiceAuthTree.tree.getSelectedNodes();
    var cusparam = new Object();
    cusparam.code = node[0].applicationCode;
    cusparam.name = node[0].applicationName;
    if (param.length < 1){
        layer.alert('请先选择要添加的应用！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }else {
        layer.confirm('确认要添加该应用吗?', {
            title : '提示',
            icon : 3,
            closeBtn:0,
            area: ['400px', ''],
            btn: ['确定','取消']
        }, function(index){
            $.ajax({
                type: 'POST',
                url: _self.getUrl()+"/addApplication",
                dataType:"json",
                data: {
                    modifyParam: JSON.stringify(param),
                    customer:JSON.stringify(cusparam)
                },
                success: function(data){
                    if(data.result == "success"){
                        layer.msg('添加成功！',{
                            icon: 1,
                            area: ['200px', ''],
                            closeBtn: 0
                        });
                        layer.close(_self.addapp);
                        $(_self._datagridId).trigger("reloadGrid");
                    }else if(data.result == "fail"){
                        layer.alert('添加失败！',{
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }else if(data.result == "exist"){
                        layer.alert('已存在！',{
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }

                }
            });
        });
    }
    return true;
}

ServiceAuthList.prototype.close=function(id){
    var _self=this;
    layer.close(_self.addapp);
}


/*授权 */
ServiceAuthList.prototype.doAuthorization = function(){
    var _self = this;
    var rowIds = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
    if (rowIds.length < 1){
        layer.alert('请先选择要授权的应用！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }else {
        layer.confirm('确认授权该应用吗?', {
            title : '提示',
            icon : 3,
            closeBtn:0,
            area: ['400px', ''],
            btn: ['确定','取消']
        }, function(index){

            var param_list = new Array();
            for (var i = 0; i < rowIds.length; i++) {
                var rowData = $(_self._datagridId).jqGrid('getRowData',rowIds[i]);
                param_list[i] = rowData;
            }

            $.ajax({
                type: 'POST',
                url: _self.getUrl()+"/changeState",
                dataType:"json",
                data: {
                    modifyParam: JSON.stringify(param_list),
                    state:"1"
                },
                success: function(data){
                    if(data.result == "success"){
                        layer.msg('授权成功！',{
                            icon: 1,
                            area: ['200px', ''],
                            closeBtn: 0
                        });
                    }else if(data.result == "fail"){
                        layer.alert('授权失败！',{
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }
                    $(_self._datagridId).trigger("reloadGrid");
                }
            });
            layer.close(index);
        });
    }
    return true;
}

/*禁止 */
ServiceAuthList.prototype.disable = function(){
    var _self = this;
    var rowIds = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
    if (rowIds.length < 1){
        layer.alert('请先选择要禁止的应用！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }else {
        layer.confirm('确认禁止该应用吗?', {
            title : '提示',
            icon : 3,
            closeBtn:0,
            area: ['400px', ''],
            btn: ['确定','取消']
        }, function(index){

            var param_list = new Array();
            for (var i = 0; i < rowIds.length; i++) {
                var rowData = $(_self._datagridId).jqGrid('getRowData',rowIds[i]);
                param_list[i] = rowData;
            }

            $.ajax({
                type: 'POST',
                url: _self.getUrl()+"/changeState",
                dataType:"json",
                data: {
                    modifyParam: JSON.stringify(param_list),
                    state:"0"
                },
                success: function(data){
                    if(data.result == "success"){
                        layer.msg('禁止成功！',{
                            icon: 1,
                            area: ['200px', ''],
                            closeBtn: 0
                        });
                    }else if(data.result == "fail"){
                        layer.alert('禁止失败！',{
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }
                    $(_self._datagridId).trigger("reloadGrid");
                }
            });
            layer.close(index);
        });
    }
    return true;
}

/*删除 */
ServiceAuthList.prototype.delete = function(){
    var _self = this;
    var rowIds = $(_self._datagridId).jqGrid('getGridParam','selarrrow');
    var DeleteIds = [];
    var l = rowIds.length;
    if (rowIds.length < 1){
        layer.alert('请选择要删除的应用！', {
                title : '提示',
                icon : 0,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }else {
        layer.confirm('确认删除该应用吗?', {
            title : '提示',
            icon : 3,
            closeBtn:0,
            area: ['400px', ''],
            btn: ['确定','取消']
        }, function(index){
            for (; l--;) {
                DeleteIds.push(rowIds[l]);
            }
            $.ajax({
                type: 'POST',
                url: _self.getUrl()+"/deleteAuthorization",
                dataType:"json",
                data: {
                    ids: DeleteIds.join(','),
                },
                success: function(data){
                    if(data.result == "success"){
                        layer.msg('删除成功！',{
                            icon: 1,
                            area: ['200px', ''],
                            closeBtn: 0
                        });
                    }else if(data.result == "fail"){
                        layer.alert('删除失败！',{
                            icon: 2,
                            area: ['400px', ''],
                            closeBtn: 0
                        });
                    }
                    $(_self._datagridId).trigger("reloadGrid");
                }
            });
            layer.close(index);
        });
    }
    return true;
}

