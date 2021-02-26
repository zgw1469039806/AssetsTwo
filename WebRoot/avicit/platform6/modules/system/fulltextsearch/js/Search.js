/**
 * Created by rx on 2017/10/25.
 */
function Search() {
    this.init.call(this);
}
//初始化操作
Search.prototype.init = function () {
};

//添加链接
Search.prototype.addData = function (){
	//判断是否末级节点
	$.ajax({
		url : 'platform/fulltextSearch/fulltextSearchController/operation/judgeNodeType',
		data : {id:searchTypeTree.selectedNodeId},
		contentType : 'application/json',
		async: false,
		type : 'get',
		dataType : 'json',
		success : function(r) {
			if (r.flag== "notParentNode") {
				searchInfo.insert();
			} else {
				layer.alert('请选择末级分类节点添加数据！', {
					icon : 7,
					area : [ '400px', '' ],
					closeBtn : 0
				});
			}
		}
	});
	
};

//编辑
Search.prototype.editData = function () {
    searchInfo.modify();
};

//删除
Search.prototype.deleteData = function () {
    searchInfo.del(searchTypeTree.selectedNodeId);
};
//重建索引
Search.prototype.buildIndex = function () {
    searchInfo.buildIndex();
};