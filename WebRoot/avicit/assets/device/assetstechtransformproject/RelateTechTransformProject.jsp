<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%
    String importlibs = "common,table,form";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/assetstechtransformproject/assetsTechTransformProjectController/toAssetsTechTransformProjectManage" -->
    <title>管理</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
	<div id="panelnorth" data-options="region:'north',height:fixheight(.5),onResize:function(a){$('#assetsTechTransformProject').setGridWidth(a);$('#assetsTechTransformProject').setGridHeight(getJgridTableHeight($('#panelnorth')));$(window).trigger('resize');}">
		<div id="toolbar_assetsTechTransformProject" class="toolbar">
            <div class="toolbar-left">
                <a id="assetsTechTransformProject_relate" href="javascript:void(0)" class="btn btn-default form-tool-btn btn-sm" role="button" title="关联">
                    <i class="fa fa-plus"></i>关联
                </a>
            </div>
			<div class="toolbar-right">
				<div class="input-group form-tool-search" style="width:125px">
					<input type="text" name="assetsTechTransformProject_keyWord" id="assetsTechTransformProject_keyWord" style="width:125px;" class="form-control input-sm" placeholder="请输入查询条件">
					<label id="assetsTechTransformProject_searchPart" class="icon icon-search form-tool-searchicon"></label>
				</div>
				<div class="input-group-btn form-tool-searchbtn">
					<a id="assetsTechTransformProject_searchAll" href="javascript:void(0)" class="btn btn-defaul btn-sm" role="button">
						高级查询 <span class="caret"></span>
					</a>
				</div>
			</div>
		</div>
		<table id="assetsTechTransformProject"></table>
		<div id="assetsTechTransformProjectPager"></div>
	</div>
</body>

<!-- 主表高级查询 -->
<div id="searchDialog" style="overflow: auto;display: none">
    <form id="form">
        <input type="hidden" id="bpmState" name="bpmState" value="all">
        <table class="form_commonTable">
            <tr>
                <th width="10%">项目序号:</th>
                <td width="15%">
                    <input title="项目序号" class="form-control input-sm" type="text" name="projectNo" id="projectNo"/>
                </td>

                <th width="10%">技改项目名称:</th>
                <td width="15%">
                    <input title="技改项目名称" class="form-control input-sm" type="text" name="ttProjectName" id="ttProjectName"/>
                </td>

                <th width="10%">批复名称:</th>
                <td width="15%">
                    <input title="批复名称" class="form-control input-sm" type="text" name="replyName" id="replyName"/>
                </td>

                <th width="10%">主管总师:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="chiefEngineer" name="chiefEngineer">
                        <input class="form-control" placeholder="请选择用户" type="text" id="chiefEngineerAlias" name="chiefEngineerAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>
            </tr>

            <tr>
                <th width="10%">项目主管:</th>
                <td width="15%">
                    <div class="input-group  input-group-sm">
                        <input type="hidden" id="projectDirector" name="projectDirector">
                        <input class="form-control" placeholder="请选择用户" type="text" id="projectDirectorAlias" name="projectDirectorAlias">
                        <span class="input-group-addon">
							<i class="glyphicon glyphicon-user"></i>
						</span>
                    </div>
                </td>

                <th width="10%">备注:</th>
                <td width="15%">
                    <input title="备注" class="form-control input-sm" type="text" name="remarks" id="remarks"/>
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<!-- 列表的js -->
<script src="avicit/assets/device/assetstechtransformproject/js/RelateTechTransformProject.js" type="text/javascript"></script>

<script type="text/javascript">
    var assetsTechTransformProject;

    function formatValue(cellvalue, options, rowObject) {
        return '<a href="javascript:void(0);" onclick="assetsTechTransformProject.detail(\'' + rowObject.id + '\');">' + cellvalue + '</a>';
    }

    function formatDateForHref(cellvalue, options, rowObject) {
        var thisDate = format(cellvalue);
        return '<a href="javascript:void(0);" onclick="assetsTechTransformProject.detail(\'' + rowObject.id + '\');">' + thisDate + '</a>';
    }

    //刷新本页面
    window.bpm_operator_refresh = function () {
        assetsTechTransformProject.reLoad();
    };

    $(document).ready(function () {
    	/*技改项目列表初始化——开始*/
        var searchMainNames = new Array();
        var searchMainTips = new Array();

        searchMainNames.push("ttProjectName");
        searchMainTips.push("技改项目名称");

        searchMainNames.push("remarks");
        searchMainTips.push("备注");

        var searchMainC = searchMainTips.length == 2 ? '或' + searchMainTips[1] : "";
        $('#assetsTechTransformProject_keyWord').attr('placeholder', '请输入' + searchMainTips[0] + searchMainC);
        $('#assetsTechTransformProject_keyWord').attr('title', '请输入' + searchMainTips[0] + searchMainC);

		var assetsTechTransformProjectGridColModel = [
			  {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '项目序号', name: 'projectNo', width: 100}
			, {label: '技改项目名称', name: 'ttProjectName', width: 150, formatter: formatValue}
            , {label: '批复名称', name: 'replyName', width: 150}
			, {label: '主管总师', name: 'chiefEngineerAlias', width: 150}
			, {label: '项目主管', name: 'projectDirectorAlias', width: 150}
			, {label: '备注', name: 'remarks', width: 250}
		];

		assetsTechTransformProject = new AssetsTechTransformProject('assetsTechTransformProject', '${url}', 'form', assetsTechTransformProjectGridColModel,
				'searchDialog', searchMainNames, "assetsTechTransformProject_keyWord");
		/*技改项目列表初始化——结束*/

		/*技改项目表操作——开始*/
        $('#assetsTechTransformProject_relate').bind('click', function () {	//关联技改项目
            var projectRows = $('#assetsTechTransformProject').jqGrid('getGridParam','selarrrow');
            if((projectRows == undefined) || (projectRows == null) || (projectRows.length == 0)){
                layer.msg('请先选择需要关联的技改项目！');
                return;
            }
            else if(projectRows.length > 1){
                layer.msg('只能关联一个技改项目！');
                return;
            }

            var rowData = jQuery("#assetsTechTransformProject").jqGrid("getRowData", projectRows[0]);
            parent.procDetail.relateTechTransformProject(rowData);
        });

        $('#assetsTechTransformProject_searchAll').bind('click', function () {	//打开高级查询框
            assetsTechTransformProject.openSearchForm(this, $('#assetsTechTransformProject'));
        });

        $('#assetsTechTransformProject_searchPart').bind('click', function () {	//关键字段查询按钮绑定事件
            assetsTechTransformProject.searchByKeyWord();
        });

        $('#chiefEngineerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'chiefEngineer', textFiled: 'chiefEngineerAlias'});
            this.blur();
            nullInput(e);
        });

        $('#projectDirectorAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'projectDirector', textFiled: 'projectDirectorAlias'});
            this.blur();
            nullInput(e);
        });
		/*技改项目表操作——结束*/
    });
</script>
</html>