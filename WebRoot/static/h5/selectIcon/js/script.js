$(function(){
	$('li').on('click',function(){
        if(getQueryVariable("callBack")=="T"){
			iClass = ($(this).find('span').length)?$(this).find('span'):$(this).find('i');
            $('li').removeClass("selected");
            $(this).addClass('selected');

        }else{
            parent.setIconInfo(getIconInfo($(this)));
		}
	});
});
var iClass = {};
/**
 * 获取图标信息
 * @param  {object} dom 节点对象
 * @return
 */
function getIconInfo(dom){
	var icon = (dom.find('span').length)?dom.find('span'):dom.find('i');
	var iconType= dom.parents('.icon-list').data('type');

	return {
		type:iconType,
		icon:icon.attr('class'),
		name:icon.data('icon'),
		unicode:icon.data('unicode')
	};
}


/**
 * 回调选图片信息
 * @param  {object} dom 节点对象
 * @return
 */
function callback(){
	return iClass;
}

function getQueryVariable(variable)
{
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
        var pair = vars[i].split("=");
        if(pair[0] == variable){return pair[1];}
    }
    return(false);
}