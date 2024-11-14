<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="">
<title>主页</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="keywords" content="">
<meta name="description" content="">
<link rel="stylesheet" href="res/layui/css/layui.css">
<link rel="stylesheet" href="res/css/global.css">
<style type="text/css">

.search-view {
    text-align: left;
    border: 1px solid #695D69;
    background:#fff;
    border-radius: 15px;
    margin-right:20px;
    position:fixed;
    width:230px;
    height: 30px;
    top:-5px; left:110;
}
.search-view input{
	width:175px;
    height: 30px;
    border:0;
    margin-left:5px;
    border-top-left-radius: 15px;
    border-bottom-left-radius: 15px;
    background:#fff;
}
.search-view button{
	border:4px solid #ff7b11;
	width:46px;
    height: 30px;
    border-top-right-radius: 13px;
    border-bottom-right-radius: 13px;
    background:#ff7b11;
    color:#fff;
}
body .open-class .layui-layer-title{
	/*background:#ff7b11; color:#fff; border: none;*/
}
body .open-class .layui-layer-content{
	top:40px;
	left:25px;
}
</style>
</head>
<body>
	<div class="header">
		<div class="main">
			
			<div class="" style="top:5px;">
				<div class="nav search-view" style="margin-top:50px;" >
					<input type="text" class="text" value="" placeholder="搜索 商品名 类型" id="search-input">
				 	<button type="button" id="search-button" onclick="search()">搜 索</button>
				</div>
			</div>
			<div class="nav-user">
				
					
					
					
						<div class="nav">
							<a  href="user.jsp?page=userPage" target="content"> <img
							src="res/images/avatar/">test</a>
						</div>
					
				
				<div class="nav">
					<a onclick="isLogin(this)" target="content" id="cart-a">
					    <img src="res/images/pccart.png"></a>
				</div>
			</div>
		</div>
	</div>
	
	<iframe id="content" src="home.jsp?page=mainPage" style="height:100%;width:101%;" name="content" frameborder="no" border="0" marginwidth="0" marginheight="0" ></iframe>
	
</body>

<script src="res/js/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="res/layer/layer.js" type="text/javascript"></script>
<script src="res/layui/layui.js" type="text/javascript"></script>
<script type="text/javascript">

function isLogin(obj) {
	if ('User [userId=123456, userName=test, password=123456, userHeadImg=null]' != null && 'User [userId=123456, userName=test, password=123456, userHeadImg=null]' != '') {
		obj.href='cart.jsp?page=cartPage';
	} else {
		layer.tips('您还没有登录！','#login-a');
	}
}

function search(){
	var value = $('#search-input').val();
	if(value != null && value != '') {
		///alert('ajax搜索');
		$.ajax({
				type : "GET",
				dataType : "text",
				async : false,
				url : 'home.jsp?page=searchGoods',
				data : {"condition":value},
				success : function(msg) {
						if (msg == 'success') {
							//windows.parent.location.open('result');
							window.content.location.href='home.jsp?page=result';
						} else {
							layer.msg('没有找到您要的商品！', {icon:5});
						}
				},
				error : function () {
					layer.msg('服务器响应失败！', {icon: 5});
				}
			});
	} else {
		layer.tips('请输入您要找的商品！','#search-input');
	}
}

//监听搜索input回车事件
		$('#search-input').bind('keypress', function(event) {  
        	if (event.keyCode == "13") {
            	event.preventDefault();
            	$('#search-button').click();  
        	}
    	});

</script>
</html>
