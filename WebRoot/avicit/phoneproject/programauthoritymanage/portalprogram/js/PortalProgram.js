/**
 * 
 */
function PortalProgram(datagrid,url,searchD,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var _selectId='';
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	this.init.call(this);
};
//初始化操作
PortalProgram.prototype.init=function(){
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl()+"getPortalProgramsAuthorityByPage.json",
		onLoadSuccess:function(data){
			$(this).datagrid("selectRow",0);
		},
		onSelect:function(index,data){
			programId=data.id;
			loadRelationData(tabIndex);
		}
	});
};

/**
 * 查询应用数据
 * @param value 搜索框的值
 * @date 2017-3-2上午10:28:30
 * @author yupengfei
 */
PortalProgram.prototype.searchData =function(value){
	var jsonStr='{"programName":"'+value+'","programCode":"'+value+'"}';
	portalProgram._datagrid.datagrid('load',{ param : jsonStr});
};

//通用代码
PortalProgram.prototype.programState=[];
Platform6.fn.lookup.getLookupType('PROGRAM_STATE',function(r){r&&( PortalProgram.prototype.programState=r);});  

/**
 * 根据右侧当前tab页的索引加载关系数据
 * @param tabIndex tab页索引
 * @date 2017-3-2上午10:29:05
 * @author yupengfei
 */
function loadRelationData(tabIndex){
	if(tabIndex==0){
		loadDeptRelation(programId);
	}else if(tabIndex==1){
		loadUserRelation(programId);
	}else{
		loadRoleRelation(programId);
	}
}