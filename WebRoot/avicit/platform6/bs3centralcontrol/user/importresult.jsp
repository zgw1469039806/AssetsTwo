<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<% 
String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>查看日志</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script type="text/javascript">

</script>
</head>
<body>

<div  >
	
	 <fieldset>
        <form id="search">
       		<table class="form_commonTable">
				<tr>
					<th width="5%" style="word-break: break-all; word-warp: break-word;"><label for="education">导入表：</label></th>
					<td width="20%"><input title="" class="form-control input-sm" type="text" name="filter-like-SYS_LOOKUP_NAME" id="syslookUpName" /></td>
					
					<th width="5%" style="word-break: break-all; word-warp: break-word;"><label for="education">导入人：</label></th>
					<td width="20%"><input title="" class="form-control input-sm" type="text" name="filter-like-OPETATOR_PERSON" id="optPerson" /></td>
					
				</tr>
				
			</table>
        </form>
        <div data-options="region:'south',border:false" style="height: 40px;">
		<div id="toolbar"
			class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
			<table class="tableForm" style="border:0;cellspacing:1;width:100%">
				<tr>
					<td width="50%" style="padding-right:4%;" align="center">
						<a href="javascript:void(0)" style="margin-right:10px;" class="btn btn-primary form-tool-btn typeb btn-sm" role="button" onclick="searchData();" title="查询" id="queryFrom">查询</a>
						<a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" onclick="clearData();" title="返回" id="resetFrom">重置</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
    </fieldset>
</div>

<table id="jqGrid"></table>
<div id="jqGridPager"></div>
</body>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/console/user/js/consoleUser.js" type="text/javascript"></script> 
<script type="text/javascript">

$(document).ready(function () {
	
	var dataGridColModel =  [
      { label: 'id', name: 'id', key: true, width: 75, hidden:true }
 	  ,{ label: '导入表', name: 'sysLookupName', width: 100,align:'center'}
      ,{ label: '成功数', name: 'successCount', width: 200 ,align:'center'}
      ,{ label: '失败数', name: 'failCount', width: 200,align:'center'}
      ,{ label: '导入人', name: 'opetatorPerson', width: 200,align:'center'}
      ,{ label: '导入时间', name: 'creationDate', width: 200,align:'center'}
      ,{ label: '下载', name: 'fileUrl', width: 200,align:'center',formatter:formatURL}
      
	];
	
	$('#jqGrid').jqGrid({
    	url: 'platform/excelImportResult/allImportResultsjq.json',
        mtype: 'POST',
        datatype: "json",
        colModel: dataGridColModel,
        height: document.documentElement.clientHeight-180,
        scrollOffset: 20, //设置垂直滚动条宽度
        rowNum: 10	,
        rowList:[200,100,50,30,20,10],
        altRows:true,
        pagerpos:'left',
        styleUI : 'Bootstrap',
		viewrecords: true, //
		multiselect: true,
		autowidth: true,
		hasColSet:false,
		hasTabExport:false,
		responsive:true,//开启自适应
        pager: "#jqGridPager"
    });
	
 
    
  
});






  //去后台查询
  function searchData(){
  	var searchdata = {param:JSON.stringify(serializeObject($('#search')))};
	$('#jqGrid').jqGrid('setGridParam',{postData: searchdata}).trigger("reloadGrid");
    
  }
  /*清空查询条件*/
  function clearData(){
    $('#syslookUpName').val('');
    $('#optPerson').val('');
    searchData();
  };
  function formatURL(value,row,index){
    if(!value)
      return "<span style='color:green'>导入成功</span>";
    return "<span style='color:red;cursor:pointer;'onclick='downLoadFile(\""+value+"\");'>失败【查看】</span>";
  }
  function downLoadFile(value){
    var url = "platform/excelImportController/downErroeFile?fileName="+value+"&downType=jq";
    var t = new DownLoad4URL('iframe','form',null,url);
    t.downLoad();
  
  }
  //删除导入记录
  function deleteResult(){
    var rows = dg.datagrid('getChecked');
    var ids = [];
    var l=rows.length;
    if (rows.length > 0) {
      $.messager.confirm('请确认','您确定要删除当前所选的数据？',
        function(b){
          if(b){
            for (;l--;) {
              ids.push(rows[l].id);
            }
            $.ajax({
              url : 'platform/excelImportResult/deleteImportResults',
              data : {
                ids : ids.join(',')
              },
              type : 'post',
              dataType : 'json',
              success : function(result) {
                if (result.flag == "success") {
                  var dtTemp=dg.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
                  dtTemp.datagrid('reload');
                  $.messager.show({
                    title : '提示',
                    msg : '删除成功',
                    timeout:2000,  
                        showType:'slide'
                  });
                }
              }
            });
          }
        });
    } else {
      $.messager.alert('提示', '请选择要删除的记录！', 'warning');
    }
  }
  //返回主页面
  function returnMain(){
    var f = parent&&parent.closeDataResult;
    if(typeof(f)!=='undefined'){
      f();
    }
  }
  
  /**
   * 模拟ajax导出
   * 无弹出框,post提交无参数限制
   * @param iframeId
   * @param formId
   * @param headData
   */
   function DownLoad4URL(iframeId,formId,headData,actionUrl){
     //设置是否显示遮罩Iframe
     if(typeof(iframeId)!=='string'&&iframeId.trim()!==''){
       throw new Error("iframeId不能为空！");
     }
     
    //设置是否显示遮罩Iframe
    if(typeof(formId)!=='string'&&formId.trim()!==''){
      throw new Error("formId不能为空！");
    }
    this.iframeName = "_iframe_" + iframeId;
    this.formName = "_form_" + formId;
    this.doc = document;//缓存全局对象，提高效率
    this.createDom.call(this,headData,actionUrl);
  };
  DownLoad4URL.prototype.downLoad=function(){
    this.doc.getElementById(this.formName).submit();
  };
  DownLoad4URL.prototype.createDom=function(headData,url){
    //先销毁对象，再创建
    if(jQuery("#" + this.iframeName).length > 0 ){
      jQuery("#" + this.iframeName).remove();
      
    }
    
    //先销毁对象，再创建
    if(jQuery("#" + this.formName).length > 0 ){
      jQuery("#" + this.formName).remove();
    }
    if(jQuery("#" + this.iframeName).length == 0){
      var exportIframe = this.doc.createElement("iframe"); 
      exportIframe.id = this.iframeName; 
      exportIframe.name = this.iframeName; 
      exportIframe.style.display = 'none'; 
      this.doc.body.appendChild(exportIframe); 
      //创建form 
      var exportForm = this.doc.createElement("form"); 
      exportForm.method = 'post';
      
      exportForm.action = url; 
      exportForm.name = this.formName; 
      exportForm.id = this.formName;
      exportForm.target = this.iframeName;
      this.doc.body.appendChild(exportForm); 
      if(headData&&typeof(headData)==='object'){
        for (var key in headData){
         var headInput = this.doc.createElement("input"); 
         headInput.setAttribute("name",key); 
         headInput.setAttribute("type","text"); 
         if(typeof(headData[key])=='string'){
           headInput.setAttribute("value",headData[key]);
         }else{
           var jsonStr=JSON.stringify(headData[key]);
           headInput.setAttribute("value",jsonStr);
         }
         exportForm.appendChild(headInput); 
        }
      }
    }
  };
  

</script>
</html>