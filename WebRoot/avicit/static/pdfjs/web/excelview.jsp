<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>

a, address, b, big, blockquote, body, center, cite, code, dd, del, div, dl, dt, em, fieldset, font, form, h1, h2, h3, h4, h5, h6, html, i, iframe, img, ins, label, legend, li, ol, p, pre, small, span, strong, u, ul, var{
    padding: 0;
    margin: 0;
}
a{
    color: black;
    text-decoration: none;
}

ul{
    list-style: none;
}

#tab{
    /*width: 498px;*/
    /*height: 130px;*/
    border: 1px solid #ddd;
    box-shadow: 0 0 2px #ddd;
    margin: 0px 0 0 0px;
    /*处理超出的内容*/
    overflow: hidden;
}

/*选项卡的头部*/
#tab-header{
    background-color: #F7F7F7;
    height: 33px;
    text-align: center;
    position: relative;
}

#tab-header ul{
    width: 500px;
    position: absolute;
    left: -1px;
}

#tab-header ul li{
    float: left;
    width: 98px;
    height: 33px;
    line-height: 33px;
    padding: 0 1px;
    border-bottom: 1px solid #dddddd;
}

#tab-header ul li.selected{
    background-color: white;
    font-weight: bolder;
    border-bottom: 0;
    border-left: 1px solid #dddddd;
    border-right: 1px solid #dddddd;
    padding: 0;
}

#tab-header ul li:hover{
    color: orangered;
}

/*主要内容*/
#tab-content .dom{
    display: none;
}

#tab-content .dom ul li{
    float: left;
    /*background-color: red;*/
    margin: 15px 10px;
    width: 225px;
}


#tab-content .dom ul li a:hover{
    color: orange;

}
</style>

<script type="text/javascript">

//== 值比较  === 类型比较 $(id) ---->  document.getElementById(id)
function $(id){
    return typeof id === 'string' ? document.getElementById(id):id;
}

// 当页面加载完毕
window.onload = function(){
    // 拿到所有的标题(li标签) 和 标题对应的内容(div)
    var titles = $('tab-header').getElementsByTagName('li');
    var divs = $('tab-content').getElementsByClassName('dom');
    // 判断
    if(titles.length != divs.length) return;
    // 遍历
    for(var i=0; i<titles.length; i++){
        // 取出li标签
        var li = titles[i];
        li.id = i;
        // console.log(li);
        // 监听鼠标的移动
        li.onclick = function(){
            for(var j=0; j<titles.length; j++){
                titles[j].className = '';
                divs[j].style.display = 'none';
            }
            this.className = 'selected';
            divs[this.id].style.display = 'block';
        }
    }
}

</script>

<title>Insert title here</title>
</head>
<body>
${out }
</body>
</html>