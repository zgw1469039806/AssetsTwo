/*
* 判断字符串是否以指定字符串结尾——新增
*/
String.prototype.endWith = function (str) {
	var reg = new RegExp(str + "$");
	return reg.test(this);
}

function AcceptanceDeviceComponent(datagrid, url, formSub, dataGridColModel, searchDialogSub, pid, searchSubNames, demoSubUser_KeyWord, isReload) {
    if (!datagrid || typeof (datagrid) !== 'string' && datagrid.trim() !== '') {
        throw new Error("datagrid不能为空！");
    }
    var _url = url;
    this.getUrl = function () {
        return _url;
    }
    this._searchDialogId = "#" + searchDialogSub;
    this.searchForm = "#" + formSub;
    this.pid = pid;
    this._datagridId = "#" + datagrid;
    this.Toolbardiv = "#t_" + datagrid;
    this.Toolbar = "#toolbar_" + datagrid;
    this.Pagerlbar = "#" + datagrid + "Pager";
    this._keyWordId = "#" + demoSubUser_KeyWord;
    this._searchNames = searchSubNames;
    this.dataGridColModel = dataGridColModel;
    this.isReload = isReload;
    this.notnullFiled = [];//非空字段
    this.notnullFiledComment = []; //非空字段注释
    //除时间,数字等类型长度校验字段
    this.lengthValidFiled = [];
    //除时间,数字等类型长度校验字段注释
    this.lengthValidFiledComment = [];
    //除时间,数字等类型长度
    this.lengthValidFiledSize = [];
    this.init.call(this);
};

/**
 * 初始化操作
 */
AcceptanceDeviceComponent.prototype.init = function (pid) {
    var _self = this;
    if (_self.isReload == "true") {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAcceptanceDeviceComponent',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: acceptanceDeviceComponentGridColModel,
            height: 200,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            altRows: true,
            pagerpos: 'left',
            hasColSet: false,//设置显隐属性
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            width: document.body.clientWidth - 400,
            autowidth: false,
            shrinkToFit: true,
            responsive: true,//开启自适应
            cellEdit: true,
            beforeEditCell:function(){
                $(".datatable").not(_self._datagridId).each(function(){
                    $(this).jqGrid('endEditCell');
                });
            },
            cellsubmit: 'clientArray'
        });
    } else if (_self.isReload == "edit") {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAcceptanceDeviceComponent',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: acceptanceDeviceComponentGridColModel,
            height: 200,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            altRows: true,
            pagerpos: 'left',
            hasColSet: false,//设置显隐属性
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            autowidth: true,
            shrinkToFit: true,
            responsive: true,//开启自适应
            cellEdit: true,
            cellsubmit: 'clientArray'
        });
    } else {
        $(_self._datagridId).jqGrid({
            url: _self.getUrl() + 'getAcceptanceDeviceComponent',
            postData: {pid: _self.pid},
            mtype: 'POST',
            datatype: "json",
            toolbar: [true, 'top'],
            colModel: _self.dataGridColModel,
            height: $(window).height() - 410,//120:顶部工具栏高+表头高+底部翻页模块高，17：顶部toolbar的内边距高度
            scrollOffset: 10, //设置垂直滚动条宽度
            rowNum: 20,
            rowList: [200, 100, 50, 30, 20, 10],
            altRows: true,
            pagerpos: 'left',
            hasColSet: false,//设置显隐属性
            loadComplete: function () {
                $(this).jqGrid('getColumnByUserIdAndTableName');
            },
            styleUI: 'Bootstrap',
            viewrecords: true, //
            multiselect: true,
            autowidth: true,
            shrinkToFit: true,
            responsive: true,//开启自适应
            pager: _self.Pagerlbar

        });

        $(_self.Toolbardiv).append($(_self.Toolbar));
    }

    $('.date-picker').datepicker({
        beforeShow: function () {
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    $('.time-picker').datetimepicker({
        oneLine: true,//单行显示时分秒
        closeText: '确定',//关闭按钮文案
        showButtonPanel: true,//是否展示功能按钮面板
        showSecond: false,//是否可以选择秒，默认否
        beforeShow: function (selectedDate) {
            if ($('#' + selectedDate.id).val() == "") {
                $(this).datetimepicker("setDate", new Date());
                $('#' + selectedDate.id).val('');
            }
            setTimeout(function () {
                $('#ui-datepicker-div').css("z-index", 99999999);
            }, 100);
        }
    });
    $(_self._keyWordId).on('keydown', function (e) {
        if (e.keyCode == '13') {
            _self.searchByKeyWord();
        }
    });

    //禁止时间和日期格式手输
    $('.date-picker').on('keydown', nullInput);
    $('.time-picker').on('keydown', nullInput);

    //初始化校验字段
    _self.lengthValidFiled.push("acceptanceId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("验收单ID");
    _self.lengthValidFiled.push("deviceId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("主设备ID");
    _self.lengthValidFiled.push("parentUnifiedId");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("主设备统一编号");
    _self.lengthValidFiled.push("componentName");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("组件名称");
    _self.lengthValidFiled.push("componentCategory");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("组件类别");
    _self.lengthValidFiled.push("componentModel");
    _self.lengthValidFiledSize.push(50);
    _self.lengthValidFiledComment.push("组件型号");

};

/**
 * 添加页面
 */
var newRowIndex = 0;
var newRowStart = "new_row";
AcceptanceDeviceComponent.prototype.insert = function () {
    debugger;
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var hasvalidate = true;
    var data = $(_self._datagridId).jqGrid('getRowData');
    if (data.length > 0 && _self.notnullFiled.length > 0) {
        $.each(_self.notnullFiled, function (i, item) {
            var msg = _self.nullvalid(data, item, _self.notnullFiled, _self.notnullFiledComment);
            if (msg && msg.length > 0) {
                layer.alert(msg, {
                    icon: 7,
                    area: ['400px', ''], // 宽高
                    closeBtn: 0,
                    btn: ['关闭'],
                    title: "提示"
                });
                hasvalidate = false;
                return false;
            }
        });
    }
    if (!hasvalidate) {
        return false;
    }

    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    };
    $(_self._datagridId).jqGrid('addRow', parameters);
    newRowIndex++;

    $(_self._datagridId).jqGrid('editRow', newRowId, { keys: true, focusField: 1 });
};

/**
 * 非空验证
 * @param
 * @param
 */
AcceptanceDeviceComponent.prototype.nullvalid = function (data, item, nullfiled, notnullFiledComment) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] == "") {
            temp = false;
            msg = notnullFiledComment[$.inArray(item, nullfiled)] + "为必填字段";
        }
    })
    return msg;
}

/**
 * 长度验证
 * @param
 * @param
 */
AcceptanceDeviceComponent.prototype.lengthvalid = function (data, item, lengthValidFiled, lengthValidFiledComment, lengthValidFiledSize) {
    var msg = "";
    $.each(data, function (i, dataitem) {
        if (dataitem[item] != "" && dataitem[item] != undefined && dataitem[item].replace(/[^\x00-\xff]/g, "**").length > lengthValidFiledSize[$.inArray(item, lengthValidFiled)]) {
            msg = lengthValidFiledComment[$.inArray(item, lengthValidFiled)] + "的输入长度超过预设长度" + lengthValidFiledSize[$.inArray(item, lengthValidFiled)];
        }
    })
    return msg;
}

/*
 * 长度和非空校验
 */
AcceptanceDeviceComponent.prototype.valid = function () {
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var isAddRow = false; //是新增行
    var data = $(_self._datagridId).jqGrid('getChangedCells');
    var Rowdata = $(_self._datagridId).jqGrid('getRowData');
    if (Rowdata.length > 0) {
        for (var i = 0; i < Rowdata.length; i++) {
            if (Rowdata[i].id == "") {
                isAddRow = true;
            }
        }
    }
    var hasvalidate = true;
    var msg = "";
    if (data.length == 0 && isAddRow) {
        msg = "请修改子表数据";
    } else {
        $.each(_self.notnullFiled, function (i, item) {
            msg = _self.nullvalid(Rowdata, item, _self.notnullFiled, _self.notnullFiledComment);
            if (msg && msg.length > 0) {
                hasvalidate = false;
                return false;
            }
        });
        $.each(_self.lengthValidFiled, function (i, item) {
            if (hasvalidate) {
                msg = _self.lengthvalid(Rowdata, item, _self.lengthValidFiled, _self.lengthValidFiledComment, _self.lengthValidFiledSize);
                if (msg && msg.length > 0) {
                    hasvalidate = false;
                    return false;
                }
            }
        });
    }
    return msg;
};

/**
 * 保存功能
 * @param pid
 */
AcceptanceDeviceComponent.prototype.save = function (pid) {
    var _self = this;
    _self.pid = pid;
    $(_self._datagridId).jqGrid('endEditCell');
    var data = $(_self._datagridId).jqGrid('getRowData');
    if (data && data.length > 0) {
        avicAjax.ajax({
            url: _self.getUrl() + "save",
            data: {
                data: JSON.stringify(data),
                pid: pid
            },
            type: 'post',
            dataType: 'json',
            success: function (r) {
                if (r.flag == "success") {
                    _self.reLoad();
                    if (typeof (closeForm) != "undefined") {
                        closeForm();
                    }
                } else {
                    layer.alert('保存失败,请联系管理员!', {
                            icon: 7,
                            area: ['400px', ''], //宽高
                            closeBtn: 0,
                            btn: ['关闭'],
                            title: "提示"
                        }
                    );
                }
            }
        });
    } else {
        //关闭弹窗
        if (typeof (closeForm) != "undefined") {
            closeForm();
        }
    }
};

/**
 * 删除
 */
AcceptanceDeviceComponent.prototype.del = function () {
    var _self = this;
    //删除之前结束单元格
    $(_self._datagridId).jqGrid('endEditCell');
    var rows = $(_self._datagridId).jqGrid('getGridParam', 'selarrrow');
    var isAddRow = false; //是新增行
    var notAddRow = false; //不是新增行
    var ids = [];
    var l = rows.length;
    if (l > 0) {
        for (var i = 0; i < l; i++) {
            if (rows[i].indexOf("new_row") != -1) {
                isAddRow = true;
            } else {
                notAddRow = true;
            }
            ids.push(rows[i]);
        }
    }
    if (isAddRow && notAddRow) {
        layer.alert('请确保上一条数据修改完毕！', {
            icon: 7,
            area: ['400px', ''], //宽高
            closeBtn: 0,
            title: '提示'
        });
        return false;
    } else if (isAddRow && !notAddRow) {
        for (var i = 0; i < ids.length; i++) {
            $(_self._datagridId).jqGrid('delRowData', ids[i]);
        }
        $('#cb_acceptanceDeviceComponent').click();
        return false;
    }
    if (l > 0) {
        layer.confirm('确认要删除选中的数据吗?', {icon: 3, title: "提示", area: ['400px', '']}, function (index) {
            avicAjax.ajax({
                url: _self.getUrl() + 'delete',
                data: JSON.stringify(ids),
                contentType: 'application/json',
                type: 'post',
                dataType: 'json',
                success: function (r) {
                    if (r.flag == "success") {
                        _self.reLoad();
                    } else {
                        layer.alert('删除失败,请联系管理员!', {
                                icon: 7,
                                area: ['400px', ''],
                                closeBtn: 0,
                                btn: ['关闭'],
                                title: "提示"
                            }
                        );
                    }
                }
            });
            layer.close(index);
        });
    } else {
        layer.alert('请选择要删除的数据！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            }
        );
    }
};

/**
 * 重载数据
 */
AcceptanceDeviceComponent.prototype.reLoad = function (pid) {
    if (pid != undefined) {
        this.pid = pid;
    }
    pid = this.pid;
    var searchdata = {pid: pid};
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 获取子表数据
 */
AcceptanceDeviceComponent.prototype.getSubData = function () {
    var _self = this;
    $(_self._datagridId).jqGrid('endEditCell');
    var data = $(_self._datagridId).jqGrid('getRowData');
    return JSON.stringify(data);
};

/**
 * 关闭对话框
 */
AcceptanceDeviceComponent.prototype.closeDialog = function (id) {
    if (id == "insert") {
        layer.close(this.insertIndex);
    } else {
        layer.close(this.editIndex);
    }
};

/**
 * 打开高级查询框
 */
AcceptanceDeviceComponent.prototype.openSearchForm = function (searchDiv, par) {
    var _self = this;
    par = null;
    //if(!par) par = $(window);
    var contentWidth = 600; //(par.width()*.6 >= 600)?600:par.width()*.6;
    var top = $(searchDiv).offset().top + $(searchDiv).outerHeight(true);
    var left = $(searchDiv).offset().left + $(searchDiv).outerWidth() - contentWidth;
    var text = $(searchDiv).text();
    var width = $(searchDiv).innerWidth();


    layer.config({
        extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
    });
    layer.open({
        type: 1,
        shift: 5,
        title: false,
        scrollbar: false,
        move: false,
        area: [contentWidth + 'px', '400px'],
        offset: [top + 'px', left + 'px'],
        closeBtn: 0,
        shadeClose: true,
        btn: ['查询', '清空', '取消'],
        content: $(_self._searchDialogId),
        success: function (layero, index) {
            var serachLabel = $('<div class="serachLabel"><span>' + text + '</span><span class="caret"></span></div>').appendTo(layero);
            serachLabel.bind('click', function () {
                layer.close(index);
            });
            serachLabel.css('width', width + 'px');
        },
        yes: function (index, layero) {
            _self.searchData();
            layer.close(index);
        },
        btn2: function (index, layero) {
            _self.clearData();
            return false;
        },
        btn3: function (index, layero) {

        }
    });
};

/**
 * 高级查询
 */
AcceptanceDeviceComponent.prototype.searchData = function (dataGridColModel) {
    /*新增代码，将表头搜索框内的搜索数据同步至高级搜索——开始*/
    if (dataGridColModel != undefined && dataGridColModel != null) {
        for (n = 0; n < dataGridColModel.length; n++) {
            var colName = dataGridColModel[n].name;

            //日期类型
            if (colName.endWith('Date')) {
                var headEle = document.getElementById(colName + 'Begin_head');
                var searchEle = document.getElementById(colName + 'Begin');

                if ((headEle != null && headEle != undefined) && (searchEle != null && searchEle != undefined)) {
                    searchEle.value = headEle.value;
                }

                headEle = document.getElementById(colName + 'End_head');
                searchEle = document.getElementById(colName + 'End');

                if ((headEle != null && headEle != undefined) && (searchEle != null && searchEle != undefined)) {
                    searchEle.value = headEle.value;
                }
            } else {
                var headEle = document.getElementById(colName + '_head');
                var searchEle = document.getElementById(colName);

                if ((headEle != null && headEle != undefined) && (searchEle != null && searchEle != undefined)) {
                    searchEle.value = headEle.value;
                }

                if (colName.indexOf('Alias') > -1) {
                    var headIdStr = colName.replace('Alias', '_head');
                    var searchIdStr = headIdStr.replace('_head', '');

                    var headEle1 = document.getElementById(headIdStr);
                    var searchEle1 = document.getElementById(searchIdStr);

                    if ((headEle1 != null && headEle1 != undefined) && (searchEle1 != null && searchEle1 != undefined)) {
                        searchEle1.value = headEle1.value;
                    }
                }
            }
        }
    }
    /*新增代码，将表头搜索框内的搜索数据同步至高级搜索——结束*/

    var datebox = $('.date-picker,.time-picker');
    var data = [];
    $.each(datebox, function (i, item) {
        data[i] = $(item).val();
    });
    for (var i = 0; i < (data.length / 2); i++) {
        if (data[2 * i] == "" || data[2 * i + 1] == "" || data[2 * i] == null || data[2 * i + 1] == null) {
            continue;
        }
        if (data[2 * i] > data[2 * i + 1]) {
            layer.alert("查询时,结束日期不能小于起始日期 ！", {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0,
                btn: ['关闭'],
                title: "提示"
            });
            return;
        }
    }
    var searchdata = {
        keyWord: null,
        pid: this.pid,
        param: JSON.stringify(serializeObject($(this.searchForm)))
    };
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 关键字段查询
 */
AcceptanceDeviceComponent.prototype.searchByKeyWord = function () {
    var keyWord = $(this._keyWordId).val() == $(this._keyWordId).attr("placeholder") ? "" : $(this._keyWordId).val();
    var names = this._searchNames;

    var param = {};
    for (var i in names) {
        var name = names[i];
        param[name] = keyWord;
    }

    var searchdata = {
        keyWord: JSON.stringify(param),
        pid: this.pid,
        param: null
    };
    $(this._datagridId).jqGrid('setGridParam', {datatype: 'json', postData: searchdata}).trigger("reloadGrid");
};

/**
 * 隐藏查询框
 */
AcceptanceDeviceComponent.prototype.hideSearchForm = function () {
    layer.close(searchDialogindex);
};

/**
 * 清空查询条件
 */
AcceptanceDeviceComponent.prototype.clearData = function () {
    clearFormData(this.searchForm);
    this.searchData();
};

/*表头搜索、拖拽、视图模块新增代码——开始*/
/**
 * 为表头元素添加拖拽、鼠标右键事件
 */
function SubBuildDrag(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId, jqGridObject, toolBar){
	//解决拖拽刷新列表后，列表上方的按钮、搜索框消失的问题
	var tool = document.getElementById('toolbar_'+tableId);

	if (tool == undefined || tool == null) {
		var toolFather = document.getElementById('t_' + tableId + 'jqGrid');
		if (toolFather == undefined || toolFather == null) {
			toolFather = document.getElementById('t_' + tableId);
		}

        if (toolFather != undefined && toolFather != null) {
            toolFather.innerHTML += toolBar.outerHTML;
        }

		//查询按钮绑定事件
		$('#' + tableId + '_searchPart').bind('click', function () {
			jqGridObject.searchByKeyWord();
		});

        //搜索框enter事件监控：enter触发搜索
        $('#' + keywordId).on('keydown', function (e) {
            if (e.keyCode == '13') {
                jqGridObject.searchByKeyWord();
            }
        });
	}

	for (i = 0; i < dataGridColModel.length; i++) {
		var thEle = document.getElementById(tableId + 'jqGrid_' + dataGridColModel[i].name);
		if (thEle == undefined || thEle == null) {
			thEle = document.getElementById(tableId + '_' + dataGridColModel[i].name);
		}

		if (thEle == undefined || thEle == null) {
			continue;
		}

		//禁用元素的windows右键菜单
		thEle.addEventListener('contextmenu', function (event) {
			event.preventDefault();   // 阻止浏览器鼠标右击事件。
		}, false);

		//为表头元素添加拖拽事件
		thEle.onmousedown = function myMousedown(event) {
			var firstDragWidth = true;
			//鼠标左键按下事件
			if (event.which == 1) {
				//防止拖拽事件误触发
				var targetSrc = event.target.outerHTML;

				if (targetSrc.indexOf('Alias_head') > -1) {
					var textFiledStr = event.target.id;
					var idFiledStr = textFiledStr.replace('Alias', '');

					if (targetSrc.indexOf('选择部门') > -1) {
						new H5CommonSelect({
							type: 'deptSelect',
							idFiled: idFiledStr,
							textFiled: textFiledStr,
							selectModel: 'multi'
						});
						this.blur();
						nullInput(event);
					}
					else if (targetSrc.indexOf('选择用户') > -1) {
						new H5CommonSelect({
							type: 'userSelect',
							idFiled: idFiledStr,
							textFiled: textFiledStr,
							selectModel: 'multi'
						});
						this.blur();
						nullInput(event);
					}
				}
				else if (targetSrc.indexOf('selectCategory') > -1) {
					var textFiledStr = event.target.id;
					var idFiledStr = textFiledStr.replace('Names', '');

					var lookupCode = targetSrc.substring(targetSrc.indexOf('lookupcode=') + 12);
					lookupCode = lookupCode.substring(0, lookupCode.indexOf('"'));

					//获取当前已选中的分类
					var defaultLoadCategoryId = $('#' + idFiledStr).val();

					new H5CommonSelect({
						type: 'categorySelect',
						idFiled: idFiledStr,
						textFiled: textFiledStr,
						selectModel: 'multi',
						currentCategory: lookupCode,
						defaultLoadCategoryId: defaultLoadCategoryId
					});
					this.blur();
					nullInput(event);
				}
				else if (targetSrc.indexOf('selectLookup') > -1) {
					var textFiledStr = event.target.id;
					var idFiledStr = textFiledStr.replace('Names', '');

					var lookupCode = targetSrc.substring(targetSrc.indexOf('lookupcode=') + 12);
					lookupCode = lookupCode.substring(0, lookupCode.indexOf('"'));

					//获取当前已选中的分类
					var defaultLoadLookupId = $('#' + idFiledStr).val();

					new H5CommonSelect({
						type: 'lookupSelect',
						idFiled: idFiledStr,
						textFiled: textFiledStr,
						selectModel: 'multi',
						lookupcode: lookupCode,
						defaultLookupcodeId: defaultLoadLookupId
					});
					this.blur();
					nullInput(event);
				}

				if (targetSrc.indexOf('<input') == 0) {
					return;
				}

				var event = event || window.event;  //兼容IE浏览器
				var dragIndex = -1;  //被拖拽表头的下标

				//点击的元素为搜索框图标元素
				if (targetSrc.indexOf('<span class="input-group-addon') == 0) {
					return;
				}

				var currentView = 'MyView';

				//点击的元素为列宽调整元素
				if (targetSrc.indexOf('<span class="ui-jqgrid-resize ui-jqgrid-resize-ltr"') == 0) {
					//鼠标移动结束后鼠标弹起事件
					document.onmouseup = function (event) {
						//更新dataGridColModel中的列宽
						for (n = 1; n < dataGridColModel.length - 1; n++) {
							var ele = document.getElementById(tableId + 'jqGrid_' + dataGridColModel[n].name);
							if (ele == undefined || ele == null) {
								var ele = document.getElementById(tableId + '_' + dataGridColModel[n].name);
							}

							dataGridColModel[n].width = ele.offsetWidth;
						}

						//更新视图，firstDragWidth防止死循环更新视图的问题
						if (firstDragWidth) {
							SubUpdateTableHead(dataGridColModel, currentView);
							firstDragWidth = false;
							return;
						}

					}
				}

				//点击的元素为非列宽调整元素
				if (targetSrc.indexOf('<span') != 0 && targetSrc.indexOf('<i') != 0) {
					var dragElementId = event.target.id;
					var drag = document.getElementById(dragElementId);

					if (typeof drag.setCapture !== 'undefined') {
						drag.setCapture();
					}

					//鼠标移动结束后鼠标弹起事件
					document.onmouseup = function (event) {
						this.onmousemove = null;  //清除鼠标移动事件
						this.onmouseup = null;  //清除鼠标按下事件

						if (typeof drag.releaseCapture != 'undefined') {
							drag.releaseCapture();
						}

						var toElementId = event.target.id;
						//元素移动起始元素为同意元素，元素未移动
						if (dragElementId == toElementId) {
							return;
						}

						//元素移动
						else {
							var dragIndex = -1;
							var newIndex = -1;

							//获取移动元素和目标元素的下标
							for (j = 0; j < dataGridColModel.length; j++) {
								var tempId = dataGridColModel[j].name;

								if (dragElementId.endWith('_' + tempId)) {
									dragIndex = j;
								} else if (toElementId.endWith('_' + tempId)) {
									newIndex = j;
								}

								if ((dragIndex != -1) && (newIndex != -1)) {
									break;
								}
							}

							if ((dragIndex == -1) || (newIndex == -1)) {
								return;
							}

							//左移
							if (dragIndex > newIndex) {
								//更新表头数组
								var dragEle = dataGridColModel[dragIndex];
								for (m = dragIndex; m > newIndex; m--) {
									dataGridColModel[m] = dataGridColModel[m - 1];
									jqGridObject.dataGridColModel[m] = dataGridColModel[m - 1];
								}
								dataGridColModel[newIndex] = dragEle;

								//清除列表后刷新
								$.jgrid.gridUnload(tableId);
								jqGridObject = new AcceptanceDeviceComponent(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId);

								//添加表头拖拽
                                SubBuildDrag(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId, jqGridObject, toolBar);

								//添加表头搜索
								SubAddHeaderSearch(dataGridColModel, tableId, jqGridObject);

								//更新视图
								SubUpdateTableHead(dataGridColModel, currentView);
								return;
							}

							//右移
							if (dragIndex < newIndex) {
								//更新表头数组
								var dragEle = dataGridColModel[dragIndex];
								for (m = dragIndex; m < newIndex; m++) {
									dataGridColModel[m] = dataGridColModel[m + 1];
								}
								dataGridColModel[newIndex] = dragEle;

								//清除列表后刷新
								$.jgrid.gridUnload(tableId);
								jqGridObject = new AcceptanceDeviceComponent(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId);

                                //添加表头拖拽
                                SubBuildDrag(tableId, url, searchFormId, dataGridColModel, searchDialogId, pid, searchNames, keywordId, jqGridObject, toolBar);

								//添加表头搜索
								SubAddHeaderSearch(dataGridColModel, tableId, jqGridObject);

								//更新视图
								SubUpdateTableHead(dataGridColModel, currentView);
								return;
							}
						}
					}
				}
			}

			//鼠标右键按下事件
			else if (event.which == 3) {
				showSelect('rightMenu');
			}
		}
	}
}

/**
 * 添加表头搜索
 */
function SubAddHeaderSearch(dataGridColModel, tableId, jqGridObject) {
	for (n = 0; n < dataGridColModel.length; n++) {
		var colName = dataGridColModel[n].name;
		var thEle = document.getElementById(tableId + '_' + colName);

		if ((thEle != null) && (thEle != undefined)) {
			thEle.style.height = '36px';

			//日期类型
			if (colName.endWith('Date')) {
				var searchEle = document.getElementById(colName + 'Begin').parentNode;
				var searchEleHtml = '<div>';

				if ((searchEle != undefined) && (searchEle != null)) {
					searchEleHtml += '<div style="width:40%; float:left;">' + searchEle.outerHTML + '</div>';
					searchEleHtml = searchEleHtml.replaceAll(colName + 'Begin', colName + 'Begin_head');
				}

				searchEleHtml += '<div style="width:15%; height:30px; float:left;  text-align:center; line-height:30px; ">至</div>';

				searchEle = document.getElementById(colName + 'End').parentNode;
				if ((searchEle != undefined) && (searchEle != null)) {
					searchEleHtml += '<div style="width:40%; float:left; vertical-align:middle;">' + searchEle.outerHTML + '</div>';
					searchEleHtml = searchEleHtml.replaceAll(colName + 'End', colName + 'End_head');
				}

				searchEleHtml = searchEleHtml.replaceAll('hasDatepicker', '');
				thEle.innerHTML = searchEleHtml + '</div>' + thEle.innerHTML;
			}
			//非日期类型
			else {
				var searchEle = document.getElementById(colName);

				if ((searchEle != undefined) && (searchEle != null)) {
					var searchEleHtml = searchEle.outerHTML;

					if (searchEleHtml.indexOf('<textarea') == 0) {
						searchEleHtml = searchEleHtml.replace('id="' + colName + '"', 'id="' + colName + '_head"');
						searchEleHtml = searchEleHtml.replace('name="' + colName + '"', 'name="' + colName + '_head"');

						thEle.innerHTML = "<input title='" + dataGridColModel[n].label + "' class='form-control input-sm' type='text' name='" + colName + "_head' id='" + colName + "_head' />" + thEle.innerHTML;
					} else if (searchEleHtml.indexOf('Alias') > -1) {
						var parentNode = searchEle.parentNode;
						searchEleHtml = parentNode.outerHTML;

						searchEleHtml = searchEleHtml.replaceAll('Alias', 'Alias_head');

						var colnumName = colName;
						colnumName = colnumName.replace('Alias', '');

						searchEleHtml = searchEleHtml.replace('id="' + colnumName + '"', 'id="' + colnumName + '_head"');
						searchEleHtml = searchEleHtml.replace('name="' + colnumName + '"', 'name="' + colnumName + '_head"');

						thEle.innerHTML = searchEleHtml + thEle.innerHTML;
					} else if (searchEleHtml.indexOf('selectCategory') > -1 || searchEleHtml.indexOf('selectLookup') > -1) {
						var parentNode = searchEle.parentNode;
						searchEleHtml = parentNode.outerHTML;

						var colnumName = colName;
						searchEleHtml = searchEleHtml.replace('id="' + colnumName + 'Names"', 'id="' + colnumName + 'Names_head"');
						searchEleHtml = searchEleHtml.replace('id="' + colnumName + '"', 'id="' + colnumName + '_head"');

						searchEleHtml = searchEleHtml.replace('name="' + colnumName + 'Names"', 'name="' + colnumName + 'Names_head"');
						searchEleHtml = searchEleHtml.replace('name="' + colnumName + '"', 'name="' + colnumName + '_head"');

						thEle.innerHTML = searchEleHtml + thEle.innerHTML;
					} else {
						searchEleHtml = searchEleHtml.replace('id="' + colName + '"', 'id="' + colName + '_head"');
						searchEleHtml = searchEleHtml.replace('name="' + colName + '"', 'name="' + colName + '_head"');

						thEle.innerHTML = searchEleHtml + thEle.innerHTML;
					}
				}
			}
		}
	}

    //表头搜索enter事件监控：enter触发搜索
    $('#' + tableId + '_id').parent().on('keydown', function (e) {
        if (e.keyCode == '13') {
            jqGridObject.searchData(dataGridColModel);
        }
    });
}

/**
 * 更新列表视图
 */
function SubUpdateTableHead(dataGridColModel, currentView){
    var modelList = [];
    modelList.push('AcceptanceDeviceComponent');
    modelList.push(currentView);

    for(var i = 0;i<dataGridColModel.length;i++){
        modelList.push(JSON.stringify(dataGridColModel[i]));
    }

    avicAjax.ajax({
        url : "assets/device/usertablemodel/userTableModelController/operation/save",
        data : JSON.stringify(modelList),
        contentType : 'application/json',
        type : 'post',
        dataType : 'json',
        success : function(r){
            document.getElementById('tableViewSelect').value = currentView;
            if (r.flag == "success"){
                layer.msg('视图更新成功！');
            }else{
                layer.alert('视图更新失败,请联系管理员：'+r.message, {
                        icon: 7,
                        area: ['400px', ''], //宽高
                        closeBtn: 0,
                        btn: ['关闭'],
                        title:"提示"
                    }
                );
                return;
            }
        }
    });
}
/*表头搜索、拖拽、视图模块新增代码——结束*/
