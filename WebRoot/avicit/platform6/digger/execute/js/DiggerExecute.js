function dataExportEvent(){
	layer.open({
		type: 1,
		title: '导出',
		closeBtn: 0,
		skin: 'bs-modal',
		area: ['30%', '25%'],
		content: $("#exportDataDialog"),
		btn: ['导出', '取消'],
		yes: function(){
			//处理逻辑
			var picBase64Info;
			try{
				picBase64Info = myChart.getDataURL();//获取echarts图的base64编码，为png格式
			}catch (e) {}
			var exportType = $('input[name="exportType"]:checked').val();
			var chartExportUrl = 'platform/digger/diggerExecuteController/export';
			$('#chartForm').find('input[name="base64Info"]').val(picBase64Info);//将编码赋值给输入框
			$('#chartForm').find('input[name="exportTypeValue"]').val(exportType);//将导出类型值赋值给输入框
			$('#chartForm').attr('action',chartExportUrl).attr('method', 'post');//设置提交到的url地址
			$('#chartForm').submit();
			layer.closeAll();
		}
		,btn2: function(){
			layer.closeAll();
		}
	});
}
function refresh(){
    execute();
}

function isEmpty(obj){
    if(typeof obj == "undefined" || obj == "null" || obj == ""||obj==null){
        return true;
    }else{
        return false;
    }
}

//报表行为的方法
//0窗口
function openIframe(targetType,data,behaviourtargetName,rowID) {
    var title =behaviourtargetName;
    var contentUrl;
    if(targetType==0){
        //表单
        contentUrl="platform/eform/bpmsCRUDClient/toDetail?formInfoId="+data+"&id="+rowID;
    }
    if(targetType==1){
        //报表
        contentUrl="";

    }
    if(targetType==2){
        //视图
        contentUrl="platform/eform/bpmsCRUDClient/toViewJsp/"+data;

    }

    var index = parent.layer.open({
        type: 2,
        title: title,
        closeBtn : 0,
        skin: 'bs-modal',
        area: ['55%', '55%'],
        maxmin: false,
        content: contentUrl,
        btn: ['确定', '取消'],
        yes: function(index,layero){
            parent.layer.close(index);
        },
        btn2: function(index,layero){
            parent.layer.close(index);
        },
        success: function(layero, index) {
            //弹窗之前赋值
        }
    });
};
//1浏览器窗口
function openInternet(targetType,fromorviewId,behaviourtargetName,rowID) {
    //浏览器
    var title =behaviourtargetName;
    var contentUrl;
    if(targetType==0){
        //表单
        contentUrl="platform/eform/bpmsCRUDClient/toDetail?formInfoId="+fromorviewId+"&id="+rowID;
    }
    if(targetType==1){
        //报表
        contentUrl="";

    }
    if(targetType==2){
        //视图
        contentUrl="platform/eform/bpmsCRUDClient/toViewJsp/"+fromorviewId;

    }

    window.open(contentUrl, "_blank");

};
//2框架tab
function openTab(targetType,fromorviewId,behaviourtargetName,rowID) {
    var title =behaviourtargetName;
    var contentUrl;
    if(targetType==0){
        //表单
        contentUrl="platform/eform/bpmsCRUDClient/toDetail?formInfoId="+fromorviewId+"&id="+rowID;
    }
    if(targetType==1){
        //报表
        contentUrl="";

    }
    if(targetType==2){
        //视图
        contentUrl="platform/eform/bpmsCRUDClient/toViewJsp/"+fromorviewId;

    }
    parent.addTab(behaviourtargetName,contentUrl);

};
