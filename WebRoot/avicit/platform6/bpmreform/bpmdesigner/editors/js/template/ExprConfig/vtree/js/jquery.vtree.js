(function($) {
    $.fn.vtree = function(opt) {
        $.fn.vtree.option = $.extend({
		    data: '',
		    iptEvent:'',
		    addEvent:'',
		    delEvent:'',
		    swEvent:'',
		    added:true,
		    addedEvt:'',
		}, opt);
        var that = this;
        $.fn.vtree.root = that;
        if (!$.fn.vtree.option.data) return;
        var html = $('<ul class="rootUl"></ul>');

        function drawChild(data) {
            var child = $('<ul></ul>');
            $.each(data, function(i, v) {
                child.append(drawSpan(v));
                if (v.children) {
                    child.find('>li').eq(i).addClass('hasChild open').append(drawChild(v.children));
                    child.find('>li').eq(i).find('>span .zoom').text('<');
                }
            });
            return child;
        }

        function drawSpan(data,type) {
        	var nochild = (data.type === "3")?'nochild':'',
        		andor = (data.type !== "3")?'andor':'',
        		delbtn = '<em class="delete">x</em>';
        	if(type == 'root'){
        		delbtn = "";
        	}
        	if(data.type === "3"){
        		return '<li class="'+nochild+'"><span '+
        		'id="' + data.id +
        		'" class="' + andor +
        		'" data-pid="'+data.pId +
        		'" data-type="'+data.type +
        		'" data-fieldid="'+data.fieldId +
        		'" data-fieldname="'+data.fieldName +
        		'" data-fieldtype="'+data.fieldType +
        		'" data-fieldshowtype="'+data.fieldShowType +
        		'" data-activityid="'+data.activityId +
        		'" data-activityname="'+data.activityName +
        		'" data-valueactivityid="'+data.valueActivityId +
        		'" data-valueactivityname="'+data.valueActivityName +
        		'" data-datasourceid="' + data.dataSourceId +
				'" data-formid="' + data.formId +
				'" data-histable="' + data.hisTable +
                '" data-hisfk="' + data.hisFk +
                '" data-maintablename="' + data.mainTableName +
        		'" data-tablename="'+data.tableName +
        		'" data-comparetype="'+data.compareType +
        		'" data-comparetypename="'+data.compareTypeName +
        		'" data-comparevalue="'+data.compareValue +
        		'" data-comparevaluename="'+data.compareValueName +
        		'" data-dataid="' + data.dataId +
        		'" data-datasourceid="' + data.dataSourceId +
				'" data-formid="' + data.formId +
				'" data-maintablename="' + data.mainTableName +
            	'" data-fielddatatype="' + data.fieldDataType +
        		'" data-comparevaluefieldtype="' + data.compareValueFieldType +
            	'" data-comparevaluefieldid="' + data.compareValueFieldId +
				'" data-comparevaluefieldname="' + data.compareValueFieldName +
				'" data-comparevaluefielddatatype="' + data.compareValueFieldDataType +
            	'" data-comparevaluetablename="' + data.compareValueTableName +
        		'" ><i class="txt">' + data.fieldName + data.compareTypeName + ((data.compareValueName)?data.compareValueName:data.compareValueFieldName||"") +
        		'</i><em class="zoom">></em>'+delbtn+'<em class="add">+</em></span></li>';
        	}else{
        		return '<li class="'+nochild+'"><span '+
        		'id="' + data.id +
        		'" class="' + andor +
        		'" data-pid="'+data.pId +
        		'" data-type="'+data.type +
        		'" data-fieldid="'+data.fieldId +
        		'" data-fieldname="'+data.fieldName +
        		'" data-fieldtype="'+data.fieldType +
        		'" data-fieldshowtype="'+data.fieldShowType +
        		'" data-activityid="'+data.activityId +
        		'" data-activityname="'+data.activityName +
        		'" data-valueactivityid="'+data.valueActivityId +
        		'" data-valueactivityname="'+data.valueActivityName +
        		'" data-datasourceid="' + data.dataSourceId +
				'" data-formid="' + data.formId +
				'" data-maintablename="' + data.mainTableName +
        		'" data-tablename="'+data.tableName +
        		'" data-comparetype="'+data.compareType +
        		'" data-comparetypename="'+data.compareTypeName +
        		'" data-comparevalue="'+data.compareValue +
        		'" data-comparevaluename="'+data.compareValueName +
        		'" data-dataid="' + data.dataId +
        		'" data-datasourceid="' + data.dataSourceId +
				'" data-formid="' + data.formId +
				'" data-maintablename="' + data.mainTableName +
            	'" data-fielddatatype="' + data.fieldDataType +
                '" data-histable="' + data.hisTable +
                '" data-hisfk="' + data.hisFk +
        		'" data-comparevaluefieldtype="' + data.compareValueFieldType +
            	'" data-comparevaluefieldid="' + data.compareValueFieldId +
				'" data-comparevaluefieldname="' + data.compareValueFieldName +
				'" data-comparevaluefielddatatype="' + data.compareValueFieldDataType +
            	'" data-comparevaluetablename="' + data.compareValueTableName +
        		'" ><i class="txt">' + data.fieldName  +
        		'</i><em class="zoom">></em>'+delbtn+'<em class="add">+</em></span></li>';
        	}
            
        }

        function bindEvent(dom){
        	dom.delegate('.delete','click',function(e){
        		var _self = this;
        		e.stopPropagation();
        		flowUtils.confirm("确认要删除此分支吗?此操作会同时删除该分支包含的子分支。", function(index){
        			if($.fn.vtree.option.delEvent && typeof $.fn.vtree.option.delEvent == 'function'){
						var all = $.fn.vtree.getResult($(_self).parent().parent(),true);
        				$.fn.vtree.option.delEvent($(_self).parent(),$(_self).parent().attr('id'),all);
        			}
					$.fn.vtree.delDom($(_self));
					render(that);
        		});
        	});

        	dom.delegate('span','click',function(e){
        		e.stopPropagation();
        		$('.andor-slc,.adder-slc').remove();
        		if($.fn.vtree.option.iptEvent && typeof $.fn.vtree.option.iptEvent == 'function'){
        			$.fn.vtree.option.iptEvent($(this));
        		}
        	});

        	dom.delegate('.zoom','click',function(e){
        		e.stopPropagation();
        		if($(this).parent().parent().hasClass('open')){
        			$(this).parent().parent().toggleClass("open");
        			$(this).html(">");
        		}else{
        			$(this).parent().parent().toggleClass("open");
        			$(this).html("<");
        		}
        		render(that);
        	});
        	dom.delegate('.andor','click',function(e){
        		e.stopPropagation();
        		andorEvent($(this));
        	});
        	dom.delegate('.add','click',function(e){
        		e.stopPropagation();
        		if(!$.fn.vtree.option.added){
        			if($.fn.vtree.option.addedEvt && typeof $.fn.vtree.option.addedEvt == 'function'){
        				$.fn.vtree.option.addedEvt($(this).parent());
        			}
        			return false;
        		}
        		creatChild($(this));
        		render(that);
        	});
        }

        function andorEvent(dom){
        	$('.andor-slc,.adder-slc').remove();
        	var andordom = $('<div class="andor-slc">'+
        			'<p data-val="1">AND</p>'+
        			'<p data-val="2">OR</p>'+
        		'</div>');

        	andordom
        	.find('p')
        	.on('click',function(e){
        		e.stopPropagation();
        		dom.data('type',$(this).data('val'));
        		dom.find('.txt').text($(this).text());
        		if($.fn.vtree.option.swEvent && typeof $.fn.vtree.option.swEvent == 'function'){
        			$.fn.vtree.option.swEvent(dom);
        		}
        		$('.andor-slc').remove();
        	});

        	dom.parent().find('>span').append(andordom);
        	$(window).off('click.andor').on('click.andor',function(e){
        		e.stopPropagation();
        		if($(e.target).parent()[0].className != "andor-slc"){
        			$('.andor-slc').remove();
        		}
        	});
        }

        function getJson(dom){
        	return {
					"id": dom.attr('id')||'',
					"pId": dom.data('pid')||'',
					"type": dom.data('type') + ""||'',
					"fieldId": dom.data('fieldid')||'',
					"fieldName": dom.data('fieldname')||'',
					"fieldType": dom.data('fieldtype') + ""||'',
					"fieldShowType": dom.data('fieldshowtype') + ""||'',
					"activityId": dom.data('activityid') + ""||'',
					"activityName": dom.data('activityname') + ""||'',
					"valueActivityId": dom.data('valueactivityid') + ""||'',
					"valueActivityName": dom.data('valueactivityname') + ""||'',
					"dataSourceId": dom.data('datasourceid')||'',
					"formId": dom.data('formid')||'',
					"mainTableName": dom.data('maintablename')||'',
                    "hisTable": dom.data('histable')||'',
                	"hisFk": dom.data('hisfk')||'',
					"tableName": dom.data('tablename')||'',
					"compareType": dom.data('comparetype')||'',
					"compareTypeName": dom.data('comparetypename')||'',
					"compareValue": dom.data('comparevalue') + ""||'',
					"compareValueName": dom.data('comparevaluename')+ ""||'',
					"dataId": dom.data('dataid')||'',
					"dataSourceId": dom.data('datasourceid')||'',
					"formId": dom.data('formid')||'',
					"mainTableName": dom.data('maintablename')||'',
                	"fieldDataType": dom.data('fielddatatype')||'',
                	"compareValueFieldType": dom.data('comparevaluefieldtype')||'',
                	"compareValueFieldId": dom.data('comparevaluefieldid')||'',
					"compareValueFieldName": dom.data('comparevaluefieldname')||'',
					"compareValueFieldDataType": dom.data('comparevaluefielddatatype')||'',
                	"compareValueTableName": dom.data('comparevaluetablename')||''
				};
        }

        $.fn.vtree.getJson = getJson;

        function creatChild(dom){

        	// 选择创建类型start
        	$('.adder-slc,.andor-slc').remove();
        	var adderdom = $('<div class="adder-slc">'+
        			'<p data-val="1">AND(OR)</p>'+
        			'<p data-val="2">表达式</p>'+
        		'</div>');

        	adderdom
        	.find('p')
        	.on('click',function(e){
        		e.stopPropagation();
        		var id = insetChildDom(dom,$(this).data('val'));
        		if($.fn.vtree.option.addEvent && typeof $.fn.vtree.option.addEvent == 'function'){
        			$.fn.vtree.option.addEvent($(this).parent().parent(),id);
        		}
        		render(that);
        		$('.adder-slc').remove();
        	});

        	dom.parent().append(adderdom);
        	$(window).off('click.vtreeadder').on('click.vtreeadder',function(e){
        		e.stopPropagation();
        		if($(e.target).parent()[0].className != "adder-slc"){
        			$('.adder-slc').remove();
        		}
        	});
        	// 选择创建类型end
        	return;

        }

        function insetChildDom(dom,type){
        	var ppdom = dom.parent().parent(),
        		child = "",
        		childdata = 'data-type="3"',
        		childtxt = '请选择';
        	ppdom.addClass('hasChild open');
        	ppdom.find('>span .zoom').text('<');
        	var id = "vc-"+ Math.floor(Math.random()*100) + new Date().getTime();
        	if(type == 1){
        		child = 'andor';
        		childtxt = 'AND';
        		childdata = 'data-type="1"';
        	}
        	if(ppdom.find('>ul').length){
        		ppdom.find('>ul').append('<li><span id="'+id+'" class="'+child+'" '+childdata+'><i class="txt">'+childtxt+'</i><em class="zoom">></em><em class="delete">x</em><em class="add">+</em></span></li>');
        	}else{
        		ppdom.append('<ul>'+
        			'<li><span id="'+id+'" class="'+child+'" '+childdata+'><i class="txt">'+childtxt+'</i><em class="zoom">></em><em class="delete">x</em><em class="add">+</em></span></li>'+
        			'</ul>');
        	}
        	return id;
        }

        function format(data) {
        	var root = $(drawSpan(data,'root'));
        	root.find('span').addClass('root').parent().addClass('hasChild');
            html.html(root);
            if (data.children) {
            	root.find('span').parent().addClass('hasChild open').find('.zoom').html('<');
                html.find('li').append(drawChild(data.children));
            }
            that.append(html);
            render(that);
            bindEvent(that);
        }
        function findTop(dom){
        	var toph = that.find('.rootUl').offset().top;
        	$.each(dom,function(i,v){
        		var th = $(v).offset().top - (that.offset().top - $(window).scrollTop());
        		if(th < toph) toph = th;
        	});
        	return toph;
        }

        function reverseObj(obj) {
		    var arr = [];
		    $.each(obj,function(i,v){
		    	arr.push([obj[i],i]);
		    });
		    arr.reverse();
		    var obj = {};
		    $.each(arr,function(i,v){
		    	obj[i] = arr[i][0];
		    });
		    return obj;
		}

		function findTopAndBtm($ul,test){
			var lis = $ul.find('li:visible'),
				top = $ul.offset().top + parseInt($ul.css('paddingTop')),
				btm = $ul.offset().top + $ul.height(),
				topid,
				btmid;
			var bthis="";
			$.each(lis,function(i,v){
				var thistop = $(v).offset().top + parseInt($(v).css('paddingTop'));
				if(thistop<top) top = thistop;

				var thisbtm = $(v).offset().top + $(v).outerHeight();
				bthis = $(v).find('>span').attr('id');
				if(thisbtm > btm){
					btm = thisbtm;
					bthis = $(v).find('>span').attr('id');
				}
			});
			return {
				top:top,
				btm:btm,
				bthis:bthis
			};
		}

        function renderChild(dom){
        	var uls = that.find('ul:visible');
        	uls = reverseObj(uls);

        	var zInum = dom.find('li').length;

        	dom.find('li').each(function(i,v){
        		$(this).removeAttr("style").css('zIndex',zInum);
        		zInum--;
        	});
        	dom.find('ul').each(function(i,v){
        		$(v).removeAttr("style");
        	});

        	$.each(uls,function(i,v){
        		if($(v).find(">li").length>1){
        			$(v).parent().addClass('childs');
        		}else{
        			$(v).parent().removeClass('childs');
        		}
        		if($(v).hasClass('rootUl')){

        		}else{
        			var par = $(v).parent(),
        				ul = $(v);
        			ul.css('left',par.find(">span").outerWidth()+16);
        		}
        	});

        	$.each(uls,function(i,v){
        		if($(v).hasClass('rootUl')){

        		}else{
        			var par = $(v).parent(),
        				ul = $(v),
        				lih = par.height(),
        				ulh = ul.height() - parseInt(ul.find('>li').eq(0).css('paddingTop'));
        			ul.css('top','inherit');
        			ul.css('bottom',-Math.floor((ulh - lih)/2));
        		}
        	});

        	renderPadding(uls);

        	$.each(uls,function(i,v){
        		if($(v).hasClass('rootUl')){

        		}else{
        			var par = $(v).parent(),
        				ul = $(v),
        				lih = par.height(),
        				ulh = ul.height() - parseInt(ul.find('>li').eq(0).css('paddingTop'));
        			var parn = par.next(),
        				prntop = parseInt(parn.css('paddingTop'));
        			ul.css('top','inherit');
        			ul.css('bottom',-Math.floor((ulh - lih)/2));
        			if(parn.length){
        				var ps = findTopAndBtm(par),
                            psns = findTopAndBtm(parn),
        					parpt = parseInt(par.css('paddingTop')),
        					parcenter = Math.floor(par.offset().top+parpt+lih/2),
                            parncenter = Math.floor(parn.offset().top+prntop+parn.height()/2);


        				if(prntop < Math.abs(ps.btm - parcenter)+Math.abs(parncenter - psns.top)){
        					parn.css('paddingTop',Math.abs(ps.btm - parcenter)+Math.abs(parncenter - psns.top));
        				}
        			}
        		}
        	});

        }

        function renderPadding(uls){
        	$.each(uls,function(i,v){
        		if($(v).hasClass('rootUl')){

        		}else{
        			var par = $(v).parent(),
        				ul = $(v),
        				parpt = parseInt(par.css('paddingTop')),
        				lih = par.height(),
        				prn = par.next();

        			var ps = findTopAndBtm(ul),
        				parcenter = Math.floor(par.offset().top+parpt+lih/2),
        				childtop = ps.top,
        				parpdt = Math.floor(par.offset().top + parseInt(par.css('paddingTop')) - childtop +16);
        			if(!par.parent().hasClass('rootUl')){
						par.css('paddingTop',parpdt);
        			}
        			par.find('>ul>li').eq(0).css('paddingTop',16);
        			if(prn.length){
                        var pns = findTopAndBtm(prn);
        				var prntop =  parseInt(pns.btm - pns.top)/2;
        				prn.css('paddingTop',prntop + (ps.btm - ps.top)/2);
        			}

        		}

        	});
        }

        function render() {
        	renderChild(that.find('.rootUl>li'));

        	that.find('.rootUl').css('top',$('.rootUl').offset().top - 1 - that.offset().top - findTop(that.find('ul:visible')));
        }

        $.fn.vtree.render = render;

        format($.fn.vtree.option.data);
    };
    $.fn.vtree.option = {
	    data: '',
	    iptEvent:''
	};

	$.fn.vtree.delDom = function(dom){
		var pdom = dom.parent().parent().parent();
		dom.parent().parent().remove();
		if(!pdom.find('>li').length){
			pdom.parent().removeClass('hasChild');
		}
	};

	$.fn.vtree.delJson = function(target){
		if(!target) return;
		var dummy = '';
		target = target.replace('root','');
		if(target){
			target = target.split('-');
			$.each(target,function(i,v){
				if(v){
					dummy += '.children['+v+']';
				}
			});
			$.each(obj,function(k,v){
				eval('$.fn.vtree.option.data'+dummy+'["'+k+'"] = "'+v+'"');
			});
		}else{
			$.each(obj,function(k,v){
				$.fn.vtree.option.data[k] = v;
			});
		}
	};

	$.fn.vtree.setJson = function(dom,obj){
		if(!dom) return;
		$.each(obj,function(i,v){
			i = i.toLowerCase();
			if(i=="id"){
				dom.attr(i,v||"");
			}else{
				dom.data(i,v||"");
			}
		});
		if(dom.data('type') != 3){
			dom.addClass('andor');
		}else{
			dom.removeClass('andor');
		}
	};

	$.fn.vtree._getAllResult = function(dom){
    	var that = this,
    		data = [],
    		root = that.root;
    		console.log(that)
    	if(!dom) dom = root;

    	dom.find('>ul>li').each(function(i,v){
    		var tdata = that.getJson($(v).find(">span"));
    		if($(v).find('>ul').length > 0){
    			tdata['children'] = that._getAllResult($(v));
    		}
    		data.push(tdata);
    	});
    	return data;
    };

    $.fn.vtree.refresh = function(){
    	$.fn.vtree.render();
    };

    $.fn.vtree.getResult = function(dom,all){
    	var data = $.fn.vtree._getAllResult(dom);
    	if(all){
    		return data;
    	}else{
    		return data[0];
    	}
    };
})(jQuery);