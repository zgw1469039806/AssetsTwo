#使用说明

##依赖
###jQuery.js~1.9.1
> 考虑到本插件需要支持ie8，所以jquery版本最好是1.9.x版本

###bootstrap.css
> bootstrap原始样式

###autofixedForm-bootstrap.css
> 对boostrap的表单样式进行了一部分修正，以便兼容本插件

##API
###jquery.autofixedform.js
> 插件主体，对表单内的块元素进行重绘，保证块元素以一定格式排列

####html 样例代码
``` html
<!-- 表单主体 -->
<div id="domform" class="form form-inline">
    <!-- 用data-fw属性设置区块的权重 -->
    <!-- 权重为1的一个块区，权重越大所占宽度越大，1的宽度为父级的100% -->
    <div class="form-group fixed-form" data-fw="1">
        <label for="exampleInputName1" title="测试表单一">测试表单一</label>
        <div class="ipt"><div class="cont"><input type="text" class="form-control" id="exampleInputName1" placeholder="Jane Doe"></div></div>
        <div class="remove">删除我</div>
    </div>
    <!-- 权重为2的一个块区，2的宽度为父级的50% -->
    <div class="form-group fixed-form" data-fw="2">
        <label for="exampleInputName2" title="测试表单二">测试表单二</label>
        <div class="ipt"><div class="cont"><input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe"></div></div>
    </div>
    <!-- 权重为1的一个块区，*注意*本区块在初始化后会被强制对齐 -->
    <div class="form-group fixed-form" data-fw="1">
        <label for="exampleInputName3" title="测试表单名字长">测试表单名字长</label>
        <div class="ipt"><div class="cont"><input type="text" class="form-control" id="exampleInputName3" placeholder="Jane Doe"></div></div>
        <div class="remove">删除我</div>
    </div>
    <!-- 权重为3的一个块区，3的宽度为父级的33% -->
    <div class="form-group fixed-form" data-fw="3">
        <label for="exampleInputName4" title="表单">表单</label>
        <div class="ipt"><div class="cont"><input type="text" class="form-control" id="exampleInputName4" placeholder="Jane Doe"></div></div>
    </div>
    <!-- 未设置权重的区块，无权重则不会被重绘，保持原有样式 -->
    <div class="form-group fixed-form">
        <label for="exampleInputName5" title="测试表单五">测试表单五</label>
        <div class="ipt"><div class="cont"><input type="text" class="form-control" id="exampleInputName5" placeholder="Jane Doe"></div></div>
    </div>
</div>
```

####js 样例代码
``` javascript
//父窗体注册本插件
$('#domform').autofixedform({
    //[jQuery选择器语法]需要格式化的表单的class，默认.fixed-form
    name:'.fixed-form',
    //区块最小宽度，默认200
    minWidth:200,
});
```

##PS
>理论上区块权重可以无限，但考虑到排版权重最大到5是比较合适的，通常到4