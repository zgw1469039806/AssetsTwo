$(function(){

    //initForm();
    $('#jslist_insert').bind('click', function() {
        insert();
    });

    $("#jslist_del").bind('click',function(){
        del();
    });
    
    $("#jslist_checK").bind('click',function(){
        check();
    });
    
});


/**
 * 单表单元格编辑下拉框控件扩展
 * @param value
 * @param options
 */
function selectSqlElem(value, options) {
	var rowId = options.rowId;
	var datas = options.value;
	var forId = options.forId;
	var require = options.require;
	var rowData = $(this).jqGrid('getRowData', rowId);
	var gid = $(this).jqGrid("getGridParam","id");
	var elemHtml = [];
	elemHtml.push('<select onchange="$(\'#'+gid+'\').jqGrid(\'endEditCell\')" class="form-control">');
	if (!require) {
        elemHtml.push('<option value="">请选择</option>');
    }
    var queryStatement = $("#queryStatement").val();
    var dataId = $('#dataCombox').val();
    var dataType = $('#dataComboxType').val();
    
    if(queryStatement != null || queryStatement != ""){
    	$.ajax({
			url : baseUrl+"platform/eform/plugin/getTargetNameBySql",
			type : 'post',
			dataType : 'json',
			async : false,
			data: {"queryStatement":queryStatement, "dataId":dataId, "dataType":dataType},
			success : function(r) {
				if (r.flag == "success" && r.queryFieldList) {
					for(var i =0;i<r.queryFieldList.length;i++){
						var field = r.queryFieldList[i];
						elemHtml.push('<option value="'+ field +'">' + field + '</option>');
					}
				}
				
			}
		});
    }else{
    	for ( var code in datas) {
			if(options.dataModel && options.dataModel.model=="array_object"){
				elemHtml.push('<option value="'+ datas [code][options.dataModel.key] +'">' + datas[code] [options.dataModel.value] + '</option>');
			}else{
				elemHtml.push('<option value="'+ code +'">' + datas[code] + '</option>');
			}
		}
    }
	elemHtml.push('</select>');
	var elem = $(elemHtml.join(''));
	elem.val(rowData[forId]);
	elem.attr('data-rowid', rowId);
	elem.attr('data-forid', forId);
	return elem[0];
}

function valueTargetNameFunc(){
	var nameJson= {};
	if(isMain == "1"){
		var doms = parent.editorUtil.getAllDomAttr();
	    for (var dom in doms){
	        if (dom != "clone" && (doms[dom].colType!="NOT_DB_COL_ELE"||doms[dom].domType == "virtual-box")){
	            var id = doms[dom].domId||doms[dom].colName;
	        	if(doms[dom].domType == "dept-box" 
	        	|| doms[dom].domType == "user-box"
	        	|| doms[dom].domType == "select-box"
	        	|| doms[dom].domType == "linkage-box"
	        	|| doms[dom].domType == "role-box"
	        	|| doms[dom].domType == "group-box"
	        	|| doms[dom].domType == "position-box"){
		        	nameJson[id] = doms[dom].colLabel+"(值)";
		        	nameJson[id + "Name"] = doms[dom].colLabel;
	        	}else{
	        		nameJson[id] = doms[dom].colLabel || doms[dom].title || doms[dom].domId;
	        	}
	        	//nameJson[doms[dom].colName] = doms[dom].colLabel;
	        }
	
	    }
	}
	
    return nameJson;
}


function changeTargetNameFunc(doms,title){
	if (title==undefined || title == null){
        title = "子表变量";
    }
	
	var flag = true;
    for (var dom in doms){
        if (dom != "clone"){
        	if(doms[dom].data != undefined){
        		if(flag){
        			//添加子表单变量
        			var rootNode = zTreeObj.getNodeByTId("1");
        			var subFieldNode = zTreeObj.addNodes(rootNode, { id: "subFieldNode", parentid: rootNode.id, name: title});
        			flag = false;
        		}
        		zTreeObj.addNodes(subFieldNode[0], { id: "doms[dom].data.colName", parentid: subFieldNode[0].id, name: "subfield{" + doms[dom].data.colName + "}", iconSkin:"icon"});
        	}
        }
    }
    
	var nameJson= {};
    for (var dom in doms){
        if (dom != "clone"){
        	if(doms[dom].data){
                var id = doms[dom].data.domId||doms[dom].data.colName;
        		if(doms[dom].data.elementType == "dept" 
	        	|| doms[dom].data.elementType == "user"
	        	|| doms[dom].data.elementType == "select"
	        	|| doms[dom].data.elementType == "linkage"
	        	|| doms[dom].data.elementType == "role"
	        	|| doms[dom].data.elementType == "group"
	        	|| doms[dom].data.elementType == "position"){
		        	nameJson[id] = doms[dom].data.colLabel+"(值)";
		        	nameJson[id + "Name"] = doms[dom].data.colLabel;
	        	}else{
	        		nameJson[id] = doms[dom].data.colLabel;
	        	}
        	}else{
                var id = doms[dom].domId||doms[dom].colName;
        		if(doms[dom].elementType == "dept" 
	        	|| doms[dom].elementType == "user"
	        	|| doms[dom].elementType == "select"
	        	|| doms[dom].elementType == "linkage"
	        	|| doms[dom].elementType == "role"
	        	|| doms[dom].elementType == "group"
	        	|| doms[dom].elementType == "position"){
		        	nameJson[id] = doms[dom].colLabel+"(值)";
		        	nameJson[id + "Name"] = doms[dom].colLabel;
	        	}else{
	        		nameJson[id] = doms[dom].colLabel;
	        	}
        	}
        	
        }
    }
	jQuery("#propertytable").setColProp('targetNameName',{editoptions:{value:nameJson}});
}

function formatDictionaryTableData(cellvalue, options, rowObject){
   	if(cellvalue && cellvalue != ''){
		return cellvalue;
	}else{
		var rowId = options.rowId;
		var datas = options.colModel.editoptions.value;
		var forId = options.colModel.editoptions.forId;
		var code = rowObject[forId];
		return datas[code] ? datas[code] : '';
	}
}

var dictionaryProperty = {
    mydata : [
    ],
    dataGridColModel:[
        { label:'源字段名称', name:'name', width:75, hidden:true},
        {
            label:'源字段名称',
            name:'nameName',
            width : 50,
            editable:true, 
            edittype:"custom",
   	        formatter:formatDictionaryTableData, 
   	        editoptions: {custom_element:selectSqlElem, custom_value:selectValue, forId:'name', 
   	     	value: {"-1":"请选择"}}
        },
        { label:'目标字段', name:'targetName', width:75, hidden:true},
        {
            label:'目标字段',
            name:'targetNameName',
            width : 50,
            editable:true, 
            edittype:"custom",
   	        formatter:formatDictionaryTableData, editoptions: {custom_element:selectElem, custom_value:selectValue, forId:'targetName', 
   	     	value: valueTargetNameFunc() }
        },
        {
            label:'列名称',
            name:'display',
            width : 50, 
            editable : true
        },
        {
            label:'列宽度',
            name:'width',
            width : 50,
            editable : true
        },
        { label:'是否隐藏', name:'isHidden', width:75, hidden:true},
        {
            label:'是否隐藏',
            name:'isHiddenName',
            width : 50, 
            editable:true, 
            edittype:"custom",
   	        formatter:formatDictionaryTableData, 
   	        editoptions: {custom_element:selectElem, custom_value:selectValue, forId:'isHidden', 
   	     	value: {"1":"否","2":"是"}}
        },
        { label:'是否模糊过滤', name:'filter', width:75, hidden:true},
        {
            label:'是否模糊过滤',
            name:'filterName',
            width : 50, 
            editable:true, 
            edittype:"custom",
   	        formatter:formatDictionaryTableData, 
   	        editoptions: {custom_element:selectElem, custom_value:selectValue, forId:'filter', 
   	     	value: {"1":"否","2":"是"}}
        },
        {
            label:'排序',
            name:'sort',
            width : 50,
            editable : true,
            edittype:"custom",
            editoptions: {custom_element:spinnerElem, custom_value:spinnerValue, forId:'filter',
   	     	min:0,max:9999,step:1,precision:0}

        }
    ]
};

function jqgridInit(){

    jQuery("#propertytable").jqGrid(
        {
            datatype: "local",
            data:dictionaryProperty.mydata,
            toolbar: [false,'top'],//启用toolbar
            colModel: dictionaryProperty.dataGridColModel,//表格列的属性
            height:$(window).height() - 180,//初始化表格高度
            scrollOffset: 20, //设置垂直滚动条宽度
            altRows:true,//斑马线
            styleUI : 'Bootstrap',
			viewrecords: true,
			multiselect: true,
			autowidth: true,
			responsive:true,
            rowNum:dictionaryProperty.mydata.length,
		    cellEdit:true,
		    cellsubmit: 'clientArray',
			forceFit:false,
			shrinkToFit:true,
			autoScroll: true,
			loadonce:true, //一次加载全部数据到客户端，由客户端进行排序。
			sortable: true,
			sortname: 'sort', //设置默认的排序列
			sortorder: 'asc',
			rowNum:dictionaryProperty.mydata.length,
			gridComplete: function(){
   				 $(".ui-th-column").click(function(e){
            		$('#propertytable').jqGrid('endEditCell');
   				 })
   				if(initFirstFlag){
   					$('#eformTab').trigger("click");
   					initFirstFlag = false;
   				}

            }
        });

	$('#propertytable').validateJqGrid("addValidate","name","required");
	//$('#propertytable').validateJqGrid("addValidate","targetName","required");//需求更改，目标字段不做必填校验  20190424
	$('#propertytable').validateJqGrid("addValidate","display","required");
	$('#propertytable').validateJqGrid("addValidate","width","required");
	$('#propertytable').validateJqGrid("addValidate","isHidden","required");
	$('#propertytable').validateJqGrid("addValidate","filter","required");

}
var newRowIndex = 0;
var newRowStart = "new_row";
function insert(){
    $("#propertytable").jqGrid('endEditCell');
    var newRowId = newRowStart + newRowIndex;
    var parameters = {
        rowID : newRowId,
        initdata : {
        	width:"50",
            isHidden:"1",
            isHiddenName:"否",
            filter:"1",
            filterName:"否",
        },
        position :"first",
        useDefValues : true,
        useFormatter : true,
        addRowParams : {extraparam:{}}
    };
    $("#propertytable").jqGrid('addRow', parameters);
    newRowIndex++;
}
function del(){
    $("#propertytable").jqGrid('endEditCell');
    var rows = $("#propertytable").jqGrid('getGridParam','selarrrow');
    var ids = [];
    var l =rows.length;
    if(l>0){
        layer.confirm('确定要删除该数据吗？',{icon:2,title:"请确认",area:['400px','']},function(index){
            for(var i=l-1;i>=0;i--){
                $("#propertytable").jqGrid('delRowData',rows[i]);
            }
            layer.close(index);
        });
    }else{
        layer.alert('请选择要删除的记录！', {
                icon: 7,
                area: ['400px', ''], //宽高
                closeBtn: 0
            }
        );
    }
}

function check(){

    $("#propertytable").jqGrid('endEditCell');
    var queryStatement = $('#queryStatement').val();
    
    var dataId = $('#dataCombox').val();
    var dataType = $('#dataComboxType').val();
    
    if(queryStatement != null || queryStatement != ""){
    	$.ajax({
			url : baseUrl+"platform/eform/plugin/getTargetNameBySql",
			type : 'post',
			dataType : 'json',
			async : false,
			data: {"queryStatement":queryStatement, "dataId":dataId, "dataType":dataType},
			success : function(r) {
				if (r.flag == "success" && r.queryFieldList) {
                    layer.msg('查询语句通过校验！',{icon: 1});
				}else{
					layer.alert('查询语句校验失败！ ' + r.error, {
			                icon: 7,
			                area: ['400px', ''], //宽高
			                closeBtn: 0
			            }
			        );
				}
				
			}
		});
    }
}

function initForm(rowCount,queryStatement,dictionaryPara,jsSuccess,jsBefore,jsAfter,dataCombox,dataComboxType,dataComboxText,isMuti,
					waitSelect,inputChk,inputDetail,detail,detailpagefileId,detailpagePath,detailpagefileName, dicType){
    //var dictionaryPara = $('#dictionaryPara', window.parent.document).val();
    //var rowCount = $('#rowCount', window.parent.document).val();
    //var queryStatement = $('#queryStatement', window.parent.document).val();
    if (dictionaryPara){
        var data = $.parseJSON(dictionaryPara);
        dictionaryProperty.mydata = data;
    }

    if (rowCount){
        $("#rowCount").val(rowCount);
    }
    
    if (queryStatement){
        $("#queryStatement").val(queryStatement);
    }
    
    if (jsSuccess){
        $("#jsSuccess").val(jsSuccess);
    }
    
    if (jsBefore){
        $("#jsBefore").val(jsBefore);
    }
    
    if (jsAfter){
        $("#jsAfter").val(jsAfter);
    }

    if (inputChk){
        $("#inputChk").val(inputChk);
    }
    if (inputDetail){
        $("#inputDetail").val(inputDetail);
    }


    if (detailpagefileId){
        $("#detailpagefileId").val(detailpagefileId);
    }
    if (detailpagePath){
        $("#detailpagePath").val(detailpagePath);
    }
    if (detailpagefileName){
        $("#detailpagefileName").val(detailpagefileName);
    }


    if(dicType && dicType == "2" ){
		$("#isMuti").prop("checked",true);
		isMuti = "Y";
		$("#isMuti").attr("disabled","disabled");
    	$("#detailTab").hide();
    }

    if (isMuti && isMuti == "Y"){
        $("#isMuti").prop("checked",true);
        $("#waitSelectDiv").css("visibility","visible");
    }else{
    	$("#waitSelectDiv").css("visibility","hidden");
    }

    if (waitSelect && waitSelect == "Y"){
        $("#waitSelect").prop("checked",true);
    }

	if(inputDetail && inputDetail == "Y"){
		$("#detailpagePath").css("display","block");
		$("#detailpagefileName").css("display","none");
		$("#detailpagePath").attr("required","required");
		$("#detailpagefileName").removeAttr("required");
	}else{
		$("#detailpagefileName").css("display","block");
		$("#detailpagePath").css("display","none");
		$("#detailpagePath").removeAttr("required");
		$("#detailpagefileName").attr("required","required");
	}

	$("#isMuti").on("change",function(){
		if($(this).prop("checked") == true) {
			$("#waitSelectDiv").css("visibility","visible");
		}else{
            $("#waitSelect").prop("checked",false);
			$("#waitSelectDiv").css("visibility","hidden");
		}
	});

    jqgridInit();
    
    initDetailTab(detail);

    if (dataCombox){
        $("#dataCombox").val(dataCombox);
        $("#dataComboxType").val(dataComboxType);
        $("#dataComboxText").val(dataComboxText);
    }
    
}

function commitForm(){
	$('#propertytable').jqGrid('endEditCell');
    var obj = {};
    if (!$('#propertytable').validateJqGrid("validate")){
    	$('#noEformTab').trigger("click");
    	return false;
    }

	$('#eformTab').trigger("click");
	var isValidate = $("#form").validate();
    if (!isValidate.checkForm()) {
         isValidate.showErrors();
         return false;
    }


	$('#noEformTab').trigger("click");
	$('#propertytable').jqGrid('endEditCell');
    var obj = {};
    if (!$('#propertytable').validateJqGrid("validate")){
    	return false;
    }

	$('#detailTab').trigger("click");
	var isValidate1 = $("#form1").validate();
    if (!isValidate1.checkForm()) {
         isValidate1.showErrors();
         return false;
    }

    //obj.dictionaryName = $("#dictionaryName").val();
    obj.rowCount = $("#rowCount").val();
    obj.queryStatement = $("#queryStatement").val();
    obj.datagridData = $("#propertytable").jqGrid("getRowData");
    obj.jsSuccess = $("#jsSuccess").val();
    obj.jsBefore = $("#jsBefore").val();
    obj.jsAfter = $("#jsAfter").val();
    obj.inputChk = $("#inputChk").val();
    obj.inputDetail = $("#inputDetail").val();
    obj.detail = $("#detail").val();
    obj.detailpagefileId = $("#detailpagefileId").val();
    obj.detailpagePath = $("#detailpagePath").val();
    obj.detailpagefileName = $("#detailpagefileName").val();

	obj.dataCombox = $("#dataCombox").val();
	obj.dataComboxType = $("#dataComboxType").val();
	obj.dataComboxText = $("#dataComboxText").val();

	if($("#isMuti").prop('checked')){
		obj.isMuti = "Y";
	}else{
		obj.isMuti = "N";
	}

	if($("#waitSelect").prop('checked')){
		obj.waitSelect = "Y";
	}else{
		obj.waitSelect = "N";
	}

    jQuery("#propertytable").trigger("reloadGrid");

    return obj;
}



function initFormByParam(linkageColumnid,linkageResultType,linkageImpl,linkagePara,doms){
	var jsondata = linkagePara;
    var linkageResultType = linkageResultType;
    var linkageColumnid = linkageColumnid;
    var linkageImpl = linkageImpl;

    var dataRow;
    if (jsondata){
        dataRow = $.parseJSON(jsondata);
        linkageProperty.mydata = dataRow;
    }

    $("#linkageColumnid").empty();
    var count = 0;
    for (var dom in doms){
        if (dom != "clone"){
            var id = doms[dom].data.domId||doms[dom].data.colName;
            if (count == 0) {
                $("#linkageColumnid").append("<option value=\"" + id + "\" selected>" + doms[dom].data.colLabel + "</option>");
            }else{
                $("#linkageColumnid").append("<option value=\"" + id + "\">" + doms[dom].data.colLabel + "</option>");
            }
            count++;
        }

    }

    if (linkageResultType){
        $("#linkageResultType").val(linkageResultType);
    }
    if (linkageColumnid){
        $("#linkageColumnid").val(linkageColumnid);
    }
    if (linkageImpl){
        $("#linkageImpl").val(linkageImpl);
        $("#tabletr").css("display","none");
		$("#impltr").css("display","table-row");
		$("#IsCustom").prop("checked","checked");
    }

    $("#linkageColumnid").change(function(){
        linkageProperty.mydata = $("#propertytable").jqGrid("getRowData");
        var value = $("#linkageColumnid").val();
        var text = $("#linkageColumnid option:selected").text();
        for ( var i = 0; i < linkageProperty.mydata.length; i++){
            linkageProperty.mydata[i].linkageColumnid = value;
            linkageProperty.mydata[i].linkageColumnLabel = text;
        }
        $("#propertytable").jqGrid('setGridParam',{
           datatype:'local',
           data: linkageProperty.mydata
        }).trigger("reloadGrid");

    });

    $("#linkageResultType").change(function(){
        linkageProperty.mydata = $("#propertytable").jqGrid("getRowData");
        var value = $("#linkageResultType").val();
        var text = $("#linkageResultType option:selected").text();
        for ( var i = 0; i < linkageProperty.mydata.length; i++){
            linkageProperty.mydata[i].linkageResultType = value;
            linkageProperty.mydata[i].linkageResultTypeName = text;
        }
        $("#propertytable").jqGrid('setGridParam',{
            datatype:'local',
            data: linkageProperty.mydata
        }).trigger("reloadGrid");

    });

    $("#IsCustom").change(function(){
    	if(this.checked){
    		$("#tabletr").css("display","none");
    		$("#impltr").css("display","table-row");
    	}else{
    		$("#tabletr").css("display","table-row");
    		$("#impltr").css("display","none");
    		$(window).resize();
    	}
    });

    //$('#propertytable').jqGrid("clearGridData");
    if(dataRow != "" && dataRow != undefined){
    	for (var i = 0; i < dataRow.length; i++) {
    		$("#propertytable").jqGrid('endEditCell');
			var newRowId = newRowStart + newRowIndex;
    		var parameters = {
       	 	rowID : newRowId,
        	initdata : dataRow[i],
        	position :"first",
        	useDefValues : true,
        	useFormatter : true,
        	addRowParams : {extraparam:{}}
   	 		};
    		$("#propertytable").jqGrid('addRow', parameters);
    		newRowIndex++;
    	}

    }

}



function clickDdetailPagefile(){
	   linkagedialog = layer.open({
			  type: 2,
			  title: '详情页面配置',
			  skin: 'bs-modal',
			  area: ['100%', '75%'],
			  maxmin: false,
			  content: "avicit/platform6/eform/bpmsformmanage/select/selectPublishEform/selectPublishEform.jsp?fieldId=detailpagefileId&fieldName=detailpagefileName",
			  btn: ['确定', '取消'],
			  success: function (layero, index) {
			  },
			  yes: function(index, layero){
			  	 var frm = layero.find('iframe')[0].contentWindow;
			       /*var reData = frm.commitForm();
			       if (!reData){
			           return false;
			       }
			       $("#detailpagefileId").val(reData.detailpagefileId);
			       $("#detailpagefileName").val(reData.detailpagefileName).change();
			       */
			       top.layer.close(index);
			  },
			  no: function(index, layero){
			      layero.close(index);
			  }
			});
}



function initDetailSelect(detailValue){
	if(detailValue == null || detailValue == undefined){
		detailValue = $("#detail").val();
	}

	var detailField = $("#propertytable").jqGrid("getRowData");
    var optionstring="";
    for(var field in detailField){
    	var id = detailField[field].targetName;
    	if(id && id != undefined){
	 	    optionstring += "<option value=\"" +id + "\" >" + detailField[field].targetNameName + "</option>";
    	}
    }
    $("#detail").html("<option value=''>选择关联字段</option> "+optionstring);

    $("#detail").val(detailValue);

}

function initDetailTab(detailValue){
    initDetailSelect(detailValue);

    var inputChk = $("#inputChk").val();
	var inputDetail = $("#inputDetail").val();
	if(inputChk == "Y"){
		$("#inputDetailDiv").show();
		$("#detailpageDiv").show();
		$("#detail").attr("required","required");
		if(inputDetail == "Y"){
			$("#detailpagePath").attr("required","required");
			$("#detailpagefileName").removeAttr("required");
		}else{
			$("#detailpagefileName").attr("required","required");
			$("#detailpagePath").removeAttr("required");
		}
	}else{
		$("#inputDetailDiv").hide();
		$("#detailpageDiv").hide();
		$("#detail").removeAttr("required");
	}

    $("#inputChk").bind('change',function(){
        inputChkChange(this);
    });
}


function inputChkChange(elem){
	var inputDetail = $("#inputDetail").val();
	if($(elem).val() == "Y"){
		$("#inputDetailDiv").show();
		$("#detailpageDiv").show();
		$("#detail").attr("required","required");
		if(inputDetail == "Y"){
			$("#detailpagePath").attr("required","required");
			$("#detailpagefileName").removeAttr("required");
		}else{
			$("#detailpagefileName").attr("required","required");
			$("#detailpagePath").removeAttr("required");
		}
	}else{
		$("#inputDetailDiv").hide();
		$("#detailpageDiv").hide();
		$("#detail").removeAttr("required");
	}
}


function onChangeInputDetail(elem){
	if($(elem).val() == "Y"){
		$("#detailpagePath").css("display","block");
		$("#detailpagefileName").css("display","none");
		$("#detailpagePath").attr("required","required");
		$("#detailpagefileName").removeAttr("required");
	}else{
		$("#detailpagefileName").css("display","block");
		$("#detailpagePath").css("display","none");
		$("#detailpagePath").removeAttr("required");
		$("#detailpagefileName").attr("required","required");
	}
}