

ViewEngine.prototype.setLayout = function(){
    alert(444);
    this.layout="";
};

ViewEngine.prototype.setTreeNode = function(){
    alert(321);
    data = [{
        id : viewId,
        pid: 0,
        type : "view",
        name : "页面视图",
        attribute:{id : viewId, name : "页面视图"}
    }];
    this.treeNodes = data;
};


ViewEngine.prototype.initButtonArea = function () {
    alert(123);
    $("#buttonArea").html("");
};