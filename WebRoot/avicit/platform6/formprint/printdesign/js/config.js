/**
 * 电子表单设计配置
 */

EformConfig = {
    formdesignPath: "avicit/platform6/formprint/printdesign",
    contentCssPath: "avicit/platform6/formprint/printdesign/css/tinymce-content",
    dropitems: [
        {
            name: '展示控件',
            group: ['print-text-box', 'print-photo-box','print-rtf-box','print-datatable', 'print-dbfield-box',
                'print-virtual-box','print-linkage-box','print-bpmopinion-box','div-box']
        },

    ],
    tinymceContentStyle: [
        //default样式必须存在
        {
            styleName: "default",
            showText: "默认样式",
            showIcon: "ace-icon fa fa-css3 bigger-200"
        },
        {
            styleName: "document",
            showText: "信纸样式",
            showIcon: "ace-icon fa fa-file-word-o bigger-200"
        }
    ],
    extraJs:["avicit/platform6/formprint/printdesign/js/editorExtra.js"]
};