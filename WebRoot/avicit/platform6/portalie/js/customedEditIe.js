
var notnullFiled=["sysGroupName","sysUserName","value"];//非空字段
var notnullFiledComment=["群组名称","群组成员","审批意见"]; //非空字段注释
//除时间,数字等类型长度校验字段
var lengthValidFiled = ["sysGroupName","value"];
//除时间,数字等类型长度校验字段注释
var lengthValidFiledComment = ["群组名称","审批意见"];
//
var lengthValidFiledSize = [100,500];



//关闭layer
function closeForm(){
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index);
}

//保存
function saveForm($form){
    if ($form.form('validate') == false) {
        return false;
    }
    save($form);
}

//保存功能
function save($form){

    $.ajax({
        url: "platform/console/customed/updateUser?random="+Math.random(),
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

//datagrid加载数据成功回调
function loadSuccess() {
    $(this).datagrid('clearChecked').datagrid('unselectAll').datagrid('clearSelections');
    $(this).datagrid("options").colediting = undefined;
    $(this).datagrid("options").insertRowFlag = undefined;
}

//初始化
function initDataGrid(dataGrid) {
    // 初始化键盘，鼠标事件基准列（可视列）数据
    $("#"+dataGrid).datagrid('initTabKeyColumns',this);
    // 注册点击单元格事件
    $("#"+dataGrid).datagrid("options").onClickCell = function(index, field) {

        $.fn.datagrid.methods["defaultClickCellEvent"]({
            gridId: "#"+dataGrid,
            index: index,
            field: field
        });
        // 注册“tab”及“上下左右”键事件
        bindKeyBoardHander("#"+dataGrid);
    };
}

/**
 * 绑定键盘事件
 * @param temp datagrid对象
 */
function bindKeyBoardHander (temp) {
    var gridId;
    if (typeof (temp) === "object") {
        gridId = "#" + temp.attr('id');
    } else {
        gridId = temp;
    }
    $(document).unbind("keyup");
    $(document).keyup(function(event) {
        $.fn.datagrid.methods["tabKeyUpEvent"]({
            event : event,
            gridId : gridId
        });
    });
};

//个人群组
var personGroupNewRowIndex = 0;
var personGroupNewRowStart = "pn_new_row";

//个人群组添加按钮
function addPersonGroup($personGroupJqGrid){

    $personGroupJqGrid.datagrid('endEdit', $personGroupJqGrid.datagrid("options").colediting);

    //校验
    var vlidateFlag = validPersonGroup($personGroupJqGrid);
    if(!vlidateFlag) {
        return false;
    }
    //添加数据
    var newRowId = personGroupNewRowStart + personGroupNewRowIndex;
    $personGroupJqGrid.datagrid('insertRow', {
        index : 0,
        row : {
            id : newRowId,
            sysGroupId:"",
            sysGroupName:"",
            sysUserId:"",
            sysUserIdAlias:""
        }
    });

    $.fn.datagrid.methods["defaultClickCellEvent"]({
        gridId : $personGroupJqGrid,
        index : 0,
        field : $personGroupJqGrid.datagrid("options").columnArray[0]
    });

    bindKeyBoardHander($personGroupJqGrid);
    $personGroupJqGrid.datagrid("options").insertRowFlag = '1';
    $personGroupJqGrid.datagrid('selectRecord', newRowId);
    personGroupNewRowIndex++;
}

//校验个人群组
function validPersonGroup($personGroupJqGrid){
    var vlidateFlag = true;
    var data = $personGroupJqGrid.datagrid('getData').rows;
    var changeData = copyArray($personGroupJqGrid.datagrid('getChanges'));
    var ids = [];
    var msg;

    $.each(data, function(idx, obj){

        if(obj.sysUserIdAlias == "" && obj.sysGroupName == ""){
            msg = "请填写群组名称,群组成员!";
            vlidateFlag = false;
        }else if(obj.sysGroupName == ""){
            msg = "请填写群组名称!";
            vlidateFlag = false;
        }else if(obj.sysUserIdAlias == ""){
            msg = "请填写群组成员!";
            vlidateFlag = false;
        }
        if(vlidateFlag){
            if(gblen(obj.sysGroupName) > 100){
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
            url:"platform/console/customed/checkPersonalGroupNameJSP?random="+Math.random(),
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
        $personGroupJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
        for(var i=0;i < ids.length ;i++){
            $personGroupJqGrid.datagrid('selectRecord',ids[i]);
        }
        layer.alert(msg,{icon:7,title: "提示",area: ['400px', '']});
    }

    return vlidateFlag;
}

//个人群组保存按钮
function savePersonGroup($personGroupJqGrid){

    $personGroupJqGrid.datagrid('endEdit',$personGroupJqGrid.datagrid("options").colediting);

    //校验
    var hasvalidate = validPersonGroup($personGroupJqGrid);
    if(!hasvalidate){
        return false;
    }

    var data = copyArray($personGroupJqGrid.datagrid('getChanges'));
    if(data && data.length > 0){
        for(var i = 0; i < data.length; i++){
            if(data[i].id.indexOf(personGroupNewRowStart) > -1){
                data[i].id = '';
            }
        }
        avicAjax.ajax({
            url:"platform/console/customed/insertOrUpdatePersonalGroupJSP?random="+Math.random(),
            data : {customedData :JSON.stringify(data)},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success"){
                    reLoadDatagrid($personGroupJqGrid);
                    $personGroupJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                    $personGroupJqGrid.datagrid("options").colediting = undefined;
                    $personGroupJqGrid.datagrid("options").insertRowFlag = undefined;
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
    $personGroupJqGrid.datagrid('endEdit',$personGroupJqGrid.datagrid("options").colediting);
    var rows = $personGroupJqGrid.datagrid('getChecked');
    var idsInDb = [];
    var ids = [];

    if(rows.length == 0){
        layer.alert('请选择要删除的数据！',{icon:3,title: "提示",area: ['400px', '']});

    }else {
        for (var i = rows.length - 1; i > -1; i--) {
            if(rows[i].id.indexOf(personGroupNewRowStart) != -1){
                ids.push(rows[i]);
            }else{
                idsInDb.push(rows[i]);
            }
        }
        if(ids.length > 0 || idsInDb.length > 0) {
            layer.confirm('确认要删除选中的数据吗?', {icon: 7, title: "提示", area: ['400px', '']}, function (index) {
                //删除页面上的数据
                if (ids.length > 0 && idsInDb.length == 0) {
                    reLoadDatagrid($personGroupJqGrid);
                    $personGroupJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                    $personGroupJqGrid.datagrid("options").colediting = undefined;
                    $personGroupJqGrid.datagrid("options").insertRowFlag = undefined;
                    layer.msg("删除成功！", {icon: 1 ,title: "提示",area: ['400px', '']});
                }
                //删除DB中的数据
                if (idsInDb.length > 0) {
                    avicAjax.ajax({
                        url: "platform/console/customed/deletePersonalGroupsJSP?random="+Math.random(),
                        data: {"customedData": JSON.stringify(idsInDb)},
                        //contentType : 'application/json',
                        type: 'post',
                        dataType: 'json',
                        success: function (r) {
                            if (r.flag = "success") {
                                reLoadDatagrid($personGroupJqGrid);
                                $personGroupJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                                $personGroupJqGrid.datagrid("options").colediting = undefined;
                                $personGroupJqGrid.datagrid("options").insertRowFlag = undefined;
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

var approvalOptionNewRowIndex = 0;
var approvalOptionNewRowStart = "ao_new_row";

//常用意见添加按钮
function addApprovalOption($approvalOptionJqGrid){

    $approvalOptionJqGrid.datagrid('endEdit', $approvalOptionJqGrid.datagrid("options").colediting);

    //校验
    var vlidateFlag = validApprovalOption($approvalOptionJqGrid);
    if(!vlidateFlag) {
        return false;
    }

    //添加数据
    var newRowId = approvalOptionNewRowStart + approvalOptionNewRowIndex;
    $approvalOptionJqGrid.datagrid('insertRow', {
        index : 0,
        row : {
            id : newRowId,
            value:"",
            processType:"1",
            processIds:"",
            hiddenProcessIds:"",
            hiddenProcessIdsAlias:"",
            processIdsAlias:"",
            processName:""
        }
    });

    $.fn.datagrid.methods["defaultClickCellEvent"]({
        gridId : $approvalOptionJqGrid,
        index : 0,
        field : $approvalOptionJqGrid.datagrid("options").columnArray[0]
    });

    bindKeyBoardHander($approvalOptionJqGrid);
    $approvalOptionJqGrid.datagrid("options").insertRowFlag = '1';
    $approvalOptionJqGrid.datagrid('selectRecord', newRowId);
    approvalOptionNewRowIndex++;
}

//校验常用意见
function validApprovalOption($approvalOptionJqGrid){
    var vlidateFlag = true;
    var data = $approvalOptionJqGrid.datagrid('getData').rows;

    $.each(data, function(idx, obj){
        var msg;
        if(obj.value == ""){
            msg = "请填写审批意见!";
            vlidateFlag = false;
        }else if(obj.processType == ""){
            msg = "请填写流程类型!";
            vlidateFlag = false;
        }else if(!obj.processIdsAlias && obj.processType == "0"){
            msg = "请填写流程名称!";
            vlidateFlag = false;
        }
        if(vlidateFlag){
            if(gblen(obj.value) > 30){
                msg = "审批意见最多可以输入30个字符(一个中文字符长度为2)!";
                vlidateFlag = false;
            }
        }
        if(!vlidateFlag){
            $approvalOptionJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
            $approvalOptionJqGrid.datagrid('selectRecord',obj.id);
            layer.alert(msg,{icon:7 ,title: "提示",area: ['400px', '']});
            return false;
        }
    });

    return vlidateFlag;
}

//常用意见保存按钮
function saveApprovalOption($approvalOptionJqGrid){

    $approvalOptionJqGrid.datagrid('endEdit', $approvalOptionJqGrid.datagrid("options").colediting);

    //校验
    var hasvalidate = validApprovalOption($approvalOptionJqGrid);
    if(!hasvalidate){
        return false;
    }

    var data = copyArray($approvalOptionJqGrid.datagrid('getChanges'));
    if(data && data.length > 0){
        for(var i = 0; i < data.length; i++){
            if(data[i].id.indexOf(approvalOptionNewRowStart) > -1){
                data[i].id = '';
            }
        }
        avicAjax.ajax({
            url:"platform/console/customed/insertOrUpdateApprovalOptionJSP?random="+Math.random(),
            data : {customedData :JSON.stringify(data)},
            type : 'post',
            dataType : 'json',
            success : function(r){
                if (r.flag == "success"){
                    reLoadDatagrid($approvalOptionJqGrid);
                    $approvalOptionJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                    $approvalOptionJqGrid.datagrid("options").colediting = undefined;
                    $approvalOptionJqGrid.datagrid("options").insertRowFlag = undefined;
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
    $approvalOptionJqGrid.datagrid('endEdit',$approvalOptionJqGrid.datagrid("options").colediting);
    var rows = $approvalOptionJqGrid.datagrid('getChecked');
    var idsInDb = [];
    var ids = [];

    if(rows.length == 0){
        layer.alert('请选择要删除的记录！',{icon:3 ,title: "提示",area: ['400px', '']});

    }else {
        for (var i = rows.length - 1; i > -1; i--) {
            if(rows[i].id.indexOf(approvalOptionNewRowStart) != -1){
                ids.push(rows[i]);
            }else{
                idsInDb.push(rows[i]);
            }
        }
        if(ids.length > 0 || idsInDb.length > 0) {
            layer.confirm('确定要删除该数据吗?', {icon: 7, title: "提示", area: ['400px', '']}, function (index) {
                //删除页面上的数据
                if (ids.length > 0 && idsInDb.length == 0) {
                    reLoadDatagrid($approvalOptionJqGrid);
                    $approvalOptionJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                    $approvalOptionJqGrid.datagrid("options").colediting = undefined;
                    $approvalOptionJqGrid.datagrid("options").insertRowFlag = undefined;
                    layer.msg("删除成功！", {icon: 1 ,title: "提示",area: ['400px', '']});
                }
                //删除DB中的数据
                if (idsInDb.length > 0) {
                    var data = [];
                    for (var i = idsInDb.length - 1; i > -1; i--) {
                        data.push(idsInDb[i].id)
                    }
                    avicAjax.ajax({
                        url: "platform/console/customed/deleteApprovalOptionJSP?random="+Math.random(),
                        data: JSON.stringify(data),
                        contentType : 'application/json',
                        type: 'post',
                        dataType: 'json',
                        success: function (r) {
                            if (r.flag = "success") {
                                reLoadDatagrid($approvalOptionJqGrid);
                                $approvalOptionJqGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                                $approvalOptionJqGrid.datagrid("options").colediting = undefined;
                                $approvalOptionJqGrid.datagrid("options").insertRowFlag = undefined;
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
    $jqGrid.datagrid("load",{postData: {keyWord:""},datatype:"json"});
}

function copyArray(data){
    var copyData = [];
    $.each(data, function (idx, obj) {
        var object = {};
        $.each(obj, function (key, value) {
            object[key] = value;
        });
        copyData.push(object);
    });
    return copyData;
}

//计算字符串长度(英文占1个字符，中文汉字占2个字符)
function gblen(str) {
    var len = 0;
    for (var i=0; i<str.length; i++) {
        if (str.charCodeAt(i)>127 || str.charCodeAt(i)==94) {
            len += 2;
        } else {
            len ++;
        }
    }
    return len;
}