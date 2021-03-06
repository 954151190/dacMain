<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="/struts-tags" prefix="s"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="utf-8" />
<title>更新业务页面</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="ueditor/ueditor.all.min.js"> </script>
<style> 
.textbox {
	 background: #BFCEDC;
	 border-top: #7F9DB9 1px solid;
	 border-left: #7F9DB9 1px solid; 
	border-right: #7F9DB9 1px solid; 
	border-bottom: #7F9DB9 1px solid; 
	font-family: "宋体", "Verdana", "Arial", "Helvetica"; 
	font-sizE: 220px; 
	text-align: LIFT;
	} 
</style>
<script>
	/**
		执行更新业务信息方法
	*/
	function UpdateScheme() {
		var title = encodeURI(encodeURI(document.getElementById("title").value));
		var arr = [];
        arr.push(UE.getEditor('editor').getContent());
        var content = arr.join("\n");
		content = encodeURI(encodeURI(content));
		var type = getSelectValue();
		$.ajax({  
             url :"schemeUpdate",//后台处理程序
             type:"post",    	//数据发送方式  
             async:false,  
             data:"scheme.title="+title+"&scheme.content="+content+"&scheme.type="+type+"",
             error: function(){  
             	alert("服务器没有返回数据，可能服务器忙，请重试");  
            },  
             success: function(data){
            	 var retDate = eval("("+data+")");
            	 if( true == retDate.MANAGER_RESULT ) {
            		 //执行成功,跳转到UserList页面
            		 alert("更新业务成功");
            		 document.getElementById("toSchemeList").submit();
            	 }else{
            		 //执行失败，alert错误信息
            		 alert("更新业务信息失败，失败原因：" + retDate.MANAGER_ERROR_MESSAGE );
            	 }
            }	
		});  
	}
	
	function getSelectValue(  ) {
		var obj = document.getElementById("type"); //定位id
		var index = obj.selectedIndex; // 选中索引
		var id = obj.options[index].id; // 选中值
		return id;
	}
</script>
</head>

<body>
	<form id="toSchemeList" method="post" name="toSchemeList" action="toSchemeList" />
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">更新产品</a></li>
    </ul>
    </div>
    <div class="formbody">
    <div class="formtitle"><span>基本信息</span></div>
    <ul class="forminfo">
    <li><label>文章标题</label><input name="title" id="title" type="text" class="dfinput" value="${ scheme.title }" ></input> <i>标题不能超过30个字符</i></li>
     <li>
    	<label>业务文章类型</label>
    	<cite>
    		<select id="type" name="type">
	    		<s:iterator value="schemeTypeMap" id="schemeType">
	    			<s:if test=" #schemeType.key == scheme.type ">
	    				<option id="${ schemeType.key }" selected="selected">${ schemeType.value }</option>
	    			</s:if>
	    			<s:else>
	    				<option id="${ schemeType.key }">${ schemeType.value }</option>
	    			</s:else>
	   			</s:iterator>
   			</select>
    	</cite>
    </li>
    <li>
    	<label>文章内容</label>
    	<script id="editor" type="text/plain" style="width:100%;height:500px;">${ scheme.content }</script>
    </li>
    <li><label>&nbsp;</label><input name="" type="button" class="btn" value="确认更新" onclick="UpdateScheme()"/></li>
    </ul>
    </div>
<script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');


    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }
</script>    
</body>
</html>