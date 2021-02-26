function BpmEventProperties(parentdatagrid,datagrid, url, formSub, dataGridColModel,
                      searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    this._url = url;
    this.getUrl = function(){
        return this._url;
    };
    this._searchDialogId = "#" + searchDialogSub;
    this.searchForm = "#" + formSub;
    this.pid = pid;
    this._datagridId = "#" + datagrid;
    this.parentdatagrid = "#" + parentdatagrid;
    this.Toolbardiv = "#t_" + datagrid;
    this.Toolbar = "#toolbar_" + datagrid;
    this.Pagerlbar = "#" + datagrid + "Pager";
    this._keyWordId = "#" + demoSubUser_KeyWord;
    this._searchNames = searchSubNames;
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};
//初始化操作
BpmEventProperties.prototype.init = function(pid) {
    var _self = this;
    $(_self._datagridId).jqGrid({
        url : this.getUrl() + 'getPropertiesListByPage',
        postData : {
            pid : _self.pid
        },
        mtype : 'POST',
        datatype : "json",
        toolbar : [ true, 'top' ],
        colModel : this.dataGridColModel,
        height : $('#north2').height() - $("#toolbar_resteasyUser").innerHeight() -36  -48,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
        scrollOffset : 10, //设置垂直滚动条宽度
        //rowNum : 20,
        //rowList : [ 200, 100, 50, 30, 20, 10 ],
        altRows : true,
        pagerpos : 'left',
        hasTabExport:false, //导出
        hasColSet:false,  //设置显隐
        loadComplete : function() {
            $(this).jqGrid('getColumnByUserIdAndTableName');
        },
        styleUI : 'Bootstrap',
        viewrecords : true, //
        multiselect : true,
        autowidth : true,
        shrinkToFit : true,
        responsive : true//开启自适应
        //pager : _self.Pagerlbar
    });

    $(_self.Toolbardiv).append($(_self.Toolbar));


};
//添加页面
BpmEventProperties.prototype.insert = function() {
    var ids = $(this.parentdatagrid).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择添加用户的系统数据！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0,
            title:'提示'
        });
        return false;
    }else if (ids.length > 1){
        layer.alert('只允许选择一条系统数据！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0
        });
        return false;
    }

    var parentId = ids[0];
    var rowdata = $(this.parentdatagrid).jqGrid('getRowData',parentId);
    var type = rowdata.type;
    if (type != "流程事件监听") {
        layer.alert('事件列表选中数据的类型不是【流程事件监听】,不能添加参数！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0,
            title:'提示'
        });
        return;
    }
    this.insertIndex = layer.open({
        type : 2,
        title : '添加',
        skin : 'bs-modal',
        area : [ '700px', '300px' ],
        maxmin : false,
        content : this.getUrl() + 'Add/null/'+parentId
    });
};
//修改页面
BpmEventProperties.prototype.modify = function() {
    if (this.pid == null || this.pid == "") {
        layer.alert('请选择一条主表数据！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0
        });
        return false;
    }
    var ids = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    if (ids.length == 0) {
        layer.alert('请选择要编辑的数据！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0,
            title:'提示'
        });
        return false;
    } else if (ids.length > 1) {
        layer.alert('只允许选择一条数据，进行编辑！', {
            icon : 7,
            area : [ '400px', '' ], //宽高
            closeBtn : 0,
            title:'提示'
        });
        return false;
    }
    var rowData = $(this._datagridId).jqGrid('getRowData', ids[0]);
    this.eidtIndex = layer.open({
        type : 2,
        title : '编辑',
        skin : 'bs-modal',
        area : [ '60%', '60%' ],
        maxmin : false,
        content : this.getUrl() + 'Edit/' + rowData.dbid + '/'+this.pid
    });
};
//详细页
BpmEventProperties.prototype.detail = function(id) {
    this.detailIndex = layer.open({
        type : 2,
        area : [ '100%', '100%' ],
        title : '详细页',
        skin : 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin : false, //开启最大化最小化按钮
        content : this.getUrl() + 'Detail/' + id
    });
};
//控件校验   规则：表单字段name与rules对象保持一致
BpmEventProperties.prototype.formValidate = function(form) {
    form.validate({
        rules : {
            name : {
                maxlength : 50,
                required : true
            },
            orderBy : {
                maxlength : 10,
                required : true
            }
        }
    });
}
//保存功能
BpmEventProperties.prototype.save = function(form, id) {
    var _self = this;
    avicAjax.ajax({
        url : _self.getUrl() + "save",
        data : {
            data : JSON.stringify(serializeObject(form))
        },
        type : 'post',
        dataType : 'json',
        success : function(r) {
            if (r.flag == "success") {
                _self.reLoad();
                if (id == "insert") {
                    layer.close(_self.insertIndex);
                } else {
                    layer.close(_self.eidtIndex);
                }
                layer.msg('保存成功！');
            } else {
                layer.alert('保存失败！' + r.error, {
                    icon : 7,
                    area : [ '400px', '' ], //宽高
                    closeBtn : 0
                });
            }
        }
    });
};
//删除
BpmEventProperties.prototype.del = function() {
    var rows = $(this._datagridId).jqGrid('getGridParam', 'selarrrow');
    var _self = this;
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        layer.confirm('确认要删除选择的数据吗?', {
            icon : 3,
            title : "提示",
            area : [ '400px', '' ],
            closeBtn : 0
        }, function(index) {
            for (; l--;) {
                ids.push(rows[l]);
            }
            avicAjax.ajax({
                url : _self.getUrl() + 'delete',
                data : ids.join(","),
                contentType : 'application/json',
                type : 'post',
                dataType : 'json',
                success : function(r) {
                    if (r.flag == "success") {
                        _self.reLoad();
                        layer.msg('删除成功！');
                    } else {
                        layer.alert('删除失败！' + r.error, {
                            icon : 7,
                            area : [ '400px', '' ],
                            closeBtn : 0,
                            title : "提示"
                        });
                    }
                }
            });
            layer.close(index);
        });
    } else {
        layer.alert('请选择要删除的数据！', {
            icon : 7,
            area : [ '400px', '' ],
            closeBtn : 0,
            title:'提示'
        });
    }
};
//重载数据
BpmEventProperties.prototype.reLoad = function(pid) {
    if (pid != undefined) {
        this.pid = pid;
    }
    var searchdata = {
        pid : pid
    };
    $(this._datagridId).jqGrid('setGridParam', {
        datatype : 'json',
        postData : searchdata
    }).trigger("reloadGrid");
};
//关闭对话框
BpmEventProperties.prototype.closeDialog = function(id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.eidtIndex);
    }
};
//打开高级查询框
BpmEventProperties.prototype.openSearchForm = function(searchDiv, par) {
    var _self = this;
    par = null;
    //if(!par) par = $(window);
    var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
    var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var left = $(searchDiv).offset().left + $(searchDiv).outerWidth()
        - contentWidth;
    var text = $(searchDiv).text();
    var width = $(searchDiv).innerWidth();

    layer.config({
        extend : 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });
    layer.open({
        type : 1,
        shift : 5,
        title : false,
        scrollbar : false,
        move : false,
        area : [ contentWidth + 'px', '145px' ],
        offset : [ top + 'px', left + 'px' ],
        closeBtn : 0,
        shadeClose : true,
        btn : [ '查询', '清空', '取消' ],
        content : $(this._searchDialogId),
        success : function(layero, index) {
            var serachLabel = $(
                '<div class="serachLabel"><span>' + text
                + '</span><span class="caret"></span></div>')
                .appendTo(layero);
            serachLabel.bind('click', function() {
                layer.close(index);
            });
            serachLabel.css('width', width + 'px');
        },
        yes : function(index, layero) {
            _self.searchData();
            layer.close(index);
        },
        btn2 : function(index, layero) {
            _self.clearData();
            return false;
        },
        btn3 : function(index, layero) {

        }
    });
};
//高级查询
BpmEventProperties.prototype.searchData = function() {
    var searchdata = {
        keyWord : null,
        pid : this.pid,
        param : JSON.stringify(serializeObject($(this.searchForm)))
    };
    $(this._datagridId).jqGrid('setGridParam', {
        datatype : 'json',
        postData : searchdata
    }).trigger("reloadGrid");
};
//关键字段查询
BpmEventProperties.prototype.searchByKeyWord = function() {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr(
        "placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for ( var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }

    var searchdata = {
        keyWord : JSON.stringify(param),
        pid : this.pid,
        param : null
    };
    $(this._datagridId).jqGrid('setGridParam', {
        datatype : 'json',
        postData : searchdata
    }).trigger("reloadGrid");
}
//隐藏查询框
BpmEventProperties.prototype.hideSearchForm = function() {
    layer.close(searchDialogindex);
};
/*清空查询条件*/
BpmEventProperties.prototype.clearData = function() {
    clearFormData(this.searchForm);
    this.searchData();
};
