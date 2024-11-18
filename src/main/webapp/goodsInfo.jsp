<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="net.coffeexing.webmall.entity.Goods" %>
<%
    Goods goods = (Goods) request.getAttribute("goods");
    if (goods == null) {
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>商品详情</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<p>未找到商品详情，请返回重试。</p>
</body>
</html>
<%
        return;
    }
%>
<!DOCTYPE HTML>
<html>
<head>
    <title><%= goods.getGoodsName() %> - 商品详情</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="res/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <link href="res/css/style.css" rel="stylesheet" type="text/css" media="all">
    <link rel="stylesheet" href="res/css/flexslider.css" type="text/css" media="screen" />
    <script src="res/js/jquery.min.js"></script>
    <script src="res/js/bootstrap-3.1.1.min.js"></script>
    <script src="res/js/imagezoom.js"></script>
    <script defer src="res/js/jquery.flexslider.js"></script>
    <script type="text/javascript">
        $(window).load(function() {
            $('.flexslider').flexslider({
                animation: "slide",
                controlNav: "thumbnails"
            });
        });
    </script>
</head>
<body>
<div class="single">
    <div class="container">
        <div class="single-grids">
            <div class="col-md-4 single-grid">
                <div class="flexslider">
                    <ul class="slides">
                        <li><img src="<%= goods.getGoodsImg() %>" class="img-responsive" alt="<%= goods.getGoodsName() %>"></li>
                    </ul>
                </div>
            </div>
            <div class="col-md-4 single-grid simpleCart_shelfItem">
                <h2><a href="#"><%= goods.getGoodsName() %></a></h2>
                <p><%= goods.getGoodsDescribe() %></p>
                <ul class="size dl-horizontal">
                    <li><h3>规格：</h3></li>
                    <li><h4><%= goods.getGoodsSize() %></h4></li>
                </ul>
                <ul class="size dl-horizontal">
                    <li><h3>产地：</h3></li>
                    <li><h4><%= goods.getGoodsFrom() %></h4></li>
                    <li><h3>保质期：</h3></li>
                    <li><h4><%= goods.getGoodsTime() %></h4></li>
                    <li><h3>存储条件：</h3></li>
                    <li><h4><%= goods.getGoodsSaveCondition() %></h4></li>
                </ul>
                <ul class="size dl-horizontal">
                    <li><h4>￥<%= goods.getGoodsDiscount() %></h4></li>
                    <li><h4 class="pric1"><del>￥<%= goods.getGoodsPrice() %></del></h4></li>
                </ul>
                <ul class="size dl-horizontal">
                    <li><h3 class="qty pric1">数量：</h3></li>
                    <li>
                        <input min="1" type="number" id="quantity" name="quantity" value="1" class="form-control input-small">
                    </li>
                </ul>
                <div class="btn_form">
                    <button class="add-cart item_add" onclick="addGoodsToCart('<%= goods.getGoodsId() %>')">加入购物车</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="res/layer/layer.js" type="text/javascript"></script>
<script type="text/javascript">
    function addGoodsToCart(goodsId) {
        $.ajax({
            type: "POST",
            dataType: "text",
            url: "cart.jsp",
            data: { goodsId: goodsId, buyNum: $('#quantity').val(), oper: 1 },
            success: function(msg) {
                if (msg === 'success') {
                    layer.msg('已加入您的购物车！', {icon: 6});
                } else {
                    layer.msg('操作失败，请重试！', {icon: 5});
                }
            },
            error: function() {
                layer.msg('服务器响应失败！', {icon: 5});
            }
        });
    }
</script>
</html>
