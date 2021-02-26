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
//添加链接
Connect.prototype.addData = function (){
	var _this = this;
    var TypeId = _this.judgeNodeType();
    if (parseInt(connectTypeTree.selectedNodeId)<8||connectTypeTree.selectedNodeId=="8") {
        layer.msg('请选择分类！', {icon: 7});
    }else if(TypeId=="8"){
    	soapwebservice.insert();
    }else if(TypeId=="1"){
    	dataBase.addData();
    }else if(TypeId=="7"){
    	restful.insert();
    }else if(TypeId=="6"){
    	servlet.insert();
    }
};

//编辑
Connect.prototype.editData = function () {
    var _this = this;
    var TypeId = _this.judgeNodeType();
    if(TypeId == "1"){
    	dataBase.editData();
    }else if(TypeId == "8"){
    	soapwebservice.modify();
    }else if(TypeId == "7"){
    	restful.modify();
    }else if(TypeId == "6"){
    	servlet.modify();
    }
};

//删除
Connect.prototype.deleteData = function () {
    var _this = this;
    var TypeId = _this.judgeNodeType();
    if(TypeId == "1"){
    	dataBase.deleteData();
    }else if(TypeId == "8"){
    	soapwebservice.del(connectTypeTree.selectedNodeId);
    }else if(TypeId == "7"){
    	restful.del(connectTypeTree.selectedNodeId);
    }else if(TypeId == "6"){
    	servlet.del(connectTypeTree.selectedNodeId);
    }
};