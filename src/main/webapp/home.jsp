<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <!-- 保持CSS路径一致 -->
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
            top:-5px; left:110px;
        }
        .search-view input {
            width:175px;
            height: 30px;
            border:0;
            margin-left:5px;
            border-top-left-radius: 15px;
            border-bottom-left-radius: 15px;
            background:#fff;
        }
        .search-view button {
            border:4px solid #ff7b11;
            width:46px;
            height: 30px;
            border-top-right-radius: 13px;
            border-bottom-right-radius: 13px;
            background:#ff7b11;
            color:#fff;
        }
    </style>
</head>
<body>
<!-- Header -->
<div class="header">
    <div class="main">
        <!-- 搜索栏 -->
        <div class="search-view" style="margin-top:50px;">
            <input type="text" class="text" value="" placeholder="搜索 商品名 类型" id="search-input">
            <button type="button" id="search-button" onclick="search()">搜 索</button>
        </div>
        <!-- 用户导航 -->
        <div class="nav-user">
            <!-- 用户信息 -->
            <div class="nav">
                <a href="user.jsp?page=userPage" target="content">
                    <img src="res/images/avatar/index.html" alt="用户头像">test
                </a>
            </div>
            <!-- 购物车 -->
            <div class="nav">
                <a onclick="isLogin(this)" target="content" id="cart-a">
                    <img src="res/images/pccart.png" alt="购物车图标">
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Main Content -->
<iframe id="content" src="mainPage" style="height:100%;width:101%;" name="content" frameborder="no" border="0" marginwidth="0" marginheight="0"></iframe>

<!-- 保持JS路径一致 -->
<script src="res/js/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="res/layer/layer.js" type="text/javascript"></script>
<script src="res/layui/layui.js" type="text/javascript"></script>
<script type="text/javascript">
    // 判断是否登录
    function isLogin(obj) {
        if ('<%= session.getAttribute("user") != null %>') {
            obj.href = 'cart.jsp?page=cartPage';
        } else {
            layer.tips('您还没有登录！', '#cart-a');
        }
    }

    // 搜索功能
    function search() {
        var value = $('#search-input').val();
        if (value != null && value != '') {
            window.location.href = 'searchGoods.jsp?condition=' + encodeURIComponent(value);
        } else {
            layer.tips('请输入您要找的商品！', '#search-input');
        }
    }

    // 回车搜索监听
    $('#search-input').bind('keypress', function(event) {
        if (event.keyCode == "13") {
            event.preventDefault();
            $('#search-button').click();
        }
    });
</script>
</body>
</html>
