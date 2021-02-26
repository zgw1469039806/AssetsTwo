/**
 * 网盘用户管理
 */
if($.messager){
	$.messager.defaults.ok = '确定';
	$.messager.defaults.cancel = '取消';
};
var LoadImg = (function($) {
    var opts,
    _idAndOwnerId={},
    _idAndFileName={},
    editing = false,
    editingIndex = 0,
    // 历史列表
    $history,
    loading = false,
    isEnd = true,
    loadPage = 1,
	// 滚屏加载
    _loadById = function(pid, name) { // 按照id加载数据
        loading = true;
        $.ajax({
            url: 'platform/span/content/getSpanImgByPage.json',
            type: 'get',
            data: {
                page: loadPage,
                rows: opts.rows
            },
            dataType: 'json',
            success: function(r) {
                $.messager.progress('close');
                if (r && r.errno == 0) { // 返回成功数据
                    if (r.total > loadPage * opts.rows) {
                        $('#navTips').text('已加载' + loadPage * opts.rows + '个');
                        isEnd = false;
                    } else {
                        $('#navTips').text('已加载全部,共' + r.total + '个');
                        isEnd = true;
                    }

                    // 内容解析
                    var data_rows = r.rows;
                    
                    for (var i = 0; i < data_rows.length; i++) {
                        var id = data_rows[i].id;
                        var fsName = data_rows[i].fsName;
                        var ownerId = data_rows[i].ownerId;
                        var fsId = data_rows[i].FS_ID;

                        var liStr = "";
                        liStr += "<li class='ui-state-default' id='" + id + "' title='"+fsName+"'>";
                        liStr += "<img src='platform/span/content/getImgSrcFromFastDfsFileOfImage?id=" + fsId + "' alt='500'>";
                        liStr += "<div class='imgName'>" + fsName + "</div>";
                        liStr += "</li>";
                        
                        _idAndOwnerId[id] = ownerId;
                        _idAndFileName[id] = fsName;
                        
                        $("#selectable").append(liStr);
                    }
                } else {
                    $.messager.show({
                        title: '加载失败！',
                        msg: r.msg
                    });
                }
                loading = false;
            }
        });
        return this;
    }, 
	//共享
	_shareItem=function(rowIndex,retValue,dialogDivId){
    	var hiddenFileIds = $("#hiddenFileIds").val();
    	var hiddenFileIdsArray = hiddenFileIds.split(",");
    	
		var ids = [],fileName=[];
		for (var i = 0; i < hiddenFileIdsArray.length; i++){
			ids.push(hiddenFileIdsArray[i]);
			fileName.push(_idAndFileName[hiddenFileIdsArray[i]]);
		}
		
		 $.messager.progress();	
		 $.ajax({
			 url:'platform/span/share/share.json',
			 type :'post',
			 data:{ids:JSON.stringify(ids),fileNames:JSON.stringify(fileName),userIds:retValue.userId,userNames:retValue.userName},
			 dataType : 'json',
			 success : function(r){
				 $.messager.progress('close');	
				 if (r&&r.errno==0) {
					 $.messager.show({
						 title : '提示',
						 msg : '共享成功！'
					});
				}else{
					$.messager.show({
						 title : '提示',
						 msg : r.msg
					});
				}
			 }
		 });
	};

    var _int = function(o) {
        opts = $.extend({},
        {
            page: 1,
            rows: 50,
            count: 50
        },
        o);
        if (opts.showImgDiv) {
            $showImgDiv = $('#' + opts.showImgDiv);
            $showImgDiv.scroll(function(e) {
                e.preventDefault();
                e.stopPropagation();
                if (isEnd) {
                    return false;
                }
                var $this = $(this),
                viewH = $(this).height(),
                // 可见高度
                contentH = $(this).get(0).scrollHeight,
                // 内容高度
                scrollTop = $(this).scrollTop(); // 滚动高度
                if (scrollTop / (contentH - viewH) >= 0.98) { // 到达底部100px时,加载新内容
                    if (!loading) {
                        loadPage++;
                        _loadById();
                    }
                }
            });
        }
        if (opts.toolBar) {
            $history = $('<div class="navigation"><p><span id="navTips">已全部加载:共0个</span></p><div id="hisContent">&nbsp;&nbsp;共选择<span id="selectFileNum">0</span>个</div></div>');
            $history.appendTo($("#" + opts.toolBar));
        }
		if(opts.share){
			$("#"+opts.share).bind("click",function(){
				var hiddenFileIds = $("#hiddenFileIds").val();
				
				if(hiddenFileIds == "") {
					$.messager.alert("操作提示", "请选择图片！","warning");
				}
				else {
					$.messager.confirm("操作提示","确定分享选定的图片？", function (b) {
						if (b) {
							new GridCommonSelector("user", "","", "", {},_shareItem, null, null, null, false, null, null, "n").init();
						}
					});
				}
			});
		}       
        if (opts.del) { // 删除
            $("#" + opts.del).bind("click", function() {
				var hiddenFileIds = $("#hiddenFileIds").val();
				
				if(hiddenFileIds == "") {
					$.messager.alert("操作提示", "请选择图片！","warning");
				}
				else {
					$.messager.confirm("操作提示","确定删除选定的图片？", function (b) {
						if (b) {
							var ids = [];
							var hiddenFileIdsArray = hiddenFileIds.split(",");
							for (var i = 0; i < hiddenFileIdsArray.length; i++){
								ids.push(hiddenFileIdsArray[i]);
							}
							
	                        $.messager.progress();
	                        $.ajax({
	                            url: 'platform/span/content/delete.json',
	                            type: 'post',
	                            data: {
	                            	ids : JSON.stringify(ids)
	                            },
	                            dataType: 'json',
	                            success: function(r) {
	                                $.messager.progress('close');
	                                if (r && r.errno == 0) {
	                                    $.messager.show({
	                                        title: '提示',
	                                        msg: '删除成功！'
	                                    });
	                                    
	                                    loadPage = 1;
	                                    $("#selectable").empty();
	                                    _loadById();
	                                    
	                                    $("#hiddenFileIds").val("");
	                                    $("#selectFileNum").html("0");
	                                    
	                                    if (parent && parent.nav) {
	                                        parent.nav.loadSize().needReycble();
	                                    }
	                                }else {
	                                    $.messager.show({
	                                        title: '提示',
	                                        msg: r.msg
	                                    });
	                                }
	                            }
	                        });	
						}
					});					
				}            	
            });
        }
		if(opts.download){
			$("#"+opts.download).bind("click",function(){
				var hiddenFileIds = $("#hiddenFileIds").val();
				
				if(hiddenFileIds == "") {
					$.messager.alert("操作提示", "请选择图片！","warning");
				}
				else if(hiddenFileIds.split(",").length > 1) {
					$.messager.alert("操作提示", "一次只能下载一张图片！","warning");
				}
				else {
					var objs=[{
						key : hiddenFileIds,
						value : _idAndOwnerId[hiddenFileIds]
					}];
					
					var downloadUrl = "platform/span/content/down.json?objs=" + JSON.stringify(objs);
					new DownLoad4URL('iframe', 'form', null, downloadUrl).downLoad();
				}
			});
		}
    }
    return {
        // 加载数据
        "init": function(o) {
            _int(o);
            return this;
        },
        "loadData": function() {
            _loadById();
            return this;
        }
    };
} (jQuery));
