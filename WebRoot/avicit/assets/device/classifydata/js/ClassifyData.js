/**
 * 单表树
 * @param ztreeId
 * @param url
 * @param form
 * @param searchD
 * @param searchbtn
 * @returns
 */
function ClassifyData(zNodes, ztreeId, url, form, currentCategory, searchKey, selectModel) {
    var _url = url;
    this.getUrl = function () {
        return _url;
    };

    this.tree = null;
    this.zNodes = zNodes;
    this.ztreeId = ztreeId;
    this._ztreeId = "#" + ztreeId;
    this._formId = "#" + form; //formId
    this.currentCategory = currentCategory;
    this._searchKey = "#" + searchKey;
    this._selectModel = selectModel;

    this.setting = {
        check: {
            enable: true, //checkbox
        },
        edit: {
            enable: true,
            showRemoveBtn: false,
            showRenameBtn: false
        },
        check: {
            enable: true//checkbox
        },
        view: {
            nameIsHTML: true, //允许name支持html
            selectedMulti: false,
            dblClickExpand: false,
            showLine: false,
            addDiyDom: function (treeId, treeNode) {//添加自定义元素：缩小子节点与父节点元素左边距差
                if((treeNode.pId != undefined) && (treeNode.pId != null) &&(treeNode.pId != "")){
                    document.getElementById(treeNode.tId).style.marginLeft = "-10px";
                }
            }
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onRightClick: function (event, treeId, treeNode) {
                var zTree = $.fn.zTree.getZTreeObj("classifyTree");
                zTree.selectNode(treeNode);

                var menuRight = document.getElementById("treeMenu");
                menuRight.style.display = "inline";
                menuRight.style.top = event.clientY + 'px';

                if((document.body.clientWidth-event.clientX) < 100){
                    menuRight.style.left = (document.body.clientWidth-105) + 'px';
                }
                else{
                    menuRight.style.left = event.clientX + 'px';
                }
            }
        }
    };

    this.init();
};

/**
 * 初始化操作
 */
ClassifyData.prototype.init = function () {
    var _self = this;

    //多选时父关联子、子不关联父
    if(this._selectModel == "single"){
        this.setting.check.autoCheckTrigger = false;
        this.setting.check.chkStyle = "radio";
        this.setting.check.radioType = "all";
    }
    else{
        this.setting.check.chkboxType = { "Y" : "s", "N" : "s" };
    }

    //重新初始化菜单树
    $.fn.zTree.init($(_self._ztreeId), _self.setting, _self.zNodes);

    //初始化查询
    fuzzySearch(_self.ztreeId, _self._searchKey,null,true);

    _self.tree = $.fn.zTree.getZTreeObj(_self.ztreeId);
};

/**
 * 打开添加/编辑分类弹框
 */
ClassifyData.prototype.openDialog = function (oprateType) {
    var _self = this;
    hiddenElement('treeMenu');  //隐藏鼠标右键弹框

    //清空弹框内的分类对象的字段
    $('#id').val('');
    $('#parentId').val('');
    $('#parentCode').val('');
    $('#belongCategory').val('');
    $('#name').val('');
    $('#fatherCode').val('');
    $('#sonCode').val('');

    if(oprateType == 'Add'){
        document.getElementById('addClassifyDialog').style.display = 'inline'; //显示新增/编辑分类弹框
        document.getElementById('dialogTitle').innerHTML = '添加分类';   //设置新增/编辑分类弹框的标题

        //获取当前光标选中的节点
        var currentNodes = _self.tree.getSelectedNodes();

        //为分类对象相应的字段赋值
        if(currentNodes && currentNodes.length>0){
            $('#parentId').val(currentNodes[0].pId);
            $('#parentCode').val(currentNodes[0].parentCode);

            var fatherCode = currentNodes[0].parentCode;
            if(fatherCode != null && fatherCode != undefined){
                fatherCode = fatherCode.replace(/(0+)$/g,"");
                $('#fatherCode').val(fatherCode);
            }
        }
        else{
            $('#parentId').val('');
            $('#parentCode').val('');
        }

        $('#id').val('');
        $('#belongCategory').val(_self.currentCategory);
    }
    else if(oprateType == 'AddSub'){
        //获取当前光标选中的节点
        var currentNodes = _self.tree.getSelectedNodes();

        //判断当前是否已选择父节点
        if(currentNodes && currentNodes.length > 0){
            document.getElementById('addClassifyDialog').style.display = 'inline'; //显示新增/编辑分类弹框
            document.getElementById('dialogTitle').innerHTML = '添加分类';   //设置新增/编辑分类弹框的标题

            //为分类对象相应的字段赋值
            $('#id').val('');
            $('#parentId').val(currentNodes[0].id);
            $('#parentCode').val(currentNodes[0].code);
            $('#belongCategory').val(currentCategory);

            var fatherCode = currentNodes[0].code;
            if(fatherCode != null && fatherCode != undefined){
                fatherCode = fatherCode.replace(/(0+)$/g,"");
                $('#fatherCode').val(fatherCode);
            }
        }
        else{
            layer.alert('添加子分类必须先选择父分类！', {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title:"提示"
                }
            );
        }
    }
    else if(oprateType == 'Edit'){
        //获取当前光标选中的节点
        var currentNodes = _self.tree.getSelectedNodes();

        //判断当前是否已选择父节点
        if(currentNodes && currentNodes.length > 0){
            document.getElementById('addClassifyDialog').style.display = 'inline'; //显示新增/编辑分类弹框
            document.getElementById('dialogTitle').innerHTML = '编辑分类';   //设置新增/编辑分类弹框的标题

            //为分类对象相应的字段赋值
            $('#id').val(currentNodes[0].id);
            $('#parentId').val(currentNodes[0].pId);
            $('#parentCode').val(currentNodes[0].parentCode);
            $('#belongCategory').val(currentCategory);

            var fatherCode = currentNodes[0].parentCode;
            fatherCode = fatherCode.replace(/(0+)$/g,"");

            var sonCode = currentNodes[0].code;
            sonCode = sonCode.replace(fatherCode, '');

            $('#name').val(currentNodes[0].name);
            $('#fatherCode').val(fatherCode);
            $('#sonCode').val(sonCode);
        }
        else{
            layer.alert('请先选择待编辑分类！', {
                    icon: 7,
                    area: ['400px', ''], //宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title:"提示"
                }
            );
        }
    }
};

/**
 * 保存方法
 */
ClassifyData.prototype.save = function() {
    var _self = this;

    var id = $('#id').val();
    var parentId = $('#parentId').val();

    var nodeName = $('#name').val();
    if(nodeName == ''){
        layer.msg("请填写分类名称！");
        return;
    }

    var sonCode = $('#sonCode').val();
    if(sonCode == ''){
        layer.msg("请填写分类编号！");
        return;
    }

    $('#code').val($('#fatherCode').val() + $('#sonCode').val());
    var nodeCode = $('#code').val();
    var nodeFatherCode = $('#fatherCode').val();

    avicAjax.ajax({
        url : _self.getUrl() + '/operation/save',
        data : {data: JSON.stringify(serializeObject($(_self._formId)))},
        type : 'post',
        dataType : 'json',
        success : function(result) {
            if (result.flag == "success") { //添加分类成功
                var treeNode = null;

                //获取当前光标选中的节点
                var currentNodes = _self.tree.getSelectedNodes();
                if(currentNodes && currentNodes.length > 0){
                    treeNode = currentNodes[0];
                }

                if(id == ''){
                    //添加子节点
                    if (treeNode) {
                        if(treeNode.id == parentId){
                            treeNode = _self.tree.addNodes(treeNode, {id:result.id, pId:parentId, isParent:false, name:nodeName, code:nodeCode, parentCode:nodeFatherCode});
                        }
                        else{
                            treeNode = treeNode.getParentNode();
                            treeNode = _self.tree.addNodes(treeNode, {id:result.id, pId:parentId, isParent:false, name:nodeName, code:nodeCode, parentCode:nodeFatherCode});
                        }
                    }
                    //添加根节点
                    else {
                        treeNode = _self.tree.addNodes(null, {id:result.id, pId:0, isParent:false, name:nodeName, code:nodeCode, parentCode:nodeFatherCode});
                    }

                    //将新增的节点置为选中状态
                    _self.tree.selectNode(treeNode[0]);
                }
                else{
                    _self.tree.editName(treeNode);
                    treeNode.name = nodeName;
                    _self.tree.cancelEditName(nodeName);
                }

                hiddenElement('addClassifyDialog'); //隐藏添加/编辑分类弹框
                layer.msg("保存成功");
            }
            else {
                layer.alert('保存失败：' + result.msg, {
                    icon : 7,
                    area : [ '400px', '' ],
                    closeBtn : 0,
                    btn : [ '关闭' ],
                    title : "提示"
                });
            }
        }
    });
};

/**
 * 删除方法
 */
ClassifyData.prototype.del = function() {
    var _self = this;
    hiddenElement('treeMenu');  //隐藏鼠标右键弹框

    //获取当前勾选的节点
    var selectNodes = _self.tree.getCheckedNodes(true);
    if(selectNodes && selectNodes.length>0){
        layer.confirm('确认要删除选中的数据吗?',  {icon: 3, title:"提示", area: ['400px', '']}, function(index){
            var ids = [];
            ids.push(currentCategory);

            for(i=0; i<selectNodes.length; i++){
                ids.push(selectNodes[i].id);
            }

            avicAjax.ajax({
                url: _self.getUrl() + '/operation/delete',
                data: JSON.stringify(ids),
                contentType : 'application/json',
                type: 'post',
                dataType: 'json',
                success : function(result){
                    if (result.flag == "success") {
                        var callbackFlag = $("#callbackTrigger").attr("checked");

                        for(i=0; i<selectNodes.length; i++){
                            _self.tree.removeNode(selectNodes[i], callbackFlag);
                        }
                    }
                    else{
                        layer.alert('删除失败：' + result.msg, {
                                icon: 7,
                                area: ['400px', ''],
                                closeBtn: 0,
                                btn: ['关闭'],
                                title:"提示"
                            }
                        );
                    }
                }
            });
            layer.close(index);
        });
    }
    else{
        layer.alert('请勾选要删除的分类！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title:"提示"
            }
        );
    }
};

/**
 * 节点上下移方法
 */
ClassifyData.prototype.upDownNode = function(moveType) {
    var _self = this;
    hiddenElement('treeMenu');  //隐藏鼠标右键弹框

    //获取当前光标选中的节点
    var currentNodes = _self.tree.getSelectedNodes();

    if(currentNodes && currentNodes.length>0){
        var targetNode = null;
        if(moveType == 'prev'){
            targetNode = currentNodes[0].getPreNode();
        }
        else if(moveType == 'next'){
            targetNode = currentNodes[0].getNextNode();
        }

        //顶部节点不可上移，底部节点不可下移
        if(targetNode == null){
            if(moveType == 'prev'){
                layer.msg('当前分类已处于同级的顶点，不可再上移！');
            }
            else if(moveType == 'next'){
                layer.msg('当前分类已处于同级的底部，不可再下移！');
            }
            return;
        }

        avicAjax.ajax({
            url: _self.getUrl() + '/operation/upDownNode',
            data: {
                sourceId : currentNodes[0].id,
                targetId : targetNode.id,
            },
            type : 'post',
            dataType : 'json',
            success : function(result){
                if (result.flag == "success"){
                    //移动节点
                    _self.tree.moveNode(targetNode, currentNodes[0], moveType, false);
                }
                else{
                    layer.alert('节点上下移失败：' + r.msg, {
                            icon: 7,
                            area: ['400px', ''],
                            closeBtn: 0,
                            btn: ['关闭'],
                            title:"提示"
                        }
                    );
                }
            }
        });
    }
    else{
        layer.alert('请选择要移动的分类！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title:"提示"
            }
        );
    }
};

/*根据元素id隐藏元素*/
function hiddenElement(id) {
    document.getElementById(id).style.display = 'none';
};
