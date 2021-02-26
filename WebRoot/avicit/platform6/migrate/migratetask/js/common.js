(function($){
    //流程步骤扩展
    $.fn.extend({
        //初始化
        loadStep: function(params){
      
            //基础框架
            var baseHtml =  "<div class='ystep-container ystep-lg ystep-green'>"+
                            "<ul class='ystep-container-steps'></ul>"+
                            "<div class='ystep-progress'>"+
                              "<p class='ystep-progress-bar'><span class='ystep-progress-highlight' style='width:0%'></span></p>"+
                            "</div>"+

                          "</div>";
            //步骤框架
            var stepHtml = "<li class='ystep-step ystep-step-undone'></li>";

            //支持填充多个步骤容器
            $(this).each(function(i,n){
                var $baseHtml = $(baseHtml),
                $stepHtml = $(stepHtml),
                $ystepContainerSteps = $baseHtml.find(".ystep-container-steps"),
                arrayLength = 0,
                $n = $(n),
                i=0;

                //步骤
                arrayLength = params.steps.length;
                for(i=0;i<arrayLength;i++){
                    var _s = params.steps[i];
                    //构造步骤html
                    $stepHtml.text(_s);
                    $stepHtml.append("<div class='ystep-step-circle'>"+(i+1)+"</div>");
                    //将步骤插入到步骤列表中
                    $ystepContainerSteps.append($stepHtml);
                    //重置步骤
                    $stepHtml = $(stepHtml);
                }
                // 插入到容器中
                $n.append($baseHtml);

                //默认执行第一个步骤
                $n.setStep(1);
            });
        },

        //跳转到指定步骤
        setStep: function(step) {
            $(this).each(function(i,n){
                //获取当前容器下所有的步骤
                var $steps = $(n).find(".ystep-container").find("li");
                var $progress =$(n).find(".ystep-container").find(".ystep-progress-highlight");
                //判断当前步骤是否在范围内
                if(1<=step && step<=$steps.length){
                    //更新进度
                    var scale = "%";
                    scale = Math.round((step-1)*100/($steps.length-1))+1 +scale;
                    $progress.animate({
                            width: scale
                        },{
                            speed: 2000,
                            done: function() {
                            //移动节点
                            $steps.each(function(j,m){
                                var _$m = $(m);
                                var _j = j+1;
                                if(_j < step){
                                    _$m.attr("class","ystep-step-done");
                                }else if(_j === step){
                                    _$m.attr("class","ystep-step-active");
                                }else if(_j > step){
                                    _$m.attr("class","ystep-step-undone");
                                }
                            });
                        }
                    });
                }else{
                    return false;
                }
            });
        },

        //获取当前步骤
        getStep: function() {
            var result = [];
      
            $(this)._searchStep(function(i,j,n,m){
                result.push(j+1);
            });

            if(result.length == 1) {
                return result[0];
            }else{
                return result;
            }
        },
        //下一个步骤
        nextStep: function() {
            $(this)._searchStep(function(i,j,n,m){
                $(n).setStep(j+2);
            });
        },
        //上一个步骤
        prevStep: function() {
            $(this)._searchStep(function(i,j,n,m){
                $(n).setStep(j);
            });
        },
        //通用节点查找
        _searchStep: function (callback) {
             $(this).each(function(i,n){
                    var $steps = $(n).find(".ystep-container").find("li");
                    $steps.each(function(j,m){
                        //判断是否为活动步骤
                        if($(m).attr("class") === "ystep-step-active"){
                            if(callback){
                                callback(i,j,n,m);
                            }
                            return false;
                        }
                    });
            });
        }
    });

    $.fn.extend({
        initModelList : function(){
            var $selectTitle = $(this);

            //单击列表单击: 改变样式
            var itemClickHandler = function($target){
                $target.closest('.item-box').find('.item').removeClass('selected-item');
                $target.closest('.item').addClass('selected-item');
            };

            //左边列表项移至右边
            var leftMoveRight = function($target){
                $target.closest('.item').removeClass('selected-item');
                $target.closest('.item').off("click").on('click', function(event){
                    itemClickHandler($(event.target));
                });
                $target.closest('.item').off('dblclick').on('dblclick', function(event){
                    rightMoveLeft($(event.target));
                });
                $selectTitle.find('.list-body .right-box').append($target.closest('.item'));
                $selectTitle.find('.list-body .right-box').attr("title", "");
                $selectTitle.find('.list-body .right-box').attr("data-original-title", "");
                $selectTitle.find('.list-body .right-box').removeClass("error");
                $selectTitle.find('.list-body .right-box').tooltip('destroy');
            };

            //右边列表项移至左边
            var rightMoveLeft = function($target){
                $target.closest('.item').removeClass('selected-item');
                $target.closest('.item').off("click").on("click", function(event){
                    itemClickHandler($(event.target));
                });
                $target.closest('.item').off('dblclick').on('dblclick', function(event){
                    leftMoveRight($(event.target));
                });
                $selectTitle.find('.list-body .left-box').append($target.closest('.item'));
            };

            //初始化列表项选择事件
            // 左边列表项单击、双击事件
            $selectTitle.find('.list-body .left-box').find('.item').unbind('click');
            $selectTitle.find('.list-body .left-box').find('.item').unbind('dblclick');
            $selectTitle.find('.list-body .left-box').find('.item').each(function(){
                $(this).on("click", function(event){
                    itemClickHandler($(event.target));
                });
                $(this).on('dblclick', function(){
                    leftMoveRight($(event.target));
                });
            });

            // 右边列表项单击、双击事件
            $selectTitle.find('.list-body .right-box').find('.item').unbind('click');
            $selectTitle.find('.list-body .right-box').find('.item').unbind('dblclick');
            $selectTitle.find('.list-body .right-box').find('.item').each(function(){
                $(this).on('click', function(event){
                    itemClickHandler($(event.target));
                });
                $(this).on('dblclick',  function(event){
                    rightMoveLeft($(event.target));
                });
            });

            //初始化添加、移除、获取值按钮事件
            var $btnBox = $selectTitle.find('.list-body .center-box');
            var $leftBox = $selectTitle.find('.list-body .left-box');
            var $rightBox = $selectTitle.find('.list-body .right-box');

            // 添加一项
            $btnBox.find('.add-one').on('click', function(){// 触发双击事件
                var $target = $leftBox.find('.selected-item');
                leftMoveRight($target);
            });

            // 添加所有项
            $btnBox.find('.add-all').on('click', function(){
                $leftBox.find('.item').each(function (idx, elem) {
                    leftMoveRight($(elem));
                });
            });

            // 移除一项
            $btnBox.find('.remove-one').on('click', function(){
                var $target = $rightBox.find('.selected-item');
                rightMoveLeft($target);
            });

            // 移除所有项
            $btnBox.find('.remove-all').on('click', function(){
                $rightBox.find('.item').each(function (idx, elem) {
                    rightMoveLeft($(elem));
                });
            });
        },


        /**
         * 获取选择的值
         * @return json数组
         */
        getSelectedValue:function (){
            var $rightBox = $(this).find('.list-body .right-box');
            var itemValues = [];
            var itemValue;

            $rightBox.find('.item').each(function(){
                itemValue = {};
                itemValue[$(this).attr('data-id')] = $(this).text();
                itemValues.push(itemValue);
            });

            for(var i = 0; i < itemValues.length; i++){
                console.log(itemValues[i]);
            }

            return itemValues;
        }
    });


})(jQuery);