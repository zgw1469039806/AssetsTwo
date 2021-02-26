<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Tab页签</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include
            page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs" />
    </jsp:include>

    <style>

        .ui-jqgrid-bdiv div{
            overflow-x: hidden;
        }

        .ui-jqgrid tr.jqgrow td { text-overflow : ellipsis;    overflow: hidden !important; }
    </style>
    <script>
		var baseUrl = "<%=ViewUtil.getRequestPath(request)%>";
	</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false" style="padding: 8px 0;overflow: hidden">
    <input id="tableId" value="DYN_HY_01" type="hidden"/>
    <input id="contentvalue" type="hidden"/>
    <form id='form'>
        <div class="mce-content-body">
 <table border="0" class="form_commonTable1">
  <tbody>
   <tr>
    <td style="width:20%; text-align: right;"><i class='required'>*</i>风格：</td>
    <td style="width:30%;">
        <div class="input-group-sm">
            <select class="form-control input-sm" id="tabStyle" name="tabStyle" title="风格">
              <option value="1">文本展示</option> 
              <option value="2">图标展示</option>
            </select>
        </div> </td>
    <td style="width:20%; text-align: right;"><i class='required'>*</i>对齐方式：</td>
    <td style="width:40%;">
     <div class="input-group-sm">
      	<select class="form-control input-sm" id="tabAlign" name="tabAlign" title="对齐方式">
              <option value="1">局左</option> 
              <option value="2">居右</option>
            </select>
     </div> </td>
   </tr>
   <tr>
   	 <td style="width:20%; text-align: right;"><i class='required'>*</i>字体大小：</td>
   	 <td style="width:30%;">
        <div class="input-group input-group-sm spinner " data-trigger="spinner"> 
	      <input type="text" class="form-control" id="fontSize" name="fontSize" data-min="12" data-max="24" data-precision="0"  title="字体大小" maxlength="20"> 
	      <span class="input-group-addon number-box-act"> 
		      <a href="javascript:" class="spin-up" data-spin="up">
		      	<i class="glyphicon glyphicon-triangle-top"></i>
		      </a> 
		      <a href="javascript:" class="spin-down" data-spin="down">
		      	<i class="glyphicon glyphicon-triangle-bottom"></i>
		      </a> 
	      </span> 
	     </div> 
     </td>
   </tr>
   <tr id="tabletr">
    <td style="width:85%;" colspan="4"> <style>
.datatable{
	margin:0 !important;
}
.ui-jqgrid-bdiv{
	overflow-x:auto !important;
}
</style>
        <div class="easyui-layout" fit="true">
     <table style="table-layout: fixed;margin: 0;width: 100%;">
      <tbody>
       <tr>
        <td>
            <div id="tableToolbar" class="tollbar">
                <div>
                    <a id="addTab" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="添加"><i class="fa fa-plus"></i> 添加</a>
        <a id="deleteTab" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="删除"><i class="fa fa-trash-o"></i> 删除</a>
        <a id="upTab" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="上移"><i class="fa fa-arrow-up"></i> 上移</a>
        <a id="downTab" href="javascript:void(0)"
           class="btn btn-primary form-tool-btn btn-sm" role="button"
           title="下移"><i class="fa fa-arrow-down"></i> 下移</a>
                </div>
            </div>
          <table id="tabjqGrid"></table>
           </td>
       </tr>
      </tbody>
     </table></div> </td>
   </tr>
  </tbody>
 </table>
</div>
    </form>
</div>


<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

</body>
<script tpye="text/javascript">
	var gdata = [];
	var lay_select_icon;
	var jqGridRowId;
	var jqGridIndex;
	
	$(function(){
		initJqgridS(null);
	});

	
    var dataGridColModel = [
        { label: 'id', name: 'id', key: true, width: 75, hidden:true },
      {
		label : 'oldValue',
		name : 'oldValue',
		hidden : true
	 },	
     {
        label: 'Tab页签',
        name: 'tab',
        width: 50,
        editable: true,
        edittype: 'text'
    },	
     {
        label: '图标',
        name: 'tabIcon',
        width: 50,
        align : 'center',
        editable: false
    }];
    
    function initJqgridS(){
        //gdata = data;
        $("#tabjqGrid").jqGrid({
            datatype: "local",
            toolbar: [false, 'top'],//启用toolbar
            colModel: dataGridColModel,//表格列的属性
            //data: gdata,
            height: $(window).height() - 200,//初始化表格高度
            scrollOffset: 20, //设置垂直滚动条宽度
            altRows: true,//斑马线
            styleUI: 'Bootstrap', //Bootstrap风格
            viewrecords: true, //是否要显示总记录数
            multiselect: true,//可多选
            autowidth: true,//列宽度自适应
            responsive: true,//开启自适应
            cellEdit: true,
            cellsubmit: 'clientArray',
            onCellSelect:function(rowid, index, contents, event){
            	if(index == 4){
            		jqGridRowId = rowid;
            		jqGridIndex = index;
            		var url = "static/h5/selectIcon/index.html";
					 lay_select_icon =  layer.open({
						    id:"selectIcon",
					        type : 2,
					        title: '图标选择',
					        skin: 'index-model-noborder',
					        move :'.simple-movetab',
					        area: ['80%', '80%'],
					        content : url
					    });
            	}
           }
        });

        $('#addTab').bind('click', function () {
            insertTab();
        });
        $("#deleteTab").bind('click', function () {
            deleteTab();
        });
        $("#upTab").bind('click',function(){
            moveRow("up");
        });
        $("#downTab").bind('click',function(){
            moveRow("down");
        });
    }
    

    function initJqgrid(data,extData){
    	gdata = data;
    	if(extData != "" && extData != undefined){
	    	//风格默认值
			if (extData.tabStyle == null||extData.tabStyle==''||extData.tabStyle==undefined){
				$('#tabStyle').val("1");
			}else{
				$("#tabStyle").val(extData.tabStyle);
			}
	    	//布局默认值
			if (extData.tabAlign == null||extData.tabAlign==''||extData.tabAlign==undefined){
				$('#tabAlign').val("1");
			}else{
				$("#tabAlign").val(extData.tabAlign);
			}
	    	//字体大小默认值
			if (extData.fontSize == null||extData.fontSize==''||extData.fontSize==undefined){
				$('#fontSize').val("12");
			}else{
				$("#fontSize").val(extData.fontSize);
			}
    	}
    	$("#tabjqGrid").setGridParam({data: gdata}).trigger('reloadGrid');
    }
    
    function setIconInfo(data) {
    	if(data != null){
    		$("#tabjqGrid").jqGrid('setCell',jqGridRowId,jqGridIndex,'<i class="'+data.icon+'"></i>'); 
    	}else{
    		$("#tabjqGrid").jqGrid('setCell',jqGridRowId,jqGridIndex,null); 
    	}
		layer.close(lay_select_icon);
	}
    /**
     * 上移下移
     * */
    function moveRow(type){
        var grid = $("#tabjqGrid");
        grid.jqGrid('endEditCell');
        var ids = grid.getDataIDs();
        var selRowid = grid.getGridParam("selrow");
        var selRowData = grid.getRowData(selRowid);//所选行数据
        var selRowNum = $.inArray(selRowid,ids);//所选行号
        var movRowNum = null;//移动行号
        var movRowid = null;
        var movRowData = null;//移动数据
        var datas = grid.jqGrid('getRowData');

        if(type === "up"){
            movRowNum = selRowNum - 1;
        }else if(type === "down"){
            movRowNum = selRowNum + 1;
        }else {
            return false;
        }

        //移动
        if(movRowNum>=0 && selRowNum>=0 && movRowNum<datas.length){
            movRowid = ids[movRowNum] ;
            movRowData = grid.getRowData(movRowid);

            datas[movRowNum] = selRowData;
            datas[selRowNum] = movRowData;

            grid.jqGrid("clearGridData");
            for(var i=0; i<datas.length; i++){
                grid.jqGrid("addRowData", i+1, datas[i]);
            }
            $(grid[0]).find("tr.jqgrow").addClass('edited');

            //默认选中移动的这个行
            grid.jqGrid('resetSelection');
            grid.jqGrid('setSelection', movRowNum+1);
        }else {
            return false;
        }
    }


    var newRowIndex = 0;
    var newRowStart = "new_row";

    function insertTab() {
        $("#tabjqGrid").jqGrid('endEditCell');
        var newRowId = newRowStart + newRowIndex;
        var parameters = {
            rowID: newRowId,
            initdata: {tabIcon:"<i class='glyphicon glyphicon-th-list'></i>"},
            position: "last",
            useDefValues: true,
            useFormatter: true,
            addRowParams: {extraparam: {}}
        };
        $("#tabjqGrid").jqGrid('addRow', parameters);
        newRowIndex++;
    }

    function deleteTab() {
        $("#tabjqGrid").jqGrid('endEditCell');
        var rows = $("#tabjqGrid").jqGrid('getGridParam', 'selarrrow');
        var ids = [];
        var l = rows.length;
        if (l > 0) {
            layer.confirm('确定要删除该数据吗？', {icon: 2, title: "提示"}, function (index) {
                for (var i = 0; i < l; i++) {
                    $("#tabjqGrid").jqGrid('delRowData', rows[0]);
                }
                var data = $("#tabjqGrid").jqGrid('getRowData');
                var temp = "";
                for (var i = 0; i < data.length; i++) {
                    temp = i == 0 ? temp + data[i].tab : temp + "," + data[i].tab;
                }

                layer.close(index);
            });
        } else {
            layer.msg('请选择要删除的记录！', {icon: 7});
        }
    }

    function saveTab() {
        $("#tabjqGrid").jqGrid('endEditCell');
        var data = $("#tabjqGrid").jqGrid('getRowData');
        var temp = "";
        for (var i = 0; i < data.length; i++) {
        	temp = i == 0 ? temp + data[i].tab.trim() : temp + "," + data[i].tab.trim();
            
        }
        return temp;
    }
    
    function getDataRows(){
    	return $("#tabjqGrid").jqGrid('getRowData');
    }
    
    function getExtData(){
    	return serializeObject($("#form"));
    }
</script>
</html>