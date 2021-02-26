/**
 * 
 */
(function() {
    CKEDITOR.plugins.add('newpreview', {
        init: function(a) {
            a.addCommand('newpreview', CKEDITOR.plugins.newpreview.commands.newpreview);
            a.ui.addButton('newpreview', {
                label: "预览",
                command: 'newpreview',
                icon: CKEDITOR.plugins.getPath('newpreview')+'preview.png'
            });
        }
    });
    CKEDITOR.plugins.newpreview = {
        commands: {
        	newpreview: {
                exec: function(a) {
                    var _html = a.getData();
                    var url = 'platform/eform/formdefine/getPreviewHtml';
                    $.post(url, {
            			tableId:tableId,
            			editorHtml : _html
            		}, function(result) {
            			var url = CKEDITOR.plugins.getPath('newpreview')+'preview.jsp';
            			if (result.isUpload == "Y"){
            				url = CKEDITOR.plugins.getPath('newpreview')+'previewAttach.jsp'
            			}
            			window._previewHtml = result.html;
            			var  dlg = new CommonDialog("preview","600","400",url,"预览",false,true,false);
        				dlg.show();
            		}, 'json');
                }
            }
        }
    };
})();