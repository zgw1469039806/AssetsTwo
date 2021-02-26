<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld" %>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil" %>
<% String importlibs="common,table" ; %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>管理</title>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-css.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="static/h5/select2/select2.css" />
<link rel="stylesheet" type="text/css" href="static/h5/jquery-range/css/jquery.range.css" />
<link rel="stylesheet" type="text/css" href="static/h5/iColor/css/iColor.css" />
<script type="text/javascript" src="static/js/platform/component/common/json2.js"></script>
<style type="text/css">
	.skins{
		width: 20px;
		height: 20px;
		float : left;
	}
	.img_box{
    width: 104px;
    text-align: center;
    border:1px solid #e8e8e8;
    height: 104px;
    box-sizing:content-box;
    position: relative;
    line-height: 104px;
     background: url("avicit/platform6/console/portalconfig/images/img_box_bg.png");
    }
 	.img_box img{
 	width: 104px;
 	height: 104px;
 	}
	 #logo{
	 	position: absolute;
	 	top: 0;
		left: 0;
	 }
	 .form_commonTable label {
	    margin: 0;
	    font-weight: 400;
	    color: #222222;
	}
	#toolbar.datagrid-toolbar{
		padding-top: 12px;
	    border-top: 1px solid #d8d8d8;
	}
	.toolbar{
		border-bottom: 1px solid #e8e8e8;
		height: 30px;
		padding:8px  10px;
		margin: 0 10px;
	}
	.toolbar .toolbar-left{
		margin-bottom: 0;
	}
	
	.form_left{
		float: left;
		width: 49%
	}
	.form_right{
		float: left;
		width: 49%;
		border-left: 1px solid #e8e8e8
	}
	.from_box{
		padding: 0 30px;
	}
	.form_title{
		font-size: 14px;
		line-height:34px;
		border-bottom: 1px solid #e8e8e8;
		padding-left: 10px;
	}
	.img_box{
	position: relative;
	}
	.form_commonTable label{
		font-size: 13px;
	}
	.img_box span{
	display: block;
    position: absolute;
    top: 34px;
    left: 120px;
    width: 150px;
    line-height: 20px;
    text-align: left;
    color: #888;
    }
    .form_commonTable td{
    	padding:8px;
    	height:48px;
    }
    .font_color{
    	border: 1px solid #e8e8e8;
    	height: 32px;
    	border-radius:3px;
    }
   .font_color .form-control{
   	float: left;
   	border: 0
   }
    .font_color input.form-control{
    	background: none!important;
    }
     .font_color #oneFontColorSelect,.font_color #secondFontColorSelect,.font_color #extFontColorSelect{
   	float: left;
   	width: 24px;
   	height: 24px;
   	margin: 3px;
   	border: 1px solid #e8e8e8
   }
   .slider-container{
   	width: 100%!important;
   }
   .theme-green .back-bar{
   	background: #ADB9CA;
   }
   .theme-green .back-bar .selected-bar{
   	background:#1182fa;
   }
   .theme-green .back-bar .pointer{
   	background: #fff;
   	border: 3px solid #1182fa
   }
   .font_style input{
           display: inline-block;
		    vertical-align: top;
		    margin: 0 6px;
    }
    .form_box{
    	overflow: auto;
	    position: absolute;
	    left: 0;
	    right: 0;
	    top: 46px;
	    bottom: 20px;
	    padding: 14px 0
    }
    .form_commonTable th{
    	min-width:120px; 
    }
</style>
</head>

<body>
	<div class="easyui-layout" fit="true">
		<div data-options="region:'center',split:true,border:false">
			<div class="toolbar">
				<div class="toolbar-left">
					<a id="save" href="javascript:void(0)" class="btn btn-primary form-tool-btn btn-sm btn-point" role="button" title="保存"><i class="icon icon-save"></i> 保存</a>
					<a id="reset" href="javascript:void(0)" class="btn form-tool-btn btn-sm" role="button" title="重置"><i class="icon icon-shuaxin"></i> 重置</a>
					<!-- <a id="preview" href="javascript:void(0)" class="btn form-tool-btn btn-sm btn-point" role="button" title="预览"><i class="icon icon-preview"></i> 预览</a> -->
				<div class="dropdown">
					<a class="btn btn-primary form-tool-btn btn-sm" role="button" href="javascript:void(0);" data-toggle="dropdown" id="dropdownMenu" aria-expanded="true">
						<i class="icon icon-preview"></i> 预览<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
						<li role="presentation"> <a id="default" href="javascript:void(0);" title="传统导航">传统导航</a></li>
						<li role="separator" class="divider"></li>
						<li role="presentation"> <a id="oa" href="javascript:void(0);" class="preview" title="H+导航">H+导航</a></li>
						<li role="separator" class="divider"></li>
						<li role="presentation"> <a id="simple" href="javascript:void(0);" title="简约导航">简约导航</a></li>
						<li role="separator" class="divider"></li>
						<li role="presentation"> <a id="win" href="javascript:void(0);" title="WIN导航">WIN导航</a></li>
					</ul>
				</div>
				</div>
			</div>
		</div>
		<form id='form' method="post" action="platform/console/logo/operation/save" enctype="multipart/form-data">
			<input type="hidden" name="id" id="id" value="${logoConfigDTO.id }"></input>
			<input type="hidden" name="version" id="version" value="${logoConfigDTO.version }"></input>
			<input type="hidden" name="bgColor" id="bgColor" value="${logoConfigDTO.bgColor }"></input>
			<input type="hidden" name="themeTypeKey" id="themeTypeKey" value="${logoConfigDTO.themeTypeKey }"></input>
			<input type="hidden" name="isTemp" id="isTemp" value="1"></input>
			<input type="hidden" name="isInit" id="isInit" value="1"></input>
			<div class="form_box">
			<div class="form_left">
				<div class="from_box">
					<div class="form_title">系统标题</div>
					<div class="form_table_box">
						<table class="form_commonTable">
							<tr>
								<th width="24%" style="vertical-align: top;padding-top: 10px;">
									<label for="oneTitle">Logo上传:</label>
								</th>
								<td>
									<div class="img_box">
										<img id="preview_img" src="platform/console/logo/operation/getLogo" style="width: 80px;height: 80px;" />
										<input id="logo" name="logo" type="file" accept="image/x-png,image/gif,image/jpeg,image/bmp" style="width:104px;height:104px;filter:alpha(opacity=0);opacity:0;z-index:10;cursor: pointer;" onchange='fileInputOnChange();' />
										<span>为了保证显示效果，请将图片背景设定为透明</span>
									</div>
								</td>
							</tr>
							<tr>
								<th>
									<label for="oneTitle">标题:</label>
								</th>
								<td>
									<input class="form-control input-sm" attrMaxLength="20" placeholder="在此处输入系统名称" type="text" name="oneTitle" id="oneTitle" value="${logoConfigDTO.oneTitle }" />
								</td>
							</tr>
							<tr>
								<th>
									<label for="oneFont">标题字体:</label>
								</th>
								<td>
									<select class="form-control input-sm js-example-data-array" name="oneFont" id="oneFont" value="${logoConfigDTO.oneFont }"></select>
								</td>
							</tr>
							<tr>
								<th>
									<label for="oneFontSize">标题大小:</label>
								</th>
								<td>
									<input type="hidden" class="form-control input-sm single-slider" name="oneFontSize" id="oneFontSize" value="${logoConfigDTO.oneFontSize }" />
								</td>
							</tr>
							<tr>
								<th>
									<label for="oneFontColor">标题颜色:</label>
								</th>
								<td>
									<div class="font_color">
										<div class="form-control input-sm" id="oneFontColorSelect"> </div>
										<input class="form-control input-sm" type="text" id="oneFontColor" name="oneFontColor" value="${logoConfigDTO.oneFontColor }" readonly="readonly" style="width:75px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>
									<label for="oneFontStyle">标题风格:</label>
								</th>
								<td>
									<div class="font_style">
										<input type="checkbox" value="Y" id="oneFontBold" name="oneFontBold" title="加粗">加粗
										<input type="checkbox" value="Y" id="oneFontItalic" name="oneFontItalic" title="斜体">斜体
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<div class="form_right">
				<div class="from_box">
					<div class="form_title">系统副标题</div>
					<div class="form_table_box">
						<table class="form_commonTable">
							<tr>
								<th width="24%">
									<label for="secondTitle">副标题:</label>
								</th>
								<td>
									<input class="form-control input-sm" type="text" name="secondTitle" placeholder="在此处输入系统副标题" id="secondTitle" value="${logoConfigDTO.secondTitle }" />
								</td>
							</tr>
							<tr>
								<th>
									<label for="secondFont">副标题字体:</label>
								</th>
								<td>
									<select class="form-control input-sm js-example-data-array" name="secondFont" id="secondFont" value="${logoConfigDTO.secondFont }"></select>
								</td>
							</tr>
							<tr>
								<th>
									<label for="secondFontSize">副标题大小:</label>
								</th>
								<td>
									<input type="hidden" class="form-control input-sm single-slider" name="secondFontSize" id="secondFontSize" value="${logoConfigDTO.secondFontSize }" />
								</td>
							</tr>
							<tr>
								<th>
									<label for="secondFontColor">副标题颜色:</label>
								</th>
								<td>
									<div class="font_color">
										<div class="form-control input-sm" id="secondFontColorSelect"> </div>
										<input class="form-control input-sm" type="text" id="secondFontColor" name="secondFontColor" value="${logoConfigDTO.secondFontColor }" readonly="readonly" style="width:75px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>
									<label for="secondFontStyle">副标题风格:</label>
								</th>
								<td>
									<div class="font_style">
										<input type="checkbox" value="Y" id="secondFontBold" name="secondFontBold" title="加粗">加粗
										<input type="checkbox" value="Y" id="secondFontItalic" name="secondFontItalic" title="斜体">斜体
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="from_box">
					<div class="form_title">拓展标题<span style="font-size: 12px;color:#adb9ca;padding-left: 10px;">(拓展标题在传统导航模式不显示)</span></div>
					<div class="form_table_box">
						<table class="form_commonTable">
							<tr>
								<th width="24%">
									<label for="extTitle">扩展标题:</label>
								</th>
								<td>
									<input class="form-control input-sm" type="text" name="extTitle" id="extTitle" value="${logoConfigDTO.extTitle }" />
								</td>
							</tr>
							</table>
						<!--扩展属性无需维护以下内容  -->
						<table class="form_commonTable" style="display: none">	
							<tr>
								<th>
									<label for="extFont">扩展标题字体:</label>
								</th>
								<td>
									<select class="form-control input-sm js-example-data-array" name="extFont" id="extFont" value="${logoConfigDTO.extFont }"></select>
								</td>
							</tr>
							<tr>
								<th>
									<label for="extFontSize">扩展标题大小:</label>
								</th>
								<td>
									<input type="hidden" class="form-control input-sm single-slider" name="extFontSize" id="extFontSize" value="${logoConfigDTO.extFontSize }" />
								</td>
							</tr>
							<tr>
								<th>
									<label for="extFontColor">扩展标题颜色:</label>
								</th>
								<td>
									<div class="font_color">
										<div class="form-control input-sm" id="extFontColorSelect" > </div>
										<input class="form-control input-sm" type="text" id="extFontColor" name="extFontColor" value="${logoConfigDTO.extFontColor }" readonly="readonly" style="width:75px;" />
									</div>
								</td>
							</tr>
							<tr>
								<th>
									<label for="extFontStyle">扩展标题风格:</label>
								</th>
								<td>
									<div class="font_style">
										<input type="checkbox" value="Y" id="extFontBold" name="extFontBold" title="加粗">加粗
										<input type="checkbox" value="Y" id="extFontItalic" name="extFontItalic" title="斜体">斜体
									</div>
								</td>
							</tr>
							</div>
						</table>
					</div>
				</div>
			</div>
			</div>
		</form>
	</div>
</div>
<jsp:include page="/avicit/platform6/h5component/common/h5uiinclude-js.jsp">
	<jsp:param value="<%=importlibs%>" name="importlibs" />
</jsp:include>
<script src="static/h5/jquery-form/jquery.form.js"></script>
<script src="static/h5/iColor/js/iColor.js"></script>
<script src="static/h5/select2/select2.js"></script>
<script src="static/h5/jquery-range/js/jquery.range.js"></script>
<!-- 模块js -->
<script type="text/javascript">

	//判断是IE，重写window.open方法
	var _IS_IE = navigator.userAgent.indexOf('MSIE') >= 0;
	if(_IS_IE){
		window.open = function(url, name){
			var a = document.createElement("a");
			a.href = url;
			a.target = name;
			document.body.appendChild(a);
			a.click();
			document.body.removeChild(a);
		};
	} 

	var fontJson = '${fontJson}';
	
	var logoConfigDTOJson = '${logoConfigDTOJson}';
	
	var logoConfigDTO = JSON.parse(logoConfigDTOJson);
	var oneFontSizeJR;
	var secondFontSizeJR;
	var extFontSizeJR;
	
	var cpLock = false;
	var initData;
	
	//字符串截断函数            
	function calNum(domEle) {
	   if(!cpLock) { 
	       var maxLen = 20;
	       var curtLen = domEle.value.length;
	       console.log('当前输入' + domEle.value);
	       if ( curtLen > maxLen ) {
	      	 domEle.value = domEle.value.substring(0, maxLen);
	       }
	   }
	}
	
	
	function init(){
		//重置：重置后的结果是展示上次保存的设置信息
	    //字体是否加粗和是否斜体添加else判断,解决重置不起作用的问题
		//如：修改前字体不为斜体,当选择斜体后保存前重置,期望结果是斜体不被选择中,不加else的情况下斜体依然是选中状态
        if(logoConfigDTO.oneFontBold == "Y"){
            $('#oneFontBold').prop('checked', true)
        }else {
            $('#oneFontBold').removeProp('checked')
        }
        if(logoConfigDTO.oneFontItalic == "Y"){
            $('#oneFontItalic').prop('checked', true)
        }else {
            $('#oneFontItalic').removeProp('checked')
        }
        if(logoConfigDTO.secondFontBold == "Y"){
            $('#secondFontBold').prop('checked', true)
        }else {
            $('#secondFontBold').removeProp('checked')
        }
        if(logoConfigDTO.secondFontItalic == "Y"){
            $('#secondFontItalic').prop('checked', true)
        }else {
            $('#secondFontItalic').removeProp('checked')
        }
        if(logoConfigDTO.extFontBold == "Y"){
            $('#extFontBold').prop('checked', true)
        }else {
            $('#extFontBold').removeProp('checked')
        }
        if(logoConfigDTO.extFontItalic == "Y"){
            $('#extFontItalic').prop('checked', true)
        }else {
            $('#extFontItalic').removeProp('checked')
        }
		$("#oneFont").select2({
		  data:JSON.parse(fontJson)
		})
		
		$("#oneFont").val(logoConfigDTO.oneFont).select2();
		
		$("#secondFont").select2({
		  data:JSON.parse(fontJson)
		})
		
		$("#secondFont").val(logoConfigDTO.secondFont).select2();
		
		$("#extFont").select2({
		  data:JSON.parse(fontJson)
		})
		
		$("#extFont").val(logoConfigDTO.extFont).select2();
		
		if(logoConfigDTO.oneFontSize != "" && logoConfigDTO.oneFontSize != undefined){
			oneFontSizeJR.setValue(logoConfigDTO.oneFontSize);
		}
		if(logoConfigDTO.secondFontSize != "" && logoConfigDTO.secondFontSize != undefined){
			secondFontSizeJR.setValue(logoConfigDTO.secondFontSize);
		}
		if(logoConfigDTO.extFontSize != "" && logoConfigDTO.extFontSize != undefined){
			extFontSizeJR.setValue(logoConfigDTO.extFontSize);
		}

		//$("#preview_img").attr("src","platform/console/logo/operation/getLogo?t="+Math.random());
		if(logoConfigDTO.corLogo != "" && logoConfigDTO.corLogo != undefined){
// 			$("#preview_img").attr("src","data:image/png;base64," + logoConfigDTO.corLogo);
		}

		//设置初始状态，回调函数
		$.iColor($('#oneFontColorSelect'), {
		    start: function($elem){
		    	$elem.css('background', logoConfigDTO.oneFontColor);
		    	$('#oneFontColor').val(logoConfigDTO.oneFontColor);
		    }
		    
		},1, function($elem, evt, $obj){
	        var hx = '#' + $obj.attr('hx');
	        $elem.css('background', hx);
	        $('#oneFontColor').val(hx);
	    });
		
		$('#oneFontColor').on("keyup", function(e){
			var hx = '#' + this.value;
			$(this).css('background', hx).val(this.value);
		})
		
		
		$.iColor($('#secondFontColorSelect'), {
		    start: function($elem){
		    	$elem.css('background', logoConfigDTO.secondFontColor);
		    	$('#secondFontColor').val(logoConfigDTO.secondFontColor);
		    }
		    
		},2, function($elem, evt, $obj){
	        var hx = '#' + $obj.attr('hx');
	        $elem.css('background', hx);
	        $('#secondFontColor').val(hx);
	    });
		
		$('#secondFontColor').on("keyup", function(e){
			var hx = '#' + this.value;
			$(this).css('background', hx).val(this.value);
		})
		
		$.iColor($('#extFontColorSelect'), {
		    start: function($elem){
		    	$elem.css('background', logoConfigDTO.extFontColor);
		    	$('#extFontColor').val(logoConfigDTO.extFontColor);
		    } 
		    
		},3, function($elem, evt, $obj){
	        var hx = '#' + $obj.attr('hx');
	        $elem.css('background', hx);
	        $('#extFontColor').val(hx);
	    });
		
		$('#extFontColor').on("keyup", function(e){
			var hx = '#' + this.value;
			$(this).css('background', hx).val(this.value);
		})
			
	}
	
	$(document).ready(function(){
		
		
		
		oneFontSizeJR= $('#oneFontSize').jRange({
		    from: 12,
		    to: 24,
		    step: 1,
		    scale: [12,13,14,15,16,17,18,19,20,21,22,23,24],
		    format: '%spx',
		    width: $("#oneFontSize").parent().width(),
		    height: 50,
		    showLabels: true,
		    isRange : false
		});
		
		secondFontSizeJR = $('#secondFontSize').jRange({
		    from: 12,
		    to: 24,
		    step: 1,
		    scale: [12,13,14,15,16,17,18,19,20,21,22,23,24],
		    format: '%spx',
		    width: $("#secondFontSize").parent().width(),
		    height: 50,
		    showLabels: true,
		    isRange : false
		});
		
		extFontSizeJR = $('#extFontSize').jRange({
		    from: 12,
		    to: 24,
		    step: 1,
		    scale: [12,13,14,15,16,17,18,19,20,21,22,23,24],
		    format: '%spx',
		    width: $("#extFontSize").parent().width(),
		    height: 50,
		    showLabels: true,
		    isRange : false
		});
		
		
		init();
		initData = serializeObject($('#form'));
		
		
		//重置
		$("#reset").bind('click', function() {
			setValue(initData);
			init();
			$("#isInit").val("1");
			$("#preview_img").remove();
			$("#logo").val(null);
// 			if(logoConfigDTO.corLogo != null && logoConfigDTO.corLogo != undefined){
// 				$("#logo").before($("<img id='preview_img' src='data:image/png;base64," + logoConfigDTO.corLogo+"' style='width: 80px;height: 80px;' />"));
// 			}else{
// 				$("#logo").before($("<img id='preview_img' src='platform/console/logo/operation/getLogo' style='width: 80px;height: 80px;' />"));
// 			}
            //直接base64赋值在IE8下不生效
			$("#logo").before($("<img id='preview_img' src='platform/console/logo/operation/getLogo' style='width: 80px;height: 80px;' />"));

		});

		//预览
		$.each($("ul.dropdown-menu>li>a"),function(index,a){
			$(a).bind('click', function() {
				var _self = this;
				$("#isTemp").val(2);
				var options = {
						type: "POST",
				        url: "platform/console/logo/operation/save",
				        //dataType: 'json',
				        //contentType: "application/json; charset=utf-8",
				        success: function (result) {
				        	var data = JSON.stringify(serializeObject($('#form')));
							window.open('platform/console/logo/operation/toPortalTemp?themeTypeKey='+_self.id+'&bgColor=blue&data='+encodeURIComponent(data),'_blank');
				        }/* ,
				        error: function(e){
				        	debugger;
				        	alert(2);
				        	var data = JSON.stringify(serializeObject($('#form')));
							window.open('platform/console/logo/operation/toPortalTemp?themeTypeKey='+_self.id+'&bgColor=blue&data='+encodeURIComponent(data),'_blank');
				        } */
				 };
				
				if(navigator.userAgent.indexOf("MSIE")>0){
					if(navigator.appVersion.match(/8./i)=="9." || navigator.appVersion.match(/8./i)=="8."){
						$("#form").ajaxForm(options);
						$("#form").submit();
					}else{
						 $("#form").ajaxSubmit(options);
					}
	    		} else{
	    			$("#form").ajaxSubmit(options);
	    		}
				
			});
			
		});
	
		//保存按钮绑定事件
		$('#save').bind('click', function() {
			var isValidate = $("#form").validate();
			var title=$("#oneTitle").val();
			var titleLength=$("#oneTitle").attr("attrMaxLength");
			if(title.length>titleLength){
				layer.alert('标题不能超过20个字符，请重新输入！', {
		            icon: 7,
		            area: ['400px', ''],
		            title:'提示',
		            closeBtn: 0
		        });
				return;
			}
		    if (!isValidate.checkForm()) {
		        isValidate.showErrors();
		        return false;
		    }
		    //限制保存按钮多次点击
			$('#save').addClass('disabled'); 
		    
			layer.confirm('确定要保存并应用该设置吗？', {													    
				icon: 3,																			
				title: '提示',																	    
				area: ['400px', '']																	
			}, function(index) {
				$("#isTemp").val(1);
				var options = {
				        url: "platform/console/logo/operation/save",
				        //dataType: 'json',
				        //contentType: "application/json; charset=utf-8",
				        success: function (result) {
				        	if(result.indexOf("success") != -1){
								 layer.msg('保存成功！');
				        	}else{
				        		layer.msg('保存失败！');
				        	}
				        	$('#save').removeClass('disabled'); 
				        }/* ,
				        error: function(){
				        	layer.msg('保存成功！');
				        	$('#save').removeClass('disabled'); 
				        } */
				    };
				
				if(navigator.userAgent.indexOf("MSIE")>0){
					if(navigator.appVersion.match(/8./i)=="9." || navigator.appVersion.match(/8./i)=="8."){
						$("#form").ajaxForm(options);
						$("#form").submit();
					}else{
						 $("#form").ajaxSubmit(options);
					}
	    		} else{
	    			$("#form").ajaxSubmit(options);
	    		}
				
				layer.close(index);
				},function(index){
					$('#save').removeClass('disabled'); 
					layer.close(index);
				}
			)
		});
	
});

//加载图片显示
function fileInputOnChange(){
	$("#isInit").val("2");
	  var pic = document.getElementById("preview_img");
        var file = document.getElementById("logo");
        if(window.FileReader){//chrome,firefox7+,opera,IE10+
           var oFReader = new FileReader();
           oFReader.readAsDataURL(file.files[0]);
           oFReader.onload = function (oFREvent) {pic.src = oFREvent.target.result;};   
        }
        else if (document.all) {//IE9-//IE使用滤镜，实际测试IE6设置src为物理路径发布网站通过http协议访问时还是没有办法加载图片
            file.select();
           // file.blur();//要添加这句，要不会报拒绝访问错误（IE9或者用ie9+默认ie8-都会报错，实际的IE8-不会报错）
            var reallocalpath = document.selection.createRange().text//IE下获取实际的本地文件路径
            //if (window.ie6) pic.src = reallocalpath; //IE6浏览器设置img的src为本地路径可以直接显示图片
            //else { //非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现，IE10浏览器不支持滤镜，需要用FileReader来实现，所以注意判断FileReader先
                pic.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale',src=\"" + reallocalpath + "\")";
                pic.src = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==';//设置img的src为base64编码的透明图片，要不会显示红xx
//         		pic.style.height="138px;"
           // }
        }
        else if (file.files) {//firefox6-
            if (file.files.item(0)) {
                url = file.files.item(0).getAsDataURL();
                pic.src = url;
            }
        }
}


function setValue(obj){  
    // 开始遍历   
    for(var p in obj){      
       // 方法  
       if(typeof(obj[p])=="function"){      
           // obj[p]();     
        }else{    
        	$("#"+p).val(obj[p]);
            // p 为属性名称，obj[p]为对应属性的值     
              
        }      
    }      
    
}

//检查输入的长度方法，区分中英文
function checkLength(input) {
    var i, sum;   
    sum = 0;   
    for (i = 0; i < input.length; i++) {   
       //中英文不同的长度检测办法，英文一个字符长度，中文两个支付长度
//        if ((input.charCodeAt(i) >= 0) && (input.charCodeAt(i) <= 255)) {   
          sum = sum + 1;   
//        } else {   
//        sum = sum + 2;   
//        }   
    }   
    return sum;
}

//处理超过长度的字符，截取maxlength的字符
function subString(str,n){  
  var len=checkLength(str,n);
  if(len>n){  
     var newlen=Math.floor(n/2);  
     var stringLength=str.length;
     var newString = "";
     for(var i=newlen;i<=stringLength;i++){
          var tempString = str.substr(0,i);
          if(checkLength(tempString)>n){
             return newString;
             break;
          }else{
	         newString = tempString;
          }
     }  
     }else{  
          return str;  
     }  
  }

</script>
</body>

</html>