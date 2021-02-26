<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>编辑</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
    <jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
     <script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
    <div data-options="region:'center',split:true,border:false">
        <form id='form'>
            <input type="hidden" name="id" value='${portlet.id}'/>
            <table class="form_commonTable">
                <tr>
					<th width="10%"><span class="remind">*</span>名称:</th>
                    <td width="40%">
                        <input title="名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" type="text" name="name" id="name" value='<c:out value='${portlet.name}'/>'/>
                    </td>
                    <th width="10%"><span class="remind">*</span>创建者:</th>
                    <td>
                    	<input type="hidden" name="userid" id="userid" value='${portlet.userid}'/>
                        <input title="创建者" class="easyui-validatebox" readonly="readonly" type="text" name="userName" id="userName" value='${portlet.userName}'/>
                    </td>
                </tr>
                <tr>
                    <th>应用角色:</th>
                    <td>
                        <input class="inputbox" type="hidden" name="roleId" id="roleId" value='${portlet.roleId}'/>
                        <div><input class="easyui-validatebox" name="layoutExtends" id="layoutExtends" readOnly="readOnly" value='${portlet.layoutExtends}'></input>
                        </div>
                    </td>
                    <th>首页类型:</th>
                    <td>
                        <pt6:syslookup name="indexType" isNull="false" lookupCode="PLATFORM_INDEX_TYPE" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" defaultValue='${portlet.indexType}'></pt6:syslookup>
                    </td>
                </tr>
                <tr>
                    <th>优先级:</th>
                    <td>
                        <input title="优先级" class="easyui-numberbox" data-options="validType:'maxLength[8]'"  type="text" name="orderBy" id="orderBy" value='${portlet.orderBy}'/>
                    </td>
                    <th>布局:</th>
                    <td>
                        <input title="布局" class="easyui-validatebox" type="text" name="layout" id="layout" readOnly="readOnly" value='${portlet.layout}'/>
                    </td>
                </tr>
                <tr>
                	<th>门户菜单:</th>
	                <td>
	                	<pt6:syslookup name="isUse" isNull="false" lookupCode="PLATFORM_SYS_TEMPLATE_STATE" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" defaultValue='${portlet.isUse}'></pt6:syslookup>
	                </td>
                </tr>
                <tr>
                    <th>首页地址:</th>
                    <td colspan="3">
                    	<div id="i_u" style="display: none;">
                        	<input title="首页地址" class="easyui-validatebox" type="text" name="indexUrl1" id="indexUrl1" value='${url1}'/>
                    	</div>
                    	<div id="i_s" style="display: none;">
                    		<pt6:syslookup name="indexUrl2" isNull="false" lookupCode="PLATFORM_MENU_STYLE" dataOptions="editable:false,panelHeight:'auto',onShowPanel:comboboxOnShowPanel" defaultValue='${url2}'></pt6:syslookup>
                    	</div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div data-options="region:'south',border:false" style="height:40px;">
    <div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend foot-formopera">
            <table class="tableForm" border="0" cellspacing="1" width='100%'>
                <tr>
                    <td align="right">
                        <a title="保存" id="saveButton" class="easyui-linkbutton primary-btn" onclick="saveForm();" href="javascript:void(0);">保存</a>
                        <a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        $.extend($.fn.validatebox.defaults.rules, {
            maxLength: {
                validator: function(value, param) {
                    return param[0] >= value.length;

                },
                message: '请输入最多 {0} 字符.'
            }
        });
        $(function() {
            var roles = new CommonSelector("role", "roleSelectCommonDialog", "roleId", "layoutExtends",null,null,null,false),comb;
            roles.init(null,null,1);
            comb =$('#indexType').combobox({    
            	onSelect:function(rec){
            		if(rec.value ==='1'){
            			$("#i_s").css("display","none");
            			$("#i_u").css("display","block");
            		}else{
            			$("#i_u").css("display","none");
            			$("#i_s").css("display","block");
            		}
            	}
            }); 
            if('${portlet.indexType}'==='1'){
    			$("#i_s").css("display","none");
    			$("#i_u").css("display","block");
            }else{
            	$("#i_u").css("display","none");
    			$("#i_s").css("display","block");
            }
        });

        function closeForm() {
            parent.closeDialog("#edit");
        }

        function saveForm() {
        	if(!$('#name').val()){
        		alert('请完善名称信息！');
        		return ;
        	}
        	var o =serializeObject($('#form')),url;
        	if(o.indexType ==='0'){
        		url =o.indexUrl2;
        	}else{
        		url=o.indexUrl1;
        	}
        	delete o.indexUrl1;
        	delete o.indexUrl2;
        	o.indexUrl=url;
        	if(!o.layoutExtends){
        		o.layoutExtends='请选择角色';
        	}
            parent.save(o, "#edit",2); 
        }
        
        window.onresize = comboboxHidePanel;
       
    </script>
</body>             
</html>