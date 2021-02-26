function RudgpObj(datagrid,url,dataGridColModel){
    if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
        throw new Error("datagrid不能为空！");
    }
    var	_url=url,_self=this;
    this.getUrl = function(){
        return _url;
    }
    this.__url=url;
    this._datagridId="#"+datagrid;
    this._jqgridToolbar="#t_"+datagrid;
    this._doc = document;
    this._keyWordId="#keyWord";
    this._searchNames = "";
    this.dataGridColModel = dataGridColModel;
    this.init.call(this);
};
//初始化操作
RudgpObj.prototype.init=function(){
    var _self = this;
    $(_self._datagridId).jqGrid({
        url:_self.getUrl()+'/all',
        mtype: 'get',
        datatype: "json",
        toolbar: [true,'top'],
        colModel: this.dataGridColModel,
        height:this._doc.documentElement.clientHeight-193,
        scrollOffset: 20, //设置垂直滚动条宽度
        pagerpos:'left',
        styleUI : 'Bootstrap',
        viewrecords: true, //
        hasTabExport:false,
        hasColSet:false,
        autowidth: true,
        multiselect: true,
        multiboxonly:true,
        onCellSelect:function(rowid, index){
            if(index=="3"){
                var rowData = $(this).jqGrid('getRowData', rowid);
                new H5CommonSelect({
                    type : 'roleSelect',
                    selectModel:'multi',
                    idFiled : '',
                    textFiled : '',
                    viewScope : 'currentOrg',
                    beferOpen:function () {
                        var roleids =rowData.sysroleId;
                        return {ids:roleids.split(",").join(';')};
                    },
                    callBack:function(role){
                        rowData.sysroleName=role.roleNames;
                        rowData.sysroleId=role.roleids;
                        rowData.isChanged='1';
                        $(_self._datagridId).jqGrid('setRowData', rowid, rowData);

                    }
                });
            }

        },
        //responsive:true,//开启自适应
    });

    $(this._jqgridToolbar).append($("#tableToolbar"));


    $(_self._keyWordId).on('keydown',function(e){
        if(e.keyCode == '13'){
            _self.searchByKeyWord();
        }
    });
    $("#searchPart").on('click',function(e){
        _self.searchByKeyWord();
    });

};
//关键字段查询
RudgpObj.prototype.searchByKeyWord =function(){

    var searchdata = {
        keyWord:$(this._keyWordId).val()
    };
    $(this._datagridId).jqGrid('setGridParam',{postData: {keyWord:$(this._keyWordId).val()}}).trigger("reloadGrid");
};
RudgpObj.prototype.save=function(appId){
    var rows = $(this._datagridId).jqGrid('getRowData');

    var changedRows = [];
    var l =rows.length;
    for(;l--;){
        if(rows[l].isChanged==='1'){
            changedRows.push(rows[l]);
        }

    }
    var data =JSON.stringify(changedRows);
    var _self = this;
    if(rows.length > 0){
        $.ajax({
            url: _self.getUrl()+'/save.json',
            data : {datas : data},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success") {
                    $(_self._datagridId).jqGrid().trigger("reloadGrid");
                    layer.msg('保存成功！',{
                        icon: 1,
                        area: ['200px', ''],
                        closeBtn: 0
                    });
                }else{
                    layer.alert('保存失败！' + r.e, {
                        icon: 2,
                        area: ['400px', ''],
                        closeBtn: 0
                    });
                }
            }
        });
    }else{
        layer.alert('没有要提交的数据!', {
            icon: 2,
            area: ['400px', ''],
            closeBtn: 0
        });
    }
};

