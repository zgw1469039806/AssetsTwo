<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="panel-main">
    <div class="btn-bar">
    </div>
    <div class="easyui-layout" data-options="fit:true" id="processLevelLayout"
         style="width:100%;height:100%;overflow:hidden;">
        <div data-options="region:'west',split:true" style="width:200px;" id="processLevelWest">
            <div>
                <ul id="processLevelTree" class="ztree"></ul>
            </div>
        </div>
        <div data-options="region:'center',split:true" style="overflow:hidden;" id="processLevelCenter">
            <iframe id="iframeCenter_processlevel_graph" src="" scrolling="yes" frameborder="0"
                    style="width:100%;height:100%; border: 0;"></iframe>
        </div>
    </div>
</div>