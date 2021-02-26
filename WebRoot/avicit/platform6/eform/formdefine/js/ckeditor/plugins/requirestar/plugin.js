/**
 * 
 */
(function() {
    CKEDITOR.plugins.add('requirestar', {
        init: function(a) {
            a.addCommand('requirestar', CKEDITOR.plugins.requirestar.commands.requirestar);
            a.ui.addButton('requirestar', {
                label: "必填",
                command: 'requirestar',
                icon: CKEDITOR.plugins.getPath('requirestar')+'required.gif'
            });
        }
    });
    CKEDITOR.plugins.requirestar = {
        commands: {
        	requirestar: {
                exec: function(editor) {
                	editor.insertHtml('<span class="remind">*</span>');
                }
            }
        }
    };
})();