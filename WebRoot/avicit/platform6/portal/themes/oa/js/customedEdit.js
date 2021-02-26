
var notnullFiled=["sysGroupName","sysUserName","value"];//非空字段
var notnullFiledComment=["群组名称","群组成员","审批意见"]; //非空字段注释
//除时间,数字等类型长度校验字段
var lengthValidFiled = ["sysGroupName","value"];
//除时间,数字等类型长度校验字段注释
var lengthValidFiledComment = ["群组名称","审批意见"];
//
var lengthValidFiledSize = [100,500];


//验证
function formValidate($form){
    $form.validate({
        rules: {
            nameEn:{
                isEnName: true,
                maxlength:50
			},
            email: {
                email: true,
                maxlength:50
            },
            homeAddress:{
                maxlength:100
			},
            homeTel: {
                isTel:true,
                maxlength:50
            },
            mobile: {
                isMobile: true,
                maxlength:50
            },
            officeTel: {
                isTel: true,
					maxlength:50
			},
            fax: {
                isTel: true,
                maxlength:50
            }
        },
		message:{
            nameEn:{
                isEnName: "请正确填写您的英文名",
                maxlength:"最多可以输入50个字符"
            },
            email: {
                email: "请正确填写您的邮箱",
                maxlength:"最多可以输入50个字符"
            },
            homeAddress:{
                maxlength:"最多可以输入100个字符(一个中文字符长度为2)"
            },
            homeTel: {
                isTel:"请正确填写您的电话号码",
                maxlength:"最多可以输入50个字符"
            },
            mobile: {
                isMobile: "请正确填写您的手机号码",
                maxlength:"最多可以输入50个字符"
            },
            officeTel: {
                isTel: "请正确填写您的电话号码",
                maxlength:"最多可以输入50个字符"
            },
            fax: {
                isTel: "请正确填写您的电话号码",
                maxlength:"最多可以输入50个字符"
            }
		}
    });
}

//关闭layer
function closeForm(){
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index);
}

//保存
function saveForm($form){
    var isValidate = $form.validate();
    if (!isValidate.checkForm()) {
        isValidate.showErrors();
        return false;
    }
    save($form);
}

//保存功能
function save($form){

    $.ajax({
        url: "platform/console/customed/updateUser",
        data : {"user" :JSON.stringify(serializeObject($form))},
        type : 'post',
        dataType : 'json',
        success : function(r){
            if (r.flag == "success"){
                layer.msg('保存成功！',{icon:1,title: "提示",area: ['400px', '']});
                setTimeout(closeForm, 1000);
            }else{
                layer.alert('保存失败！',{icon: 2,title: "提示",area: ['400px', '']});
            }
        }
    });
}

//打开用户头像选择
function chooseUserPhoto(){

	layer.config({
	  extend: 'skin/layer-bootstrap.css' // boostraps风格modal外框
	});

	layer.open({
		type: 1,
		shift: 5,
		title: false,
		scrollbar: false,
		move : true,
		area: ['500px', '200px'],
		closeBtn: 0,
		shadeClose: true,
		btn: ['上传', '取消'],
		content: $('#addUserPhotoDialog'),
		yes: function(index, layero){
			if(upLoadUserPhoto()){
                layer.close(index);
            }
		},
		btn3: function(index, layero){
			layer.close(index);
		}
	});
}

//上传头像
function upLoadUserPhoto(){
	if($("#sysUserPhoto").val() != ''){
		if(checkfiletype('sysUserPhoto')){
			$('#uploadForm').submit();
			return true;
		}else{
            layer.alert('只能上传如下[jpg,png,gif,bmp]格式头像文件!',{icon: 7, closeBtn: 0});
            return false;
        }
	}else{
		layer.alert('请选择要上传的头像文件!',{icon: 7, closeBtn: 0});
		return false;
	}
}

function checkfiletype(id){
	var fileName = $("#"+id).val();
	//设置文件类型数组
	var extArray =[".jpg",".png",".gif",".bmp"];
	//获取文件名称
	while (fileName.indexOf("//") != -1)
		fileName = fileName.slice(fileName.indexOf("//") + 1);
    while (fileName.indexOf("\\") != -1)
        fileName = fileName.slice(fileName.indexOf("\\") + 1);
	//获取文件扩展名
	var ext = fileName.slice(fileName.lastIndexOf(".")).toLowerCase();
	//遍历文件类型
	var count = extArray.length;
	for (;count--;){
		if (extArray[count] == ext){
			return true;
		}
	}

   return false;
}

// 个人群组表格初始化
function personGroupJqGridInit($personGroupJqGrid) {
	var lastSelection;

    $personGroupJqGrid.jqGrid({
        url : "platform/console/customed/getPersonalGroupListByPage",
        mtype : 'POST',
        datatype : "json",
        toolbar : [ true, 'top' ],
        colModel : [
            {label : 'id', name : 'id', key : true, hidden : true},
            {label : '群组ID', name : 'sysGroupId', hidden : true},
            {label : '群组名称', name : 'sysGroupName', width : 250, editable:true},
            {label : '群组成员ID', name : 'sysUserId',  hidden : true},
            {label : '群组成员', name : 'sysUserName', width : 575, editable:true, edittype:"custom",editoptions: {custom_element: userNameElem, custom_value:userNameValue, forId:"sysUserId"}}
        ],
        height : $(window).height() - 168,
        scrollOffset : 20, // 设置垂直滚动条宽度
        rowNum : 10,
        rowList : [ 200, 100, 50, 30, 20, 10 ],
        altRows : true,
        pagerpos:'left',//分页栏位置
        styleUI : 'Bootstrap',
        viewrecords : true,
        multiselect : true,
        autowidth : true,
        responsive : true,// 开启自适应
        cellEdit:true,
        cellsubmit: 'clientArray',
        scrollrows:true,
        rownumbers:false,
        pager : "#personGroupJqGridPager",
        loadComplete:function(){
            $("#set_personGroupJqGridPager").hide();
            $("#exportExcel_personGroupJqGridPager").hide();
        }
    });
    $("#t_personGroupJqGrid").append($("#personGroupTableToolbar"));

    $('.dropdown-menu').click(function(e) {
        e.stopPropagation();
    });
}

//群组成员
function userNameElem(value, options){
    var rowId = options.rowId;
    var forId = options.forId;
    var rowData = $(this).jqGrid('getRowData', rowId);

    var $elem = $('<div class="input-group input-group-sm" style="margin:2px">'+
                    '<input type="hidden" id="cellRowId" value="'+ rowId +'">'+
                    '<input type="hidden" id="cellForId" value="'+ forId +'">'+
                    '<input type="hidden" id="cellUserId" name="cellUserId" value="'+ rowData[forId] +'">'+
                    '<input class="form-control" placeholder="请选择用户" type="text" id="cellUserName" name="cellUserName" readonly value="'+ value +'">'+
                    '<span class="input-group-addon">'+
                        '<i class="glyphicon glyphicon-user"></i>'+
                    '</span>'+
                '</div>');

    $elem.find('#cellUserName, .input-group-addon').on('click',function() {
        new H5CommonSelect({type: 'userSelect', selectModel: "multi", idFiled: 'cellUserId',viewScope:'currentOrg', textFiled: 'cellUserName'});
    });

    return $elem;
}

//群组成员
function userNameValue(elem, operation, value) {
    if (operation === 'get') {
        var rowId = $(elem).find('#cellRowId').val();
        var forId = $(elem).find('#cellForId').val();
        var userId = $(elem).find('#cellUserId').val();
        var rowData = {};
        rowData[forId] = userId;
        $(this).jqGrid('setRowData', rowId, rowData);
        return $(elem).find('#cellUserName').val();
    } else if (operation === 'set') {
        $(elem).find('#cellUserName').val(value);
    }
}

var personGroupNewRowIndex = 0;
var personGroupNewRowStart = "pn_new_row";

//个人群组添加按钮
function addPersonGroup($personGroupJqGrid){

    $personGroupJqGrid.jqGrid('endEditCell');

    //校验
    var vlidateFlag = validPersonGroup($personGroupJqGrid);
    if(!vlidateFlag) {
        return false;
    }
    //添加数据
    var newRowId = personGroupNewRowStart + personGroupNewRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {id:newRowId},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    }
    $personGroupJqGrid.jqGrid('addRow', parameters);
    $personGroupJqGrid.jqGrid('setSelection', newRowId);
    personGroupNewRowIndex++;
}

//校验个人群组
function validPersonGroup($personGroupJqGrid){
    var vlidateFlag = true;
    var data = $personGroupJqGrid.jqGrid('getRowData');
    var changeData = $personGroupJqGrid.jqGrid('getChangedCells');
    var ids = [];
    var msg;

    $.each(data, function(idx, obj){

        if(obj.sysUserName == "" && obj.sysGroupName == ""){
            msg = "请填写群组名称,群组成员!";
            vlidateFlag = false;
        }else if(obj.sysGroupName == ""){
            msg = "请填写群组名称!";
            vlidateFlag = false;
        }else if(obj.sysUserName == ""){
            msg = "请填写群组成员!";
            vlidateFlag = false;
        }
        if(vlidateFlag){
            if(obj.sysGroupName.gblen() > 100){
                msg = "群组名称最多可以输入100个字符(一个中文字符长度为2)!";
                vlidateFlag = false;
            }
        }
        if(!vlidateFlag){
            ids.push(obj.id);
            return false;
        }
    });
    if(vlidateFlag) {

        $.each(changeData, function (idx, obj) {
            $.each(data, function (index, object) {
                if (obj.id != object.id && obj.sysGroupName == object.sysGroupName) {
                    msg = "群组名称不能相同，请重新输入！";
                    if (jQuery.inArray(obj.id, ids) == -1) {
                        ids.push(obj.id);
                    }
                    if (jQuery.inArray(object.id, ids) == -1) {
                        ids.push(object.id);
                    }
                    vlidateFlag = false;
                }
            });
        });
    }

    if(vlidateFlag && changeData.length >0){
        for(var i = 0; i < changeData.length; i++){
            if(changeData[i].id.indexOf(personGroupNewRowStart) > -1){
                changeData[i].id = '';
            }
        }
        $.ajax({
            url:"platform/console/customed/checkPersonalGroupNameJSP",
            data : {customedData :JSON.stringify(changeData)},
            type : 'post',
            dataType : 'json',
            async:false,
            success : function(r){
                if (r.flag == "success"){
                    if(r.result.length > 0){
                        Array.prototype.push.apply(ids, r.result);
                        vlidateFlag = false;
                        msg = "该群组名称在数据库中已存在，请重新输入！";
                    }
                }
            }
        });
    }

    if(!vlidateFlag){
        var selarrrow = $personGroupJqGrid.jqGrid('getGridParam','selarrrow');
        if(selarrrow){
            while(selarrrow.length> 0) {
                $personGroupJqGrid.jqGrid('setSelection', selarrrow[0]);
            }
        }
        for(var i=0;i < ids.length ;i++){
            $personGroupJqGrid.jqGrid('setSelection',ids[i]);
        }
        layer.alert(msg,{icon:7,title: "提示",area: ['400px', '']});
    }

    return vlidateFlag;
}

//个人群组保存按钮
function savePersonGroup($personGroupJqGrid){

    $personGroupJqGrid.jqGrid('endEditCell');

    //校验
    var hasvalidate = validPersonGroup($personGroupJqGrid);
    if(!hasvalidate){
        return false;
    }

    var data = $personGroupJqGrid.jqGrid('getChangedCells');
    if(data && data.length > 0){
        for(var i = 0; i < data.length; i++){
            if(data[i].id.indexOf(personGroupNewRowStart) > -1){
                data[i].id = '';
            }
        }
        avicAjax.ajax({
            url:"platform/console/customed/insertOrUpdatePersonalGroupJSP",
            data : {customedData :JSON.stringify(data)},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success"){
                    reLoadDatagrid($personGroupJqGrid);
                    layer.msg('保存成功！', {icon: 1 ,title: "提示",area: ['400px', '']});
                }else{
                    layer.alert('保存失败！', {icon: 2 ,title: "提示",area: ['400px', '']});
                }
            }
        });
    }else{
        layer.alert('请先修改数据！', {icon: 7,title: "提示",area: ['400px', '']});
    }
}


//个人群组删除按钮
function deletePersonGroup($personGroupJqGrid){
    $personGroupJqGrid.jqGrid('endEditCell');
    var rows = $personGroupJqGrid.jqGrid('getGridParam','selarrrow');
    var idsInDb = [];
    var ids = [];

    if(rows.length == 0){
        layer.alert('请选择要删除的数据！',{icon:3,title: "提示",area: ['400px', '']});

    }else {
        for (var i = rows.length - 1; i > -1; i--) {
            if(rows[i].indexOf(personGroupNewRowStart) != -1){
                ids.push(rows[i]);
            }else{
                idsInDb.push(rows[i]);
            }
        }
        if(ids.length > 0 || idsInDb.length > 0) {
            layer.confirm('确认要删除选中的数据吗?', {icon: 7, title: "提示", area: ['400px', '']}, function (index) {
                //删除页面上的数据
                if (ids.length > 0 && idsInDb.length == 0) {
                    for (var i = ids.length - 1; i > -1; i--) {
                        $personGroupJqGrid.jqGrid('delRowData', ids[i]);
                    }
                    layer.msg("删除成功！", {icon: 1 ,title: "提示",area: ['400px', '']});
                }
                //删除DB中的数据
                if (idsInDb.length > 0) {
                    var data = [];
                    for (var i = idsInDb.length - 1; i > -1; i--) {
                        data.push($personGroupJqGrid.jqGrid('getRowData', idsInDb[i]));
                    }
                    avicAjax.ajax({
                        url: "platform/console/customed/deletePersonalGroupsJSP",
                        data: {"customedData": JSON.stringify(data)},
                        //contentType : 'application/json',
                        type: 'post',
                        dataType: 'json',
                        success: function (r) {
                            if (r.flag = "success") {
                                reLoadDatagrid($personGroupJqGrid);
                                layer.msg("删除成功！", {icon: 1 ,title: "提示",area: ['400px', '']});
                            } else {
                                layer.alert('删除失败！', {icon: 2 ,title: "提示",area: ['400px', '']});
                            }
                        }
                    });
                }
                layer.close(index);
            });
        }
    }
}

// 常用意见表格初始化
function approvalOptionInit($approvalOptionJqGrid) {
    var lastSelection;

    $approvalOptionJqGrid.jqGrid({
        url : "platform/console/customed/getApprovalOptionListByPage",
        mtype : 'POST',
        datatype : "json",
        toolbar : [ true, 'top' ],
        colModel : [
            {label : 'id', name : 'id', key : true, hidden : true},
            {label : '审批意见', name : 'value',width : 150, editable:true},
            {label : '类型', name : 'processType', width : 140, align:"center", formatter:processTypeFormatter,unformat:processTypeUnFormatter, editable:true, edittype:"custom",editoptions:{custom_element: processTypeElem, custom_value:processTypeValue}},
            {label : '流程ID', name : 'processIds', hidden : true},
            {label : '流程ID', name : 'hiddenProcessIds', hidden : true},
            {label : '流程名称', name : 'hiddenProcessName', hidden : true},
            {label : '流程名称', name : 'processName', width : 400, editable:true, edittype:"custom",editoptions: {custom_element: processNameElem, custom_value:processNameValue, forId:"processIds"}},
            {label : '排序', name : 'orderBy',width : 136, editable:true}
        ],
        height : $(window).height() - 168,
        scrollOffset : 20, // 设置垂直滚动条宽度
        rowNum : 10,
        rowList : [ 200, 100, 50, 30, 20, 10 ],
        altRows : true,
        pagerpos:'left',//分页栏位置
        styleUI : 'Bootstrap',
        viewrecords : true,
        multiselect : true,
        autowidth : true,
        responsive : true,// 开启自适应
        cellEdit:true,
        cellsubmit: 'clientArray',
        scrollrows:true,
        rownumbers:false,
        pager : "#approvalOptionJqGridPager",
        afterSaveCell: function (rowId, cellname, value, iRow, iCol) {
            if(cellname == "processType" ) {
                if (value == "1") {
                    var rowData = $(this).jqGrid("getRowData", rowId);
                    rowData["hiddenProcessIds"] = rowData["processIds"];
                    rowData["hiddenProcessName"] = rowData["processName"];
                    rowData["processIds"] = "";
                    rowData["processName"] = "";
                    $(this).jqGrid('setRowData', rowId, rowData);
                } else {
                    var rowData = $(this).jqGrid("getRowData", rowId);
                    rowData["processIds"] = rowData["hiddenProcessIds"];
                    rowData["processName"] = rowData["hiddenProcessName"];
                    $(this).jqGrid('setRowData', rowId, rowData);
                }
            }
        },
        loadComplete:function(){
            $("#set_approvalOptionJqGridPager").hide();
            $("#exportExcel_approvalOptionJqGridPager").hide();
        }
    });
    $("#t_approvalOptionJqGrid").append($("#approvalOptionTableToolbar"));

    $('.dropdown-menu').click(function(e) {
        e.stopPropagation();
    });
}

//常用意见显示样式
function processTypeFormatter(cellvalue, options, rowObject) {

    if(cellvalue == "0"){
        return "自定义";
    }else {
        return "全部";
    }

}

function processTypeUnFormatter(cellvalue, options, rowObject) {

    if(cellvalue == "自定义"){
        return "0";
    }else {
        return "1";
    }
}

//常用意见编辑时的样式
function processTypeElem(value, options){

    var $elem = $('<div style="margin-top:10px;text-align: center;">'+
                    '<label class="radio-inline">'+
                        '<input class="form-control" type="radio" name="cellProcessType" value="1" id="cellProcessTypeAll" title="全部" checked>全部'+
                    '</label>'+
                    '<label class="radio-inline">'+
                        '<input class="form-control" type="radio" name="cellProcessType" value="0" id="cellProcessTypeCustome" title="自定义" >自定义'+
                    '</label>'+
                 '</div>');

    if(value && value != ""){
        $elem.find('input[name="cellProcessType"][value="' + value + '"]').prop("checked",true);
    }
    return $elem;
}

//常用意见返回值
function processTypeValue(elem, operation, value) {
    if (operation === 'get') {
        return $(elem).find('input[name="cellProcessType"]:checked').val();
    } else if (operation === 'set') {
        $(elem).find('input[name="cellProcessType"][value="' + value + '"]').prop("checked",true);

    }
}

//常用意见表现
function processNameElem(value, options){
    var rowId = options.rowId;
    var forId = options.forId;
    var rowData = $(this).jqGrid('getRowData', rowId);

    var $elem = $('<div class="input-group input-group-sm" style="margin:2px">' +
                    '<input type="hidden" id="cellRowId" value="' + rowId + '">' +
                    '<input type="hidden" id="cellForId" value="' + forId + '">' +
                    '<input type="hidden" id="cellProcessId" name="cellProcessId" value="' + rowData[forId] + '">' +
                    '<input class="form-control" placeholder="请选择流程" type="text" id="cellProcessName" name="cellProcessName" readonly value="' + value + '">' +
                    '<span class="input-group-addon" id="selectProcess">' +
                        '<i class="iconfont icon-liucheng" style="font-size: 12px"></i>' +
                    '</span>' +
                  '</div>');

    //添加流程选择框
    new BpmModuleSelect("cellProcessId", $elem.find("#cellProcessName"), function(data){
        $elem.find("#cellProcessId").val(data.ids);
        $elem.find("#cellProcessName").val(data.texts);
    },undefined, $elem.find("#cellProcessId"),$elem.find("#cellProcessName"));

    new BpmModuleSelect("cellProcessId", $elem.find("#selectProcess"), function(data){
        $elem.find("#cellProcessId").val(data.ids);
        $elem.find("#cellProcessName").val(data.texts);
    },undefined, $elem.find("#cellProcessId"),$elem.find("#cellProcessName"));

    //类型是全部时，不显示流程
    if(rowData.processType == "1") {
        $elem.hide();
    }
    return $elem;

}

//常用意见返回值
function processNameValue(elem, operation, value) {
    if (operation === 'get') {
        var rowId = $(elem).find('#cellRowId').val();
        var forId = $(elem).find('#cellForId').val();
        var processId = $(elem).find('#cellProcessId').val();
        var rowData = {};
        rowData[forId] = processId;
        $(this).jqGrid('setRowData', rowId, rowData);
        return $(elem).find('#cellProcessName').val();
    } else if (operation === 'set') {
        $(elem).find('#cellProcessName').val(value);
    }
}

var approvalOptionNewRowIndex = 0;
var approvalOptionNewRowStart = "ao_new_row";

//常用意见添加按钮
function addApprovalOption($approvalOptionJqGrid){

    $approvalOptionJqGrid.jqGrid('endEditCell');

    //校验
    var vlidateFlag = validApprovalOption($approvalOptionJqGrid);
    if(!vlidateFlag) {
        return false;
    }
    //添加数据
    var newRowId = approvalOptionNewRowStart + approvalOptionNewRowIndex;
    var parameters = {
        rowID: newRowId,
        initdata: {id:newRowId,processType:1},
        position: "first",
        useDefValues: true,
        useFormatter: true,
        addRowParams: {extraparam: {}}
    }
    $approvalOptionJqGrid.jqGrid('addRow', parameters);
    $approvalOptionJqGrid.jqGrid('setSelection', newRowId);
    approvalOptionNewRowIndex++;
}

//校验常用意见
function validApprovalOption($approvalOptionJqGrid){
    var vlidateFlag = true;
    var data = $approvalOptionJqGrid.jqGrid('getRowData');

    $.each(data, function(idx, obj){
        var msg;
        if(obj.value == "" && obj.processName == "" && obj.processType == "0"){
            msg = "请填写审批意见,流程名称!";
            vlidateFlag = false;
        }else if(obj.value == ""){
            msg = "请填写审批意见!";
            vlidateFlag = false;
        }else if(obj.processName == "" && obj.processType == "0"){
            msg = "请填写流程名称!";
            vlidateFlag = false;
        }
        if(vlidateFlag){
            if(obj.value.gblen() > 30){
                msg = "审批意见最多可以输入30个字符(一个中文字符长度为2)!";
                vlidateFlag = false;
            }
        }
        if(!vlidateFlag){
            var selarrrow = $approvalOptionJqGrid.jqGrid('getGridParam','selarrrow');
            if(selarrrow){
                while(selarrrow.length> 0) {
                    $approvalOptionJqGrid.jqGrid('setSelection', selarrrow[0]);
                }
            }
            $approvalOptionJqGrid.jqGrid('setSelection',obj.id);
            layer.alert(msg,{icon:7 ,title: "提示",area: ['400px', '']});
            return false;
        }
    });

    return vlidateFlag;
}

//常用意见保存按钮
function saveApprovalOption($approvalOptionJqGrid){

    $approvalOptionJqGrid.jqGrid('endEditCell');

    //校验
    var hasvalidate = validApprovalOption($approvalOptionJqGrid);
    if(!hasvalidate){
        return false;
    }

    var data = $approvalOptionJqGrid.jqGrid('getChangedCells');
    if(data && data.length > 0){
        for(var i = 0; i < data.length; i++){
            if(data[i].id.indexOf(approvalOptionNewRowStart) > -1){
                data[i].id = '';
            }
        }
        avicAjax.ajax({
            url:"platform/console/customed/insertOrUpdateApprovalOptionJSP",
            data : {customedData :JSON.stringify(data)},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success"){
                    reLoadDatagrid($approvalOptionJqGrid);
                    layer.msg('保存成功！', {icon: 1 ,title: "提示",area: ['400px', '']});
                }else{
                    layer.alert('保存失败！', {icon: 2 ,title: "提示",area: ['400px', '']});
                }
            }
        });
    }else{
        layer.alert('请先修改数据！', {icon: 7 ,title: "提示",area: ['400px', '']});
    }
}


//常用意见删除按钮
function deleteApprovalOption($approvalOptionJqGrid){
    $approvalOptionJqGrid.jqGrid('endEditCell');
    var rows = $approvalOptionJqGrid.jqGrid('getGridParam','selarrrow');
    var idsInDb = [];
    var ids = [];

    if(rows.length == 0){
        layer.alert('请选择要删除的记录！',{icon:3 ,title: "提示",area: ['400px', '']});

    }else {
        for (var i = rows.length - 1; i > -1; i--) {
            if(rows[i].indexOf(approvalOptionNewRowStart) != -1){
                ids.push(rows[i]);
            }else{
                idsInDb.push(rows[i]);
            }
        }
        if(ids.length > 0 || idsInDb.length > 0) {
            layer.confirm('确定要删除该数据吗?', {icon: 7, title: "提示", area: ['400px', '']}, function (index) {
                //删除页面上的数据
                if (ids.length > 0 && idsInDb.length == 0) {
                    for (var i = ids.length - 1; i > -1; i--) {
                        $approvalOptionJqGrid.jqGrid('delRowData', ids[i]);
                    }
                    layer.msg("删除成功！", {icon: 1});
                }
                //删除DB中的数据
                if (idsInDb.length > 0) {

                    avicAjax.ajax({
                        url: "platform/console/customed/deleteApprovalOptionJSP",
                        data: JSON.stringify(idsInDb),
                        contentType : 'application/json',
                        type: 'post',
                        dataType: 'json',
                        success: function (r) {
                            if (r.flag = "success") {
                                reLoadDatagrid($approvalOptionJqGrid);
                                layer.msg("删除成功！", {icon: 1 ,title: "提示",area: ['400px', '']});
                            } else {
                                layer.alert('删除失败！', {icon: 2 ,title: "提示",area: ['400px', '']});
                            }
                        }
                    });
                }
                layer.close(index);
            });
        }
    }
}

//重载数据
function reLoadDatagrid($jqGrid){
    $jqGrid.jqGrid("setGridParam",{postData: {keyWord:""},datatype:"json"}).trigger("reloadGrid");
}

//计算字符串长度(英文占1个字符，中文汉字占2个字符)
String.prototype.gblen = function() {
    var len = 0;
    for (var i=0; i<this.length; i++) {
        if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {
            len += 2;
        } else {
            len ++;
        }
    }
    return len;
}