/**
 * 流程右键菜单
 * 默认支持
 * 右键流程详情页，
 * 右键流程添加页。
 *
 * <div class="contextMenu" style="display: none;" id="commonContextMenuProcess">
     <ul>
    <li id="P_item_select">查询</li>
    <li id="P_item_add">添加</li>
    </ul>
    </div>
 若使用默认可以使用ContextMenu.jsp 需要引入
 若需要使用其他div 保证id 为  commonContextMenuProcess
 查询栏的id为      P_item_select
 添加栏的id为     P_item_add
 *
 */
function initContextMenuProcess() {
        $('tr.jqgrow').contextMenu('commonContextMenuProcess', { //菜单样式
            bindings: {
                'P_item_select': function(t) {
                    flowUtils.detail(t.id);
                },
                'P_item_add': function(t) {
                    flowListEditor.addFlow();
                }
            }
        })
}

/**
 * 列表页右键菜单（添加页与编辑页为弹出）
 * 默认支持
 * 右键添加，
 * 右键编辑，
 * 右键删除
 <div class="contextMenu" style="display: none;" id="commonContextMenuForm">
 <ul>
 <li id="F_item_add">添加</li>
 <li id="F_item_edit">编辑</li>
 <li id="F_item_del">删除</li>
 </ul>
 </div>
 若使用默认可以使用ContextMenu.jsp 需要引入
 若需要使用其他div 保证id 为  commonContextMenuProcess
 添加栏的id为      F_item_add
 修改栏的id为     F_item_edit
 删除栏的id为     F_item_del
 * @param jqgrid   jqgrid
 * @param subject  为当前js 生成的对象。
 */
function initContextMenu(jqgrid,subject) {
    $('tr.jqgrow').contextMenu('commonContextMenuForm', { //菜单样式
        bindings: {
            'F_item_add': function(t) {
                subject.insert();
            },
            'F_item_edit': function(t) {
                $(jqgrid).jqGrid('setSelection',t.id);
                subject.modify();
            },
            'F_item_del': function(t) {
                $(jqgrid).jqGrid('setSelection',t.id);
                subject.del();
            }
        }
    })
}

/**
 * 列表页右键菜单（添加与编辑为行编辑）
 * 默认支持
 * 右键添加，
 * 右键删除
 <div class="contextMenu" style="display: none;" id="commonContextMenuFormInLine">
 <ul>
 <li id="I_item_add">添加</li>
 <li id="I_item_del">删除</li>
 </ul>
 </div>
 若使用默认可以使用ContextMenu.jsp 需要引入
 若需要使用其他div 保证id 为  commonContextMenuFormInLine
 添加栏的id为      I_item_add
 删除栏的id为      I_item_del
 * @param jqgrid   jqgrid
 * @param subject  为当前js 生成的对象。
 */
function initContextMenuInLine(jqgrid,subject) {
    $('tr.jqgrow').contextMenu('commonContextMenuFormInLine', { //菜单样式
        bindings: {
            'I_item_add': function(t) {
                subject.insert();
            },
            'I_item_del': function(t) {
                $(jqgrid).jqGrid('setSelection',t.id);
                subject.del();
            }
        }
    })
}

