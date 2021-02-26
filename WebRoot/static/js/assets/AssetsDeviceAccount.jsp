<%--
  Created by IntelliJ IDEA.
  User: 666666
  Date: 2020/7/10
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>台账信息</title>
</head>

<body>


</body>
<script>
    $(document).ready(function () {
        var winheight = $(window).height()*2/5;
        $(".eform-tab").css("height",winheight);
        var dataGridColModel = [
            {label: 'id', name: 'id', key: true, width: 75, hidden: true}
            , {label: '序号', name: 'attribute01', width: 150}
            , {label: '资产编号', name: 'assetId', width: 150, formatter: formatValue}
            , {label: '统一编号', name: 'unifiedId', width: 150, formatter: formatValue}
            , {label: '设备类别', name: 'deviceCategory', width: 150}
            , {label: '设备名称', name: 'deviceName', width: 150, formatter: formatValue}
            , {label: '设备型号', name: 'deviceModel', width: 150}
            , {label: '设备规格', name: 'deviceSpec', width: 150}
            , {label: '责任人', name: 'ownerIdAlias', width: 150}
            , {label: '责任人部门', name: 'ownerDeptAlias', width: 150}
            , {label: '使用人', name: 'userIdAlias', width: 150}
            , {label: '使用人部门', name: 'userDeptAlias', width: 150}
            , {label: '生产厂家', name: 'manufacturerId', width: 150}
            , {label: '立卡日期', name: 'createdDate', width: 150, formatter: format}
            , {label: '是否统管设备', name: 'isManage', width: 150}
            , {label: '是否在流程中', name: 'isInWorkflow', width: 150}
            , {label: '统管设备状态', name: 'manageState', width: 150}
            , {label: '设备状态', name: 'deviceState', width: 150}
            // , {label: '父级设备ID', name: 'parentId', width: 150}
            // , {label: '父级设备名称', name: 'parentName', width: 150}
            // , {label: '常用名', name: 'commonName', width: 150}
            // , {label: '安装地点ID', name: 'positionId', width: 150}
            // , {label: 'ABC分类', name: 'abcCategory', width: 150}
            // , {label: '是否军工关键设备设施', name: 'isKeyDevice', width: 150}
            // , {label: '是否科研生产设备', name: 'isResearch', width: 150}
            // , {label: '生产国家和地区', name: 'productCountry', width: 150}
            // , {label: '制造厂', name: 'productFactory', width: 150}
            // , {label: '供应商', name: 'supplier', width: 150}
            // , {label: '出厂日期', name: 'productDate', width: 150, formatter: format}
            // , {label: '出厂编号', name: 'productNum', width: 150}
            // , {label: '功率(单位：千瓦)', name: 'devicePower', width: 150}
            // , {label: '重量(单位：公斤)', name: 'deviceWeight', width: 150}
            // , {label: '外形尺寸', name: 'deviceSize', width: 150}
            // , {label: '验收时间', name: 'checkDate', width: 150, formatter: format}
            // , {label: '技改项目', name: 'improveProject', width: 150}
            // , {label: '单价(单位：元)', name: 'unitPrice', width: 150}
            // , {label: '合同号', name: 'contractNum', width: 150}
            // , {label: '申购单号', name: 'applyNum', width: 150}
            // , {label: '验收单号', name: 'checkNum', width: 150}
            // , {label: '车架号', name: 'carFrameNum', width: 150}
            // , {label: '发动机号', name: 'engineNum', width: 150}
            // , {label: '车牌号', name: 'carNum', width: 150}
            // , {label: '密级', name: 'secretLevel', width: 150}
            // , {label: '是否计量', name: 'isMetering', width: 150}
            // , {label: '是否保养', name: 'isMaintain', width: 150}
            // , {label: '是否精度检查', name: 'isAccuracyCheck', width: 150}
            // , {label: '是否定检', name: 'isRegularCheck', width: 150}
            // , {label: '是否点检', name: 'isSpotCheck', width: 150}
            // , {label: '是否特种设备', name: 'isSpecialDevice', width: 150}
            // , {label: '是否涉及安全生产', name: 'isSafetyProduction', width: 150}
            // , {label: '是否安装', name: 'isNeedInstall', width: 150}
            // , {label: '是否计算机', name: 'isPc', width: 150}
            // , {label: '设备类型', name: 'deviceType', width: 150}
            // , {label: '设备启用年月', name: 'enableDate', width: 150, formatter: format}
            // , {label: '运行时间', name: 'runningTime', width: 150}
            // , {label: 'IP地址', name: 'ip', width: 150}
            // , {label: 'MAC地址', name: 'mac', width: 150}
            // , {label: '硬盘序列号', name: 'diskNum', width: 150}
            // , {label: '操作系统', name: 'os', width: 150}
            // , {label: '操作系统安装时间', name: 'osInstallDate', width: 150, formatter: format}
            // , {label: '计量标识', name: 'meteringId', width: 150}
            // , {label: '计量人员', name: 'metermanAlias', width: 150}
            // , {label: '计量时间', name: 'meteringDate', width: 150, formatter: format}
            // , {label: '计量周期', name: 'meteringCycle', width: 150}
            // , {label: '上次计量日期', name: 'lastMeteringDate', width: 150, formatter: format}
            // , {label: '下次计量日期', name: 'nextMeteringDate', width: 150, formatter: format}
            // , {label: '计量计划员', name: 'planMetermanAlias', width: 150}
            // , {label: '计量单位', name: 'meteringDeptAlias', width: 150}
            // , {label: '是否现场计量', name: 'isSceneMetering', width: 150}
            // , {label: '上次保养日期', name: 'lastMaintainDate', width: 150, formatter: format}
            // , {label: '上次精度检查日期', name: 'lastAccuracyCheckDate', width: 150, formatter: format}
            // , {label: '计量结论', name: 'meteringConclution', width: 150}
            // , {label: '累计借用天数', name: 'totalBorrow', width: 150}
            // , {label: '安全信息', name: 'safeInfo', width: 150}
            // , {label: '设备使用费', name: 'useCost', width: 150}
            // , {label: '维修部门', name: 'repairDeptAlias', width: 150}
            // , {label: '状态变动日期', name: 'stateChangeDate', width: 150, formatter: format}
            // , {label: '设备系统名称', name: 'deviceSysName', width: 150}
            // , {label: '设备关联人员', name: 'deviceRelatedManAlias', width: 150}
            // , {label: '是否实验室设备', name: 'isLabDevice', width: 150}
            // , {label: '是否固定资产', name: 'isFixedAssets', width: 150}
            // , {label: '资产财务类别', name: 'assetsFinanceType', width: 150}
            // , {label: '资产来源', name: 'assetsSource', width: 150}
            // , {label: '资产财务状态', name: 'assetsFinanceState', width: 150}
            // , {label: '财务入账时间', name: 'financeEntryDate', width: 150, formatter: format}
            // , {label: '原值', name: 'originalValue', width: 150}
            // , {label: '累计折旧', name: 'totalDepreciation', width: 150}
            // , {label: '折旧方法', name: 'depreciationMethod', width: 150}
            // , {label: '折旧年限', name: 'depreciationYear', width: 150}
            // , {label: '净残值率', name: 'netSalvageRate', width: 150}
            // , {label: '净残值', name: 'netSalvage', width: 150}
            // , {label: '月折旧率', name: 'monthDepreciationRate', width: 150}
            // , {label: '月折旧额', name: 'monthDepreciation', width: 150}
            // , {label: '年折旧率', name: 'yearDepreciationRate', width: 150}
            // , {label: '年折旧额', name: 'yearDepreciation', width: 150}
            // , {label: '净值', name: 'netValue', width: 150}
            // , {label: '已提月份', name: 'monthCount', width: 150}
            // , {label: '未计提月份', name: 'monthRemain', width: 150}
            // , {label: '研究所/公司', name: 'instituteOrCompany', width: 150}
            // , {label: '凭证编号', name: 'proofNum', width: 150}
            // , {label: '指标信息', name: 'indexInfo', width: 150}
            // , {label: '是否转固', name: 'isTransFixed', width: 150}
            // , {label: '计量外送员', name: 'meteringOuterAlias', width: 150}
            // , {label: '适用机型', name: 'applyModel', width: 150}
            // , {label: '适用产品', name: 'applyProduct', width: 150}
            // , {label: '受测对象', name: 'testedObject', width: 150}
            // , {label: '专业类别', name: 'majorType', width: 150}
            // , {label: '设备性质', name: 'deviceNature', width: 150}
            // , {label: '软件标识号', name: 'softwareNum', width: 150}
            // , {label: '软件设计人员', name: 'softwareDesignerAlias', width: 150}
            // , {label: '硬件设计人员', name: 'hardwareDesignerAlias', width: 150}
            // , {label: '是否测试设备', name: 'isTestDevice', width: 150}
            // , {label: '是否需要操作证', name: 'isNeedCertificate', width: 150}
        ];
        var searchNames = new Array();
        var searchTips = new Array();
        searchNames.push("assetId");
        searchTips.push("资产编号");
        searchNames.push("unifiedId");
        searchTips.push("统一编号");
        var searchC = searchTips.length == 2 ? '或' + searchTips[1] : "";
        $('#assetsDeviceAccount_keyWord').attr('placeholder', '请输入' + searchTips[0] + searchC);
        assetsDeviceAccount = new AssetsDeviceAccount('assetsDeviceAccountjqGrid', '${url}', 'searchDialog', 'form', 'assetsDeviceAccount_keyWord', searchNames, dataGridColModel);
        //添加按钮绑定事件
        $('#assetsDeviceAccount_insert').bind('click', function () {
            assetsDeviceAccount.insert();
        });
        //编辑按钮绑定事件
        $('#assetsDeviceAccount_modify').bind('click', function () {
            assetsDeviceAccount.modify();
        });
        //删除按钮绑定事件
        $('#assetsDeviceAccount_del').bind('click', function () {
            assetsDeviceAccount.del();
        });
        //查询按钮绑定事件
        $('#assetsDeviceAccount_searchPart').bind('click', function () {
            assetsDeviceAccount.searchByKeyWord();
        });
        //打开高级查询框
        $('#assetsDeviceAccount_searchAll').bind('click', function () {
            assetsDeviceAccount.openSearchForm(this);
        });
        $('#ownerIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'ownerId', textFiled: 'ownerIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#ownerDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'ownerDept', textFiled: 'ownerDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userIdAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'userId', textFiled: 'userIdAlias'});
            this.blur();
            nullInput(e);
        });
        $('#userDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'userDept', textFiled: 'userDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#metermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meterman', textFiled: 'metermanAlias'});
            this.blur();
            nullInput(e);
        });
        $('#planMetermanAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'planMeterman', textFiled: 'planMetermanAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meteringDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'meteringDept', textFiled: 'meteringDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#repairDeptAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'deptSelect', idFiled: 'repairDept', textFiled: 'repairDeptAlias'});
            this.blur();
            nullInput(e);
        });
        $('#deviceRelatedManAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'deviceRelatedMan', textFiled: 'deviceRelatedManAlias'});
            this.blur();
            nullInput(e);
        });
        $('#meteringOuterAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'meteringOuter', textFiled: 'meteringOuterAlias'});
            this.blur();
            nullInput(e);
        });
        $('#softwareDesignerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'softwareDesigner', textFiled: 'softwareDesignerAlias'});
            this.blur();
            nullInput(e);
        });
        $('#hardwareDesignerAlias').on('focus', function (e) {
            new H5CommonSelect({type: 'userSelect', idFiled: 'hardwareDesigner', textFiled: 'hardwareDesignerAlias'});
            this.blur();
            nullInput(e);
        });
        //设备附表操作
        //添加按钮绑定事件
        $('#DYN_SUB_insertBtn').bind('click', function () {
            assetsDeviceAccount.insertSUB();
        });

    });
</script>
</html>
