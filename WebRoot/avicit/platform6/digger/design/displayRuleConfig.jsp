<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="avicit.platform6.commons.utils.ViewUtil" %>
<%
    String importlibs = "common,form";
%>
<!DOCTYPE html>
<HTML>

<head>
    <title>显示规则配置</title>
    <base href="<%=ViewUtil.getRequestPath(request)%>">
    <jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
        <jsp:param value="<%=importlibs%>" name="importlibs"/>
    </jsp:include>
</head>
<style type="text/css">
    .nav>li>a {
        position: relative;
        display: block;
        padding: 2px 2px;

    }
</style>

<body class="easyui-layout" fit="true">
<div data-options="region:'center',split:true,border:false">
    <form id='editForm'>
<%--        <input type="hidden" id="id" name="id" value="${diggerType.id}">--%>
<%--        <input type="hidden" id="parentId" name="parentId" value="${diggerType.parentId}">--%>
        <div style="margin:10px 20px">
        		<ul class="nav nav-tabs" role="tablist">
        			<li role="presentation" class="active"><a href="#diggerBaseInfo" aria-controls="diggerBaseInfo" role="tab" data-toggle="tab" style="font-size: 12px">数据映射</a></li>
        			<li role="presentation"><a href="#diggerDatasource" aria-controls="diggerDatasource" role="tab" data-toggle="tab" style="font-size: 12px">数据格式化</a></li>
        		</ul>
        		<div class="tab-content">
        			<%--数据映射 --%>
        			<div role="tabpanel" class="tab-pane active" id="diggerBaseInfo">
        				<div data-options="region:'center',split:true,border:false">
        					<form id='baseinfoForm' enctype="multipart/form-data" style="margin-top: 20px">
        					    <input type='hidden' name='id' id='id' value=''>
                                <table class="form_commonTable" style="border:1px;">
                                    <tr>
                                        <td  width="100%">
                                             <label><input type='radio' name='dataMappingType' id="radio0" value='0'>常量</input></label>
                                             <label><input type='radio' name='dataMappingType' id="radio1" value='1'>JSON</input></label>
                                             <label><input type='radio' name='dataMappingType' id="radio2" value='2'>组织</input></label>
                                             <label><input type='radio' name='dataMappingType' id="radio3" value='3'>通用代码</input></label>
                                            <label><input type='radio' name='dataMappingType' id="radio4" value='4'>SQL语句转义</input></label>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td  width="100%">
                                           <table class="form_commonTable" style="border:1px;" id="commonValue">
                                                <tr>
                                                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                        <label for="commonValueName">配置值：</label>
                                                    </th>
                                                    <td  width="80%">
                                                        <input title="配置值" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                                                                   name="commonValueName" id="commonValueName" value=""/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                        &nbsp;
                                                    </th>
                                                    <td  width="80%">
                                                       --提示：值1:显示值1|值2:显示值2|.......
                                                    </td>
                                                </tr>
                                           </table>
                                           <table class="form_commonTable" style="border:1px;display:none;" id="jsonValue">
                                               <tr>
                                                   <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                       <label for="jsonValueName">配置值：</label>
                                                   </th>
                                                   <td  width="80%">
                                                       <input title="配置值" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                                                                  name="jsonValueName" id="jsonValueName" value=""/>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                       &nbsp;
                                                   </th>
                                                   <td  width="80%">
                                                      提示：{
                                                                "值1":"显示值1",
                                                                "值2":"显示值2",
                                                                ..........
                                                            }
                                                   </td>
                                               </tr>
                                          </table>
                                          <table class="form_commonTable" style="border:1px;display:none;" id="orgValue">
                                             <tr>
                                                 <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                     <label for="orgValueName">配置值：</label>
                                                 </th>
                                                 <td  width="80%">
                                                     <select id="orgValueName" name="orgValueName" style="width:100%" class="form-control input-sm">
                                                         <option value='user'>用户</option>
                                                         <option value='dept'>部门</option>
                                                         <option value='org'>组织</option>
                                                         <option value='role'>角色</option>
                                                         <option value='group'>群组</option>
                                                         <option value='position'>岗位</option>
                                                      </select>
                                                 </td>
                                             </tr>
                                              <tr>
                                                  <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                      <label for="flagbyId">是否根据代码查询：</label>
                                                  </th>
                                                  <td  width="80%">
                                                      <input type='checkbox' id='flagbyId' name='flagbyId'>
                                                  </td>
                                              </tr>
                                             <tr>
                                                  <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                      <label for="orgValueSeparator">分隔符：</label>
                                                  </th>
                                                  <td  width="80%">
                                                      <select id="orgValueSeparator" name="orgValueSeparator" style="width:100%" class="form-control input-sm">
                                                          <option value='0'>逗号</option>
                                                          <option value='1'>分号</option>
                                                          <option value='2'>竖划线</option>
                                                       </select>
                                                  </td>
                                              </tr>
                                              <tr>
                                                <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                    <label for="valueNullNotDisplay">值为空不显示：</label>
                                                </th>
                                                <td  width="80%">
                                                    <input type='checkbox' id='valueNullNotDisplay' name='valueNullNotDisplay'>
                                                </td>
                                            </tr>
                                          </table>
                                          <table class="form_commonTable" style="border:1px;display:none;" id="commonCodeValue">
                                              <tr>
                                                  <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                      <label for="commonCodeValueName">配置值：</label>
                                                  </th>
                                                  <td  width="80%">
                                                      <input title="配置值" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                                                                 name="commonCodeValueName" id="commonCodeValueName" value=""/>
                                                  </td>
                                              </tr>
                                              <tr>
                                                  <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                      &nbsp;
                                                  </th>
                                                  <td  width="80%">
                                                     --提示：支持livesearch即时搜索，或点击搜索按钮，进行选择..
                                                  </td>
                                              </tr>
                                         </table>

                                            <table class="form_commonTable" style="border:1px;display:none;" id="sqlValue">
                                                <tr>
                                                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                        <label for="sqlValueName">配置值：</label>
                                                    </th>
                                                    <td  width="80%">
                                                        <input title="配置值" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                                               name="sqlValueName" id="sqlValueName" value=""/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                                        &nbsp;
                                                    </th>
                                                    <td  width="80%">
                                                        --提示：select NAME from Table t where t.id =?
                                                               (其中?表示当前列的单元格值)
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>

        					</form>
        				</div>

        			</div>
        			<%--数据映射 end--%>
        			<%--数据格式化--%>
        			<div role="tabpanel" class="tab-pane" id="diggerDatasource">
        				<div data-options="region:'center',split:true,border:false">
                            <form id='baseinfoForm' enctype="multipart/form-data" style="margin-top: 20px">
                                <input type='hidden' name='id' id='id' value=''>
                                <table class="form_commonTable" style="border:1px;">
                                    <tr>
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="formatType">格式化类型：</label>
                                        </th>
                                        <td  width="80%">
                                            <select id="formatType" name="formatType" style="width:100%" class="form-control input-sm" onchange="qqqq(this);">
                                                <option value='0' selected></option>
                                                <option value='1'>数值</option>
                                                <option value='2'>日期</option>
                                                <option value='3'>百分比</option>
                                                <option value='4'>货币</option>
                                            </select>
                                        </td>
                                    </tr>



                                    <tr id="TrnumType">
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="numType">保留有效位：</label>
                                        </th>
                                        <td  width="80%">
                                            <input title="数值格式" class="form-control input-sm" type="number" style="width: 99%;" type="text"
                                                   name="numType" id="numType"/>
                                        </td>
                                    </tr>

                                    <tr id="TrtimeType">
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="timeType">日期格式：</label>
                                        </th>
                                        <td  width="80%">
                                            <select id="timeType" name="timeType" style="width:100%" class="form-control input-sm">
                                                <option value='0' selected></option>
                                                <option value='1'>yyyy年MM月dd日 HH时mm分ss秒</option>
                                                <option value='2'>yyyy年MM月dd日</option>
                                                <option value='3'>yyyy/MM/dd HH:mm:ss</option>
                                                <option value='4'>yyyy/MM/dd</option>
                                                <option value='5'>yyyy-MM-dd HH:mm:ss</option>
                                                <option value='6'>yyyy-MM-dd</option>
                                                <option value='7'>MM-dd-yyyy</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr id="TrpercentageType">
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="percentageType">保留有效位：</label>
                                        </th>
                                        <td  width="80%">
                                            <input title="百分比格式" class="form-control input-sm" type="number" data-min="0" style="width: 99%;" type="text"
                                                   name="percentageType" id="percentageType" value=""/>
                                        </td>
                                    </tr>

                                    <tr id="TrmoneyType">
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="moneyType">千分位显示：</label>
                                        </th>
                                        <td  width="80%">
                                            <input type='checkbox' id='moneyType' name='moneyType'>
                                        </td>
                                    </tr>

                                    <tr>
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="prefix">前缀：</label>
                                        </th>
                                        <td  width="80%">
                                            <input title="前缀" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                                                                               name="prefix" id="prefix" value=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th width="20%" style="word-break: break-all; word-warp: break-word;">
                                            <label for="suffix">后缀：</label>
                                        </th>
                                        <td  width="80%">
                                            <input title="后缀" class="form-control input-sm" type="text" style="width: 99%;" type="text"
                                                                                               name="suffix" id="suffix" value=""/>
                                        </td>
                                    </tr>
                                </table>

                            </form>
                        </div>
        			</div>
                    <%--数据格式化 end--%>
        		</div>
        	</div>

    </form>
</div>

<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
    <jsp:param value="<%=importlibs%>" name="importlibs"/>
</jsp:include>
<script src="avicit/platform6/eform/bpmsformmanage/js/common.js"></script>

<script type="text/javascript">
    document.ready = function () {
    	$.validator.addMethod("integer", function (value, element) {
    	    var tel = /^-?\d+$/g;  //正、负 整数 + 0
    	    return this.optional(element) || (tel.test(value));
    	}, "请输入整数");

    };
    $(function() {
        //常量，json,组织，通用代码显示事件
        $("input[name='dataMappingType']").bind('click', function() {
            if($(this).val() == 0){
                $('table#commonValue').show();
                $('table#jsonValue').hide();
                $('table#orgValue').hide();
                $('table#commonCodeValue').hide();
                $('table#sqlValue').hide();
            } else if($(this).val() == 1){
               $('table#commonValue').hide();
               $('table#jsonValue').show();
               $('table#orgValue').hide();
               $('table#commonCodeValue').hide();
               $('table#sqlValue').hide();

            } else if($(this).val() == 2){
               $('table#commonValue').hide();
               $('table#jsonValue').hide();
               $('table#orgValue').show();
               $('table#commonCodeValue').hide();
               $('table#sqlValue').hide();

            } else if($(this).val() == 3){
              $('table#commonValue').hide();
              $('table#jsonValue').hide();
              $('table#orgValue').hide();
              $('table#commonCodeValue').show();
              $('table#sqlValue').hide();

            }
            else if($(this).val() == 4){
                $('table#commonValue').hide();
                $('table#jsonValue').hide();
                $('table#orgValue').hide();
                $('table#commonCodeValue').hide();
                $('table#sqlValue').show();

            }
        });
        $('table#commonValue').hide();
        $('table#jsonValue').hide();
        $('table#orgValue').hide();
        $('table#commonCodeValue').hide();
        $('table#sqlValue').hide();
        var opt=$("#timeType option:selected").val();
        if(opt==0){
            $("#TrnumType").hide();
            $("#TrtimeType").hide();
            $("#TrmoneyType").hide();
            $("#TrpercentageType").hide();
        }
        if(opt==1){
            $("#TrnumType").show();
        }
        if(opt==2){
            $("#TrtimeType").show();
        }
        if(opt==3){
            $("#TrpercentageType").show();
        }
        if(opt==4){
            $("#TrmoneyType").show();
        }

    });

     // function saveForm(){
     //   parent.diggerType.subEdit($("#editForm"));
     // }
     // function closeForm(){
     //   parent.diggerType.closeDialog("edit");
     // }
     function getFormConfig() {
         var inputs = document.getElementsByName("dataMappingType");
         var config={}
         for (var i = 0; i < inputs .length; i++) {
             if (inputs [i].checked) {
                 if (inputs [i].value=='0'){
                     config["radioType"]='0';
                     config["commonValueName"]= $('#commonValueName').val();
                 }
                 if (inputs [i].value=='1'){
                     config["radioType"]='1';
                     config["jsonValueName"]=$('#jsonValueName').val()=="" ? "" : JSON.parse($('#jsonValueName').val());

                 }
                 if (inputs [i].value=='2'){
                     config["radioType"]='2';
                     config["orgValueName"]= $('#orgValueName').val();
                     config["orgValueSeparator"]= $('#orgValueSeparator').val();
                     config["flagbyId"]=$("input[name='flagbyId']").is(':checked');
                     // config["valueNullNotDisplay"]= $('#valueNullNotDisplay').val();
                     config["valueNullNotDisplay"]=$("input[name='valueNullNotDisplay']").is(':checked');

                 }
                 if (inputs [i].value=='3'){
                     config["radioType"]='3';
                     config["commonCodeValueName"]= $('#commonCodeValueName').val();

                 }
                 if (inputs [i].value=='4'){
                     config["radioType"]='4';
                     config["sqlValueName"]= $('#sqlValueName').val();

                 }
             }
            }
         var formatType = $('#formatType').val();
         config["suffix"]= $('#suffix').val();
         config["prefix"]= $('#prefix').val();
         config["formatType"]= formatType;
         if(formatType==0){
             //没选中
         }
         if(formatType==1){
             //数值
             config["formatValue"]= $('#numType').val();
         }
         if(formatType==2){
             //日期
             config["formatValue"]= $('#timeType').val();
         }
         if(formatType==3){
             //百分比
             config["formatValue"]= $('#percentageType').val();

         }
         if(formatType==4){
             //货币
             config["formatValue"]= $('#moneyType').is(':checked');
         }
         return config
     }
     function setFormConfig(obj) {
         // var inputs = document.getElementsByName("dataMappingType");
         if ("0"==obj.radioType){//0
             $('#commonValueName').val(obj.commonValueName);
             $("#radio0").attr("checked","checked");
             $('table#commonValue').show();
         }
         if ("1"==obj.radioType){//1
             if(obj.jsonValueName==""){
                 $('#jsonValueName').val();
                 // $("#radio1").removeAttr("checked");
             }else {
                 $('#jsonValueName').val(JSON.stringify(obj.jsonValueName));
                 $("#radio1").attr("checked","checked");
             }
             $('table#jsonValue').show();
         }
         if ("2"==obj.radioType){//2
             $('#orgValueName').val(obj.orgValueName);
             $('#orgValueSeparator').val(obj.orgValueSeparator);
             $('#valueNullNotDisplay').val(obj.valueNullNotDisplay);
             if(obj.flagbyId){
                 $("#flagbyId").attr("checked","checked");
             }
             if(obj.valueNullNotDisplay){
                 $("#valueNullNotDisplay").attr("checked","checked");
             }

             $("#radio2").attr("checked","checked");
             $('table#orgValue').show();
         }
         if ("3"==obj.radioType){//3
             $('#commonCodeValueName').val(obj.commonCodeValueName);
             $("#radio3").attr("checked","checked");
             $('table#commonCodeValue').show();
         }
         if ("4"==obj.radioType){//4
             $('#sqlValueName').val(obj.sqlValueName);
             $("#radio4").attr("checked","checked");
             $('table#sqlValue').show();
         }

         if(obj.formatType==1){
             //数值
             $('#numType').val(obj.formatValue);
             $("#TrnumType").show();
         }
         if(obj.formatType==2){
             //日期
             $('#timeType').val(obj.formatValue);
             $("#TrtimeType").show();
          }
         if(obj.formatType==3){
             //百分比
             $('#percentageType').val(obj.formatValue);
             $("#TrpercentageType").show();
         }
         if(obj.formatType==4){
             //货币
             //moneyType
             var checktype = obj.formatValue;
             if(checktype){
                 $('#moneyType').prop("checked","checked");
             }else{
                 $('#moneyType').removeAttr("checked");
             }
             $("#TrmoneyType").show();
          }
         $('#suffix').val(obj.suffix);
         $('#prefix').val(obj.prefix);
         $('#formatType').val(obj.formatType);

     }
     function  qqqq(obj) {
         if(obj.value=="1"){//数值
             $("#TrnumType").show();
             $("#TrtimeType").hide();
             $("#TrmoneyType").hide();
             $("#TrpercentageType").hide();
         }
         if(obj.value=="2"){//日期
             $("#TrnumType").hide();
             $("#TrtimeType").show();
             $("#TrmoneyType").hide();
             $("#TrpercentageType").hide();
         }
         if(obj.value=="3"){//百分比
             $("#TrnumType").hide();
             $("#TrtimeType").hide();
             $("#TrmoneyType").hide();
             $("#TrpercentageType").show();
         }
        if(obj.value=="4"){//货币
            $("#TrnumType").hide();
            $("#TrtimeType").hide();
            $("#TrmoneyType").show();
            $("#TrpercentageType").hide();
        }
     }
</script>
</body>
</html>
