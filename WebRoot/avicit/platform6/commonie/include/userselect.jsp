<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
    String importlibs = "common,tree,form";
%>
<!DOCTYPE html>
<html>
<head>
<title>用户选择</title>
<base href="<%=ViewUtil.getRequestPath(request)%>"></base>
<jsp:include
	page="/avicit/platform6/commonie/include/easyui-include.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="static/h5/jquery-ztree/3.5.12/css/zTreeStyle/metro-ie6.css" />


<link rel="stylesheet" type="text/css"
	href="static/fixie/bsie/bootstrap/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="static/fixie/bsie/bootstrap/css/bootstrap-ie6.css">
<link rel="stylesheet" type="text/css"
	href="static/fixie/bsie/bootstrap/css/ie.css">

<style type="text/css">
.userinfo {
	width: 100%;
	margin: 0 auto;
	height: 20px;
	line-height: 20px;
	overflow: hidden
}

#platform-userselect-userview {
	padding: 0 5px;
}

.userviewkads {
	color: #454545;
	background: #FFF;
	height: auto;
	padding: 0 5px;
	display: inline-block;
	*display: inline;
	_zoom: 1;
	*zoom: 1;
	line-height: 30px;
	border-bottom: #b9b9b9;
}

.simplecard {
	display: block;
}

.userviewkads div {
	display: inline-block;
	*display: inline;
	_zoom: 1;
	*zoom: 1
}

.col-xs-6 {
	width: 50%;
}

.col-xs-5 {
	width: 41.66666667%;
}

.col-xs-1 {
	width: 8.33333333%;
}

.userviewkads .thumbnail, .userviewkads .thumbnail div {
	*display: inline;
}

.userviewkads:nth-child(even) {
	color: #454545;
	background: #f7f7f7;
	border-bottom: #f7f7f7;
}

.userviewkads .icon-remove {
	color: #b1b1b1;
}

.userviewkads .icon-remove:hover {
	color: #454545;
}

.panel .row {
	margin: 0;
}

.thumbnail {
	width: 111px;
	padding: 2px;
	margin-top: 10px;
	margin-bottom: 0;
	position: relative;
	border-color: #a1a1a1;
}

.thumbnail center {
	color: #444;
	padding: 2px;
	line-height: 20px;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}

.thumbnail .img {
	width: 105px;
	*width: 111px;
	height: 92px;
	background-color: #c2c2c2;
	background-size: cover;
	background-position: center;
}

.thumbnail .icon-remove {
	display: none;
	color: #fc0001;
	position: absolute;
	right: 2px;
	top: 2px;
}

.thumbnail:hover .icon-remove, .thumbnail.on .icon-remove {
	display: block;
}
</style>
</HEAD>
<BODY class=" easyui-layout" fit="true">
	<div data-options="region:'north'"
		style="height: 40px; margin-right: 5px; overflow-y: hidden;">
		<div id="tools" class="datagrid-toolbar">
			<table width="99%">
				<tr>
					<td>
						<div class="ext-toolbar-left" style="width: 50%">
							<ul class="nav nav-pills" style="display: inline-block;">
								<li id="dept" role="presentation" class="active"><a
									href="javascript:void(0)" onclick="TabActiveClick('dept');">部门</a></li>
								<li id="group" role="presentation"><a
									href="javascript:void(0)" onclick="TabActiveClick('group');">群组</a></li>
								<li id="role" role="presentation"><a
									href="javascript:void(0)" onclick="TabActiveClick('role');">角色</a></li>
								<li id="position" role="presentation"><a
									href="javascript:void(0)" onclick="TabActiveClick('position');">岗位</a></li>
							</ul>
						</div>
						<div class="ext-toolbar-right" style="width: 50%">
							<table
								style="width: 220px; margin-top: 2px; position: absolute; right: 0;">
								<tr>
									<td style="width: 35px; display: inline-block">
										<button type="button" onclick="removeAllUser();"
											aria-label="清空" class="btn btn-default"
											style="padding: 3px 5px">
											<span class="icon icon-trash"></span>
										</button>
									</td>
									<td class="isShowVoid"
										style="text-align: right; display: inline-block"><input
										id="viewSystemUser" class="toolbox input-checkbox"
										type="checkbox"></td>
									<td class="isShowVoid"
										style="width: 85px; display: inline-block">&nbsp;显示无效用户</td>
									<td style="text-align: right; display: inline-block"><input
										id="viewType" class="toolbox input-checkbox" type="checkbox"
										checked="checked"></td>
									<td style="display: inline-block">&nbsp;平铺</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div data-options="region:'west',split:false,collapsible:false"
		style="width: 250px; overflow: hidden;">
		<div style="height: 100%; width: 100%;">
			<table style="width: 240px;">
				<tr>
					<td width="160px">
					<input class="form-control" placeholder="输入用户名称查询" type="text"
						id="search_text" name="search_text" style="width: 110px"
						onkeyup="onSeach(event.keyCode, this.value)"> <span
						class="input-group-btn">
						<button class="btn btn-default ztree-search"
							style="padding: 3px 5px" type="button"
							onclick="onSeach(13, $('#search_text').val())">
							<span class="icon icon-search"></span>
						</button>
					</span>
			    </td>
			    <td width="60px" align="right" nowrap>
					级联<br>选择
				</td>
				<td width="20px">
					<input id="isCheck" style="width:18px" class="toolbox" type="checkbox" checked="checked">
				</td>
			</tr>
		</table>
			<div style="height: 100%; width: 100%;">
				<ul id="selectUserTree" class="ztree"
					style='overflow: scroll; height: 82%; width: 95%;'></ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center',title:'已选择用户(0)'">
		<div id="platform-userselect-userview" class="row" style="width: 99%;">
		</div>
	</div>
</BODY>
<script type="text/javascript"
	src="static/h5/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.js"></script>
<script type="text/javascript">
    var h5KadsView = null;
    var currentTab = "dept";
    var setting = null;
    var firstAsyncSuccessFlag2 = 0;
    var isShowChebox = false;
    var defaultLoadDeptId = "";
    var fileSecretLevel =  "";
    var viewScope = "";
    var defaultOrgId = "";
    var isShowVoid = false;
    var secretLevel = "";
	var isload = 0;
    function init(o){
        if(o.hidTab){
            for(var i = 0; i < o.hidTab.length; i++){
                $("#" + o.hidTab[i]).hide();
            }
        }
        isShowVoid = o.isShowVoid;

        if(isShowVoid){
            $(".isShowVoid").hide();
        }
        var selectModel = o.selectModel;
        var useridArrays = ((o.userids == null || o.userids == '')?[]:o.userids.split(";"));
        var userDeptidsArrays = ((o.userdeptids == null || o.userdeptids == '')?[]:o.userdeptids.split(";"));
        defaultLoadDeptId = o.defaultLoadDeptId;
        fileSecretLevel =  o.fileSecretLevel;
        viewScope = o.viewScope;
        secretLevel = o.secretLevel;
        defaultOrgId = o.defaultOrgId;

        var viewType = "H5KadsView";
        var viewSystemUser = false;

        if(selectModel == 'multi'){
            isShowChebox = true;
        }

        setting = {
            view: {
                selectedMulti: false
            },
            check: {
                autoCheckTrigger:true,
    			chkboxType: {"Y":"ps", "N":"ps"},
                enable: isShowChebox
            },
            data: {
                key: {
                    id: "id",
                    name: "text",
                    children: "children"
                },
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "parentId",
                    rootPId: -1
                }
            },
            async: {
                enable: true,
                url:"h5/view/common/select/SelectController/getUserSelectList",
                autoParam:["id","nodeType","orgId"],
                otherParam: {
                    "currentTab": function(){ return currentTab; },
                    "viewSystemUser": function(){ return viewSystemUser; },
                    "defaultLoadDeptId":  defaultLoadDeptId,
                    "fileSecretLevel": fileSecretLevel,
                    "viewScope" : viewScope,
                    "secretLevel" : secretLevel,
                    "defaultOrgId" : defaultOrgId
                },
                dataFilter: function(treeId, parentNode, childNodes){
                    if (!childNodes)
                        return null;
                    var childNodes = eval(childNodes);
                    //start
                    var userlist = getUserList();
                    if(userlist.userids!=""){
                        useridArrays = userlist.userids.split(';');
                        userDeptidsArrays = userlist.userdeptids.split(';');
                    }
                    //end
                    for(var i = 0; i < childNodes.length; i++){
                        for(var j = 0; j < useridArrays.length; j++){
                            if(childNodes[i].id == useridArrays[j] && ((userDeptidsArrays.length > 0 && childNodes[i].attributes.deptid == userDeptidsArrays[j]) || userDeptidsArrays.length <= 0 )){
                                childNodes[i].checked = true;
                                if(h5KadsView != null){
                                    if(childNodes[i].nodeType == "user"){
                                        h5KadsView.add(childNodes[i].id, [childNodes[i].id, childNodes[i].text, childNodes[i].attributes.deptid, childNodes[i].attributes.deptname,childNodes[i].orgIdentity], false);
                                    }
                                    break;
                                }
                            }else{
                                if(parentNode !=null && parentNode.checked == true){
                                    childNodes[i].checked = true;
                                    if(h5KadsView != null){
                                        if(childNodes[i].nodeType == "user"){
                                            h5KadsView.add(childNodes[i].id, [childNodes[i].id, childNodes[i].text, childNodes[i].attributes.deptid, childNodes[i].attributes.deptname,childNodes[i].orgIdentity], false);
                                        }
                                        break;
                                    }
                                }
                            }
                        }
                    }
                    $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                    return childNodes;
                }
            },
            callback: {
                onAsyncError:  function(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown){layer.alert(XMLHttpRequest);},
    			beforeAsync: function(){
    				if(isload == 0){
    					leyerindex = layer.load(1, {
    						  shade: [0.3,'#000'] //0.1透明度的白色背景
    					});
    				}
    				isload++;
    				return true;
    			},
                onAsyncSuccess:  function(event, treeId, treeNode, msg){
                    var tree = $.fn.zTree.getZTreeObj(treeId);
                    var nodes = tree.getNodes();
                    if (firstAsyncSuccessFlag2 == 0 && currentTab != 'group' && currentTab != 'role' && currentTab != 'position') {
                        tree.expandNode(nodes[0], true);
                        firstAsyncSuccessFlag2 = 1;
                    }
                    if(typeof(treeNode)!="undefined" && typeof(treeNode.checked)!="undefined"&& treeNode.checked == true){
                        tree.checkNode(treeNode, true, true, true);
                    }
    				isload--;
    				if(isload == 0){
    					layer.close(leyerindex);
    				}
                },
                onClick: function (event, treeId, treeNode){
                    if(treeNode.nodeType == "user"){
                        h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text, treeNode.attributes.deptid, treeNode.attributes.deptname,treeNode.orgIdentity]);
                        if(isShowChebox){
                            treeNode.checked = true;
                            $.fn.zTree.getZTreeObj(treeId).updateNode(treeNode);
                        }
                    }
                    $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                },
                onCheck: function (event, treeId, treeNode) {
                    if(treeNode.nodeType == "user" ){
                        if(treeNode.checked){
                            h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text, treeNode.attributes.deptid, treeNode.attributes.deptname,treeNode.orgIdentity]);
                        }else{
                            if(h5KadsView.getDataList().length > 0){
                                h5KadsView.remove(treeNode.id);
                            }
                        }
                    }else{
                        if(treeNode.isParent == true && treeNode.children.length == 0){
                            var tree = $.fn.zTree.getZTreeObj(treeId);
                            tree.expandNode(treeNode, true);
                        }
                    }
                    $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                }
            }
        };

        firstAsyncSuccessFlag2 = 0;
        $.fn.zTree.init($("#selectUserTree"),setting, []);
        h5KadsView = new H5KadsView({
            id:'#platform-userselect-userview',
            selectModel: selectModel,
            beferRemove: function(id){
                try{
                    var tree = $.fn.zTree.getZTreeObj("selectUserTree");
                    if(id != "all"){
                        var node = tree.getNodesByParam("id", id , null);
                        node[0].checked = false;
                        tree.updateNode(node[0]);
                        $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                    }}catch(e){}
            },
            afertRemove: function(){
                var tree = $.fn.zTree.getZTreeObj("selectUserTree");
                if(h5KadsView.getDataList().length == 0){
        			var nodes = tree.getCheckedNodes(true);
        			for (var i=0, l=nodes.length; i < l; i++) {
        				tree.checkNode(nodes[i], false, false);
        			}
        			$(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                }
            },
            template : function(){
                if(viewType == "H5KadsView"){
                    return '<div class="col-xs-3 userviewkads"  data=\'{\"id\":\"#0#\", \"name\": \"#1#\",\"deptid\":\"#2#\",\"deptname\":\"#3#\",\"orgIdentity\":\"#4#\"}\'  id=\"kads_#0#\">  <div class="thumbnail" style="font-size:12px">	'+
                        ' <span class="icon icon-remove" aria-hidden="true"  style="cursor:pointer;z-index:100" onclick="h5KadsView.remove(\'#0#\');"></span>'+
                        '  <div class="img" style="position:relative"><img src="<%=ViewUtil.getRequestPath(request)%>/h5/view/common/select/SelectController/getUserPhoto?userid=#0#" style="position:absolute;top:0;left:0;width:100%;height:100%;"></div> <center class="userinfo">#3#</center><center  class="userinfo">#1#</center></div>' +
                        ' </div>';
                }else{
                    return '<div class="col-xs-12 alert-info userviewkads simplecard" data=\'{\"id\":\"#0#\", \"name\": \"#1#\", \"deptid\":\"#2#\",\"deptname\":\"#3#\",\"orgIdentity\":\"#4#\"}\'  id=\"kads_#0#\">'+
                        '<div class="col-xs-6">#1#</div><div class="col-xs-5">#3#</div><div class="col-xs-1"><span class="icon icon-remove" aria-hidden="true"  style="cursor:pointer" onclick="h5KadsView.remove(\'#0#\');"></span><div>'+
                        '</div>';
                }
            }
        });
        $.ajax({
            url  : "h5/view/common/select/SelectController/getInitUserInfo",
            data : {"userids": JSON.stringify(useridArrays), "deptids": JSON.stringify(userDeptidsArrays)},
            type : 'post',
            dataType : 'json',
            success : function(r){
                for(var i = 0; i < r.length; i++){
                    h5KadsView.add(r[i].id, [r[i].id,r[i].name, r[i].deptid, r[i].deptname,r[i].orgIdentity]);
                }
                $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
            }
        });

        $('.toolbox').on('change', function() {
            if ($(this).is(':checked')) {
                $(this).attr("checked", true);
            } else {
                $(this).attr("checked", false);
            }

            if($(this).attr('id') == "viewType"){
                if($("#viewType").attr("checked") == "checked"){
                    viewType = "H5KadsView";
                }else{
                    viewType = "H5ListView";
                }

                var retArray = h5KadsView.getDataList();

                h5KadsView.removeAllNOEvent();
                for(var i = 0; i < retArray.length; i++){
                    h5KadsView.add(retArray[i].id, [retArray[i].id,retArray[i].name, retArray[i].deptid, retArray[i].deptname,retArray[i].orgIdentity]);
                }
	        	$(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
			}else if($(this).attr('id') == "viewSystemUser"){
                if($("#viewSystemUser").attr("checked") == "checked"){
                    viewSystemUser = true;
                }else{
                    viewSystemUser = false;
                }
                firstAsyncSuccessFlag2 = 0;
                $.fn.zTree.init($("#selectUserTree"),setting, []);
			}else{
				if($("#isCheck").attr("checked") == "checked"){
					 $.fn.zTree.getZTreeObj("selectUserTree").setting.check.chkboxType = {"Y":"ps", "N":"ps"};
				}else{
					 $.fn.zTree.getZTreeObj("selectUserTree").setting.check.chkboxType = {"Y":"", "N":""};
				}
            }
        });
    }
    function getUserList(){
        var userids = "";
        var usernames = "";
        var userdeptids = "";
        var userdeptnames = "";
        var orgIdentitys = "";

        var userlist = h5KadsView.getDataList();
        for(var i = 0;  i< userlist.length; i ++ ){
            userids = userids + userlist[i].id + ";";
            usernames = usernames + userlist[i].name + ";";
            userdeptids = userdeptids + userlist[i].deptid + ";";
            userdeptnames = userdeptnames + userlist[i].deptname + ";";
            orgIdentitys = orgIdentitys + userlist[i].orgIdentity+ ";";
        }

        userids = userids.substring(0, userids.length-1);
        usernames = usernames.substring(0, usernames.length-1);
        userdeptids = userdeptids.substring(0, userdeptids.length-1);
        userdeptnames = userdeptnames.substring(0, userdeptnames.length-1);

        return {userids: userids, usernames: usernames, userdeptids: userdeptids, userdeptnames: userdeptnames, orgIdentitys: orgIdentitys};
    }

    function onSeach(ecode, value){
        if(ecode == 13){
            var viewSystemUser = false;
            if($("#viewSystemUser").attr("checked") == "checked"){
                viewSystemUser = true;
            }else{
                viewSystemUser = false;
            }
            if(value==null||value==""||value=="输入用户名称查询"){
                firstAsyncSuccessFlag2 = 0;
                $.fn.zTree.init($("#selectUserTree"),setting, []);
                return;
            }
            $.ajax({
                cache: true,
                type: "post",
                url: "h5/view/common/select/SelectController/newSearchUser",
                dataType:"json",
                data:{
                    "currentTab": function(){ return currentTab; },
                    "search_text":value,
                    "selectedUser": JSON.stringify(h5KadsView.getDataList()),
                    "viewSystemUser":function(){ return viewSystemUser; },
                    "defaultLoadDeptId":  defaultLoadDeptId,
                    "fileSecretLevel": fileSecretLevel,
                    "secretLevel" : secretLevel,
                    "viewScope" : viewScope,
                    "defaultOrgId" : defaultOrgId
                },
                async: false,
                error: function(request) {
                    throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
                    $.fn.zTree.init($("#selectUserTree"), {
                        view: {
                            selectedMulti: false
                        },
                        check: {
                            autoCheckTrigger:true,
                			chkboxType: {"Y":"ps", "N":"ps"},
                            enable: isShowChebox
                        },
                        data: {
                            key: {
                                id: "id",
                                name: "text",
                                children: "children"
                            },
                            simpleData: {
                                enable: false,
                                idKey: "id",
                                pIdKey: "parentId",
                                rootPId: -1
                            }
                        },callback: {
                            onClick: function (event, treeId, treeNode){
                                if(treeNode.nodeType == "user"){
                                    h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text, treeNode.attributes.deptid, treeNode.attributes.deptname,treeNode.orgIdentity]);
                                    $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                                    if(isShowChebox){
                                        treeNode.checked = true;
                                        $.fn.zTree.getZTreeObj(treeId).updateNode(treeNode);
                                    }
                                }
                            },
                            onCheck: function (event, treeId, treeNode) {
                                if(treeNode.nodeType == "user" ){
                                    if(treeNode.checked){
                                        h5KadsView.add(treeNode.id, [treeNode.id,treeNode.text, treeNode.attributes.deptid, treeNode.attributes.deptname,treeNode.orgIdentity]);
                                    }else{
                                        if(h5KadsView.getDataList().length > 0){
                                            h5KadsView.remove(treeNode.id);
                                        }
                                    }
                                    $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
                                }
                            }
                        }

                    }, data);
                }
            });
        }
    }
    function removeAllUser (){
        h5KadsView.removeAll();
        $(".panel-title").text("已选择用户(" + h5KadsView.getKadsSize() + ")");
    }

    function TabActiveClick(Tabid){
        $("#" + currentTab).removeClass("active");
        $("#" + Tabid).addClass("active");
        currentTab = Tabid;
        firstAsyncSuccessFlag2 = 0;
        $.fn.zTree.init($("#selectUserTree"),setting, []);
        $("#search_text").val("");
        inputPlaceHolder();//切换tab,补上placeholder
        return false;
    }
</script>

</HTML>