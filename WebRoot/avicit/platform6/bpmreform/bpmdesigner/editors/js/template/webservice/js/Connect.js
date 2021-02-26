/**
 * Created by rx on 2017/10/25.
 */
function Connect() {
    this.init.call(this);
}
//初始化操作
Connect.prototype.init = function () {
};

//判断当前分类类型
Connect.prototype.judgeNodeType = function (){
	var TypeId = "";
    $.ajax({
		url : 'platform/connectcenter/connectCenterController/operation/judgeNodeType',
		data : {id:connectTypeTree.selectedNodeId},
		contentType : 'application/json',
		async: false,
		type : 'get',
		dataType : 'json',
		success : function(r) {
			if (r!= "") {
				TypeId = r;
			} else {
				layer.alert('获取节点分类失败！' + r.error, {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0
				});
			}
		}
	});
    return TypeId;
}