//导入页面，与h5-common-before.js同名函数保持一致，EasyUI版导入使用此文件
function excelImport(templateCode,moreData, afertClose){
    //获取接口
    var userExtdata = JSON.stringify(moreData);
    self.userExtdata = userExtdata;
    //打开导入页面
    this.impIndex = layer.open({
        type: 2,
        area: ['500px', '200px'],
        title: '导入',
        skin: 'bs-modal', // bootstrap 风格皮肤 需加载skin
        maxmin: false, //开启最大化最小化按钮
        content: "avicit/platform6/console/imp/common/commonImport.jsp?templateCode="+templateCode,
        end:function(){
            if(typeof(afertClose) == 'function'){
                afertClose();
            }
        }
    });
}