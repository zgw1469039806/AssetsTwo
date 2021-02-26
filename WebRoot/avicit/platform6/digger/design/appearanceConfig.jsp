<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>外观配置</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='editForm'>
<%--        <input type="hidden" id="id" name="id" value="${diggerType.id}">--%>
<%--        <input type="hidden" id="parentId" name="parentId" value="">--%>

        <table class="form_commonTable" style="border:1px;">
            <tr>
                <th width="20%" style="word-break: break-all; word-warp: break-word;">
                    <label for="frontColor">前景色：</label>
                </th>
                <td colspan="2" width="80%">
                    <input title="前景色" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                           name="frontColor" id="frontColor" value=""/>
                </td>
            </tr>

            <tr>
            	<th width="20%" style="word-break: break-all; word-warp: break-word;">
                    <label for="bgColor">背景色：</label>
                </th>
                <td colspan="2" width="80%">
                     <input title="背景色" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                               name="bgColor" id="bgColor" value=""/>
                </td>
            </tr>
             <tr>
                <th width="20%" style="word-break: break-all; word-warp: break-word;">
                    <label for="columnWidth">列宽：</label>
                </th>
                <td  width="40%">
                     <input title="列宽" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                               name="columnWidth" id="columnWidth" value=""/>
                </td>
                <td  width="40%">
                     <select id="columnWidthUnit" name="columnWidthUnit" style="width:100%" class='form-control input-sm'>
                        <option value='px'>像素</option>
                        <option value='cm'>厘米</option>
                     </select>
                </td>
            </tr>
            <tr>
                <th width="20%" style="word-break: break-all; word-warp: break-word;">
                    <label for="fontSize">文字大小：</label>
                </th>
                <td colspan="2" width="80%">
                    <select id="fontSize" name="fontSize" style="width:100%" class='form-control input-sm'>
                        <option value='8px'>8px</option>
                        <option value='10px'>10px</option>
                        <option value='12px' selected>12px</option>
                        <option value='14px'>14px</option>
                        <option value='16px'>16px</option>
                        <option value='18px'>18px</option>
                        <option value='20px'>20px</option>
                     </select>
                </td>
            </tr>
            <tr>
                <th width="20%" style="word-break: break-all; word-warp: break-word;">
                    <label for="allowWrapDisplay">允许换行显示：</label>
                </th>
                <td colspan="2" width="80%">
                    <input type='radio' name='allowWrapDisplay' id="radio1" value='1'>是
                    <input type='radio' name='allowWrapDisplay' id="radio0" value='0' checked>否
                </td>
            </tr>
        </table>
    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>
<link rel="stylesheet" href="static/h5/colorpicker/css/colorpicker.css" type="text/css" />
<script type="text/javascript" src="static/h5/colorpicker/js/colorpicker.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");

    };
    $(function(){
        //绑定前景色拾色器
          $('#frontColor').ColorPicker({
              color: '#0000ff',
              onShow: function (colpkr) {
                  $(colpkr).fadeIn(500);
                  return false;
              },
              onHide: function (colpkr) {
                  $(colpkr).fadeOut(500);
                  return false;
              },
              onChange: function (hsb, hex, rgb) {
                  $('#frontColor').val('#' + hex);
              }
          });
          //绑定背景色拾色器
            $('#bgColor').ColorPicker({
                color: '#0000ff',
                onShow: function (colpkr) {
                    $(colpkr).fadeIn(500);
                    return false;
                },
                onHide: function (colpkr) {
                    $(colpkr).fadeOut(500);
                    return false;
                },
                onChange: function (hsb, hex, rgb) {
                    $('#bgColor').val('#' + hex);
                }
            });
    });

    //获取配置值
    function getFormConfig(){
        var config = {
            frontColor: $('#frontColor').val(),
            bgColor: $('#bgColor').val(),
            columnWidth: $('#columnWidth').val(),
            columnWidthUnit: $('#columnWidthUnit').val(),
            fontSize: $('#fontSize').val(),
            allowWrapDisplay: $('input[name="allowWrapDisplay"]:checked').val()
        };
        return config;
    }
    function setFormConfig(obj){
        $('#frontColor').val(obj["frontColor"]);
        $('#bgColor').val(obj["bgColor"]);
        $('#columnWidth').val(obj["columnWidth"]);
        $('#columnWidthUnit').val(obj["columnWidthUnit"]);
        $('#fontSize').val(obj["fontSize"]);
        if(obj["allowWrapDisplay"]=="0"){
            $("#radio0").attr("checked","checked")
        }
        if(obj["allowWrapDisplay"]=="1"){
            $("#radio1").attr("checked","checked")
        }

    }

</script>
</body>
</html>
