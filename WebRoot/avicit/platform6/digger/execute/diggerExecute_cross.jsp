<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form,table";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>${diggerName} - 运行</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <style type="text/css">
        .sp {
            width: 60px;
            border-left: 1px solid #666666;
            border-right: 1px solid #666666;
            padding-left: 25px;
            background-color: #ffffff;
        }
        .totalBackgroupColor{
            background-color: #efef6d;
        }
        .text-ellipsis {
            white-space: nowrap;
            text-overflow : ellipsis;
        }
        .text-break{word-break: break-all; white-space: normal!important}
        .panel-fit, .panel-fit body {
            overflow-x: auto;
            overflow-y: hidden;
        }
    </style>
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
    <script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
    <script type="text/javascript">
        var isAdmin ='true';
        var viewScopeType='';
        if(isAdmin=="true"){
        	viewScopeType = 'currentOrg';
        }else{
        	viewScopeType = 'allowAcross';
        }
    </script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='queryForm'>
        <table class="form_commonTable" id="condition" style="display: ${displayConditionArea}">
            <tr>
                <td width="80%" style="word-break: break-all; word-warp: break-word;">
                   <table class="form_commonTable">
                       ${queryCondition}
                   </table>
                </td>
                <td width="20%">
<%--                    <input title="名称" class="form-control input-sm" type="text" style="width: 99%;" type="text"--%>
<%--                          name="name" id="name"/>--%>
                    <table>
                        <tr><td valign="bottom">
                            <a href="javascript:execute();" class="btn btn-default form-tool-btn btn-sm" role="button" title="保存" id="execute">查询</a>
                            <a href="javascript:rest();" class="btn btn-grey form-tool-btn btn-sm" role="button" title="取消" id="rest">重置</a>
                        </td></tr>
                    </table>
                </td>
            </tr>

        </table>
        <div id="container" style="height: 400px">
            <table style="width: 100%">
                <tr>
                    <td style="width: 100%" align="center"><h4>${diggerName}</h4></td>
                </tr>
                <tr>
                    <td>
                        <div class="toolbar">
                            <div class="toolbar-left"></div>
                            <div class="toolbar-right" style="padding-right:10px;">
                                <span style="color: #B5B5B5;">
                                     <a href="javascript:void(0)" onclick="changeShowType(1)" title="打印" style="text-decoration:none;" class="cicon" >
                                    <i class="glyphicon glyphicon-print" style="font-size:14px;"></i></a>&nbsp;
                                </span>
                                <span style="color: #B5B5B5;">
                                    <a href="javascript:void(0)" onclick="refresh();return false;" title="刷新" style="text-decoration:none;" class="cicon" >
                                    <i class="glyphicon glyphicon-refresh" style="font-size:14px;"></i></a>&nbsp;
                                </span>
                                <span style="color: #B5B5B5;">
                                    <a href="javascript:void(0)" onclick="dataExportEvent();return false;" title="导出" style="text-decoration:none;" class="cicon" id="lbicon">
                                        <i class="glyphicon glyphicon-share" style="font-size:14px;"></i></a>
                                </span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%" align="center">
                        <table style="width: 80%" id="executeCrossGrid"></table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</div>
<div id="exportDataDialog" style="display:none;">
    <table style="margin:20px 0 0 50px">
        <tr>
            <td> <label ><input type='radio' name='exportType' value='pdf' checked /> <image src='static/images/platform/common/file/pdf.jpg'/>PDF</label></td>
        </tr>
        <tr>
            <td><label><input type='radio' name='exportType' value='excel' /> <image src='static/images/platform/common/file/excel.jpg'/>EXCEL</label></td>
        </tr>
    </table>
</div>
<form id="chartForm" style="display:none">
    <input id="imageValue" name="base64Info" type="text" maxlength="50000"/>
    <input id="exportTypeValue" name="exportTypeValue" type="text" />
    <input id="diggerId" name="diggerId" type="hidden" value="${diggerId}" />
</form>
<script src="avicit/platform6/digger/execute/js/DiggerExecuteCrossGrid.js"></script>
<script src="avicit/platform6/digger/execute/js/DiggerExecute.js"></script>
<script src="static/js/platform/component/common/json2.js" type="text/javascript"></script>
<script type="text/javascript">

    function getCondition(){
         var form =  $('#queryForm');
         var formSerializeValue = form.serialize();
         var formdata = decodeURIComponent(formSerializeValue,true);
         var condition = convertFormSerializeValueToJson(formdata);
         return condition;
    }
    var autoExec = ${autoExec};
    $(function(){
        if(autoExec == 1){//自动执行查询
            execute();
        }
    });
    var detailGridColModelJson = ${detailGridColModelJson};
    var diggerExecuteDetailGridModel = new Array();
    //表信息息设置
    diggerExecuteDetailGridModel.push({
        label : '${aggregateHeader}',
        name : 'CROSSTABLEHEADER',
        width : '150px'
    });

    for(var i = 0 ; i < detailGridColModelJson.length ; i++){
        var detailGridColModel = detailGridColModelJson[i];
        if(detailGridColModel){
            var obj = new Object();
            obj.name = detailGridColModel.${name};
            obj.label = detailGridColModel.${label};
            //设置列框
            obj.hidedlg = false;
            obj.hidden = false;
            obj.sortable = true;
            //'left' | 'right' | 'center  /0:'左对齐',1:'居中',2:'右对齐'
            var alignType="left";
            if(detailGridColModel.alignType==0){
                alignType="left";
            }
            if(detailGridColModel.alignType==1){
                alignType="center";
            }
            if(detailGridColModel.alignType==2){
                alignType="right";
            }
            obj.align = alignType;

            if(isEmpty(detailGridColModel.appearance)){
                //默认（没有配置值）
                obj.width = '150px';
            }else{
                //有配置值
                if(!isEmpty(JSON.parse(detailGridColModel.appearance).columnWidth)){
                    obj.width = JSON.parse(detailGridColModel.appearance).columnWidth+JSON.parse(detailGridColModel.appearance).columnWidthUnit;
                }else{
                    obj.width = '150px';
                }
                obj.cellattr =  function addCellAttr(rowId, val, rawObject, cm, rdata) {
                    // return "style='color:"+JSON.parse(detailGridColModel.appearance).frontColor+"'";
                    var appearanceColModel={};
                    for(var i=0;i<detailGridColModelJson.length;i++){
                        if(detailGridColModelJson[i].name==cm.name){
                            appearanceColModel=JSON.parse(detailGridColModelJson[i].appearance);
                            break;
                        }
                    }
                    var styleStr = "";
                    if(!isEmpty(appearanceColModel.fontSize)||!isEmpty(appearanceColModel.bgColor)||!isEmpty(appearanceColModel.frontColor)){
                        styleStr+="style='";
                        if(!isEmpty(appearanceColModel.fontSize)){
                            styleStr+="font-size:"+appearanceColModel.fontSize+";";
                        }
                        if(!isEmpty(appearanceColModel.bgColor)){
                            styleStr+="background-color:"+appearanceColModel.bgColor+";";
                        }
                        if(!isEmpty(appearanceColModel.frontColor)){
                            styleStr+="color:"+appearanceColModel.frontColor+";";
                        }
                        styleStr+="'";
                        return styleStr;
                    }else{
                        return ;
                    }
                    // return "style='font-size:"+appearanceColModel.fontSize+";background-color:"+appearanceColModel.bgColor+";color:"+appearanceColModel.frontColor+"'";
                };
                if(JSON.parse(detailGridColModel.appearance).allowWrapDisplay=="1"){
                    //1允许换行
                    obj.classes="text-break";
                }else{
                    //0不允许换行
                    obj.classes="text-ellipsis";
                }
            }

            if(!isEmpty(detailGridColModel.action)){
                //action有值
                obj.formatter=function format(cellvalue, options, rowObject){
                    var actionColModel ={};
                    for(var i=0;i<detailGridColModelJson.length;i++){
                        if(detailGridColModelJson[i].name==options.colModel.name){
                            actionColModel =JSON.parse(detailGridColModelJson[i].action);
                            break;
                        }
                    }
                    //0窗口，1浏览器tab,2本框架tab
                    //0窗口，1浏览器tab,2本框架tab
                    if(actionColModel.openway=="0"){
                        //窗口
                        return "<a onclick=\"openIframe('"+actionColModel.targetType+"','"+actionColModel.behaviourtarget+"','"+actionColModel.behaviourtarget2+"','"+rowObject.ID+"')\">"+cellvalue+"</a>";
                        // return "<a href='javascript:void(0);' onclick=openIframe();>"+cellvalue+"</a>";

                    }
                    if(actionColModel.openway=="1"){
                        //新建浏览器tab页面
                        return "<a onclick=\"openInternet('"+actionColModel.targetType+"','"+actionColModel.behaviourtarget+"','"+actionColModel.behaviourtarget2+"','"+rowObject.ID+"')\">"+cellvalue+"</a>";

                    }
                    if(actionColModel.openway=="2"){
                        //新建本框架tab页
                        return "<a onclick=\"openTab('"+actionColModel.targetType+"','"+actionColModel.behaviourtarget+"','"+actionColModel.behaviourtarget2+"','"+rowObject.ID+"')\">"+cellvalue+"</a>";

                    }

                }
            }

            diggerExecuteDetailGridModel.push(obj);
        }
    }
    var executeCrossGrid;
    $(function() {
        var condition = getCondition();
        executeCrossGrid = new DiggerExecuteCrossGrid('executeCrossGrid','${url}',diggerExecuteDetailGridModel,'${diggerId}',${rownumbers},false,escape(condition));
    });

    function execute(){
         var condition = getCondition();
         executeCrossGrid.executeQuery(condition);
         return false;
    }
    function rest(){
        document.getElementById("queryForm").reset();
    }

</script>
</body>
</html>
