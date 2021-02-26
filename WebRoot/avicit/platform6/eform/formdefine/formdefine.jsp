<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=11,chrome=1">

<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
<script src="avicit/platform6/eform/formdefine/js/ckeditor/ckeditor.js"></script>
<script src="avicit/platform6/eform/formdefine/js/ckeditor/config.js"></script>

</head>
<style>
.unselect {
    -webkit-user-select: none; 
    -moz-user-select: none;    
    -khtml-user-select: none;  
    -ms-user-select: none;    

    /* 以下两个属性目前并未支持，写在这里为了减少风险 */
    -o-user-select: none;
    user-select: none;  
}
</style>
<body class="easyui-layout"  fit="true">
<form id="fm" method="post" novalidate>
<input type="hidden"   id="tableId"   value="${tableId}">

	<div data-options="region:'west',split:true,border:false" style="padding:0px;overflow:hidden;width:300px">
	${allcontent}	
	</div>

	<div data-options="region:'center'" style="background:#f5fafe;height:100%">
		
			<div id="editor" >
				${content}<div id="padding_area" contenteditable="false" style="height:200px;" class="unselect"></div>
			</div>
		
		<div id="toolbar" class="datagrid-toolbar foot-formopera">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton primary-btn" onclick="saveObj()" >保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="parent.dlg_close_only('newform')" >返回</a>
					</td>
				</tr>
			</table>
		</div>
		
	</div>


</form>

<script>
	var dragFlag = false;
	var upFlag = false;
	var isCrossIFrameDragging = false;
	var tableId = "${tableId}";
	var editor,transData;
	var TransData = function(){
		this.data = {};
		this.setData = function(key,value){
			this.data[key] = value;
		};
		this.getData = function(key){
			var value = eval('this.data.'+key);
			return value;
		}
	}
	
	
	function dragEvent() {
        $("body").append("<div style='position:absolute' id='dragshadow'></div>");
        $("body").mousemove(function(e) {
        	if (isCrossIFrameDragging){
        	
	            var f = $("#dragshadow:visible");
	            if (f[0]) {
	                f.css("left", e.pageX + 10);
	                f.css("top", e.pageY + 10);
	            }
	            
        	}
        });
        $("body").mouseup(function() { if (isCrossIFrameDragging){$("#dragshadow").hide(); isCrossIFrameDragging=false;}});

        var f1 =  $("iframe");
		var f1_body = $(f1[0].contentWindow.document.body);
        // var f2_body = $(f2[0].contentWindow.document.body);
        var f2_body = $("#items");

        f1_body.mousemove(function(e) {
        	e.preventDefault();
            var f = $("#dragshadow:visible");
            f.css("left", e.pageX + f1.offset().left + 10);
            f.css("top", e.pageY + f1.offset().top + 10);
        	
        }).mouseup(function() { $("#dragshadow").hide(); isCrossIFrameDragging=false;});

        //跨iframe不能用clone的对象append,可能克隆的对象是在外层document下保存
        
        f1_body.find("#edittable").mouseup(function(ev) {
        	if (isCrossIFrameDragging){
						var data = transData.getData('html');
	                    $(ev.target).html(data);
	                    isCrossIFrameDragging = false;
	                    if (CKEDITOR.env.ie){
	                    	
	    				}else{
	    					$(ev.target).children().each(function(){
	    						$(this).attr("contenteditable",false);
	    						$(this).attr("data-cke-editable","1");
	    						$(this).click(function(){
	    							f1_body.find("#edittable").find(".active").removeClass("active");
	    							$(this).addClass("active");
	    							editor.focus();
	    							//阻止冒泡
	    							return false;
	    						})
	    					});
	    				}
                   // iframeWindow.removeDraggingItem();
                $("#dragshadow div").empty();
                isCrossIFrameDragging = false;
        	}
            });
        
        
     /*    
        f1_body.find(".drop_area").mouseup(function(e) {
            $(this).append($("#dragshadow:visible").html());
            $("#dragshadow:visible div").empty();
        }); */


        f2_body.mousemove(function(e) {
        	if (isCrossIFrameDragging){
            var f = $("#dragshadow:visible");
            if (f[0]) {
                f.css("left", e.pageX + 10);
                f.css("top", e.pageY + 10);
            }
        	}
        }).mouseup(function() { if (isCrossIFrameDragging){$("#dragshadow").hide(); isCrossIFrameDragging=false;}}).bind("selectstart", function(e) { e.preventDefault(); });

      //文本框
		$("#items").find("input[type='text']").mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = "<input name=\""+$(this).attr("name")+"\" type=\""+$(this).attr("type")+"\" value=\""+$(this).val()+"\" width=\"173\" style=\"width:173px;\"/>";
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
		
		//checkbox
		$("#items").find("input[type='checkbox']").mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = "<input name=\""+$(this).attr("name")+"\" type=\""+$(this).attr("type")+"\" value=\"Y\"/>";
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
		
		$("#items").find($("p[type='checkbox']")).mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = $(this).html();
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
		
		//textarea
		$("#items").find("input[type='textarea']").mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = "<textarea name=\""+$(this).attr("name")+"\">"+$(this).val()+"</textarea>";
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
		
		//下拉框
		$(".select").mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = "<select name=\""+$(this).attr("name")+"\" style='width:173px'></select>";
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
		
		//radio
		$("#items").find($("p[type='radio']")).mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = $(this).html();
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
		
		//label文本
		$("#items").find($("p[type='text']")).mousedown(function(e){
			e.preventDefault();
			 $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
            var html = $(this).html();
            transData.setData('html',html);
            isCrossIFrameDragging = true;
        });
        
        
        
        
    }
	
	
	$(function(){ 
		transData = new TransData();
		var hg=($('#editor').parent().height());
		editor = CKEDITOR.replace( 'editor',{height:hg-95} );
		CKEDITOR.instances.editor.execCommand('maximize');
		setTimeout(function(){
			
			dragEvent();

		},500);		
		
		editor.on("instanceReady", function () {  
	        this.document.on("click", clickBlank);  
	    });  
		
		editor.on('blur', function() { 
			clickBlank();
		});
	});
	

	function clickBlank(e) {//取消选中状态
		var table = document.getElementsByTagName('iframe')[0].contentWindow.document.getElementById('edittable');
		$(table).find(".active").removeClass("active");

    }
	
	
  /**
	
	$(function(){ 
		transData = new TransData();
		var hg=($('#editor').parent().height());
		editor = CKEDITOR.replace( 'editor',{height:hg-95} );
		CKEDITOR.instances.editor.execCommand('maximize');
		setTimeout(function(){
			init();
			bindEvent();
		},500);

	    if (! 0) {
	    	$("iframe")[0].onload = function() {
	            dragEvent();
	        };
	    } else {

	    }
	    $("iframe")[0].onreadystatechange = function() {
	        if ($("iframe")[0].readyState == "complete") {
	            dragEvent();
	        }
	    }
		editor.on("instanceReady", function () {  
	        this.document.on("click", clickBlank);  
	    });  
		
		editor.on('blur', function() { 
			clickBlank();
		});
	});
		
		function clickBlank(e) {//取消选中状态
			var table = document.getElementsByTagName('iframe')[0].contentWindow.document.getElementById('edittable');
			$(table).find(".active").removeClass("active");

	    }
		
		
		
		function bindEvent(){
			var f1 =  $("iframe");
			var f1_body = $(f1[0].contentWindow.document.body);
			f1_body.mousemove(function(e) {
				if (isCrossIFrameDragging){
	                var f = $("#dragshadow");
	                f.css("left", e.pageX + f1.offset().left + 10);
	                f.css("top", e.pageY + f1.offset().top + 10);
				}
            });
			f1_body.find("#edittable").mouseup(function(ev) {
						alert(123);
						var data = parent.transData.getData('html');
	                    $(ev.target).html(data);
	                    isCrossIFrameDragging = false;
	                    if (CKEDITOR.env.ie){
	                    	
	    				}else{
	    					$(ev.target).children().each(function(){
	    						$(this).attr("contenteditable",false);
	    						$(this).attr("data-cke-editable","1");
	    						$(this).click(function(){
	    							f1_body.find("#edittable").find(".active").removeClass("active");
	    							$(this).addClass("active");
	    							editor.focus();
	    							//阻止冒泡
	    							return false;
	    						})
	    					});
	    				}
                   // iframeWindow.removeDraggingItem();
                $("#dragshadow div").empty();
            });
		}
		
		/**
		function bindEvent(){
			var table = document.getElementsByTagName('iframe')[0].contentWindow.document.getElementById('edittable');
		     
				$(table).find("td").on("dragenter",function(ev){
                if(isCrossIFrameDragging) {
                   // $(ev.target).text("hehe");
                }
            })
            .on('dragleave', function(ev) {
                if(isCrossIFrameDragging) {
                   // $(ev.target).text("jiba");
                }
            })
            .on("dragover",function(ev){
                if(isCrossIFrameDragging) {
                    ev.preventDefault();
                    ev.originalEvent.dataTransfer.dropEffect = 'move';
                }
            })
            .on("drop",function(ev){
                var df = ev.originalEvent.dataTransfer;
                var data = df.getData("Text");
                if(isCrossIFrameDragging)  {
                    $(ev.target).html(data);
                    if (CKEDITOR.env.ie){
                    	
    				}else{
    					$(ev.target).children().each(function(){
    						$(this).attr("contenteditable",false);
    						$(this).attr("data-cke-editable","1");
    						$(this).click(function(){
    							$(table).find(".active").removeClass("active");
    							$(this).addClass("active");
    							editor.focus();
    							//阻止冒泡
    							return false;
    						})
    					});
    				}
                   // iframeWindow.removeDraggingItem();
                }
        
			});

				if (CKEDITOR.env.ie){
					
				}else{
					
					$(table).find("td").children().each(function(){
						$(this).click(function(){
							$(table).find(".active").removeClass("active");
							$(this).addClass("active");
							editor.focus();
							//阻止冒泡
							return false;
						});
					});
				}
		}

		function init(){
			
			$("body").append("<div style='position:absolute' id='dragshadow'></div>");
		    $("body").mousemove(function(e) {
		    	if (isCrossIFrameDragging){
			        var f = $("#dragshadow");
			        if (f[0]) {
			            f.css("left", e.pageX + 10);
			            f.css("top", e.pageY + 10);
			        }
		    	}
		    });
		    
		    $("body").mouseup(function() { $("#dragshadow").hide(); isCrossIFrameDragging = false;alert(333); });	
			
			//文本框
			$("#items").find("input[type='text']").mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (e.pageX + 10) + "px", top: (e.pageY + 10) + "px" }).show();
	            var html = "<input name=\""+$(this).attr("name")+"\" type=\""+$(this).attr("type")+"\" value=\""+$(this).val()+"\" width=\"173\" style=\"width:173px;\"/>";
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
			
			//checkbox
			$("#items").find("input[type='checkbox']").mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (f2.offset().left + e.pageX + 10) + "px", top: (f2.offset().top + e.pageY + 10) + "px" }).show();
	            var html = "<input name=\""+$(this).attr("name")+"\" type=\""+$(this).attr("type")+"\" value=\"Y\"/>";
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
			
			$("#items").find($("p[type='checkbox']")).mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (f2.offset().left + e.pageX + 10) + "px", top: (f2.offset().top + e.pageY + 10) + "px" }).show();
	            var html = $(this).html();
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
			
			//textarea
			$("#items").find("input[type='textarea']").mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (f2.offset().left + e.pageX + 10) + "px", top: (f2.offset().top + e.pageY + 10) + "px" }).show();
	            var html = "<textarea name=\""+$(this).attr("name")+"\">"+$(this).val()+"</textarea>";
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
			
			//下拉框
			$(".select").mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (f2.offset().left + e.pageX + 10) + "px", top: (f2.offset().top + e.pageY + 10) + "px" }).show();
	            var html = "<select name=\""+$(this).attr("name")+"\" style='width:173px'></select>";
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
			
			//radio
			$("#items").find($("p[type='radio']")).mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (f2.offset().left + e.pageX + 10) + "px", top: (f2.offset().top + e.pageY + 10) + "px" }).show();
	            var html = $(this).html();
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
			
			//label文本
			$("#items").find($("p[type='text']")).mousedown(function(e){
				e.preventDefault();
	            $("#dragshadow").empty().append($(this).clone()).css({ left: (f2.offset().left + e.pageX + 10) + "px", top: (f2.offset().top + e.pageY + 10) + "px" }).show();
	            var html = $(this).html();
	            transData.setData('html',html);
	            isCrossIFrameDragging = true;
	        });
						
		}
		
		/* function init(){
			
			//文本框
			$("#items").find("input[type='text']").on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = "<input name=\""+$(this).attr("name")+"\" type=\""+$(this).attr("type")+"\" value=\""+$(this).val()+"\" width=\"173\" style=\"width:173px;\"/>";
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
			//checkbox
			$("#items").find("input[type='checkbox']").on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = "<input name=\""+$(this).attr("name")+"\" type=\""+$(this).attr("type")+"\" value=\"Y\"/>";
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
			$("#items").find($("p[type='checkbox']")).on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = $(this).html();
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
			//textarea
			$("#items").find("input[type='textarea']").on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = "<textarea name=\""+$(this).attr("name")+"\">"+$(this).val()+"</textarea>";
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
			//下拉框
			$(".select").on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = "<select name=\""+$(this).attr("name")+"\" style='width:173px'></select>";
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
			//radio
			$("#items").find($("p[type='radio']")).on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = $(this).html();
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
			//label文本
			$("#items").find($("p[type='text']")).on("dragstart",function(ev){
	            var dt = ev.originalEvent.dataTransfer;
	            var html = $(this).html();
	            dt.setData('Text',html);
	            dt.effectAllowed = 'move';
	            isCrossIFrameDragging = true;
	        }).on("dragend",function(ev){
	        	isCrossIFrameDragging = false;
	        });
			
		}
	});  
	
	
	**/
	var baseurl = '<%=request.getContextPath()%>';
	var url;
	
	function saveObj() {
		var tableId=$('#tableId').val();
		var unselect = editor.document.find(".unselect");
		if (unselect && unselect.count()>0){
			for (var i=0;i<unselect.count();i++){
				unselect.getItem(i).remove();
			}
		}
		url = 'platform/eform/formdefine/add?formversion='+encodeURI('${formversion}');
		var tableWidth = $("#edittable").css("width");
		$.post(url, {
			tableId:tableId,
			editor : CKEDITOR.instances.editor.getData()
		}, function(result) {
			if (result.success) {
				parent.dlg_close('newform');
			} else {
				$.messager.show({
					title : '错误',
					msg : result.msg
				});
			}
		}, 'json');
		
	}
	
</script>

    
    
</body>
</html>