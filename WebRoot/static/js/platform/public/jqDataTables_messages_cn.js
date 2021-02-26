//jquery dataTables信息汉化
(function(){
    var oLanguage={
        "oAria": {
            "sSortAscending": ": 升序排列",
            "sSortDescending": ": 降序排列"
        },
        "oPaginate": {
        	"sFirst" : "首页",
    		"sPrevious" : "上一页",
    		"sNext" : "下一页",
    		"sLast" : "末页"
        },
        "sEmptyTable": "没有相关记录",
        "sInfo": "第 _START_ 到 _END_ 条记录，共 _TOTAL_ 条 ",
        "sInfoEmpty": "没有数据",
        "sInfoFiltered": "(从 _MAX_ 条记录中检索)",
        "sInfoPostFix": "",
        "sDecimal": "",
        "sThousands": ",",
        "sLengthMenu": "每页显示 _MENU_ 条记录",
        "sLoadingRecords": "正在加载数据...",
        "sProcessing": "正在加载数据...",
        "sSearch": "搜索:",
        "sSearchPlaceholder": "",
        "sUrl": "",
        "sZeroRecords": "没有检索到数据"      	       	
    }
    
    $.fn.dataTable.defaults.oLanguage = oLanguage;
})();