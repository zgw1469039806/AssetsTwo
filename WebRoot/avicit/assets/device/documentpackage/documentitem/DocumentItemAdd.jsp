<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
	String importlibs = "common,form,table,fileupload,tree";
%>
<!DOCTYPE html>
<html>
<head>
    <!-- ControllerPath = "assets/device/documentpackage/documentPackageController/operation/sub/Add/null" -->
    <title>添加</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">

	<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
		<jsp:param value="<%=importlibs%>" name="importlibs"/>
	</jsp:include>
</head>
<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='form'>
        <input type="hidden" name="id"/>
        <input type="hidden" name="packageId" id="packageId"/>
        <table class="form_commonTable">
			<tr class="commonTableTr">
				<th><label for="attachment">附件:</label></th>
				<td colspan="<%=4 * 2 - 1%>">
					<div id="attachment" class="attachment_div eform_mutiattach_auth"></div>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="documentName">文档名称:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="documentName" id="documentName" />
				</td>

				<th width="10%"><label for="documentType">文档类型:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="documentType" id="documentType" title="" isNull="true" lookupCode="PLATFORM_FILE_TYPE"/>
				</td>

				<th width="10%"><label for="documentCategory">文档分类:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="documentCategory" id="documentCategory" title="" isNull="true" lookupCode="PLATFORM_FILE_CATEGORY"/>
				</td>

				<th width="10%"><label for="lifeStage">生命阶段:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="lifeStage" id="lifeStage" title="" isNull="true" lookupCode="PLATFORM_FILE_LIFE_STAGE"/>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="documentAuthorAlias">作者:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="documentAuthor" name="documentAuthor">
						<input class="form-control" placeholder="请选择用户" type="text" id="documentAuthorAlias" name="documentAuthorAlias">
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
					</div>
				</td>

				<th width="10%"><label for="authorDeptAlias">作者所在部门:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="authorDept" name="authorDept">
						<input class="form-control" placeholder="请选择部门" type="text" id="authorDeptAlias" name="authorDeptAlias">
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
					</div>
				</td>

				<th width="10%"><label for="keyWord">关键字:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="keyWord" id="keyWord" />
				</td>

				<th width="10%"><label for="currentVersion">文档版本:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="currentVersion" id="currentVersion" />
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="lastVersion">更新前版本:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="lastVersion" id="lastVersion" />
				</td>

				<th width="10%"><label for="documentState">文档状态:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="documentState" id="documentState" title="" isNull="true" lookupCode="PLATFORM_FILE_STATE"/>
				</td>

				<th width="10%"><label for="languageCategory">语言类别:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="languageCategory" id="languageCategory" title="" isNull="true" lookupCode="PLATFORM_LANGUAGE_CATEGORY"/>
				</td>

				<th width="10%"><label for="secretLevel">文档密级:</label></th>
				<td width="15%">
					<pt6:h5select css_class="form-control input-sm" name="secretLevel" id="secretLevel" title="" isNull="true" lookupCode="SECRET_LEVEL"/>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="documentAbstract">文档摘要:</label></th>
				<td width="40%" colspan="3">
					<textarea class="form-control input-sm" rows="3" name="documentAbstract" id="documentAbstract"></textarea>
				</td>

				<th width="10%"><label for="documentDescribe">文档描述:</label></th>
				<td width="40%"  colspan="3">
					<textarea class="form-control input-sm" rows="3" name="documentDescribe" id="documentDescribe"></textarea>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="personLiableAlias">责任人:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="personLiable" name="personLiable">
						<input class="form-control" placeholder="请选择用户" type="text" id="personLiableAlias" name="personLiableAlias">
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
					</div>
				</td>

				<th width="10%"><label for="participantsAlias">参与人:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="participants" name="participants">
						<input class="form-control" placeholder="请选择用户" type="text" id="participantsAlias" name="participantsAlias">
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
					</div>
				</td>

				<th width="10%"><label for="documentUpdateByAlias">更新人:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="documentUpdateBy" name="documentUpdateBy">
						<input class="form-control" placeholder="请选择用户" type="text" id="documentUpdateByAlias" name="documentUpdateByAlias">
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-user"></i>
							</span>
					</div>
				</td>

				<th width="10%"><label for="documentUpdateDate">最近更新时间:</label></th>
				<td width="15%">
					<div class="input-group input-group-sm">
						<input class="form-control date-picker" type="text" name="documentUpdateDate" id="documentUpdateDate" />
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-calendar"></i>
							</span>
					</div>
				</td>
			</tr>
			<tr>
				<th width="10%"><label for="belongProject">所属项目:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="belongProject" id="belongProject" />
				</td>

				<th width="10%"><label for="warehouseCatelog">文档仓库目录:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="warehouseCatelog" id="warehouseCatelog" />
				</td>

				<th width="10%"><label for="knowScopeAlias">知悉范围:</label></th>
				<td width="15%">
					<div class="input-group  input-group-sm">
						<input type="hidden" id="knowScope" name="knowScope">
						<input class="form-control" placeholder="请选择群组" type="text" id="knowScopeAlias" name="knowScopeAlias">
						<span class="input-group-addon">
								<i class="glyphicon glyphicon-equalizer"></i>
							</span>
					</div>
				</td>

				<th width="10%"><label for="documentLabel">文档标签:</label></th>
				<td width="15%">
					<input class="form-control input-sm" type="text" name="documentLabel" id="documentLabel" />
				</td>
			</tr>
        </table>
    </form>
</div>
<div data-options="region:'south',border:false" style="height: 60px;">
    <div id="toolbar"
         class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
        <table class="tableForm" style="border:0;cellspacing:1;width:100%">
            <tr>
                <td width="50%" style="padding-right:4%;" align="right">
                    <a href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm" role="button" title="保存" id="documentItem_saveForm">保存</a>
                    <a href="javascript:void(0)" class="btn btn-grey form-tool-btn btn-sm" role="button" title="返回" id="documentItem_closeForm">返回</a>
                </td>
            </tr>
        </table>
    </div>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>

<script type="text/javascript">
    function closeForm() {
        parent.documentItem.closeDialog("insert");
    }

    function saveForm() {
        var isValidate = $("#form").validate();
        if (!isValidate.checkForm()) {
            isValidate.showErrors();
            $(isValidate.errorList[0].element).focus();
            return false;
        }
        $("#packageId").val(parent.documentItem.pid);

		//验证附件密级
		var files = $('#attachment').uploaderExt('getUploadFiles');
		for(var i = 0; i < files.length; i++){
			var name = files[i].name;
			var secretLevel = files[i].secretLevel;
		}

        //限制保存按钮多次点击
        $('#documentItem_saveForm').addClass('disabled').unbind("click");
        parent.documentItem.save($('#form'), "insert", callback);
    }

	//上传附件
	function callback(id) {
		var files = $('#attachment').uploaderExt('getUploadFiles');
		if(files == 0){
			closeForm();
		}
		else{
			$("#id").val(id);
			$('#attachment').uploaderExt('doUpload', id);
		}
	}

	//附件上传完后执行
	function afterUploadEvent(){
		closeForm();
	}

    $(document).ready(function () {
        $('.date-picker').datepicker();
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
            }
        });

        parent.documentItem.formValidate($('#form'));

		//初始化附件上传组件
		$('#attachment').uploaderExt({
			secretLevel: 'PLATFORM_FILE_SECRET_LEVEL',
			afterUpload: function () {
				return afterUploadEvent();
			}
		});

        //保存按钮绑定事件
        $('#documentItem_saveForm').bind('click', function () {
            saveForm();
        });
        //返回按钮绑定事件
        $('#documentItem_closeForm').bind('click', function () {
            closeForm();
        });

		$('#documentAuthorAlias').on('focus', function (e) {	//文档作者绑定事件
			new H5CommonSelect({type: 'userSelect', idFiled: 'documentAuthor', textFiled: 'documentAuthorAlias'});
			this.blur();
			nullInput(e);
		});

		$('#authorDeptAlias').on('focus', function (e) {	//文档作者部门绑定事件
			new H5CommonSelect({type: 'deptSelect', idFiled: 'authorDept', textFiled: 'authorDeptAlias'});
			this.blur();
			nullInput(e);
		});

		$('#personLiableAlias').on('focus', function (e) {	//责任人绑定事件
			new H5CommonSelect({type: 'userSelect', idFiled: 'personLiable', textFiled: 'personLiableAlias'});
			this.blur();
			nullInput(e);
		});

		$('#participantsAlias').on('focus', function (e) {	//参与人绑定事件
			new H5CommonSelect({type: 'userSelect', idFiled: 'participants', textFiled: 'participantsAlias', selectModel: 'multi'});
			this.blur();
			nullInput(e);
		});

		$('#documentUpdateByAlias').on('focus', function (e) {	//更新人绑定事件
			new H5CommonSelect({type: 'userSelect', idFiled: 'documentUpdateBy', textFiled: 'documentUpdateByAlias'});
			this.blur();
			nullInput(e);
		});

		$('#knowScopeAlias').on('focus', function (e) {	//文档知悉范围绑定事件
			new H5CommonSelect({type: 'groupSelect', idFiled: 'knowScope', textFiled: 'knowScopeAlias', selectModel: 'multi'});
			this.blur();
			nullInput(e);
		});

        $('.date-picker').on('keydown', nullInput);
        $('.time-picker').on('keydown', nullInput);
    });
</script>
</body>
</html>