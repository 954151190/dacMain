<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>业务管理</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">
$(document).ready(function(){
  $(".click").click(function(){
  $(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});

  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});

/**
 * 添加业务信息方法
 */
function addSchemes() {
	document.getElementById("formSchemeAdd").submit();
}

function updateSchemes(data) {
	var user_id = document.getElementById("form_update_scheme_id");
	user_id.value = data;
	document.getElementById("formSchemeUpdate").submit();
}

function deleteSchemes( data ) {
	$.ajax({  
        url :"schemeDelete?"+
       		 "scheme.id="+data+"",//后台处理程序
        type:"post",    	//数据发送方式  
        async:false,  
        data:"",
        error: function(){  
        	alert("服务器没有返回数据，可能服务器忙，请重试");  
       },  
        success: function(data){
       	 var retDate = eval("("+data+")");
       	 if( true == retDate.MANAGER_RESULT ) {
       		 //执行成功,跳转到UserList页面
       		 alert("删除业务成功");
       		 //当前页面刷新
       		location.reload();  
       	 }else{
       		 //执行失败，alert错误信息
       		 alert("删除业务信息失败，失败原因：" + retDate.MANAGER_ERROR_MESSAGE );
       	 }
       }	
	}); 
}
</script>


</head>


<body>
	<form id="formSchemeUpdate" name="formSchemeUpdate" action="toSchemeUpdate" >
		<input type="hidden" id="form_update_scheme_id" name="scheme.id"/>
	</form>
	<form id="formSchemeAdd" name="formSchemeAdd" action="toSchemeAdd" />
	
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">管理信息</a></li>
    <li><a href="#">业务管理</a></li>
    </ul>
    </div>
    
    <div class="rightinfo">
    
    <div class="tools">
    
    	<ul class="toolbar">
        <li ><span><a href="javascript:addSchemes();"><img src="images/t01.png" /></span>添加</a></li>
        </ul>
    </div>
    
    <table class="tablelist">
    	<thead>
    	<tr>
        <th><input name="" type="checkbox" value="" checked="checked"/></th>
        <th>编号<i class="sort"><img src="images/px.gif" /></i></th>
        <th>标题</th>
        <th>类型</th>
        <th>作者</th>
        <th>发布时间</th>
        <th>状态</th>
        <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="schemeList" var="schemes">
            <tr>
	        <td><input name="" type="checkbox" value="" /></td>
	        <td>${ schemes.id }</td>
	        <td>${ schemes.title }</td>
	        <td>
	        	<s:iterator value="schemeTypeMap" id="column" status="stuts">
	        	 	<s:if test="#column.key == #schemes.type">
	                    <s:property value="#column.value" />
	                </s:if>
            	 </s:iterator>
	        </td>
	        <td>${ schemes.author_name }</td>
	        <td>${ schemes.create_time }</td>
	        <td>已审核</td>
	        <td><a href="javascript:updateSchemes('${ schemes.id }')" class="tablelink" >更新</a>
	            <a href="javascript:deleteSchemes('${ schemes.id }')" class="tablelink"> 删除</a></td>
	        </tr> 
    	</s:iterator> 
        </tbody>
    </table>
    
   
    <div class="pagin">
    	<div class="message">共<i class="blue">1256</i>条记录，当前显示第&nbsp;<i class="blue">2&nbsp;</i>页</div>
        <ul class="paginList">
        <li class="paginItem"><a href="javascript:;"><span class="pagepre"></span></a></li>
        <li class="paginItem"><a href="javascript:;">1</a></li>
        <li class="paginItem current"><a href="javascript:;">2</a></li>
        <li class="paginItem"><a href="javascript:;">3</a></li>
        <li class="paginItem"><a href="javascript:;">4</a></li>
        <li class="paginItem"><a href="javascript:;">5</a></li>
        <li class="paginItem more"><a href="javascript:;">...</a></li>
        <li class="paginItem"><a href="javascript:;">10</a></li>
        <li class="paginItem"><a href="javascript:;"><span class="pagenxt"></span></a></li>
        </ul>
    </div>
    
    
    <div class="tip">
    	<div class="tiptop"><span>提示信息</span><a></a></div>
        
      <div class="tipinfo">
        <span><img src="images/ticon.png" /></span>
        <div class="tipright">
        <p>是否确认对信息的修改 ？</p>
        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
        </div>
        </div>
        
        <div class="tipbtn">
        <input name="" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    
    </div>
    
    
    
    
    </div>
    
    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>
