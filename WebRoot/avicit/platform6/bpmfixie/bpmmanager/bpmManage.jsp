<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmmanager/js/bpmManager.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmmanager/js/bpmProcInst.js"></script>
<script type="text/javascript" src="avicit/platform6/bpmfixie/bpmcommon/flowUtils.js"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:''" style="width:250px;padding:0px;height:0;font-size:0;">
		<ul id="bpmManagerTree">正在加载数据...
		</ul>
	</div>
	<div data-options="region:'center'" style="background:#ffffff;height:0px;padding:0px;overflow:hidden;">
		<div id="toolbarDomeUserB" class="datagrid-toolbar">
			<table style="width:99%">
				<tr>
					<td>
						<div class="ext-toolbar-left">
								<a id="bpmProcinst_button_update" class="easyui-linkbutton" iconCls="icon-edit" plain="true" href="javascript:void(0);">修改</a>
								<a id="bpmProcinst_button_del" class="easyui-linkbutton" iconCls="icon-remove" plain="true" href="javascript:void(0);">删除</a>
						</div>
						<div class="ext-toolbar-right">
								<div class="ext-selector-div">
									<input class="easyui-validatebox ext-selector-input" title="请输入查询条件" id="titleValue" name="title"> <span id="bpmProcInst_searchPart" class="ext-input-right-icon icon-search"></span>
								</div>
								<a class="easyui-linkbutton" plain="true" id="advancedQuery" href="javascript:void(0);">高级查询 <span class="caret"></span></a>
								<span class="ext-icon changyong"></span>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<table class="easyui-datagrid" id="bpmProcInst" data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarDomeUserB',
				idField :'dbId',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'dbId', align:'center',checkbox:true" width="220">id</th>
					<th data-options="field:'executionId', align:'center',hidden:true" width="220">sid</th>
					<th data-options="field:'title',align:'left',formatter:getTraceButtons" width="220">标题</th>
					<th data-options="field:'userName',align:'left'" width="120">拟稿人</th>
					<th data-options="field:'deptName',align:'left'" width="120">拟稿部门</th>
					<th data-options="field:'startDate',align:'center',formatter:formatterData" width="220">申请日期</th>
					<th data-options="field:'activityName',align:'left'" width="220">当前节点</th>
					<th data-options="field:'businessState',align:'center',formatter:formatterStatue" width="120">状态</th>
					<th data-options="field:'assigneeName',align:'left'" width="220">处理人</th>
				</tr>
			</thead>
		</table>
	</div>



    <!-- 子表高级查询 -->
    <div id="searchDialogSub" style="overflow: auto;display: none">
        <form id="formSub">
            <table class="form_commonTable">
                <tr>
                    <th width="18%">标题：</th>
                    <td width="30%">
                        <input title="标题：" class="easyui-validatebox" style="width: 99%;" type="text" name="title"  id="title"/>
                    </td>
                    <th width="15%">流程状态：</th>
                    <td width="30%"><select name="businessState" id="businessState" class="easyui-combobox" data-options="editable:false">
                        <option value="">请选择</option>
                        <option value="active">流转中</option>
                        <option value="ended">已完成</option>
                    </select></td>
                </tr>
                <tr>
                    <th width="15%">申请人：</th>
                    <td width="30%">
                        <input class="inputbox" type="hidden" name="userId" id="userId"></input>
                        <div class="">
                            <input class="easyui-validatebox" type="text" name="receptUserName" id="receptUserName" readOnly="readOnly"></input>
                        </div>

                    </td>
                    <th width="15%">申请部门：</th>
                    <td width="30%">
                        <input class="inputbox" type="hidden" name="deptId" id="deptId" />
                        <div class="">
                            <input class="easyui-validatebox" type="text" name="applyDeptidAlias" id="applyDeptidAlias" readOnly="readOnly"></input>
                        </div>

                    </td>
                </tr>
                <tr>
                    <th width="15%">申请日期</th>
                    <td width="30%">
                        <input class="easyui-datebox"  editable="false" type="text" name="startDateBegin" id="startDateBegin" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>

                    </td>
                    <th width="15%" align="center" style="text-align:center">至</th>
                    <td width="30%">
                        <input class="easyui-datebox" editable="false" type="text" name="startDateEnd" id="startDateEnd" /><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </td>
                </tr>
                <tr>
                    <th width="15%">是否挂起：</th>
                    <td width="30%"><select name="suspended" id="suspended" class="easyui-combobox" data-options="editable:false">
                        <option value="">请选择</option>
                        <option value="0">正常</option>
                        <option value="1">挂起</option>
                    </select></td>
                </tr>
            </table>
        </form>
    </div>
    <script type="text/javascript">
        var bpmManager, bpmProcInst;
        $(function() {
            bpmManager = new BpmManager('bpmManagerTree', 'bpm/monitor/getFlowModelTree?needPermission=1');
            bpmManager.setOnSelect(function(_tree, node) {
                var condition={
                    nodeId : node.id,
                    nodeType : node.attributes.nodeType,
                    pdId : node.attributes.pdId || ''
                };
                if (!bpmProcInst) {
                    bpmProcInst = new BpmProcInst("bpmProcInst", "bpm/process/searchManageHistProcessByPage?type=3");
                    bpmProcInst.init(condition);
                    return;
                }
                bpmProcInst.reLoad(condition);
            });


            $('#bpmProcinst_button_del').bind('click', function() {
                bpmProcInst.del();
            });

            $('#bpmProcinst_button_update').bind('click', function() {
                bpmProcInst.update();
            });
            $('#bpmProcInst_searchPart').bind('click',function(){
                searchByKey();
            });
            $('#titleValue').on('keydown',function(e){
                if(e.keyCode == '13'){
                    searchByKey();
                }
            });

            $('#advancedQuery').bind('click',function(){
                bpmProcInst.openSearchForm('#advancedQuery');
            });


            $("#receptUserName").on('focus', function(e) {
                new EasyuiCommonSelect({
                    type : 'userSelect',
                    idFiled : 'userId',
                    textFiled :'receptUserName',
                    viewScope : 'currentOrg'
                });
                this.blur();
            });
            $("#applyDeptidAlias").on('focus', function(e) {
                new EasyuiCommonSelect({
                    type : 'deptSelect',
                    idFiled :'deptId',
                    textFiled : 'applyDeptidAlias',
                    viewScope : 'currentOrg'
                });
                this.blur();
            });

            $('.combo').bind('click', function() {//解决高级查询控件层级问题
                $('.panel.combo-p').css('z-index', 999999999)
            });

        });


        var searchByKey=function(){
            bpmProcInst.searchByKey(JSON.stringify({"title":$('#titleValue').val()}));

        };

        //格式化数据
        var getTraceButtons = function(cellvalue, row) {
            if (cellvalue == undefined || cellvalue == '') {
                cellvalue = row.procDefName;
                if (cellvalue == undefined || cellvalue == '') {
                    cellvalue = "无";
                }
            }
            return cellvalue;
        };

        var formatterData = function(value) {
            var startdateMi = value;
            if (startdateMi == undefined) {
                return '';
            }
            var newDate = new Date(startdateMi);
            return newDate.format("yyyy-MM-dd hh:mm:ss");
        };

        var formatterStatue = function(cellvalue) {
            if (cellvalue == 'start') {
                return '拟稿中';
            } else if (cellvalue == 'active') {
                return '流转中';
            } else if (cellvalue == 'ended') {
                return '已完成';
            } else {
                return cellvalue;
            }
        }
    </script>
</body>

</html>