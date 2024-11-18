<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="net.coffeexing.webmall.entity.Goods" %>
<%
    // 获取查询关键字和商品列表
    String keyword = (String) request.getAttribute("keyword");
    List<Goods> goodsList = (List<Goods>) request.getAttribute("goodsList");
%>
<!DOCTYPE HTML>
<html>
<head>
    <title>搜索结果 - <%= keyword %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="res/css/bootstrap.css" rel="stylesheet" type="text/css" media="all">
    <link href="res/css/style.css" rel="stylesheet" type="text/css" media="all">
    <script src="res/js/jquery.min.js"></script>
    <script src="res/js/bootstrap-3.1.1.min.js"></script>
</head>
<body>
<div class="products">
    <div class="container">
        <h2>搜索结果：<%= keyword %></h2>
        <div class="row product-model-sec">
            <%
                if (goodsList != null && !goodsList.isEmpty()) {
                    for (Goods goods : goodsList) {
            %>
            <div class="col-md-3 product-grid">
                <div class="product-info simpleCart_shelfItem">
                    <!-- 商品图片 -->
                    <img src="<%= goods.getGoodsImg() %>" class="img-responsive" alt="<%= goods.getGoodsName() %>">
                    <h4><%= goods.getGoodsName() %></h4>
                    <p><%= goods.getGoodsDescribe() %></p>
                    <div class="price">
                        <del>￥<%= goods.getGoodsPrice() %></del>
                        ￥<%= goods.getGoodsDiscount() %>
                    </div>
                    <button class="btn btn-primary" onclick="addGoodsToCart('<%= goods.getGoodsId() %>')">加入购物车</button>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <p>未找到与 "<%= keyword %>" 相关的商品。</p>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
<script src="res/layer/layer.js"></script>
<script>
    function addGoodsToCart(goodsId) {
        $.ajax({
            type: "POST",
            url: "cart.jsp",
            data: { goodsId: goodsId, buyNum: 1 },
            success: function(response) {
                if (response === "success") {
                    alert("商品已加入购物车！");
                } else {
                    alert("加入购物车失败！");
                }
            },
            error: function() {
                alert("网络错误！");
            }
        });
    }
</script>
</html>
